From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: Random data corruption in VM, possibly caused by rbd
Date: Thu, 07 Jun 2012 23:03:28 +0200
Message-ID: <44640465.OVpPW54edB@tolkien>
References: <21601270.dfB0BsVfyn@pc10> <3039502.NLSCFOhhFU@pc10> <CABYiri_BOv8NoTKTuHWyZMS4nA0oc3RH4XjdFqzF_i58X8xVRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:35950 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932678Ab2FGVDg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Jun 2012 17:03:36 -0400
In-Reply-To: <CABYiri_BOv8NoTKTuHWyZMS4nA0oc3RH4XjdFqzF_i58X8xVRA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: ceph-devel@vger.kernel.org

On Thursday 07 June 2012 23:54:04 Andrey Korolyov wrote:
> Hmm, can`t reproduce that(phew!). Qemu-1.1-release, 0.47.2, guest/host
> mainly debian wheezy. Only one main difference with my setup from
> yours is a underlying fs - I`m tired of btrfs unpredictable load
> issues and moved back to xfs.

I guess I'll try that tomorrow as well. Is there a guide somewhere for 
switching from btrfs to xfs?
 
> BTW you calculate sha1 in test suite, not sha256 as you mentioned above.

True. I must have mixed that up somehow. Not that it matters - for what I'm 
doing with it here, I might as well be using CRC32.

	Guido
