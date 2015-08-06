From: Sage Weil <sweil@redhat.com>
Subject: Re: FileStore should not use syncfs(2)
Date: Thu, 6 Aug 2015 05:57:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508060556540.22099@cobra.newdream.net>
References: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net> <CAAM7YAnH8QaKP1RY3zbLX=3eZd-4tVX1EL=sH-x4y0P5ydDtfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58667 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754043AbbHFNFq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 6 Aug 2015 09:05:46 -0400
In-Reply-To: <CAAM7YAnH8QaKP1RY3zbLX=3eZd-4tVX1EL=sH-x4y0P5ydDtfQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Somnath.Roy@sandisk.com, ceph-devel <ceph-devel@vger.kernel.org>, sjust@redhat.com

On Thu, 6 Aug 2015, Yan, Zheng wrote:
> On Thu, Aug 6, 2015 at 5:26 AM, Sage Weil <sweil@redhat.com> wrote:
> > Today I learned that syncfs(2) does an O(n) search of the superblock's
> > inode list searching for dirty items.  I've always assumed that it was
> > only traversing dirty inodes (e.g., a list of dirty inodes), but that
> > appears not to be the case, even on the latest kernels.
> >
> 
> I checked syncfs code in 3.10/4.1 kernel. I think both kernels only
> traverse dirty inodes (inodes in
> bdi_writeback::{b_dirty,b_io,b_more_io} lists). what am I missing?

See wait_sb_inodes in fs/fs-writeback.c, called by sync_inodes_sb.

sage
