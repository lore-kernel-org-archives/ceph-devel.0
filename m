From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: mon memory leak
Date: Wed, 13 Mar 2013 15:06:11 +0100
Message-ID: <514087D3.20200@profihost.ag>
References: <51405874.6030506@profihost.ag> <CAOLwVUk9bT-pR3_6QmG+HywZMs4sEKZGGX=uiFqvFyFTM1Q=aA@mail.gmail.com> <CACkq2mr1juPpqn85jsxeNr_RdgX1nyC6KDLehuNs5rSveWMALw@mail.gmail.com> <514085F5.6010509@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:44405 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932281Ab3CMOGS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Mar 2013 10:06:18 -0400
In-Reply-To: <514085F5.6010509@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: Travis Rhoden <trhoden@gmail.com>, =?ISO-8859-1?Q?S=E9bastien_Han?= <han.sebastien@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Joao,
Am 13.03.2013 14:58, schrieb Joao Eduardo Luis:

> I'm expecting to be able to find the time Real Soon Now to put a doc
> together with ways, for anyone willing, to provide us further insight on
> what's happening.  The monitor is supposed to be able to dump a heap
> profile (using gperftools) on-the-fly, but I recall having some issues
> with that not so long ago, so that's probably one thing to look into asap.

Thanks - that would be great i'm willing ;-)

> In any case, Stefan, do you by chance still have that monitor going?
Sadly not i needed the memory ;-)

> Furthermore, assuming you are using a
> version prior to v0.58,
Yes current Bobtail 0.56.3

> any chance you can run a 'du -chs
> /var/lib/ceph/mon/ceph-foo',
No idea what you expect to see but all mon servers consume 180MB of disk
space.

[: ~]# du -chs /ceph/mon
180M    /ceph/mon
180M    total

Greets,
Stefan
