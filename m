From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Unable to restart Mon after reboot
Date: Tue, 3 Jul 2012 13:24:06 -0400
Message-ID: <20120703172406.GA4916@infradead.org>
References: <BDAE812E-2659-4025-9B30-2DEC6675B59A@100percentit.com>
 <4FE55567.6080201@inktank.com>
 <4FE558CB.4010509@inktank.com>
 <F38AD123-3C97-44BD-ABE5-33635AD6D768@100percentit.com>
 <CADvuQRFcgPOy765-cYSVT1DPjOZ5nPXSb1Lr1Xjt5e3rU7joNw@mail.gmail.com>
 <45F11B42CB5830479EF0E56A27F4E68D7F12ED@exchange1.ad.100it.net>
 <CADvuQRFkf8gHOknnj5zyRDBivYttC2Z1CCueZeXH5mnk+11fvQ@mail.gmail.com>
 <20120703165358.GA12567@infradead.org>
 <Pine.LNX.4.64.1207030959320.28638@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 173-166-109-252-newengland.hfc.comcastbusiness.net ([173.166.109.252]:44039
	"EHLO bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755999Ab2GCRYI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Jul 2012 13:24:08 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1207030959320.28638@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Christoph Hellwig <hch@infradead.org>, Tommi Virtanen <tv@inktank.com>, David Blundell <David.Blundell@100percentit.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 03, 2012 at 10:09:33AM -0700, Sage Weil wrote:
> The OSD keeps directories small on its own by breaking the contents of 
> large directories into smaller subdirectories.

Right, that's what I remembered.  At least for XFS that'll actually
give you much worse allocation patters as each new directory rotates
to a new allocation group.

> That said, on one system we did see what looked like crazy bad 
> fragmentation on an XFS directory... it had maybe 5 subdirs in it and many 
> many blocks.  That was probably shortly after it had been big and rehashed 
> its contents into the subdirs.  Yehuda probably remembers more.

Another reason why not doing the artifical directories is better...

> In any case, is there a way to prod XFS into defragging a specific 
> directory?

No.  XFS can only defragment regular files at the moment.

