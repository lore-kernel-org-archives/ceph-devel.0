From: Sage Weil <sage@newdream.net>
Subject: Re: OSD: no current directory
Date: Tue, 11 Oct 2011 10:48:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110111045330.20977@cobra.newdream.net>
References: <CAO47_-9FW_wD7+fD_ihGFivZD=FN1mx=32FJumNehtmvKGhqFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45020 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754830Ab1JKRsT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Oct 2011 13:48:19 -0400
In-Reply-To: <CAO47_-9FW_wD7+fD_ihGFivZD=FN1mx=32FJumNehtmvKGhqFg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 11 Oct 2011, Christian Brunner wrote:
> Maybe this one is easier:
> 
> One of our OSDs isn't starting, because ther is no "current"
> directory. What I have are three snap directories.
> 
> total 0
> -rw-r--r-- 1 root root   37 Oct  9 15:57 ceph_fsid
> -rw-r--r-- 1 root root    8 Oct  9 15:57 fsid
> -rw-r--r-- 1 root root   21 Oct  9 15:57 magic
> drwxr-xr-x 1 root root 7986 Oct 11 18:34 snap_506043
> drwxr-xr-x 1 root root 7986 Oct 11 18:34 snap_507364
> drwxr-xr-x 1 root root 7814 Oct 11 18:36 snap_507417
> -rw-r--r-- 1 root root    4 Oct  9 15:57 store_version
> -rw-r--r-- 1 root root    2 Oct  9 15:57 whoami
> 
> Is there a way to rollback the latest?

That's what the OSD actually does on startup (roll back to the newest 
snap_).  It's probably a trivial bug that's preventing startup now... I'll 
take a look.  In the meantime, you can clone the latest snap_ to current 
and it should start!

sage
