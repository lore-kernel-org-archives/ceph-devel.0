From: Christoph Hellwig <hch@infradead.org>
Subject: Re: os recommendations
Date: Wed, 27 Nov 2013 00:14:26 -0800
Message-ID: <20131127081426.GA12165@infradead.org>
References: <CAMNMNTz+whZWk55qCxx_8JCRWAruoHYz+stHYS93gBiU3qz3SQ@mail.gmail.com>
 <20131126142243.GA7360@infradead.org>
 <alpine.DEB.2.00.1311260647310.24677@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43118 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab3K0IOb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Nov 2013 03:14:31 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1311260647310.24677@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dominik Mostowiec <dominikmostowiec@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On Tue, Nov 26, 2013 at 06:50:33AM -0800, Sage Weil wrote:
> If syncfs(2) is not present, we have to use sync(2).  That means you have 
> N daemons calling sync(2) to force a commit on a single fs, but all other 
> mounted fs's are also synced... which means N times the sync(2) calls.
> 
> Fortunately syncfs(2) has been around for a while now, so this only 
> affects really old distros.  And even when glibc does not have a syscall 
> wrapper for it, we try to call the syscall directly.

And for btrfs you were/are using magic ioctls, right.

Looks like the page reference in the last post has already been updated,
thanks!
