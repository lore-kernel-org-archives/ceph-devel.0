From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: building Ceph on various architectures
Date: Sat, 26 Feb 2011 10:28:47 -0800
Message-ID: <C0A35234378B4D3A90BDEF41E55AF4A3@gmail.com>
References: <1298720478.16174.14.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57519 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab1BZS2y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 26 Feb 2011 13:28:54 -0500
Received: by pzk35 with SMTP id 35so417218pzk.19
        for <ceph-devel@vger.kernel.org>; Sat, 26 Feb 2011 10:28:53 -0800 (PST)
In-Reply-To: <1298720478.16174.14.camel@julia.gcs.org.hu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org, yehudasa@gmail.com

On Saturday, February 26, 2011 at 3:41 AM, Laszlo Boszormenyi wrote:
Hi List,
> 
> Being the Debian packager of Ceph, I ask for help about building 0.24.3
> on armel. It fails with:
> g++ -DHAVE_CONFIG_H -I. -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64
> -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT AuthAuthorizeHandler.o
> -MD -MP -MF .deps/AuthAuthorizeHandler.Tpo -c -o AuthAuthorizeHandler.o
> `test -f 'auth/AuthAuthorizeHandler.cc' || echo
> './'`auth/AuthAuthorizeHandler.cc
> In file included from ./include/buffer.h:55,
>  from ./include/encoding.h:20,
>  from ./include/object.h:29,
>  from ./include/types.h:64,
>  from auth/Crypto.h:17,
>  from auth/Auth.h:18,
>  from auth/AuthAuthorizeHandler.cc:1:
> ./include/atomic.h: In member function 'void ceph::atomic_t::inc()':
> ./include/atomic.h:33: error: 'AO_fetch_and_add1' was not declared in this scope
> ./include/atomic.h: In member function 'size_t ceph::atomic_t::dec()':
> ./include/atomic.h:36: error: 'AO_fetch_and_sub1_write' was not declared in this scope
> ./include/atomic.h: In member function 'void ceph::atomic_t::add(size_t)':
> ./include/atomic.h:39: error: 'AO_fetch_and_add' was not declared in this scope
> ./include/atomic.h: In member function 'void ceph::atomic_t::sub(int)':
> ./include/atomic.h:43: error: 'AO_fetch_and_add_write' was not declared in this scope
> make[3]: *** [AuthAuthorizeHandler.o] Error 1

This looks like an error that came up (and got fixed) on Ubuntu several months ago:
https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/635388

> You can read the full build log on the web[1].
> 
> It also fails on s390, on the same file but with a different error
> message:
> g++ -DHAVE_CONFIG_H -I. -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT AuthAuthorizeHandler.o -MD -MP -MF .deps/AuthAuthorizeHandler.Tpo -c -o AuthAuthorizeHandler.o `test -f 'auth/AuthAuthorizeHandler.cc' || echo './'`auth/AuthAuthorizeHandler.cc
> In file included from ./msg/msg_types.h:19,
>  from auth/Auth.h:19,
>  from auth/AuthAuthorizeHandler.cc:1:
> ./include/blobhash.h: In member function 'size_t blobhash::operator()(const char*, unsigned int)':
> ./include/blobhash.h:42: error: no match for call to '(rjhash<long unsigned int>) (size_t&)'
> make[3]: *** [AuthAuthorizeHandler.o] Error 1

This isn't one I'm familiar with -- I'll look into it on Monday if nobody's got it before then. :)
-Greg



