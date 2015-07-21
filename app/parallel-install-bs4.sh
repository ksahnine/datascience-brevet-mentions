#!/bin/sh

# Install Beautiful Soup on all EC2 instances

parallel --nonall --slf machines "sudo apt-get install python-bs4"
