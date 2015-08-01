From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Transitioning Ceph from Autotools to CMake
Date: Sat, 01 Aug 2015 21:24:16 +0200
Message-ID: <1438457056.20202.29.camel@redhat.com>
References: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33512 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbbHATYT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 1 Aug 2015 15:24:19 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 7DA868E22E
	for <ceph-devel@vger.kernel.org>; Sat,  1 Aug 2015 19:24:19 +0000 (UTC)
In-Reply-To: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ali Maredia <amaredia@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 2015-07-30 at 15:01 -0400, Ali Maredia wrote:
> After discussing with several other Ceph developers and Sage, I wanted
> to start a discussion about making CMake the primary build system for Ceph.
> 
> CMake works just fine as it is (make -j4 on master with CMake builds
> 350% faster than autotools!), but there's more work needed to make it 
> into a first-class build system.

I been using cmake on fedora for awhile because it is much much faster. 
I encountered several issues:
1. It breaks for time to time
2. no make check , I started working on it
(https://github.com/oritwas/ceph/tree/cmake_add_make_check) the main
issue is that part of the unit tests fail when run in the cmake build
location. We will need to fix those tests.
3. no vstart.sh , starting working on this too but have less progress
here. At the moment in order to use vstart I copy the exe and libs to
src dir.

Orit
> 
> Short term (1-2 weeks):
>  - Making sure CMake works on all supported platforms: Centos7, RHEL7,
>    Ubuntu 14.04 & 12.04, Fedora 22, Debian Jessie, Debian Wheezy are the
>    target platforms I have noted to test on already.
>  - Adding a target similar to make check
>  - Creating CMake targets that build packages (such as for rpm or debian)
>  - Writing documentation for those who haven't used CMake before to smooth the
>    transition over
>  - Making sure no targets or dependencies are missing from the
>    current CMake build, and that CMake supports all current 
>    targets, configurations and options
>  - Replacing the integration autotools has with any automated build/test
>    systems such as the gitbuilder
> 

> Longer term (2-4 weeks):
>  - Removing the current autotools files, to avoid doubling build system
>    workload
>  - Adding more but shorter CMakeLists.txt files to a tree like structure
>    where a CMakeLists.txt would be in every subdirectory
>  
> I'm already working on a target similar to the make check target, and plan
> on working on the other short term goals over the next weeks and beyond.
> 
> I wanted to get feedback from the community any reasons why someone started using 
> CMake but stopped (ex: lack of functionality), and more broadly, on what other 
> obstacles there might be for the transition.
> 
> -Ali
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


