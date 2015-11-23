From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Multiple OSDs suicide because of client issues?
Date: Mon, 23 Nov 2015 12:14:32 -0600
Message-ID: <CAJ4mKGawUUwAB7DC6uWf=6xVGpeg=ac3PB1wx2_3msDPCYDkOw@mail.gmail.com>
References: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com>
	<CAJ4mKGb5F+cuUKdU6PHs47sed9ZCb+qEnNDvxfuxB=vFyDx96A@mail.gmail.com>
	<CAANLjFo=vCsny5=JW1wYiQk5S=oXdtVd0OzXEC=uTGgmDO9ydA@mail.gmail.com>
	<CAJ4mKGbYrDOpiEJiMKZwHaEHGrZT=b58GjzYg4x35U1XtDbDWg@mail.gmail.com>
	<CAANLjFpn+MGw4cY7aZarLuXgiVznovaJGXY2wtXwMmm8n24Qsw@mail.gmail.com>
	<CAJ4mKGaA=OnH3XPM=m5JE+1Rwc38gsmwrJv3FP1MCY5qO1nYrg@mail.gmail.com>
	<CAANLjFoyAyDrxoGLTdPwzRN12ffqkHqNeXgBZBmG+s7i02WBCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38692 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbbKWSOe convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 13:14:34 -0500
Received: by wmec201 with SMTP id c201so117095151wme.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 10:14:33 -0800 (PST)
In-Reply-To: <CAANLjFoyAyDrxoGLTdPwzRN12ffqkHqNeXgBZBmG+s7i02WBCw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 23, 2015 at 12:03 PM, Robert LeBlanc <robert@leblancnet.us>=
 wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> This is one of our production clusters which is dual 40 Gb Ethernet
> using VLANs for cluster and public networks. I don't think this is
> unusual, not like my dev cluster which runs Infiniband and IPoIB. The
> client nodes are connected at 10 GB Ethernet.
>
> I wonder if you are talking about the system logs, not the Ceph OSD
> logs. I'm attaching a snippet that includes the hour before and after=
=2E

Nope, I meant the OSD logs. Whenever they crash, it should dump out
the last 10000 in-memory log entries =E2=80=94 the one you sent along d=
idn't
have a crash included at all. The exact system which timed out will
certainly be in those log entries (it's output at level 1, so unless
you manually turned everything to 0, it'll show up on a crash.)

Anyway, I wouldn't expect that cluster config to have any issues with
a client dying since it's TCP over ethernet, but I have seen some
weird behaviors out of bonded NICs when one of them dies, so maybe.
-Greg

> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Mon, Nov 23, 2015 at 10:33 AM, Gregory Farnum  wrote:
>> On Mon, Nov 23, 2015 at 11:27 AM, Robert LeBlanc  wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA256
>>>
>>> I checked the SAR data and the disks for all the OSDs showed usual
>>> performance until 20:57:32 when over the next few minutes the I/OPs=
,
>>> bandwidth and latency all decreased. The only thing that I can thin=
k
>>> of is that some replies to the client got hung up and backed up the
>>> OSD process or something.
>>
>> That shouldn't really be possible but I seem to recall you've got a
>> weird network? So maybe.
>>
>>> There are a couple of other backtraces in
>>> the log file, but I could not trace any of them to something useful=
=2E
>>>
>>> Since we took the VMs off that client, we haven't had the problem s=
how up again.
>>
>> Yeah, we'd really need the actual log output that gets dumped to log=
s
>> on crash =E2=80=94 it specifies precisely which thing failed.
>> -Greg
>
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.2.3
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWU1UGCRDmVDuy+mK58QAAOa0P/RIAO06Fd3myuzyyqlYo
> N2VA9bWGaq06iwTLF1mufiEmbVaIPAIAQk+GaODgv/PKSJj6ecqS1/au832d
> oO2LocnreeOTLJPL/n+mdeglos63ocwyvM4LP/XpvWJJ1C694mUWjvIxlWKR
> 4zFXH9V5DMTmCwm3kkY4qXqNUS/FJZyd5fwOg7NnqSzuy2UHIxEOzjGaKUwf
> ipgVgy8iIn5tprx/rCawrYvuY141z4nOu1jIzEkXEa+F7pxfpKsXeKFQvEnw
> aax/RNuikhLKu6rbCJKCQWL3uUZzrshp6EE3T/uXDP8rMX1ojOcmL1L1bJhh
> 4XqNdgXYuUXlP2cJtJSfxy7RFayZIw4Htn3YnWCrg7uqzrfwf2Hh2DGAE+06
> ggH7qo9Z99hg7ENTDSzpFOyE5eM+oA8OQgpn+/8X7OyNG/eNwJnBlHTT0C+f
> LunPV8I4HjRAuCNpkz16ZO/+pLnMAbk/Vp1wGJ3Qcdmxwk1UQ3L+UKASrwWd
> S861pU4GOGoRymcse20DDRaChbhQRmK0nxjFq4/YXIo36lbMH2gcXyuAza5z
> oFvmEkGwDoYneL0JZHJdHhRqkapMMMRqODC/2YU2EXa3fYatamKCwaHqPSdp
> c0BN/yRFlB74RA7szvItUHORyiROxo/MnmGKlCBUNud0cVbBoyzSwfSBwCN1
> zA7x
> =3Dg7l3
> -----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
