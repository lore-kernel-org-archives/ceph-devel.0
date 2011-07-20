From: Sage Weil <sage@newdream.net>
Subject: Re: rm directory slow, client read it local cache
Date: Wed, 20 Jul 2011 09:12:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107200908480.28838@cobra.newdream.net>
References: <CABAwU-YcMdTpZy9iCjPyDn_+Vp+4wWzEo1WqocghH3no-s0gtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33110 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab1GTQJG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jul 2011 12:09:06 -0400
In-Reply-To: <CABAwU-YcMdTpZy9iCjPyDn_+Vp+4wWzEo1WqocghH3no-s0gtQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 20 Jul 2011, huang jun wrote:
> hi,all
> we do test about "rm directories" repeatedly, and the result confused us a lot.
> build ceph v0.30 on linux-2.6.37
> folllow below steps:
> $ mount -t ceph 192.168.0.11:/ /mnt
> $ mkdir /mnt/a
> $ cd /mnt
> $ rm -rf a
> from the kernel client debug log, in the process "readdir a", we can't
> read directory "a" in client's cache,
>  trace to  soruce code , we find "(ci->i_ceph_flags &
> CEPH_I_COMPLETE)" is false, so client can't do "__dcache_readdir"
> function(Dir.c line 262),which was used to read data from cache.
> so client sends a request to MDS to get infomation of dir "a", that
> consumes much time, we can not tolerate if it needs 10s to remove 10
> dirs. we are not clear that why client can't read dir "a" from it
> local cache?

This is blocked by the addition of a d_prune dentry operation in the 
upstream kernel.  Hopefully that will get merged during this next window.  
See my July 8 email to linux-fsdevel and LKML.

Previously we were hooked into the d_release callback, but that was racy: 
it was possible for ceph to think the directory was complete when in fact 
it was not.  ->d_prune() will fix that when it's merged and this 
capability will get turned back on.

sage
