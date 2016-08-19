#
# Cookbook Name:: forest_monitor
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe "apt"
include_recipe "forest_monitor::setup"
include_recipe "forest_monitor::setup_autossh"

