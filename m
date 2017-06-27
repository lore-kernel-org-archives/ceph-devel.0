From: Sage Weil <sage@newdream.net>
Subject: Re: cls_rbd copyup and write
Date: Tue, 27 Jun 2017 13:42:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1706271339330.3424@piezo.novalocal>
References: <CALZt5jzk+8yS7SY6L+5BNvKuTGDZV+KOW5b=vDqO=R7t_o9Vfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41702 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751605AbdF0NmT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2017 09:42:19 -0400
In-Reply-To: <CALZt5jzk+8yS7SY6L+5BNvKuTGDZV+KOW5b=vDqO=R7t_o9Vfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 27 Jun 2017, Ning Yao wrote:
> Hi, all
> 
> currently I find that when do copy on write for a clone image. librbd
> call the cls copyup function to write the data, reading from its
> parent, to the child.
> 
> However, there is a issue here:  if an object in the parent image -->
> [0, 8192] with data and [8192, end] without data, then after COW
> operation, it will filling the whole object [0, end] to the children
> object with [8192, end] all zeros. This phenomenon also occurs in
> flatten images.

Note that BlueStore (luminous) doesn't have this issue: the clone is an 
O(1) metadata operation and subsequent writes are basically copy-no-write.

> Actually, we already have sparse_read to just read data without holes.
> However, copyup function does not support to write serveral fragments
> such as {[0, 8192], [16384,20480]}.
> 
> So it that possible to direct send OSDOp {[cow write], [cow write],
> [user write]} instead of  OSDOp {[copyup], [user write]} ?

It seems like the better fix for FileStore is to make the copyup operation 
do a sparse_read and write only the allocated ranges.  I think the only 
issue there is that the two mechanisms for making sparse_read actually 
sparse are fiemap and seek_hole_data, both of which are disabled by 
default because they rely on newish or buggy-in-the-past kernel APIs and 
we want to avoid hard to diagnose breakage.  They should be enabled with 
caution.

sage
