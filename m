From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: OSD memory leak when scrubbing [0.56.6]
Date: Tue, 21 May 2013 17:38:16 +0200
Message-ID: <519B94E8.9010703@filoo.de>
References: <519B9196.5090402@filoo.de> <CAF6-1L6E6s_wP6012ifwTRwZA4bp5+OLmYo92Y5QbmS20uxReA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-1.de-punkt.de ([93.190.64.237]:37453 "EHLO
	mail-1.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754686Ab3EUPiR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 May 2013 11:38:17 -0400
In-Reply-To: <CAF6-1L6E6s_wP6012ifwTRwZA4bp5+OLmYo92Y5QbmS20uxReA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Right,

On 05/21/2013 05:35 PM, Sylvain Munaut wrote:
> Hi,
>
>> subject seems familiar, version was 0.48.3 in the last mail.
>>
>> Not anyone else with perhaps large pg's experiencing such behaviour?
>>
>> Any advice on how to proceed?
> I had the same behavior in both argonaut and bobtail, raising sharply
> ~ 100M or so at each scrub (every 24h).
>
> It's now resolved in cuttlefish AFAICT.
>
> However given the mon leveldb issues I'm having with cuttlefish, I'm
> not sure I'd recommend upgrading ...

not really at this moment. Cause we have an otherwise stable and fast=20
cluster for our VM's ;)

Oliver.

>
> Cheers,
>
>      Sylvain


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
