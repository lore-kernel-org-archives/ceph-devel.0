From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 2/3] fs/ceph/xattr.c: Use kasprintf
Date: Sun, 17 Oct 2010 21:02:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1010172101570.394@ask.diku.dk>
References: <1287341311-11161-1-git-send-email-julia@diku.dk>
 <1287341311-11161-3-git-send-email-julia@diku.dk> <1287341657.20968.61.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mgw2.diku.dk ([130.225.96.92]:52044 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932531Ab0JQTCl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 17 Oct 2010 15:02:41 -0400
In-Reply-To: <1287341657.20968.61.camel@Joe-Laptop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Sage Weil <sage@newdream.net>, kernel-janitors@vger.kernel.org, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, 17 Oct 2010, Joe Perches wrote:

> On Sun, 2010-10-17 at 20:48 +0200, Julia Lawall wrote:
> > Convert a sequence of kmalloc and memcpy to use kasprintf.  The argument is
> > checked for being a string by the presence of a previous call to strlen.
> []
> > diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
> []
> > @@ -716,10 +716,9 @@ int ceph_setxattr(struct dentry *dentry, const char *name,
> >  
> >  	/* preallocate memory for xattr name, value, index node */
> >  	err = -ENOMEM;
> > -	newname = kmalloc(name_len + 1, GFP_NOFS);
> > +	newname = kasprintf(GFP_NOFS, "%s", name);
> 
> This one is probably better converted to kmemdup
> as name_len is already known and is used later
> in the routine.
> 
> kstrdup is also a possibility.

That calculates the length again, so I will change it to kmemdup.

julia
