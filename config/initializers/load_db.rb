# frozen_string_literal: true

require 'mongoid'

Mongoid.load!(File.join(File.dirname(__FILE__), '..', 'mongoid.yml'))
