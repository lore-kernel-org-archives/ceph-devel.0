From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: Publishing hammer v0.94.6
Date: Fri, 29 Jan 2016 10:06:23 -0700
Message-ID: <CAANLjFp9nB9Qh+ruBvSW7fkpKZ7dTTFiuq22fgkcn0uCSuAhSg@mail.gmail.com>
References: <56AAFAB2.9010103@dachary.org>
	<alpine.DEB.2.11.1601290951320.6524@cpach.fuggernut.com>
	<CAANLjFqWTCGBTbzRkhPXTAnj=UiYVmzDKJMKR2b62FJ7ThzgqA@mail.gmail.com>
	<56AB9875.7020609@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36551 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756424AbcA2RGY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jan 2016 12:06:24 -0500
Received: by mail-vk0-f54.google.com with SMTP id n1so45357834vkb.3
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jan 2016 09:06:23 -0800 (PST)
In-Reply-To: <56AB9875.7020609@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I've ran it through run-make-check.sh and it passed. Is that what you
are asking?

Thanks,
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Fri, Jan 29, 2016 at 9:51 AM, Loic Dachary  wrote:
> Hi Robert,
>
> Thanks for the comments update :-) It needs a rados run before it is =
merged. Can you do that ?
>
> Cheers
>
> On 29/01/2016 23:35, Robert LeBlanc wrote:
>> We'd really like to have http://tracker.ceph.com/issues/14329 in
>> 0.94.6. I think I fixed the comments. Please let me know.
>> ----------------
>> Robert LeBlanc
>> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>>
>>
>> On Fri, Jan 29, 2016 at 7:51 AM, Sage Weil  wrote:
>>> Let's do it!
>>
>>> On Fri, 29 Jan 2016, Loic Dachary wrote:
>>
>>>> Hi Sage,
>>>>
>>>> Now that the test infrastructure is back, we could try to publish =
v0.94.6. These are the issues it fixes: http://tracker.ceph.com/version=
s/505. And these are the backports that are in flight and would not be =
in v0.94.6 if we decide to cut the release today: http://tracker.ceph.c=
om/projects/ceph/issues?query_id=3D78
>>>>
>>>> What do you think ?
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>>>
>>
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.4
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWq5wMCRDmVDuy+mK58QAA264P/RyWJRxdKNx0c2cva9Jo
Hu3+gKLgsmSleWPcmK4zQiQ8AENenlh1Ob9VPIU+YDpfJGboJo8aDXP4+tbu
GJ6wX37T5cKAQ6EnMb1Y+xMlIGpa1E5OZyS9jmY12gatgvKAZZ6NYbGnmyK/
WalK02tqvmsnVr6ukArnR2Lt1grneGcpaBoT6qxRYx2sfiB3K3tXitsicF0F
Z73R/wqM2RjM0a7m1cv2rRkXyhbcNZV+qaX5bHpmsS0RU5tbMQSIH2758z2/
mbDzyvN/jhjADvNSClO7HnYZ4H4RIORMnxpnCNrOAQGdom7SG6cnZFVeZsjg
+z7ZNvx2TxTd3qUeZ27KN5cTaejStgheQRBH1mexquMxtsdVg6Y6rmJVp2eO
V07HWGk3Kujf4s4QrOptO/AbB6snOKTTZ+m0HCzDBGJXuVK1qaMsE4Rtpgsq
sbDTlsE9aYYi12dHrEVG0Sc8yFbNwcj+fpR4vXPNdIkC9wNkfyxHqe/1/zPt
=46TZujUeIoFtIveqOV0b6PMkBHXBErTjntFI7Zedkip+ydlhmsz8WKfc4aJaT
RpHK1lzjwgOSYy1XgB72ocJEUf1I1t9oxy0kJ4PPfKWnPKTjttGmsM6lnX4j
WBnFt00Fc/w4ajArtdCyGuxbckB/8ls6yjgji8bzvYZt7j6zxwOmGjPH4Ju4
fNJv
=3DCuuA
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
