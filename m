From: Christoph Hellwig <hch@infradead.org>
Subject: Re: Forever growing data in ceph using RBD image
Date: Thu, 17 Jul 2014 09:47:12 -0700
Message-ID: <20140717164712.GA4690@infradead.org>
References: <53C7D97D.3010607@kepler.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57916 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbaGQQrM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jul 2014 12:47:12 -0400
Content-Disposition: inline
In-Reply-To: <53C7D97D.3010607@kepler.cl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alphe Salas <asalas@kepler.cl>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jul 17, 2014 at 10:11:09AM -0400, Alphe Salas wrote:
> Usually when I talk to dev team about this problem they tell me that the
> real problem is the lack of trim in XFS, but my own analysis shows that the
> real problem is ceph internal way to handle data. It is ceph that never
> discard any replicas and never "clean" itself to only keep records of the
> data in use.

XFS supports TRIM just fine - with -o discard it will issue TRIMs on
unlink, and with fstrim you can do it explicitly.  Note that the online
discard might be very slow for all Linux filesystems, although I've not
actually tested it on top of RBD.

