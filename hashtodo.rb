#!/usr/bin/env ruby

require 'erb'
require 'thor'

class Task
	attr_accessor :text, :hashtags
	
	def initialize text, hashtags
		@text = text
		@hashtags = hashtags
	end
end

class Parser
	def self.parse filename
		file = File.open filename, "r+"
		
		parsed = []
		file.each_line do |line|
			parsed.push parse_line line
		end
		
		parsed
	end
	
	def self.parse_line line	
		# hashtag
		hashtags = line.scan(/#(\S+)\s?/)
		line.gsub!(/#\S+\s?/, "")
		
		Task.new line, hashtags.flatten
	end
end

class Exporter
	def self.export tasks, erb, export
		# erb読み込み
		res_file = File.open(erb, "r")
		erb = ERB.new res_file.read
		# 処理
		result = erb.result binding
		# 書き込み
		File.open export, "w" do |f|
			f.write result
		end
	end
end

class CLI < Thor
	desc "export <todo> <template> <file>", "<todo>の中身をerbの<template>によって<file>にエクスポートします"
	def export todofile, erb, target
		parsed = Parser.parse todofile
		Exporter.export parsed, erb, target
	end
	
	# taskのCRUDとか?
end

CLI.start ARGV