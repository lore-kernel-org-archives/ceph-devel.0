From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random blocks when accessing rbd images
Date: Thu, 15 Dec 2011 18:32:32 +0100
Message-ID: <1716052.bJiDSmxyA4@pc10>
References: <1404301.on6okQVZ04@pc10> <3807778.ycpoZxnZL4@pc10> <4EEA20DA.3030006@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:53475 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758983Ab1LORci (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 15 Dec 2011 12:32:38 -0500
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id EB9F610C866
	for <ceph-devel@vger.kernel.org>; Thu, 15 Dec 2011 18:32:36 +0100 (CET)
In-Reply-To: <4EEA20DA.3030006@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Donnerstag, 15. Dezember 2011, 17:31:22 schrieb Martin Mailand:
> Hi Guido,
> I am running ceph version 0.39-37-g54758ab
> (commit:54758abccf429122c1bc3bce6d01bc33f1cfe238) on my cluster and I do
> not see this problem. Do you use the qemu rbd block driver or the kernel
> mount?

Both - Kernel mount for the Cephfs, qemu rbd driver for the actual qemu 
volumes.

	Guido
