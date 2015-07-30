From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Transitioning Ceph from Autotools to CMake
Date: Thu, 30 Jul 2015 14:12:08 -0500
Message-ID: <55BA7708.2090300@redhat.com>
References: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54713 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980AbbG3TML (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 30 Jul 2015 15:12:11 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 08FE659
	for <ceph-devel@vger.kernel.org>; Thu, 30 Jul 2015 19:12:11 +0000 (UTC)
In-Reply-To: <26481727.639679.1438282888566.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ali Maredia <amaredia@redhat.com>, ceph-devel@vger.kernel.org

Just here to provide moral support. Go CMake go! :)

Mark

On 07/30/2015 02:01 PM, Ali Maredia wrote:
> After discussing with several other Ceph developers and Sage, I wanted
> to start a discussion about making CMake the primary build system for Ceph.
>
> CMake works just fine as it is (make -j4 on master with CMake builds
> 350% faster than autotools!), but there's more work needed to make it
> into a first-class build system.
>
> Short term (1-2 weeks):
>   - Making sure CMake works on all supported platforms: Centos7, RHEL7,
>     Ubuntu 14.04 & 12.04, Fedora 22, Debian Jessie, Debian Wheezy are the
>     target platforms I have noted to test on already.
>   - Adding a target similar to make check
>   - Creating CMake targets that build packages (such as for rpm or debian)
>   - Writing documentation for those who haven't used CMake before to smooth the
>     transition over
>   - Making sure no targets or dependencies are missing from the
>     current CMake build, and that CMake supports all current
>     targets, configurations and options
>   - Replacing the integration autotools has with any automated build/test
>     systems such as the gitbuilder
>
> Longer term (2-4 weeks):
>   - Removing the current autotools files, to avoid doubling build system
>     workload
>   - Adding more but shorter CMakeLists.txt files to a tree like structure
>     where a CMakeLists.txt would be in every subdirectory
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
>
