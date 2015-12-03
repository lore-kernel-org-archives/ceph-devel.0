From: Pete Zaitcev <zaitcev@redhat.com>
Subject: cmake
Date: Thu, 3 Dec 2015 15:24:36 -0700
Message-ID: <20151203152436.73e15e38@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42013 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979AbbLCWYg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 17:24:36 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id B307342E5D6
	for <ceph-devel@vger.kernel.org>; Thu,  3 Dec 2015 22:24:36 +0000 (UTC)
Received: from lembas.zaitcev.lan (ovpn-113-110.phx2.redhat.com [10.3.113.110])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB3MOaNH012590
	for <ceph-devel@vger.kernel.org>; Thu, 3 Dec 2015 17:24:36 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dear All:

I'm trying to run cmake, in order to make sure my patches do not break it
(in particular WIP 5073 added source files). Result looks like this:

[zaitcev@lembas ceph-tip]$ cmake src
-- The C compiler identification is GNU 5.1.1
-- The CXX compiler identification is GNU 5.1.1
-- Check for working C compiler: /usr/bin/cc
-- Check for working C compiler: /usr/bin/cc -- works
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Detecting C compile features
-- Detecting C compile features - done
-- Check for working CXX compiler: /usr/bin/c++
-- Check for working CXX compiler: /usr/bin/c++ -- works
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Detecting CXX compile features
-- Detecting CXX compile features - done
CMake Error at CMakeLists.txt:1 (include):
  include could not find load file:

    GetGitRevisionDescription


-- The ASM compiler identification is GNU
-- Found assembler: /usr/bin/cc
CMake Warning (dev) at CMakeLists.txt:11 (add_definitions):
  Policy CMP0005 is not set: Preprocessor definition values are now escaped
  automatically.  Run "cmake --help-policy CMP0005" for policy details.  Use
  the cmake_policy command to set the policy and suppress this warning.
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at CMakeLists.txt:12 (add_definitions):
  Policy CMP0005 is not set: Preprocessor definition values are now escaped
  automatically.  Run "cmake --help-policy CMP0005" for policy details.  Use
  the cmake_policy command to set the policy and suppress this warning.
This warning is for project developers.  Use -Wno-dev to suppress it.

--  we do not have a modern/working yasm
-- Performing Test COMPILER_SUPPORTS_CXX11
-- Performing Test COMPILER_SUPPORTS_CXX11 - Success
CMake Error at CMakeLists.txt:95 (get_git_head_revision):
  Unknown CMake command "get_git_head_revision".


CMake Warning (dev) in CMakeLists.txt:
  No cmake_minimum_required command is present.  A line of code such as

    cmake_minimum_required(VERSION 3.3)

  should be added at the top of the file.  The version specified may be lower
  if you wish to support older CMake versions for this project.  For more
  information run "cmake --help-policy CMP0000".
This warning is for project developers.  Use -Wno-dev to suppress it.

-- Configuring incomplete, errors occurred!
See also "/q/zaitcev/ceph/ceph-tip/CMakeFiles/CMakeOutput.log".
[zaitcev@lembas ceph-tip]$ rpm -qa | grep -i cmake
extra-cmake-modules-5.16.0-1.fc23.noarch
cmake-3.3.2-1.fc23.x86_64
[zaitcev@lembas ceph-tip]$ 

Is this expected? Is my cmake incantation wrong?

Thanks,
-- Pete
