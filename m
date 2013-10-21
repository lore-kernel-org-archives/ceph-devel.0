From: Christoph Hellwig <hch@infradead.org>
Subject: Re: poor read performance on rbd+LVM, LVM overload
Date: Mon, 21 Oct 2013 07:11:47 -0700
Message-ID: <20131021141147.GA30189@infradead.org>
References: <CAE63xUO1jhgxQoRbJU-8+j-cxRB7QEspu=JWvekp9ExzFmnjSA@mail.gmail.com>
 <alpine.DEB.2.00.1310160914360.22271@cobra.newdream.net>
 <20131017151828.GB28859@redhat.com>
 <CAE63xUPtovZwGq=4Xseq3DJ+uAyGJJmYbO70ry=WJqqGcBamRA@mail.gmail.com>
 <alpine.DEB.2.00.1310181657151.19763@cobra.newdream.net>
 <CAE63xUO4ZrzObMFeQ=FXGFnqpwWsjCiiDr2_VhOt91h=djofYw@mail.gmail.com>
 <alpine.DEB.2.00.1310202051240.29488@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:39968 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab3JUOLz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Oct 2013 10:11:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1310202051240.29488@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Ugis <ugis22@gmail.com>, Mike Snitzer <snitzer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>, linux-lvm@redhat.com, elder@inktank.com

On Sun, Oct 20, 2013 at 08:58:58PM -0700, Sage Weil wrote:
> It looks like without LVM we're getting 128KB requests (which IIRC is 
> typical), but with LVM it's only 4KB.  Unfortunately my memory is a bit 
> fuzzy here, but I seem to recall a property on the request_queue or device 
> that affected this.  RBD is currently doing

Unfortunately most device mapper modules still split all I/O into 4k
chunks before handling them.  They rely on the elevator to merge them
back together down the line, which isn't overly efficient but should at
least provide larger segments for the common cases.

