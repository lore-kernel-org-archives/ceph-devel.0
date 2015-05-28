From: Marcel Lauhoff <ml@irq0.org>
Subject: Re: OSD-Based Object Stubs
Date: Thu, 28 May 2015 11:45:12 +0200
Message-ID: <877frtc9xz.fsf@irq0.org>
References: <87a8wqct38.fsf@irq0.org> <CAANLjFriAw_RcWvkGBvt_2EwzicTQCF1ygymyDwbi8z4H-i3jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cpu0.net ([37.187.2.217]:37549 "EHLO cpu0.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbbE1JpK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 May 2015 05:45:10 -0400
Received: from janelane.irq0.org (x5d82518d.dyn.telefonica.de [93.130.81.141])
	by ks3366964.kimsufi.com (Postfix) with ESMTPSA id 307878029A
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 09:45:08 +0000 (UTC)
In-reply-to: <CAANLjFriAw_RcWvkGBvt_2EwzicTQCF1ygymyDwbi8z4H-i3jQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


Robert LeBlanc <robert@leblancnet.us> writes:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> At first I thought this was to allow the OSDs to stub the location of
> the real data after a CRUSH map change so that it didn't have to
> relocate the data right away (or at all) and reduce the  number of map
> changes. Then I realized it was for cold storage tiering. Is the idea
> to be able to move data off to near-line storage like tape?

Yes, cold storage. Basically, let the OSD move data elsewhere like tape or some
archive system.

~marcel
--
Marcel Lauhoff
Mail/XMPP: ml@irq0.org
http://irq0.org
