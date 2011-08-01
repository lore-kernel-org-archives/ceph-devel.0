From: Sage Weil <sage@newdream.net>
Subject: Re: [GIT PULL] Ceph updates for 3.1-rc1
Date: Sun, 31 Jul 2011 21:53:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107311547000.23447@cobra.newdream.net>
References: <Pine.LNX.4.64.1107261152440.2593@cobra.newdream.net>
 <20110731183556.GA23133@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51935 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab1HAEta (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 00:49:30 -0400
In-Reply-To: <20110731183556.GA23133@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org

On Sun, 31 Jul 2011, Christoph Hellwig wrote:
> On Tue, Jul 26, 2011 at 01:36:37PM -0700, Sage Weil wrote:
> > Sage Weil (19):
> >       ceph: add flags field to file_info
> >       ceph: add F_SYNC file flag to force sync (non-O_DIRECT) io
> 
> Can you document what the exact semantics of this flag are, and how
> they different from using O_SYNC/O_DSYNC.

I should document this... in the fs/ceph/ioctl.h?  Not sure where this 
normally goes.

The CEPH_F_SYNC flag forces synchronous reads/writes that bypass the page 
cache.  It's similar to O_DIRECT, but makes a copy of the data before 
doing the IO and does not have the alignment restrictions.

The real value is that it forces us to take a code path that's hard to 
trigger otherwise.  When a single client writes to a file, we can do 
buffered IO.  Even with O_SYNC/D_SYNC this just causes a flush after every 
write.  When multiple clients open a file for read/write, though, ceph 
bypasses the page cache and does synchronous IO to the server.  It's 
similar to the O_DIRECT path, but not quite, and doesn't get good test 
coverage without an easy way to use it.  

A ceph ioctl sets the CEPH_F_SYNC flag in the file private struct.  It's 
similar to the CEPH_F_LAZYIO ioctl, but with opposite results; that one 
avoids sync io despite multi-client write sharing (for applications who 
know what they're doing).

sage

