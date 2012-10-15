From: Sage Weil <sage@inktank.com>
Subject: Re: OSD::mkfs: couldn't mount FileStore: error -22
Date: Sun, 14 Oct 2012 20:48:32 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210142044060.3424@cobra.newdream.net>
References: <k5dqro$s4d$1@ger.gmane.org> <507B2E71.4040706@inktank.com> <k5fha7$h3l$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44896 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab2JODsc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Oct 2012 23:48:32 -0400
In-Reply-To: <k5fha7$h3l$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Adam Nielsen <a.nielsen@shikadi.net>
Cc: ceph-devel@vger.kernel.org

On Mon, 15 Oct 2012, Adam Nielsen wrote:
> > The immediate cause of the problem is that the osd's "commit_op_seq" file is
> > reading back '0',
> > which is invalid; it's created with an initial value of 1.  Try removing the
> > osd data dir
> > (/var/lib/ceph/osd/ceph-0) completely and let it be recreated; perhaps
> > something got there somehow by mistake.
> 
> Well it looks like commit_op_seq was never created properly:
> 
> $ ls /var/lib/ceph/osd/ceph-0/current/
> total 4.0K
> drwxr-xr-x 1 root root 26 Oct 14 17:40 .
> drwxrwx--- 1 root root 74 Oct 14 17:40 ..
> -rw-r--r-- 1 root root  0 Oct 14 17:40 commit_op_seq
> 
> But how do I delete it to start again?
> 
> $ rm -rf current/
> rm: cannot remove `current': Directory not empty
> $ ls current/
> total 4.0K
> drwxr-xr-x 1 root root  0 Oct 15 09:16 .
> drwxrwx--- 1 root root 26 Oct 15 09:16 ..

current/ is a btrfs subvolume.. 'btrfs sub delete current' will remove it.

> This is on a brand new btrfs filesystem mounted in /var/lib/ceph/osd/ceph-0. I
> created it with this:
> 
> $ mkfs.btrfs -L data -s 4096 /dev/sda1
> 
> Did I do something wrong?

The warning in the previous email suggets you're running a fairly old 
kernel.. there is probably something handled incorrectly during the fs 
init process.  Exactly which kernel are you running?

In any case, btrfs isn't going to work particularly well on something that 
old; I suggest running something newer (3.5 or 3.6) or switching to XFS.

sage
