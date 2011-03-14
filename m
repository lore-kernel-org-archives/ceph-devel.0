From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: building Ceph on various architectures
Date: Mon, 14 Mar 2011 12:03:38 -0700
Message-ID: <20110314190338.GA2416@dreamer>
References: <1298720478.16174.14.camel@julia.gcs.org.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34093 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753402Ab1CNTDk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Mar 2011 15:03:40 -0400
Content-Disposition: inline
In-Reply-To: <1298720478.16174.14.camel@julia.gcs.org.hu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Laszlo Boszormenyi <gcs@debian.hu>
Cc: ceph-devel@vger.kernel.org

On Sat, Feb 26, 2011 at 12:41:18PM +0100, Laszlo Boszormenyi wrote:
> It also fails on s390, on the same file but with a different error
> message:
> g++ -DHAVE_CONFIG_H -I.    -Wall -D__CEPH__ -D_FILE_OFFSET_BITS=64 -D_REENTRANT -D_THREAD_SAFE -rdynamic -g -O2 -MT AuthAuthorizeHandler.o -MD -MP -MF .deps/AuthAuthorizeHandler.Tpo -c -o AuthAuthorizeHandler.o `test -f 'auth/AuthAuthorizeHandler.cc' || echo './'`auth/AuthAuthorizeHandler.cc
> In file included from ./msg/msg_types.h:19,
>                  from auth/Auth.h:19,
>                  from auth/AuthAuthorizeHandler.cc:1:
> ./include/blobhash.h: In member function 'size_t blobhash::operator()(const char*, unsigned int)':
> ./include/blobhash.h:42: error: no match for call to '(rjhash<long unsigned int>) (size_t&)'
> make[3]: *** [AuthAuthorizeHandler.o] Error 1

This is ticket http://tracker.newdream.net/issues/837 for us.

Can you try branch tv-blobhash-837 in ceph.git and see if it compiles
right?  I don't have convenient access to a zSeries box / Hercules.

-- 
:(){ :|:&};:
