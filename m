From: Christoph Hellwig <hch@lst.de>
Subject: Re: --with-libxfs error on F23.
Date: Wed, 30 Mar 2016 17:37:22 +0200
Message-ID: <20160330153722.GA19902@lst.de>
References: <87oa9xndeq.fsf@ira-t430.wakeful.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:32832 "EHLO newverein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107AbcC3PhZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Mar 2016 11:37:25 -0400
Content-Disposition: inline
In-Reply-To: <87oa9xndeq.fsf@ira-t430.wakeful.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ira Cooper <ira@wakeful.net>
Cc: ceph-devel@vger.kernel.org, hch@lst.de

On Tue, Mar 29, 2016 at 06:10:37PM -0400, Ira Cooper wrote:
> ira@ira-t430:/usr/include/xfs
> [/dev/pts/1](1002/0)$ ag off64_t
> linux.h
> 145:typedef off64_t		xfs_off_t;
> 
> off64_t isn't there by default.

off64_t requires _LARGEFILE64_SOURCE on Linux/glibc which still likes
to make applications not handle large file offsets and inodes by default,
something which 4.4BSD solved 20 years ago.

We have no intent in supporting non-large file applications in
xfsprogs, so I think the right thing is to ensure that your configure
checks defines _LARGEFILE64_SOURCE.  I'm pretty sure the applications
actually already do that, and it's just the configure machinery that's
lazy.
