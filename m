From: Sage Weil <sweil@redhat.com>
Subject: Re: Forever growing data in ceph using RBD image
Date: Thu, 17 Jul 2014 12:28:11 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407171227110.3932@cobra.newdream.net>
References: <53C7D97D.3010607@kepler.cl> <alpine.DEB.2.00.1407170931270.3932@cobra.newdream.net> <53C81266.6080306@kepler.cl> <alpine.DEB.2.00.1407171121040.3932@cobra.newdream.net> <20140717185714.GA10709@infradead.org> <53C821AC.1080307@kepler.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56567 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbaGQT2M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jul 2014 15:28:12 -0400
In-Reply-To: <53C821AC.1080307@kepler.cl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alphe Salas <asalas@kepler.cl>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 17 Jul 2014, Alphe Salas wrote:
> I don t use QEMU /KVM just a plain regular rbd image format 1 map and mounted
> to a real machine that is used as proxy for data droping to ceph.

Oh, that explains part of it at least. The discard support isn't yet 
upstream for the kernel RBD driver.  The patches are mostly ready but 
there was a QA failure they're chasing down first.  Hopefully it will make 
it into the next kernel cycle.

sage
