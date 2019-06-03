#
# Cookbook Name:: aws-parallelcluster
# Recipe:: _efa_install
#
# Copyright 2013-2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License"). You may not use this file except in compliance with the
# License. A copy of the License is located at
#
# http://aws.amazon.com/apache2.0/
#
# or in the "LICENSE.txt" file accompanying this file. This file is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
# OR CONDITIONS OF ANY KIND, express or implied. See the License for the specific language governing permissions and
# limitations under the License.

efa_tarball = "#{node['cfncluster']['sources_dir']}/aws-efa-installer-latest.tar.gz"

bash "install efa" do
  cwd Chef::Config[:file_cache_path]
  code <<-EFAINSTALL
    # default openmpi installation conflicts with new install
    # new one is installed in /opt/amazon/efa/bin/
    yum remove -y openmpi openmpi-devel
    tar -xzf #{efa_tarball}
    cd aws-efa-installer
    ./efa_installer.sh -y
  EFAINSTALL
  creates '/opt/amazon/efa/bin/mpirun'
end