From: "Christopher LILJENSTOLPE" <cdl@asgaard.org>
Subject: Re: erasure coding (sorry)
Date: Thu, 18 Apr 2013 17:33:54 -0700
Message-ID: <1C2EACD9-CA7D-4949-B947-247D1F995B11@asgaard.org>
References: <20130418162842.0c61d1e2@dieter-t420s>
 <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net>
 <517060B2.80706@inktank.com> <51706120.2060702@inktank.com>
 <20130418173113.74a53769@dieter-t420s>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_66CAAC19-22A9-4962-B9B8-0E533848A995_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.emailarray.com ([65.39.216.14]:59557 "EHLO
	smtp1.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967617Ab3DSAkk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 20:40:40 -0400
In-Reply-To: <20130418173113.74a53769@dieter-t420s>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Plaetinck, Dieter" <dieter@vimeo.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org, danm@annaisystems.com

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_66CAAC19-22A9-4962-B9B8-0E533848A995_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Supposedly, on 2013-Apr-18, at 14.31 PDT(-0700), someone claiming to be P=
laetinck, Dieter scribed:

> On Thu, 18 Apr 2013 16:09:52 -0500
> Mark Nelson <mark.nelson@inktank.com> wrote:
>
>> On 04/18/2013 04:08 PM, Josh Durgin wrote:
>>> On 04/18/2013 01:47 PM, Sage Weil wrote:
>>>> On Thu, 18 Apr 2013, Plaetinck, Dieter wrote:
>>>>> sorry to bring this up again, googling revealed some people don't
>>>>> like the subject [anymore].
>>>>>
>>>>> but I'm working on a new +- 3PB cluster for storage of immutable fi=
les.
>>>>> and it would be either all cold data, or mostly cold. 150MB avg
>>>>> filesize, max size 5GB (for now)
>>>>> For this use case, my impression is erasure coding would make a lot=

>>>>> of sense
>>>>> (though I'm not sure about the computational overhead on storing an=
d
>>>>> loading objects..? outbound traffic would peak at 6 Gbps, but I can=

>>>>> make it way less and still keep a large cluster, by taking away the=

>>>>> small set of hot files.
>>>>> inbound traffic would be minimal)
>>>>>
>>>>> I know that the answer a while ago was "no plans to implement erasu=
re
>>>>> coding", has this changed?
>>>>> if not, is anyone aware of a similar system that does support it? I=

>>>>> found QFS but that's meant for batch processing, has a single
>>>>> 'namenode' etc.
>>>>
>>>> We would love to do it, but it is not a priority at the moment (thin=
gs
>>>> like multi-site replication are in much higher demand).  That of cou=
rse
>>>> doesn't prevent someone outside of Inktank from working on it :)
>>>>
>>>> The main caveat is that it will be complicate.  For an initial
>>>> implementation, the full breadth of the rados API probably wouldn't =
be
>>>> support for erasure/parity encoded pools (thinkgs like rados classes=
 and
>>>> the omap key/value api get tricky when you start talking about parit=
y).
>>>> But for many (or even most) use cases, objects are just bytes, and t=
hose
>>>> restrictions are just fine.
>>>
>>> I talked to some folks interested in doing a more limited form of thi=
s
>>> yesterday. They started a blueprint [1]. One of their ideas was to ha=
ve
>>> erasure coding done by a separate process (or thread perhaps). It wou=
ld
>>> use erasure coding on an object and then use librados to store the
>>> rasure-encoded pieces in a separate pool, and finally leave a marker =
in
>>> place of the original object in the first pool.
>>>
>>> When the osd detected this marker, it would proxy the request to the
>>> erasure coding thread/process which would service the request on the
>>> second pool for reads, and potentially make writes move the data back=
 to
>>> the first pool in a tiering sort of scenario.
>>>
>>> I might have misremembered some details, but I think it's an
>>> interesting way to get many of the benefits of erasure coding with a
>>> relatively small amount of work compared to a fully native osd soluti=
on.
>>>
>>> Josh
>>
>> Neat. :)
>>
>
> @Bryan: I did come across cleversafe.  all the articles around it seeme=
d promising,
> but unfortunately it seems everything related to the cleversafe open so=
urce project
> somehow vanished from the internet.  (e.g. http://www.cleversafe.org/) =
quite weird...

Yea - in a previous incarnation I looked at cleversafe to do something si=
milar a few years ago.  It is odd that the cleversafe.org stuff did disap=
ear.  However, tahoe-lafs also does encoding, and their package (zfec) [1=
] may be leverageable.

>
> @Sage: interesting. I thought it would be more relatively simple if one=
 assumes
> the restriction of immutable files.  I'm not familiar with those ceph s=
pecifics you're mentioning.
> When building an erasure codes-based system, maybe there's ways to reus=
e existing ceph
> code and/or allow some integration with replication based objects, with=
out aiming for full integration or
> full support of the rados api, based on some tradeoffs.

I think this might sit UNDER the rados api.  I would certainly want to le=
verage CRUSH to place the shards, however (great tool, no reason to re-in=
vent the wheel).
>
> @Josh, that sounds like an interesting approach.  Too bad that page doe=
sn't contain any information yet :)

Give me time :) - openstack has kept me a bit busy=E2=80=A6  May also be =
a factor of "design at keyboard" :)

>
> Dieter

Christopher


[1] https://tahoe-lafs.org/trac/zfec

--
=E6=9D=8E=E6=9F=AF=E7=9D=BF
Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
Check my calendar availability: https://tungle.me/cdl
--=_MailMate_66CAAC19-22A9-4962-B9B8-0E533848A995_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJRcJDyAAoJEGmx2Mt/+Iw/jj4H/0C/zuh0E672hB/a5Z1Yw560
46YH4pn8+sT1HsRUEyM1QUOG/TpHfJszv9wyEvBV1Tgr6a/3EzfyTRAClY/xXD3H
PuNfOVedHiLDimgOmsnpNsexhaPCXKEdpBKomyQYfoBx2qIQMKv6FNOB4DXYCY/M
ynEyKknkyZVFrjQLvutQEyAT5lgmmBkeknK65IeWMj1DW99JTrGUGm57cG6E0oWZ
6CgpWFACOLbw3SQKHo3Qr08hlOiFtNyNlqj+mH4rQ7Iha9Ao68r8plJRUxp5ffzB
UpJ2Pwm8vTt8NcJoPik5o2U1BgAHyqN4P2nutQATajyA3yubPuFEFNAJPrtF7eQ=
=Ndiv
-----END PGP SIGNATURE-----

--=_MailMate_66CAAC19-22A9-4962-B9B8-0E533848A995_=--
