From: Ali Maredia <amaredia@redhat.com>
Subject: Transitioning Ceph from Autotools to CMake
Date: Thu, 30 Jul 2015 15:01:28 -0400 (EDT)
Message-ID: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com>
References: <568775149.634533.1438280976401.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:54485 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762AbbG3TB2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 15:01:28 -0400
Received: from zmail26.collab.prod.int.phx2.redhat.com (zmail26.collab.prod.int.phx2.redhat.com [10.5.83.33])
	by mx6-phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t6UJ1Ssf023853
	for <ceph-devel@vger.kernel.org>; Thu, 30 Jul 2015 15:01:28 -0400
In-Reply-To: <568775149.634533.1438280976401.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

After discussing with several other Ceph developers and Sage, I wanted
to start a discussion about making CMake the primary build system for Ceph.

CMake works just fine as it is (make -j4 on master with CMake builds
350% faster than autotools!), but there's more work needed to make it 
into a first-class build system.

Short term (1-2 weeks):
 - Making sure CMake works on all supported platforms: Centos7, RHEL7,
   Ubuntu 14.04 & 12.04, Fedora 22, Debian Jessie, Debian Wheezy are the
   target platforms I have noted to test on already.
 - Adding a target similar to make check
 - Creating CMake targets that build packages (such as for rpm or debian)
 - Writing documentation for those who haven't used CMake before to smooth the
   transition over
 - Making sure no targets or dependencies are missing from the
   current CMake build, and that CMake supports all current 
   targets, configurations and options
 - Replacing the integration autotools has with any automated build/test
   systems such as the gitbuilder

Longer term (2-4 weeks):
 - Removing the current autotools files, to avoid doubling build system
   workload
 - Adding more but shorter CMakeLists.txt files to a tree like structure
   where a CMakeLists.txt would be in every subdirectory
 
I'm already working on a target similar to the make check target, and plan
on working on the other short term goals over the next weeks and beyond.

I wanted to get feedback from the community any reasons why someone started using 
CMake but stopped (ex: lack of functionality), and more broadly, on what other 
obstacles there might be for the transition.

-Ali
