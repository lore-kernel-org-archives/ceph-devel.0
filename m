From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 0/3] ceph: fix a few problems in ceph_dir_*_complete()
Date: Thu, 22 Dec 2011 12:12:05 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112221203440.3284@cobra.newdream.net>
References: <1324576249.3957.105.camel@doink>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60223 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751135Ab1LVUMG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Dec 2011 15:12:06 -0500
In-Reply-To: <1324576249.3957.105.camel@doink>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>, josh.durgin@dreamhost.com
Cc: ceph-devel@vger.kernel.org

On Thu, 22 Dec 2011, Alex Elder wrote:
> This series fixes a possible null pointer dereference in
> ceph_dir_set_complete().
> 
> It also fixes the ceph-private implementation of
> __d_find_any_alias() so it takes a reference to the
> returned dentry.  In addition, getting that reference
> to the dentry requires the Linux inode lock, so ensure
> that is taken by (duplicating and) using the locking
> form of that function, d_find_any_alias().

I pushed the first two to for-linus, and squashed the third into the patch 
it fixed.  Posting the series here.  Josh, can you schedule a regression 
suite run on that branch?

We should definitely replace the d_find_any_alias() stuff with an export 
from the VFS during the next window...

Thanks!
sage

