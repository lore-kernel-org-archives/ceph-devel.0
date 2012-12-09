From: Noah Watkins <noah.watkins@inktank.com>
Subject: Re: [ceph-commit] [ceph/ceph] e6a154: osx: compile on OSX
Date: Sun, 9 Dec 2012 10:22:37 -0800
Message-ID: <CA+Hcz5-z4=aYGaTb3tU28B0Qanb=a+iR+yq_RKqc9EVsJZ-GAQ@mail.gmail.com>
References: <50c4cd4dabe04_4126fc8af02216d@sh2.rs.github.com.mail>
	<4685D39E3A8A4352B08C753D91FC4A5A@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:54765 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756823Ab2LISWj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Dec 2012 13:22:39 -0500
Received: by mail-la0-f46.google.com with SMTP id p5so1408875lag.19
        for <ceph-devel@vger.kernel.org>; Sun, 09 Dec 2012 10:22:37 -0800 (PST)
In-Reply-To: <4685D39E3A8A4352B08C753D91FC4A5A@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Dec 9, 2012 at 10:05 AM, Gregory Farnum <greg@inktank.com> wrote:
> Oooh, very nice! Do you have a list of the dependencies that you actually needed to install?

I can put that together. They were boost, gperf, fuse4x, cryptopp. I
think that might have been it.

> Apart from breaking this up into smaller patches, we'll also want to reformat some of it. Rather than sticking an #if APPLE on top of every spin lock, we should have utility functions that do this for us. ;)

Definitely. OSX has spinlock implementations for user space, but it's
going to take some reading. For example, spinlocks in Ceph are
initialized for shared memory, rather than the default private. It
isn't clear from documentation what the semantics are of OSX
spinlocks, nor is it clear if the shared memory attribute is needed.

> Also, we should be able to find libatomic_ops for OS X (its parent project works under OS X), and we can use that to construct a spin lock if we think it'll be useful. I'm not too sure how effective its muteness are at spinlock-y workloads.

This patch set uses the OSX atomic inc/dec ops, rather than spinlocks.

Another fun fact:

msg/Pipe.cc and common/pipe.c are compiled into libcommon_la-Pipe.o
and libcommon_la-pipe.o, but HFS+ is case-insensitive by default.
Result is duplicate symbols. That took a while to figure out :P

-Noah
