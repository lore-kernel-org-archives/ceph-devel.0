From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Experiences with Ceph at the June'14 issue of USENIX ;login:
Date: Mon, 2 Jun 2014 21:40:40 +0000
Message-ID: <20140602214040.GG4356@orbis-terrarum.net>
References: <20140602183219.GD17479@philipgian-mac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:46182 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbaFBVkq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Jun 2014 17:40:46 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 8D0CC33FDF9
	for <ceph-devel@vger.kernel.org>; Mon,  2 Jun 2014 21:40:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20140602183219.GD17479@philipgian-mac>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Mon, Jun 02, 2014 at 09:32:19PM +0300,  Filippos Giannakos wrote:
> As you may already know, we have been using Ceph for quite some time now to back
> the ~okeanos [1] public cloud service, which is powered by Synnefo [2].
(Background info for other readers: Synnefo is a cloud layer on top of
Ganeti).

> In the article we describe our storage needs, how we use Ceph and how it has
> worked so far. I hope you enjoy reading it.
Are you just using the existing kernel RBD mapping for Ganeti running
KVM, or did you implement the pieces for Ganeti to use the QEMU
userspace RBD driver?

I've got both Ceph & Ganeti clusters already, but am reluctant to marry
the two sets of functionality because the kernel RBD driver still seemed
to perform so much worse than the Qemu userspace RBD driver, and Ganeti
still hasn't implemented the userspace mapping pieces :-(

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
