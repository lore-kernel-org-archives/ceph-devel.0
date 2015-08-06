From: Christoph Hellwig <hch@infradead.org>
Subject: Re: FileStore should not use syncfs(2)
Date: Thu, 6 Aug 2015 06:06:36 -0700
Message-ID: <20150806130636.GA20436@infradead.org>
References: <alpine.DEB.2.00.1508051415070.26854@cobra.newdream.net>
 <20150806112747.GA21742@infradead.org>
 <alpine.DEB.2.00.1508060559410.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:50633 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbbHFNGh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Aug 2015 09:06:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1508060559410.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Somnath.Roy@sandisk.com, ceph-devel@vger.kernel.org, sjust@redhat.com

On Thu, Aug 06, 2015 at 06:00:42AM -0700, Sage Weil wrote:
> I'm guessing the strategy here should be to fsync the file (leaf) and then 
> any affected ancestors, such that the directory fsyncs are effectively 
> no-ops?  Or does it matter?

All metadata transactions log the involve parties (parent and child
inode(s) mostly) in the same transaction.  So flushing one of them out
is enough.  But file data I/O might dirty the inode before flushing them
out, so to not need to write out the inode log item twice you first want
to fsync any file that had data I/O followed by directories or special
files that only had metadata modified.
