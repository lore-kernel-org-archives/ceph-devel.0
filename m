From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Forever growing data in ceph using RBD image
Date: Thu, 17 Jul 2014 11:57:14 -0700
Message-ID: <20140717185714.GA10709@infradead.org>
References: <53C7D97D.3010607@kepler.cl>
 <alpine.DEB.2.00.1407170931270.3932@cobra.newdream.net>
 <53C81266.6080306@kepler.cl>
 <alpine.DEB.2.00.1407171121040.3932@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:42290 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084AbaGQS5Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jul 2014 14:57:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1407171121040.3932@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Alphe Salas <asalas@kepler.cl>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 17, 2014 at 11:27:31AM -0700, Sage Weil wrote:
> I assume you are using kvm/qemu?  It may be that older versions aren't 
> passing through trims; Josh would know more.  Or maybe the trim sizes are 
> too small to let rados effectively deallocate entire objects.  Logs might 
> help there.

At least for the qemu version from a few month ago that I'm using in my
testing I explicitly have to enable passthrough of UNMAP/TRIM on the
qemu command line.
