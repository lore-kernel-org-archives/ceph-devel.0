From: Christoph Hellwig <hch@infradead.org>
Subject: Re: all rbd users: set 'filestore fiemap = false'
Date: Mon, 18 Jun 2012 04:57:20 -0400
Message-ID: <20120618085719.GA7592@infradead.org>
References: <Pine.LNX.4.64.1206172053320.16985@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:34216
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751716Ab2FRI5V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Mon, 18 Jun 2012 04:57:21 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1206172053320.16985@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Sun, Jun 17, 2012 at 09:02:15PM -0700, Sage Weil wrote:
> that data over the wire.  We have observed incorrect/changing FIEMAP on 
> both btrfs:

both btrfs and?

Btw, btrfs had SEEK_HOLE/SEEK_DATA which are a lot more useful for this
kind of operations, and xfs has added support for it as well now.

