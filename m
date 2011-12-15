From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 17:51:15 +0100
Message-ID: <1506085.0EuulaqoFR@pc10>
References: <1404301.on6okQVZ04@pc10> <3807778.ycpoZxnZL4@pc10> <4EEA20DA.3030006@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:53147 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932644Ab1LOQvR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Dec 2011 11:51:17 -0500
In-Reply-To: <4EEA20DA.3030006@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

Am Donnerstag, 15. Dezember 2011, 17:31:22 schrieb Martin Mailand:
> Hi Guido,
> I am running ceph version 0.39-37-g54758ab
> (commit:54758abccf429122c1bc3bce6d01bc33f1cfe238) on my cluster and I do
> not see this problem. Do you use the qemu rbd block driver or the kernel
> mount?
> How did you install ceph, via the packages?

I downloaded the tarball from 
http://ceph.newdream.net/download/ untarred it, and did the usual ./configure ; 
make ; make install. Though if I were to do it again, I would prefer rpmbuild 
now.

The host system is CentOS 6, with the Kernel upgraded to 3.1.1, btw.

	Guido
