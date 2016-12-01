From: Lenz Grimmer <lenz@grimmer.com>
Subject: Re: disk enclosure LEDs
Date: Thu, 1 Dec 2016 14:19:11 +0100
Message-ID: <3f1f9b7f-c715-c382-603d-67fabe31a001@grimmer.com>
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <CALe9h7ct1+VwwdWshLPkAJTgAKLa4=+gbxPAkTfa=J488Hv7KA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="KFPivE9wCqFT5clXme9K9jA0MV9Wlt9fF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:49243 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753786AbcLANTX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Dec 2016 08:19:23 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id 92D4E4493C
        for <ceph-devel@vger.kernel.org>; Thu,  1 Dec 2016 14:19:21 +0100 (CET)
Received: from smtp1.mailbox.org ([80.241.60.240]) (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256)
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTPS id Biybck7R2y7W for <ceph-devel@vger.kernel.org>;
        Thu,  1 Dec 2016 14:19:18 +0100 (CET)
In-Reply-To: <CALe9h7ct1+VwwdWshLPkAJTgAKLa4=+gbxPAkTfa=J488Hv7KA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KFPivE9wCqFT5clXme9K9jA0MV9Wlt9fF
Content-Type: multipart/mixed; boundary="dB1g0dpoe5POegaMdPIB4e51cSJJJhVSq";
 protected-headers="v1"
From: Lenz Grimmer <lenz@grimmer.com>
To: Ceph Development <ceph-devel@vger.kernel.org>
Message-ID: <3f1f9b7f-c715-c382-603d-67fabe31a001@grimmer.com>
Subject: Re: disk enclosure LEDs
References: <alpine.DEB.2.11.1611301606060.2097@piezo.novalocal>
 <CALe9h7ct1+VwwdWshLPkAJTgAKLa4=+gbxPAkTfa=J488Hv7KA@mail.gmail.com>
In-Reply-To: <CALe9h7ct1+VwwdWshLPkAJTgAKLa4=+gbxPAkTfa=J488Hv7KA@mail.gmail.com>

--dB1g0dpoe5POegaMdPIB4e51cSJJJhVSq
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 12/01/2016 01:10 AM, John Spray wrote:

> The "what block device am I?" part in the OSD (especially given
> many-to-one relations as you say) is probably harder than the calling
> into libstoragemgmt.  We would probably also need all the LED commands
> to have a flag to optionally target the journal drive instead of the
> data drive.  Where multiple OSDs target the same drive, I don't see
> that as a problem: it's reasonable to have the commands me "blink the
> drive you use" and not "blink a drive and thereby claim you are the
> only thing using it".

I tend to agree to Joao's point that I don't think that the OSD should
be in the business of blinking disk LEDs.

Instead, I would be in favor if it could tell me which disks it actually
uses, which would allow me to pass this device name to any given tool I
choose for blinking the LED on that device.

There was a pull request about this, but I don't think it ever got
merged - http://tracker.ceph.com/issues/3120

Would it make sense to revisit this?

Thanks,

Lenz


--dB1g0dpoe5POegaMdPIB4e51cSJJJhVSq--

--KFPivE9wCqFT5clXme9K9jA0MV9Wlt9fF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iFgEARECABgFAlhAI08RHGxlbnpAZ3JpbW1lci5jb20ACgkQSVDhKrJykfK9hACf
RoYKClEvKCH0FIW8GHpzu6fg4CIAn2CrsQkDQ2q/W02zdFlDhmTyn9+B
=qFO5
-----END PGP SIGNATURE-----

--KFPivE9wCqFT5clXme9K9jA0MV9Wlt9fF--
