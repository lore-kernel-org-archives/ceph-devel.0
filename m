From: Denis Fondras <ceph@ledeuns.net>
Subject: Re: Ceph performance improvement
Date: Fri, 24 Aug 2012 18:41:28 +0200
Message-ID: <5037AEB8.5030905@ledeuns.net>
References: <50349E62.90405@ledeuns.net> <5034D210.8060109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bmenez.pck.nerim.net ([213.41.245.173]:1038 "EHLO
	mail.ledeuns.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964937Ab2HXQla (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Aug 2012 12:41:30 -0400
Received: from [IPv6:2001:7a8:b5ad::10:10] (denis.ledeuns.net [IPv6:2001:7a8:b5ad::10:10])
	by mail.ledeuns.net (Postfix) with ESMTP id 8CD4593494
	for <ceph-devel@vger.kernel.org>; Fri, 24 Aug 2012 18:41:28 +0200 (CEST)
In-Reply-To: <5034D210.8060109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello Mark,


> Not sure what version of glibc Wheezy has, but try to make sure you have
> one that supports syncfs (you'll also need a semi-new kernel, 3.0+
> should be fine).
>

Wheezy has a fairly recent kernel :
# uname -a
Linux ceph-osd-0 3.2.0-3-amd64 #1 SMP Mon Jul 23 02:45:17 UTC 2012 
x86_64 GNU/Linux

>
> default values are quite a bit lower for most of these.  You may want to
> play with them and see if it has an effect.
>

I found these values on this ML. I haven't tried to tweak them but it is 
much better than with default values. I will try to change it.

>
> RBD caching should definitely be enabled for a test like this.  I'd be
> surprised if you got 42MB/s without it though...
>

root@ceph-osd-0:~# ceph --admin-daemon /var/run/ceph/ceph-osd.0.asok 
config show | grep rbd
debug_rbd = 0/5
rbd_cache = false
rbd_cache_size = 33554432
rbd_cache_max_dirty = 25165824
rbd_cache_target_dirty = 16777216
rbd_cache_max_dirty_age = 1

In my opinions, performances from RBD client are decent.
Unfortunately I need concurrent access and CephFS is really appealing in 
that respect.

>
> Ouch, that's taking a while!  In addition to the comments that David
> made, be aware that you are also testing the metadata server with
> cephFS.  Right now that's not getting a lot of attention as we are
> primarily focusing on RADOS performance at the moment.  For this kind of
> test though, distributed filesystems will never be as good as local
> disks...
>

Yes, it may be the MDS that is the bottleneck. Perhaps I should have a 
lot of them...

>
> Are you putting both journals on the SSD when you add an OSD?  If so,
> what's the throughput your SSD can sustain?
>

Both journals are on the SSD. It seems that when I do "ceph-osd -i $id 
--mkfs --mkkey" it creates the journal according to the settings in 
ceph.conf.
I did some tests and my SSD drive is somewhat broken... Crucial C300 is 
a bit old and can only do 80MB/s writing.

>
> You may want to check and see how big the IOs going to disk are on the
> OSD node, and how quickly you are filling up the journal vs writing out
> to disk.  "collectl -sD -oT" will give you a nice report.  Iostat can
> probably tell you all of the same stuff with the right flags.
>

Thank you for that tool.

Denis
