From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: Creating the filesystem and tweaking configurations
Date: Mon, 28 Mar 2011 14:21:24 -0700
Message-ID: <20110328212124.GC10768@dreamer>
References: <loom.20110328T213028-664@post.gmane.org>
 <Pine.LNX.4.64.1103281340050.20362@cobra.newdream.net>
 <AANLkTimJn0kp4e=CKKdx2g=fDD-JpDPgXwvMqCxFJc8F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:34032 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab1C1VV1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2011 17:21:27 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimJn0kp4e=CKKdx2g=fDD-JpDPgXwvMqCxFJc8F@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steena Monteiro <steena.m@aggiemail.usu.edu>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

On Mon, Mar 28, 2011 at 03:07:58PM -0600, Steena Monteiro wrote:
> This does seem to be the case. The osd log snippet:
...
> 2011-03-28 13:23:23.597008 b77b16d0  ** ERROR: error creating empty object
> store in /data/osd0: error 95: Operation not supported
> 
> Would *mount -t 127.0.0.1:/ /ceph, user_xattr* solve this?

This is about the local filesystem as accessed by the osd.

You need either btrfs, or ext3/4 with the user_xattr mount option, on
the filesystem that contains /data/osd0.

If it's ext3/4, as it seems to be, you can do this temporarily with:

   mount -o remount,user_xattr /data/osd0

If the actual filesystem root is /data or /, adjust accordingly.

To make that permanent, you need to edit /etc/fstab.

-- 
:(){ :|:&};:
