#!/usr/bin/env ruby

require 'yaml'
require 'erb'
require 'clier'
require 'fssm'

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
	def self.export taskfile, erbfile, export
		# parse
		tasks = Parser.parse taskfile
		# erb読み込み
		res_file = File.open(erbfile, "r")
		erb = ERB.new res_file.read
		# 処理
		result = erb.result binding
		# 書き込み
		File.open export, "w" do |f|
			f.write result
		end
		
		puts "\e[32mExported:\e[0m #{taskfile} --#{erbfile}--> #{export}"
	end
end

params = Clier.parse ARGV

if params[:c] # YAMLがあれば優先
	config = YAML.load_file params[:c]
	
	config_mapping = { "data"   => :d,
		                 "erb"    => :e,
		                 "target" => :t }
	config = config.map { |k, v| [config_mapping[k], v] } # 省略形に変換
	config = Hash[config] # hashに変換
	config[:key] = params[:key] # :keyを戻す (これがないとexportやautoexportの判断ができない)
	params = config
	
	puts "\e[32mConfig:\e[0m #{params[:d]} --#{params[:e]}--> #{params[:t]}"
end

case params[:key]
when "export"
	Exporter.export params[:d], params[:e] , params[:t]
when "autoexport"
	FSSM.monitor do
		path File.dirname(params[:d]), "**/#{File.basename(params[:d])}" do # data変更監視
			update do |base, file|
				Exporter.export params[:d], params[:e], params[:t]
			end
		end
		path File.dirname(params[:e]), "**/#{File.basename(params[:e])}" do # erb変更監視
			update do |base, file|
				Exporter.export params[:d], params[:e], params[:t]
			end
		end
	end
end