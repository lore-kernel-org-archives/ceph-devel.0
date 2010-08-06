From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: compiler warnings on centos5
Date: Fri, 6 Aug 2010 09:25:53 -0700
Message-ID: <AANLkTinKDgH-K7myRsEeP3PUHP3E_fM8CQd=gMzha6uR@mail.gmail.com>
References: <i3e1fs$mv$1@dough.gmane.org>
	<AANLkTi=uegGEfjXw_DpfshdArsjQjk=sOv8DJ0-TF5be@mail.gmail.com>
	<i3gthp$56v$2@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45106 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0HFQZy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Aug 2010 12:25:54 -0400
Received: by wyb39 with SMTP id 39so7922791wyb.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Aug 2010 09:25:53 -0700 (PDT)
In-Reply-To: <i3gthp$56v$2@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Fri, Aug 6, 2010 at 5:00 AM, Thomas Mueller <thomas@chaschperli.ch> wrote:
> I found out that Centos5 actually provides a gcc44 and gcc44-c++ package.
> Compiling with those doesn't show the wanrings.
>
> symlinking g++44 and gcc44 to /usr/local/(gcc|g++) works.
>
>
> calling configure with the custom paths for gcc and g++ doesn't:
>
> CC=/usr/bin/gcc44 CXX=/usr/bin/g++44 ./configure --prefix=/usr
> ...
> checking for atomic_ops.h... yes
> checking for dirent.h that defines DIR... yes
> checking for library containing opendir... none required
> checking for ANSI C header files... (cached) yes
> checking for sys/wait.h that is POSIX.1 compatible... yes
> checking boost/spirit.hpp usability... no
> checking boost/spirit.hpp presence... no
> checking for boost/spirit.hpp... no
> configure: error: Sorry you need to install the Boost spirit parser
> library (libboost-dev on debian)
Looks like a configuration issue since it can't find the Boost header
file. I imagine that by calling them directly you're losing some
include lines or something?
