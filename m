From: Christoph Hellwig <hch@infradead.org>
Subject: Re: all rbd users: set 'filestore fiemap = false'
Date: Fri, 22 Jun 2012 11:16:23 -0400
Message-ID: <20120622151623.GA18366@infradead.org>
References: <Pine.LNX.4.64.1206172053320.16985@cobra.newdream.net>
 <20120618085719.GA7592@infradead.org>
 <Pine.LNX.4.64.1206180830160.7376@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:55048
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758017Ab2FVPQY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Jun 2012 11:16:24 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1206180830160.7376@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel@vger.kernel.org

On Mon, Jun 18, 2012 at 08:32:50AM -0700, Sage Weil wrote:
> On Mon, 18 Jun 2012, Christoph Hellwig wrote:
> > On Sun, Jun 17, 2012 at 09:02:15PM -0700, Sage Weil wrote:
> > > that data over the wire.  We have observed incorrect/changing FIEMAP on 
> > > both btrfs:
> > 
> > both btrfs and?
> 
> Whoops, it was XFS.  :/

If you manage to extract a minimal test case I'd love to see it,  FIEMAP
is a complete mess, although most of the time the errors actually are on
the users side due to it's complicated semantics.

