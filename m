From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/6] ceph: virtual extended attribute cleanup
Date: Tue, 28 Feb 2012 23:20:44 -0500
Message-ID: <20120229042044.GB1865@infradead.org>
References: <4F4D98D5.1010506@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:56266
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752935Ab2B2EUo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Feb 2012 23:20:44 -0500
Content-Disposition: inline
In-Reply-To: <4F4D98D5.1010506@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Feb 28, 2012 at 07:17:41PM -0800, Alex Elder wrote:
> This series cleans up some code involving ceph's virtual extended
> attributes.  Three of them define some simple macros are set up to
> help ensure the attributes are defined in a consistent way.  One
> makes the size of certain constant values get defined at startup
> time rather than repeatedly, and the remaining two are some very
> small changes made for clarity.

Is there any reason you can't use the generic_*xattr helpers that
parse attribute names and use the handler array in the superblock?

I'm still vaguely planning on getting all remaining filesystems
converted over to it.
