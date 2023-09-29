# frozen_string_literal: true

def mark_here!(offset: 0)
  marker = caller.first
  regex = /^(.+):(\d+):.+/
  source_file = marker[regex, 1]
  line = Integer(marker[regex, 2]) + offset
  code = File.readlines(source_file)[line - 1]
  location = {
    code:        code,
    source_file: source_file,
    line:        line,
  }
end
