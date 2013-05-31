From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: caller_ops.size error messages upstream/cuttlefish
Date: Fri, 31 May 2013 14:35:25 +0200
Message-ID: <51A8990D.2000706@profihost.ag>
References: <51A88E04.5040405@profihost.ag> <51A89626.6040201@profihost.ag> <CAF6-1L4NYJ6kD=vbma1JB4Jh+h6PN53H1nUcPz=wOv66sj=5Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:57895 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab3EaMfb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 May 2013 08:35:31 -0400
In-Reply-To: <CAF6-1L4NYJ6kD=vbma1JB4Jh+h6PN53H1nUcPz=wOv66sj=5Gg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Am 31.05.2013 14:32, schrieb Sylvain Munaut:
> Just as FYI, I also had a couple of those messages last night when
> adding a couple new OSDs.
> 
> [ERR] 3.274 caller_ops.size 3002 > log size 3001
> 
> it eventually cleared and a deep scrub on that pg doesnt' show any
> error so I'm not sure what it means ...

_mrjack_ and tnt on irc saw this too. And they also got stalled I/O.

I opened up a bug in the tracker:
http://tracker.ceph.com/issues/5216

Stefan

