From: "Christopher LILJENSTOLPE" <cdl@asgaard.org>
Subject: Re: erasure coding (sorry)
Date: Thu, 18 Apr 2013 17:29:24 -0700
Message-ID: <4A3EE2C6-3F2A-479B-AA9F-F5FBDD2D30AF@asgaard.org>
References: <20130418162842.0c61d1e2@dieter-t420s>
 <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net>
 <517060B2.80706@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_80E898AB-1D69-474C-8D58-F544A1E3442D_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.emailarray.com ([65.39.216.14]:57981 "EHLO
	smtp1.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967575Ab3DSAgO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 18 Apr 2013 20:36:14 -0400
In-Reply-To: <517060B2.80706@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "Plaetinck, Dieter" <dieter@vimeo.com>, ceph-devel@vger.kernel.org, danm@annaisystems.com

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_80E898AB-1D69-474C-8D58-F544A1E3442D_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Supposedly, on 2013-Apr-18, at 14.08 PDT(-0700), someone claiming to be J=
osh Durgin scribed:

> On 04/18/2013 01:47 PM, Sage Weil wrote:
>> On Thu, 18 Apr 2013, Plaetinck, Dieter wrote:
>>> sorry to bring this up again, googling revealed some people don't lik=
e the subject [anymore].
>>>
>>> but I'm working on a new +- 3PB cluster for storage of immutable file=
s.
>>> and it would be either all cold data, or mostly cold. 150MB avg files=
ize, max size 5GB (for now)
>>> For this use case, my impression is erasure coding would make a lot o=
f sense
>>> (though I'm not sure about the computational overhead on storing and =
loading objects..? outbound traffic would peak at 6 Gbps, but I can make =
it way less and still keep a large cluster, by taking away the small set =
of hot files.
>>> inbound traffic would be minimal)
>>>
>>> I know that the answer a while ago was "no plans to implement erasure=
 coding", has this changed?
>>> if not, is anyone aware of a similar system that does support it? I f=
ound QFS but that's meant for batch processing, has a single 'namenode' e=
tc.
>>
>> We would love to do it, but it is not a priority at the moment (things=

>> like multi-site replication are in much higher demand).  That of cours=
e
>> doesn't prevent someone outside of Inktank from working on it :)
>>
>> The main caveat is that it will be complicate.  For an initial
>> implementation, the full breadth of the rados API probably wouldn't be=

>> support for erasure/parity encoded pools (thinkgs like rados classes a=
nd
>> the omap key/value api get tricky when you start talking about parity)=
=2E
>> But for many (or even most) use cases, objects are just bytes, and tho=
se
>> restrictions are just fine.
>
> I talked to some folks interested in doing a more limited form of this
> yesterday. They started a blueprint [1]. One of their ideas was to have=

> erasure coding done by a separate process (or thread perhaps). It would=

> use erasure coding on an object and then use librados to store the
> rasure-encoded pieces in a separate pool, and finally leave a marker in=

> place of the original object in the first pool.
>
> When the osd detected this marker, it would proxy the request to the
> erasure coding thread/process which would service the request on the
> second pool for reads, and potentially make writes move the data back t=
o
> the first pool in a tiering sort of scenario.
>
> I might have misremembered some details, but I think it's an
> interesting way to get many of the benefits of erasure coding with a re=
latively small amount of work compared to a fully native osd solution.

Greetings,

	I'm one of those individuals :)  Our thinking is evolving on this, and I=
 think we can keep most of the work out of the main machinery of ceph, an=
d simply require a modified client that runs the "proxy" function on the =
"hot" pool OSDs. Even wondering if it could be prototyped in fuse.  I wil=
l be writing this up in the next day or two in the blueprint below.  Josh=
 has the idea basically correct.

>
> Josh

Christopher

>
> [1] http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encod=
ing_as_a_storage_backend


--
=E6=9D=8E=E6=9F=AF=E7=9D=BF
Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
Check my calendar availability: https://tungle.me/cdl
--=_MailMate_80E898AB-1D69-474C-8D58-F544A1E3442D_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJRcI/kAAoJEGmx2Mt/+Iw/z50H/RCL3dX476eRowLqZArSxWWY
xdAL5/CRhCM56sFD4g45BLDADZxviNcR2OeOMccWjUKsobF/Ltkym8gVr0/qrvl5
0BIwE+30sD+YYVobXz8iGnEcpw8fhWHND9d55wCKyfD6bhSkxO2m4DqtrmefcUhe
7CrblY34NkGtWWrAAjK5YZkws5Ug846oAz05HEgGLk8/+YmHtg3qIyMSZ/YXY/95
3mGlddshQxtjITv6gwaT1JCucOQVoxcJksvlf95hYmJpMQkVwMlpRM59lswnMxa/
wTE+DNmQZnKRAoNQtRFYg6aaSGAK5ECWB0rxfc0/vjVD3fgEPMBFUSNjr0jqdH8=
=IVvc
-----END PGP SIGNATURE-----

--=_MailMate_80E898AB-1D69-474C-8D58-F544A1E3442D_=--
