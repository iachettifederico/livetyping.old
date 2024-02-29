# frozen_string_literal: true

require "pathname"

module Livetyping
  class Tracker
    def self.load
      new
    end

    def start
      @tracer.enable
    end

    def started?
      @tracer.enabled?
    end

    def stop
      @tracer.disable
    end

    def whats_on(source_file:, line:, column:)
      types_on_location = @types_by_location[{ source_file: source_file, line: line }]

      if types_on_location
        code = File.readlines(source_file)[line - 1]
        token = token_under(code, column)

        if types_on_location[:local_variables].include?(token)
          { types: types_on_location.dig(:local_variables, token) }
        else
          { types: [] }
        end
      else
        { types: [] }
      end
    end

    def project_root
      Pathname(__dir__).join("../../").expand_path
    end

    private

    def initialize
      @old_trace_point = nil
      @types_by_location = {}
      @tracer = TracePoint.new(:line) do |trace_point|
        track_types(trace_point)
      end
    end

    def track_types(trace_point)
      if @old_trace_point
        the_binding = @old_trace_point.binding
        location = trace_point_location(@old_trace_point)
        new_type_information = @types_by_location[location] || { local_variables: Hash.new { |hash, key| hash[key] = [] }, location: location }

        ap location
        the_binding.local_variables.each do |local_variable|
          new_type_information[:local_variables][local_variable] << the_binding.local_variable_get(local_variable).class.to_s
        end

        type_information = {
          local_variables: the_binding.local_variables.each_with_object({}) { |local_variable, information|
                             information[local_variable] ||= []
                             information[local_variable] << the_binding.local_variable_get(local_variable).class.to_s
                           },
          location:        location,
        }

        @types_by_location[location] = new_type_information
      end

      @old_trace_point = trace_point
    end

    def trace_point_location_old(trace_point)
      source_file = trace_point.path
      line = trace_point.lineno
      code = if source_file =~ /<internal:.+>/
               "<internal implementation>"
             else
               File.readlines(source_file)[line - 1]
             end

      {
        code:        code,
        source_file: source_file,
        line:        line,
      }
    end

    def trace_point_location(trace_point)
      {
        source_file: trace_point.path,
        line:        trace_point.lineno,
      }
    end

    def token_under(code, column)
      Livetyping::TokenUnder.for(code: code, column: column).to_sym
    end
  end
end
