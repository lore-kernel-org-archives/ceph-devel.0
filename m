From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Fwd: Build failed in Jenkins: ceph-master #804
Date: Fri, 16 Jun 2017 00:20:21 +0200
Message-ID: <3f1da6b3-d5ca-634c-8859-473c268f0c80@digiware.nl>
References: <394935589.12.1497535633528.JavaMail.jenkins@cephdev.digiware.nl>
 <f59d7e73-01ed-255c-9dee-85805f36ae56@digiware.nl>
 <97ec6826-d5d0-206f-7461-79a786fd304a@redhat.com>
 <2e3c5dff-8f88-bca6-e241-a35c12100493@digiware.nl>
 <1a41f840-8521-eab5-8000-a7ef3dc5bb03@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:42444 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750820AbdFOWU1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Jun 2017 18:20:27 -0400
In-Reply-To: <1a41f840-8521-eab5-8000-a7ef3dc5bb03@digiware.nl>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 15-6-2017 23:36, Willem Jan Withagen wrote:
> On 15-6-2017 23:32, Willem Jan Withagen wrote:
>> On 15-6-2017 16:44, Casey Bodley wrote:
>>> Yeah, this was changed in https://github.com/ceph/ceph/pull/15376. That
>>> Boost::thread string shouldn't be making it to the link line. Can you
>>> share your cmake --version?
>>
>> wjw@cephdev:~/master % cmake --version
>> cmake version 3.6.3
>>
>> But note that this is FreeBSDS and I'm using the system Boost, v1.64
>>
>> I'll pull the PR into my jenkins, and see what it brings.
> 
> Now I know what you ment #15376 was merged and probably causes this.

One of the problems might be that the included cmake templates for boost
do not (yet) understand this version:

====
CMake Warning at /usr/local/share/cmake/Modules/FindBoost.cmake:743
(message):
  Imported targets not available for Boost version 106400
Call Stack (most recent call first):
  /usr/local/share/cmake/Modules/FindBoost.cmake:842
(_Boost_COMPONENT_DEPENDENCIES)
  /usr/local/share/cmake/Modules/FindBoost.cmake:1395
(_Boost_MISSING_DEPENDENCIES)
  CMakeLists.txt:553 (find_package)
====

The output of cmake is full of warnings:
====
CMake Warning (dev) at src/CMakeLists.txt:694 (add_executable):
  Policy CMP0028 is not set: Double colon in target name means ALIAS or
  IMPORTED target.  Run "cmake --help-policy CMP0028" for policy details.
  Use the cmake_policy command to set the policy and suppress this warning.

  Target "librados-config" links to target "Boost::thread" but the
target was
  not found.  Perhaps a find_package() call is missing for an IMPORTED
  target, or an ALIAS target is missing?
This warning is for project developers.  Use -Wno-dev to suppress it.

CMake Warning (dev) at src/CMakeLists.txt:694 (add_executable):
  Policy CMP0028 is not set: Double colon in target name means ALIAS or
  IMPORTED target.  Run "cmake --help-policy CMP0028" for policy details.
  Use the cmake_policy command to set the policy and suppress this warning.

  Target "librados-config" links to target "Boost::system" but the
target was
  not found.  Perhaps a find_package() call is missing for an IMPORTED
  target, or an ALIAS target is missing?
This warning is for project developers.  Use -Wno-dev to suppress it.
====

