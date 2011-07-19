From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: RBD performance poor
Date: Tue, 19 Jul 2011 10:06:26 -0700
Message-ID: <CAF3hT9AP7oVpdaH4YAD_Zx3Sto-V6QiFDuu-StigdZo6BLFuWw@mail.gmail.com>
References: <loom.20110719T132334-607@post.gmane.org>
	<CAF3hT9DcGSA8=vbGj3ibpwDRP2hZvEOgq9ru7PPcrYuUWRMHbA@mail.gmail.com>
	<CAN4=B2k+L-im-p17L3CoFHwy7QYy3QcKSGthcfEebEpCjOQghQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60942 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1GSRG1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jul 2011 13:06:27 -0400
Received: by yxi11 with SMTP id 11so1863337yxi.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jul 2011 10:06:27 -0700 (PDT)
In-Reply-To: <CAN4=B2k+L-im-p17L3CoFHwy7QYy3QcKSGthcfEebEpCjOQghQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: Christian Gramsch <christian.gramsch@gmail.com>, ceph-devel@vger.kernel.org

On Tue, Jul 19, 2011 at 10:02 AM, Brian Chrisman <brchrisman@gmail.com> wrote:
> On Tue, Jul 19, 2011 at 9:11 AM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> RBD presently does absolutely no client-side caching of writes. If a
>> write is issued, it goes out to the network and doesn't return from
>> the write until it's been committed on-disk to the OSDs.
>> This is the simplest and safest implementation, but it's not quite
>> what many things expect from their disk devices: they think a write
>> should be fast (and land in the disk's cache) and expect that a sync
>> might be slow. If you run an actual OS on RBD you should find it
>> performing reasonably well since the VFS and page cache will hide all
>> this latency from you, but if you're accessing it directly your
>> application is likely to issue a bunch of serialized 4KB writes with a
>> per-write latency of ~10 milliseconds, which obviously severely limits
>> total write bandwidth.
>> Implementing client-side caching is in the future for RBD but not
>> something we're working on right now.
>>
>> So most (all, I think) reports of slow RBD behavior have been because
>> of this (certainly the one you reference). But with the commands
>> you're running, you're doing dd in file mode rather than raw disk, so
>> the VFS ought to be coalescing those writes and giving you much higher
>> bandwidth. Are you using any special mount options? What result do you
>> get doing a dd directly to the device?
>> -Greg
>
>
> So what would be the throughput-optimal block size for writing to RBD
> with the default configuration? 4MB?
>

Well in general it's not a question of optimal block size so much as
of not letting the latency impact your write pattern. Larger blocks
like 4MB certainly help with that, as does doing multiple writes at a
time and async IO.
But running a filesystem on top of the disk will generally do all
those things for you, so I'm not sure exactly what's going on here...
