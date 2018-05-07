#
# Cookbook:: partition_cookbook
# Recipe:: _test
#
# Copyright:: 2012-2016, John Dewey
# Copyright:: 2018, Bryan L. Gay
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

partition_disk 'mklabel' do
  device '/dev/sdb'
  action :mklabel
end

partition_disk 'mkpart' do
  device '/dev/sdb'
  action :mkpart
end

partition_disk 'mkfs' do
  device '/dev/sdb1'
  action :mkfs
end

partition_disk 'setflag' do
  device '/dev/sdb'
  action :setflag
end
