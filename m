From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Multiple OSDs suicide because of client issues?
Date: Mon, 23 Nov 2015 12:32:28 -0700
Message-ID: <CAANLjFpxidEjcJ1GvyERqh+Q8UDVnZYqvY5ZcVdxL8FC1SO3PQ@mail.gmail.com>
References: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com>
	<CAJ4mKGb5F+cuUKdU6PHs47sed9ZCb+qEnNDvxfuxB=vFyDx96A@mail.gmail.com>
	<CAANLjFo=vCsny5=JW1wYiQk5S=oXdtVd0OzXEC=uTGgmDO9ydA@mail.gmail.com>
	<CAJ4mKGbYrDOpiEJiMKZwHaEHGrZT=b58GjzYg4x35U1XtDbDWg@mail.gmail.com>
	<CAANLjFpn+MGw4cY7aZarLuXgiVznovaJGXY2wtXwMmm8n24Qsw@mail.gmail.com>
	<CAJ4mKGaA=OnH3XPM=m5JE+1Rwc38gsmwrJv3FP1MCY5qO1nYrg@mail.gmail.com>
	<CAANLjFoyAyDrxoGLTdPwzRN12ffqkHqNeXgBZBmG+s7i02WBCw@mail.gmail.com>
	<CAJ4mKGawUUwAB7DC6uWf=6xVGpeg=ac3PB1wx2_3msDPCYDkOw@mail.gmail.com>
	<CAANLjFq-eqTy4XN_YTMyS0M2h4Smo1GNSmuqL+FuDAZDG3yXGg@mail.gmail.com>
	<565365AF.20409@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33171 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbbKWTc3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 14:32:29 -0500
Received: by vkfr145 with SMTP id r145so45306746vkf.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 11:32:28 -0800 (PST)
In-Reply-To: <565365AF.20409@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I saw posts about that in the mailing lists. According to SAR, there
wasn't an abnormal amount of page faults. We have swap disabled and
have min_kbytes_free set to 6GB which has worked well for us so far.
We kicked around still setting swappiness to 10 (should help be more
aggressive on freeing up memory), but decided to migrate the VMs
first.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Nov 23, 2015 at 12:14 PM, Mark Nelson  wrote:
> FWIW, if you've got collectl per-process logs, you might look for major
> pagefaults associated with the osd processes.  I've seen process swapping
> cause heartbeat timeouts in the past.  Not to say that's the issue, but
> worth confirming it's not happening.
>
> Mark

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWU2nICRDmVDuy+mK58QAASAAP/ixjjqyg7a0tHpgt+Nn4
lSBUyAk5AQrvT0hv7cyMi5tt4g/R5ur05jeIJUKcrrKhroInO4s20B6cErwl
tRPJwVjFgvsmDxxvZIbqxwpZgPu1GpzHalV3XnNU0ez+pFIWG7Cu1dEFxezI
5hccNSy6afoIlC5wWCMb4I12bvpijtvhAP43pauFIDheUg0Eev4mbDCbSfU/
WuzzNiK9EZXnHcF1LVsqJtumT5PmcvmMktWFLm8BvhJk5k7ZZr7/27hgmjSK
aNddnld2RZGomDmCttUxERNeIV0I/xg0h39gc8kTc6P9buiGpABwfTlUCRhz
xI1iagmnSuV5hkCWCMc0KcZtSBdAeH1kNgkbxFI3qr1/AwPVVvAssUIrBBlV
spL+z2e/DKqNf5Hq4WHpc5GdJsBDlETFDaLYc6LquAzrYN/Bt1XbXD2pP+R1
JRNJITSrTzKcXxCFYVdpDKPzvmtojh8aVGr7LsnJYdrUTgNwYn5MBdoermjH
xKoHuP91Rmr1+0aMABU+2AD1LZ2+xY6SIOV3TDCJSUk/gLVvSwLuTOTNKbtP
3tdanJhqamh1QCX9ze4Wb96mLTCWmn0SFBzPb0dlHXCcwUinGg76po79tq0L
jTpI6Ont33fRwxC4R6lfYucanYMuDQxnrF3rrUad9K3cx8EfpCruHd6PE0Yc
iRYm
=b7ZB
-----END PGP SIGNATURE-----
