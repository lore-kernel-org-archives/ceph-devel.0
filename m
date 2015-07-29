From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Ceph write path optimization
Date: Tue, 28 Jul 2015 23:57:08 -0700
Message-ID: <20150729065708.GA27890@infradead.org>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDE784B@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57718 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbbG2G5J (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 02:57:09 -0400
Content-Disposition: inline
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F2CDE784B@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 28, 2015 at 09:08:27PM +0000, Somnath Roy wrote:
> 2. Each filestore Op threads is now doing O_DSYNC write followed by
> posix_fadvise(**fd, 0, 0, POSIX_FADV_DONTNEED);

Where aren't you using O_DIRECT | O_DSYNC?

> 15. The main challenge I am facing in both the scheme is XFS metadata 
> flush process (xfsaild) is choking all the processes accessing the disk
> when it is waking up. I can delay it till max 30 sec and if there are
> lot of dirty metadata, there is a performance spike down for very brief
> amount of time. Even if we are acknowledging writes from say NVRAM
> journal write, still the opthreads are doing getattrs on the XFS
> and those threads are getting blocked.

Can you send a more detailed report to the XFS lists?  E.g. which locks
your blocked on and some perf data?

