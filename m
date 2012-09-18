From: Guido Winkelmann <guido-ceph@thisisnotatest.de>
Subject: Re: enabling cephx by default
Date: Tue, 18 Sep 2012 14:37:14 +0200
Message-ID: <2205765.G9jEemHyT3@pc10>
References: <alpine.DEB.2.00.1209111722100.2433@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from unknownsite.de ([62.48.69.106]:57120 "EHLO hartes-hannover.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755403Ab2IRMqh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 18 Sep 2012 08:46:37 -0400
Received: from pc10.localnet (pc10.asys-h.de [193.98.1.90])
	by hartes-hannover.de (Postfix) with ESMTPSA id 3A20010C866
	for <ceph-devel@vger.kernel.org>; Tue, 18 Sep 2012 14:37:15 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.00.1209111722100.2433@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Am Dienstag, 11. September 2012, 17:25:49 schrieben Sie:
> The next stable release will have cephx authentication enabled by default.

Hm, that could be a problem for me. I have tried multiple times to get cephx 
working in the past, without lasting success. (I cannot recall at the moment 
what the problem was the last time around, but it was probably qemu/libvirt.)

IMHO, the documentation badly needs a high-level overview for cephx (or maybe 
I just haven't found it yet); what it does, what dangers it protects you from 
and how it achieves that.

        Guido
