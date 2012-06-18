From: Sage Weil <sage@inktank.com>
Subject: Re: all rbd users: set 'filestore fiemap = false'
Date: Mon, 18 Jun 2012 08:32:50 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206180830160.7376@cobra.newdream.net>
References: <Pine.LNX.4.64.1206172053320.16985@cobra.newdream.net>
 <20120618085719.GA7592@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49413 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2FRPcx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 11:32:53 -0400
In-Reply-To: <20120618085719.GA7592@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ceph-devel@vger.kernel.org

On Mon, 18 Jun 2012, Christoph Hellwig wrote:
> On Sun, Jun 17, 2012 at 09:02:15PM -0700, Sage Weil wrote:
> > that data over the wire.  We have observed incorrect/changing FIEMAP on 
> > both btrfs:
> 
> both btrfs and?

Whoops, it was XFS.  :/ 

> Btw, btrfs had SEEK_HOLE/SEEK_DATA which are a lot more useful for this
> kind of operations, and xfs has added support for it as well now.

Yeah, started looking at that last night.  (This code predates SEEK_HOLE.)

sage
