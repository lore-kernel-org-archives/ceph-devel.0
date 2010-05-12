From: Sage Weil <sage@newdream.net>
Subject: Re: mkcephfs 0.20 failure on debian: FAILED assert(r == 0)
Date: Wed, 12 May 2010 12:55:12 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005121249590.7032@cobra.newdream.net>
References: <hrhh53$gf3$2@dough.gmane.org> <loom.20100512T140305-368@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57925 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754769Ab0ELTwH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 May 2010 15:52:07 -0400
In-Reply-To: <loom.20100512T140305-368@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jean-Adrien <adv1@jeanjean.ch>
Cc: ceph-devel@vger.kernel.org

On Wed, 12 May 2010, Jean-Adrien wrote:
> I try to setup a little test cluster using kvm, and I have exactly the same
> problem.

This is fixed in git, and there are 'testing' packages built that include 
the fix (a v0.20.1 release with these will be out shortly).  Just adjust 
your /etc/apt/source.list to use 'ceph-testing', like so:

 deb http://ceph.newdream.net/debian/ squeeze ceph-testing
 deb-src http://ceph.newdream.net/debian/ squeeze ceph-testing

Alternatively, adding

        osd journal size = 100

to your ceph.conf, or simply creating the journal yourself with 'dd' will 
avoid the issue.

> Moreover, I notice that when I want to delete the data created in the btrfs
> partition it is not possible to remove the current directory, even if it is
> empty:
> 
> root@cods-1:/mnt/btrfs/data# rm -rf osd0/
> rm: cannot remove directory `osd0/current': Directory not empty
>
> The only way is to reformat the partition (mkfs.btrfs /dev/sdb1)

This is a btrfs thing.. you can't remove subvolumes with rmdir.  'btrfsctl 
-D current' will do the trick.  Or, the latest cosd will clean them up for 
you.

sage
