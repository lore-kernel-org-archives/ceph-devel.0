From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Unable to restart Mon after reboot
Date: Tue, 3 Jul 2012 12:53:58 -0400
Message-ID: <20120703165358.GA12567@infradead.org>
References: <BDAE812E-2659-4025-9B30-2DEC6675B59A@100percentit.com>
 <4FE55567.6080201@inktank.com>
 <4FE558CB.4010509@inktank.com>
 <F38AD123-3C97-44BD-ABE5-33635AD6D768@100percentit.com>
 <CADvuQRFcgPOy765-cYSVT1DPjOZ5nPXSb1Lr1Xjt5e3rU7joNw@mail.gmail.com>
 <45F11B42CB5830479EF0E56A27F4E68D7F12ED@exchange1.ad.100it.net>
 <CADvuQRFkf8gHOknnj5zyRDBivYttC2Z1CCueZeXH5mnk+11fvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:43883
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756088Ab2GCQyA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 12:54:00 -0400
Content-Disposition: inline
In-Reply-To: <CADvuQRFkf8gHOknnj5zyRDBivYttC2Z1CCueZeXH5mnk+11fvQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tommi Virtanen <tv@inktank.com>
Cc: David Blundell <David.Blundell@100percentit.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 03, 2012 at 09:44:38AM -0700, Tommi Virtanen wrote:
> We've seen similar issues with btrfs, and others have reported that
> the large metadata btrfs option helps. We're still compiling
> information, but as of right now I hear best performance tends to
> happen with xfs; however, the lead position tends to shift around a
> lot.

Btw, does anyone know which part of the btrfs metadata is hit hard?
It's been a while that I looked at the OSD code, but IIRC it didn't
create too big directories, does it?  For heavy directory operations
XFS filesystems created using large directorit blocks (mkfs.xfs -n
size=64k) will also provide additional benefits.

Also IIRC the OSDs have a directory per VDI image - for that kind of
usage pattern the -o filestreams mount option of XFS should provide
even more performance advatages.  Either way make sure to mount with
-o inode64, and for not so recent kernels -o delaylog.
