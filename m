From: Christoph Hellwig <hch@infradead.org>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 04:14:42 -0400
Message-ID: <20120626081442.GA12789@infradead.org>
References: <4FE60A65.2030800@profihost.ag>
 <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:41468
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758349Ab2FZIOq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 26 Jun 2012 04:14:46 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jun 25, 2012 at 03:11:17PM -0700, Sage Weil wrote:
> On Sat, 23 Jun 2012, Stefan Priebe wrote:
> > Hi,
> > 
> > i got stuck while selecting the right FS for ceph / RBD.
> > 
> > XFS:
> > - deadlock / hung task under 3.0.34 in xfs_ilock / xfs_buf_lock while syncfs
> 
> There was an ilock fix that went into 3.4, IIRC.  Have you tried vanilla 
> 3.4?  We are seeing some lockdep noise currently, but no deadlocks yet.

Stefan, which deadlock is this, did you report it to the XFS list?

Sage, which lockdep noise?

