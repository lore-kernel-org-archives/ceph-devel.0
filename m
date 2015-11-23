From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Multiple OSDs suicide because of client issues?
Date: Mon, 23 Nov 2015 12:03:03 -0700
Message-ID: <CAANLjFq-eqTy4XN_YTMyS0M2h4Smo1GNSmuqL+FuDAZDG3yXGg@mail.gmail.com>
References: <CAANLjFqL82wLfrYDD-LNgctWR=MpHWJ=PxfQJ8g2Ntbv8fgu2g@mail.gmail.com>
	<CAJ4mKGb5F+cuUKdU6PHs47sed9ZCb+qEnNDvxfuxB=vFyDx96A@mail.gmail.com>
	<CAANLjFo=vCsny5=JW1wYiQk5S=oXdtVd0OzXEC=uTGgmDO9ydA@mail.gmail.com>
	<CAJ4mKGbYrDOpiEJiMKZwHaEHGrZT=b58GjzYg4x35U1XtDbDWg@mail.gmail.com>
	<CAANLjFpn+MGw4cY7aZarLuXgiVznovaJGXY2wtXwMmm8n24Qsw@mail.gmail.com>
	<CAJ4mKGaA=OnH3XPM=m5JE+1Rwc38gsmwrJv3FP1MCY5qO1nYrg@mail.gmail.com>
	<CAANLjFoyAyDrxoGLTdPwzRN12ffqkHqNeXgBZBmG+s7i02WBCw@mail.gmail.com>
	<CAJ4mKGawUUwAB7DC6uWf=6xVGpeg=ac3PB1wx2_3msDPCYDkOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f43.google.com ([209.85.213.43]:34232 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752862AbbKWTDF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Nov 2015 14:03:05 -0500
Received: by vkbs1 with SMTP id s1so44381822vkb.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Nov 2015 11:03:04 -0800 (PST)
In-Reply-To: <CAJ4mKGawUUwAB7DC6uWf=6xVGpeg=ac3PB1wx2_3msDPCYDkOw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

We set the debugging to 0/0, but are you talking about lines like:

   -12> 2015-11-20 20:59:47.138746 7f70067de700 -1 osd.177 103793
heartbeat_check: no reply from osd.133 since back 2015-11-20
20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
20:59:27.138720)
   -11> 2015-11-20 20:59:47.138749 7f70067de700 -1 osd.177 103793
heartbeat_check: no reply from osd.136 since back 2015-11-20
20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
20:59:27.138720)
   -10> 2015-11-20 20:59:47.138751 7f70067de700 -1 osd.177 103793
heartbeat_check: no reply from osd.139 since back 2015-11-20
20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
20:59:27.138720)
    -9> 2015-11-20 20:59:47.138758 7f70067de700 -1 osd.177 103793
heartbeat_check: no reply from osd.147 since back 2015-11-20
20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
20:59:27.138720)
    -8> 2015-11-20 20:59:47.138761 7f70067de700 -1 osd.177 103793
heartbeat_check: no reply from osd.159 since back 2015-11-20
20:58:51.427880 front 2015-11-20 20:58:51.427880 (cutoff 2015-11-20
20:59:27.138720)
    -7> 2015-11-20 20:59:47.138789 7f70067de700 -1 osd.177 103793
heartbeat_check: no reply from osd.170 since back 2015-11-20
20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
20:59:27.138720)
    -6> 2015-11-20 20:59:47.138794 7f70067de700 -1 osd.177 103793
heartbeat_check: no reply from osd.175 since back 2015-11-20
20:57:32.413156 front 2015-11-20 20:57:32.413156 (cutoff 2015-11-20
20:59:27.138720)

There are 10,000 of those lines in the OSD log which shows all the
logs up to the crash. Unless setting the value to 0/0 is eliminating
what you are looking for. I've been wondering if setting it to 0/1 or
0/5 or even 0/20 has any runtime performance penalty? It seems like
more detailed info on crashes would be helpful, but we don't want to
write too much to the SATADOMs.

We do have the NICs bonded all across our environment.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Mon, Nov 23, 2015 at 11:14 AM, Gregory Farnum  wrote:
> On Mon, Nov 23, 2015 at 12:03 PM, Robert LeBlanc  wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>>
>> This is one of our production clusters which is dual 40 Gb Ethernet
>> using VLANs for cluster and public networks. I don't think this is
>> unusual, not like my dev cluster which runs Infiniband and IPoIB. Th=
e
>> client nodes are connected at 10 GB Ethernet.
>>
>> I wonder if you are talking about the system logs, not the Ceph OSD
>> logs. I'm attaching a snippet that includes the hour before and afte=
r.
>
> Nope, I meant the OSD logs. Whenever they crash, it should dump out
> the last 10000 in-memory log entries =E2=80=94 the one you sent along=
 didn't
> have a crash included at all. The exact system which timed out will
> certainly be in those log entries (it's output at level 1, so unless
> you manually turned everything to 0, it'll show up on a crash.)
>
> Anyway, I wouldn't expect that cluster config to have any issues with
> a client dying since it's TCP over ethernet, but I have seen some
> weird behaviors out of bonded NICs when one of them dies, so maybe.
> -Greg
>
>> - ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.2.3
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWU2LkCRDmVDuy+mK58QAA2EUP/22eOBNzAYDV5lGI4J9Z
wnSZE39UycEfo8e6v8cfikLdAUT7fbY8HBq+VPylLo7OtxA+sGwgjrcz3hzu
azRi9QuCeWNm+squPQpgISzXWnpDtSjlsA+7iQb+HJGW7/kcR+opixzMX/W5
AE0Z/hrRwImw3r7Ze3Avl/j+l7iamUznfZAnaBdeWyle7Nge/D8kV+QJSeHe
/zXDoWW8wPNiRwU/puJrH/GEzyYVZFZ4F9aPUKf9rXsp0chK5k55yysI8ABL
CfBLtZ1yXPbD20knMdEyuQrDXWMGQplQ+7Z2qFAKsbp+qMFGNqeIbtA6xmbM
+8RIXT5hTLmgH6lVLYFbk6wgiSphxTVFrkR4Bm6NzFHnloxZ3KuU1pqOZf2k
iJZ8eDPfUxuforHO2L8TWMDWAsrqTm5A2u0GFtvm7uPWvxWo6sv08sq5IICD
C75mnCRUIDGl/bQLxt06qvq7WwAtezwnNcwCth3kDFFS85WTgZGEtPgpFizt
IpBQI4ustiT6lNmYQr6V2cj4HT1G8YBT1ykKwSYmsbRnT2PWGQc7IJ11DxgC
E7i0c6UYcOMpWT18t+RTOzvv8AZGpna2X/xTJSPL2H10zIkiuXAwO/gZQ5oa
mgN/3fdhcki8q7uWbZaBCNtv814sZIoTzQy7C7kApQdxFu+kbe5LHRhHZJbZ
CExf
=3DcjG0
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
