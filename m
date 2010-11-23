From: Sage Weil <sage@newdream.net>
Subject: Re: potential null dereference in __dcache_readdir()
Date: Mon, 22 Nov 2010 23:21:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011222315250.17131@cobra.newdream.net>
References: <20101119115220.GA2111@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60752 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364Ab0KWHRV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Nov 2010 02:17:21 -0500
In-Reply-To: <20101119115220.GA2111@bicker>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: ceph-devel@vger.kernel.org

Hi Dan,

On Fri, 19 Nov 2010, Dan Carpenter wrote:
> Hi hi!
> 
> This is a smatch thing.  We check if last is NULL and then dereference
> it later with out checking.  It might be worth looking at.  I'm not
> familiar enough with the code to know the fix.
> 
> It comes from:
> 	commit 2817b000b02c5f0c05af67c01fb2684e1381d6ef
> 	Author: Sage Weil <sage@newdream.net>
> 	Date:   Tue Oct 6 11:31:08 2009 -0700
> 
> 	    ceph: directory operations
> 
> regards,
> dan carpenter
> 
> fs/ceph/dir.c +124 __dcache_readdir(28) error: we previously assumed 'last' could be null.
>    116          /* start at beginning? */
>    117          if (filp->f_pos == 2 || (last &&
>                                          ^^^^
> 	checked here.
> 
>    118                                   filp->f_pos < ceph_dentry(last)->offset)) {
>    119                  if (list_empty(&parent->d_subdirs))
>    120                          goto out_unlock;
>    121                  p = parent->d_subdirs.prev;
>    122                  dout(" initial p %p/%p\n", p->prev, p->next);
>    123          } else {
>    124                  p = last->d_u.d_child.prev;
>                             ^^^^^^^^^^^^^^^^^^^^^^
> 	dereferenced here.

Yep, that's a bit weird.  Normally last is only NULL when filp->f_pos == 
2, so this doesn't normally come up, but it could if you were a weirdo and 
llseeked forward on the dir.  I'll fix it up.

Thanks!
sage

