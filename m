From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: OSD memory leak when scrubbing [0.56.6]
Date: Tue, 21 May 2013 17:37:56 +0200
Message-ID: <FB4F06C0-410B-43C0-A5CE-64AFD18B29D0@profihost.ag>
References: <519B9196.5090402@filoo.de> <CAF6-1L6E6s_wP6012ifwTRwZA4bp5+OLmYo92Y5QbmS20uxReA@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:39313 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab3EUPiJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 11:38:09 -0400
In-Reply-To: <CAF6-1L6E6s_wP6012ifwTRwZA4bp5+OLmYo92Y5QbmS20uxReA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Oliver Francke <Oliver.Francke@filoo.de>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Am 21.05.2013 um 17:35 schrieb Sylvain Munaut <s.munaut@whatever-company.com>:

> Hi,
> 
>> subject seems familiar, version was 0.48.3 in the last mail.
>> 
>> Not anyone else with perhaps large pg's experiencing such behaviour?
>> 
>> Any advice on how to proceed?
> 
> I had the same behavior in both argonaut and bobtail, raising sharply
> ~ 100M or so at each scrub (every 24h).
> 
> It's now resolved in cuttlefish AFAICT.
> 
> However given the mon leveldb issues I'm having with cuttlefish, I'm
> not sure I'd recommend upgrading ...

I thought all mon leveldb issues were solved?

> 
> Cheers,
> 
>    Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
