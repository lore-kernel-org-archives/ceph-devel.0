From: Sage Weil <sage@inktank.com>
Subject: Re: Unable to restart Mon after reboot
Date: Tue, 3 Jul 2012 10:09:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1207030959320.28638@cobra.newdream.net>
References: <BDAE812E-2659-4025-9B30-2DEC6675B59A@100percentit.com>
 <4FE55567.6080201@inktank.com> <4FE558CB.4010509@inktank.com>
 <F38AD123-3C97-44BD-ABE5-33635AD6D768@100percentit.com>
 <CADvuQRFcgPOy765-cYSVT1DPjOZ5nPXSb1Lr1Xjt5e3rU7joNw@mail.gmail.com>
 <45F11B42CB5830479EF0E56A27F4E68D7F12ED@exchange1.ad.100it.net>
 <CADvuQRFkf8gHOknnj5zyRDBivYttC2Z1CCueZeXH5mnk+11fvQ@mail.gmail.com>
 <20120703165358.GA12567@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59508 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2GCRJg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 13:09:36 -0400
In-Reply-To: <20120703165358.GA12567@infradead.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Tommi Virtanen <tv@inktank.com>, David Blundell <David.Blundell@100percentit.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 3 Jul 2012, Christoph Hellwig wrote:
> On Tue, Jul 03, 2012 at 09:44:38AM -0700, Tommi Virtanen wrote:
> > We've seen similar issues with btrfs, and others have reported that
> > the large metadata btrfs option helps. We're still compiling
> > information, but as of right now I hear best performance tends to
> > happen with xfs; however, the lead position tends to shift around a
> > lot.
> 
> Btw, does anyone know which part of the btrfs metadata is hit hard?
> It's been a while that I looked at the OSD code, but IIRC it didn't
> create too big directories, does it?  For heavy directory operations
> XFS filesystems created using large directorit blocks (mkfs.xfs -n
> size=64k) will also provide additional benefits.

The OSD keeps directories small on its own by breaking the contents of 
large directories into smaller subdirectories.

That said, on one system we did see what looked like crazy bad 
fragmentation on an XFS directory... it had maybe 5 subdirs in it and many 
many blocks.  That was probably shortly after it had been big and rehashed 
its contents into the subdirs.  Yehuda probably remembers more.

In any case, is there a way to prod XFS into defragging a specific 
directory?

sage
