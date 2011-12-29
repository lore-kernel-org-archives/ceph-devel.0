From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/3] ceph: take a reference to the dentry in
 d_find_any_alias()
Date: Thu, 29 Dec 2011 04:11:08 -0500
Message-ID: <20111229091108.GB5257@infradead.org>
References: <1325124315-3487-1-git-send-email-sage@newdream.net>
 <1325124315-3487-3-git-send-email-sage@newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:37316
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751829Ab1L2JLJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 29 Dec 2011 04:11:09 -0500
Content-Disposition: inline
In-Reply-To: <1325124315-3487-3-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Alex Elder <elder@dreamhost.com>

On Wed, Dec 28, 2011 at 06:05:14PM -0800, Sage Weil wrote:
> From: Alex Elder <elder@dreamhost.com>
> 
> The ceph code duplicates __d_find_any_alias(), but it currently
> does not take a reference to the returned dentry as it should.
> Replace the ceph implementation with an exact copy of what's
> found in "fs/dcache.c", and update the callers so they drop
> their reference when they're done with it.
> 
> Unfortunately this requires the wholesale copy of the functions
> that implement __dget().  It would be much nicer to just export
> d_find_any_alias() from "fs/dcache.c" instead.

Just exporting it would indeed be much better.

