From: Christoph Hellwig <hch@infradead.org>
Subject: Re: ceph on btrfs [was Re: ceph on non-btrfs file systems]
Date: Tue, 25 Oct 2011 06:23:30 -0400
Message-ID: <20111025102330.GA18415@infradead.org>
References: <Pine.LNX.4.64.1110231739380.25255@cobra.newdream.net>
 <CAO47_-9jp===DT=scpe=U8BnPnUCAVz7xUWVCC9AMVmx67CdaA@mail.gmail.com>
 <Pine.LNX.4.64.1110240941500.15349@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:37992
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754745Ab1JYKXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 25 Oct 2011 06:23:32 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1110240941500.15349@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org

On Mon, Oct 24, 2011 at 10:06:49AM -0700, Sage Weil wrote:
> > - When I run ceph with btrfs snaps disabled, the situation is getting
> > slightly better. I can run an OSD for about 3 days without problems,
> > but then again the load increases. This time, I can see that the
> > ceph-osd (blkdev_issue_flush) and btrfs-endio-wri are doing more work
> > than usual.
> 
> FYI in this scenario you're exposed to the same journal replay issues that 
> ext4 and XFS are.  The btrfs workload that ceph is generating will also 
> not be all that special, though, so this problem shouldn't be unique to 
> ceph.

What journal replay issues would ext4 and XFS be exposed to?

