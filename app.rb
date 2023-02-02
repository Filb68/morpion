require 'bundler'
Bundler.require

$:.unshift File.expand_path("./../lib", __FILE_)  	
require 'morpion' 

Index.new.perform 	