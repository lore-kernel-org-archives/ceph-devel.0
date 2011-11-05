From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] FileJournal: stop using sync_file_range
Date: Sat, 5 Nov 2011 03:27:13 -0400
Message-ID: <20111105072713.GA16651@infradead.org>
References: <20111103214508.GA19234@infradead.org>
 <Pine.LNX.4.64.1111041723440.29096@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:37790
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750961Ab1KEH1P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 5 Nov 2011 03:27:15 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1111041723440.29096@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel@vger.kernel.org

On Fri, Nov 04, 2011 at 05:29:04PM -0700, Sage Weil wrote:
> On Thu, 3 Nov 2011, Christoph Hellwig wrote:
> > Using sync_file_range means that neither any required metadata gets commited,
> > nor the disk cache gets flushed.  Stop using it for the journal, and add
> > a comment on why a fsync_range system call would be helpful here.
> 
> Sigh... doesn't that mean that sync_file_range is almost completely 
> useless?  
> 
> (Okay, not completely useless; we use it in FileStore.cc to push data to 
> disk quickly so that the eventual sync(2) is faster.)

Yeah, you found the rare use case for it. 

> > Btw, why does the code use O_SYNC (and not even O_DSYNC!) if using 
> > direct I/O, but fdatasync/fsync for buffered I/O?  Avoiding cache 
> > flushes and metadata updates for every writes is just as important for 
> > direct I/O as it is for buffered I/O.
> 
> Good call.. looks like I added it in 2010-02 but I couldn't tell you why.  

I'm going to look into that once I have a real test setup.  There's a
few other I/O related bits I want to investigate, too.

