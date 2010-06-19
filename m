From: Christian Brunner <chb@muc.de>
Subject: Re: [Qemu-devel] Re: [PATCH] ceph/rbd block driver for qemu-kvm (v3)
Date: Sat, 19 Jun 2010 17:48:12 +0200
Message-ID: <AANLkTilSXVV6JzLXGBZ0OvVuut9wad7TLkZtxEmXmrEy@mail.gmail.com>
References: <20100531193140.GA13993@chb-desktop>
	<4C1293B7.1060307@gmail.com>
	<AANLkTimQ8voPJC6krCAsvlzoOZOZ-1LDXXI6_asbO9xT@mail.gmail.com>
	<4C1B45DB.4000502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34094 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab0FSPsO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jun 2010 11:48:14 -0400
In-Reply-To: <4C1B45DB.4000502@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Simone Gotti <simone.gotti@gmail.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org

>
> Are you going to send a final version which includes Simone's patch or
> should I apply them as two patches and just accept that rbd is broken
> after the first one? Or were there any other problems that need to be
> solved first?

I'll send a final version, when I've tested everything.

There is another problem with very large i/o requests. I suspect that
this can be triggered only
with qemu-io and not in kvm, but I'll try to get a proper solution it anyway.

Christian
