From: Jimmy Tang <jtang@tchpc.tcd.ie>
Subject: Re: [ceph-commit] [ceph/ceph] e6a154: osx: compile on OSX
Date: Mon, 10 Dec 2012 16:52:36 +0000
Message-ID: <C29C365E-91F0-46D8-8559-99BF78E0B098@tchpc.tcd.ie>
References: <50c4cd4dabe04_4126fc8af02216d@sh2.rs.github.com.mail> <4685D39E3A8A4352B08C753D91FC4A5A@inktank.com>  <sfid-H20121209-182244-+035.50-1@marduk.tchpc.tcd.ie> <CA+Hcz5-z4=aYGaTb3tU28B0Qanb=a+iR+yq_RKqc9EVsJZ-GAQ@mail.gmail.com>  (sfid-H20121209-182244-+035.50-1@marduk.tchpc.tcd.ie)
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from tabaet.tchpc.tcd.ie ([134.226.112.12]:36346 "EHLO
	tabaet.tchpc.tcd.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093Ab2LJQwl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 11:52:41 -0500
In-Reply-To: <CA+Hcz5-z4=aYGaTb3tU28B0Qanb=a+iR+yq_RKqc9EVsJZ-GAQ@mail.gmail.com>  (sfid-H20121209-182244-+035.50-1@marduk.tchpc.tcd.ie)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel@vger.kernel.org


On 9 Dec 2012, at 18:22, Noah Watkins wrote:

> On Sun, Dec 9, 2012 at 10:05 AM, Gregory Farnum <greg@inktank.com> wrote:
>> Oooh, very nice! Do you have a list of the dependencies that you actually needed to install?
> 
> I can put that together. They were boost, gperf, fuse4x, cryptopp. I
> think that might have been it.
> 

Is libaio really needed to build ceph-fuse? I use macports on my system and the last time I tried to make a change set to let ceph/ceph-fuse build on my laptop failed as I didn't have libaio, though I could just write a port for it.

>> Apart from breaking this up into smaller patches, we'll also want to reformat some of it. Rather than sticking an #if APPLE on top of every spin lock, we should have utility functions that do this for us. ;)
> 
> Definitely. OSX has spinlock implementations for user space, but it's
> going to take some reading. For example, spinlocks in Ceph are
> initialized for shared memory, rather than the default private. It
> isn't clear from documentation what the semantics are of OSX
> spinlocks, nor is it clear if the shared memory attribute is needed.
> 
>> Also, we should be able to find libatomic_ops for OS X (its parent project works under OS X), and we can use that to construct a spin lock if we think it'll be useful. I'm not too sure how effective its muteness are at spinlock-y workloads.
> 
> This patch set uses the OSX atomic inc/dec ops, rather than spinlocks.
> 
> Another fun fact:
> 
> msg/Pipe.cc and common/pipe.c are compiled into libcommon_la-Pipe.o
> and libcommon_la-pipe.o, but HFS+ is case-insensitive by default.
> Result is duplicate symbols. That took a while to figure out :P
> 

good catch, that might explain why my last look at ceph on osx failed so miserably.


Jimmy.

--
Senior Software Engineer, Digital Repository of Ireland (DRI)
Trinity Centre for High Performance Computing,
Lloyd Building, Trinity College Dublin, Dublin 2, Ireland.
http://www.tchpc.tcd.ie/ | jtang@tchpc.tcd.ie
Tel: +353-1-896-3847

