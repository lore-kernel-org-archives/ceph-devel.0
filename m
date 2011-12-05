From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Cannot create an rbd image
Date: Mon, 05 Dec 2011 19:04:49 +0100
Message-ID: <2508383.FSKSEkVnGt@pc10>
References: <3559228.m2Jnrzo7Vd@pc10> <4EDD0602.1070905@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:40977 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932551Ab1LESEv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Dec 2011 13:04:51 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id A3E5C10C866
	for <ceph-devel@vger.kernel.org>; Mon,  5 Dec 2011 19:04:50 +0100 (CET)
In-Reply-To: <4EDD0602.1070905@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Montag, 5. Dezember 2011, 09:57:22 schrieb Josh Durgin:
> On 12/05/2011 08:57 AM, Guido Winkelmann wrote:
> > Hi,
> > 
> > I cannot create a new rbd image in a newly created ceph cluster. When I
> > try it, I get these messages:
> > 
> > # rbd create testimage1 --size 10000
> 
> <other output trimmed>
> 
> > 2011-12-05 17:41:00.994075 7ffe8b5c3760 librbd: failed to assign a block
> > name for image
> > create error: error 5: Input/output error
> 
> This usually happens because your osds can't find cls_rbd.so. They
> search for it in osd_class_dir, which may not be set correctly by
> default (bug #1722). Most likely it's looking in /usr/lib/rados-classes
> instead of /usr/lib64/rados-classes - change osd_class_dir in your
> ceph.conf and restart the osds to fix it.

That did the trick, thanks!

(It was /usr/local/lib/rados-classes actually)

	Guido
