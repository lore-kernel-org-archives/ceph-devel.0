From: Gaudenz Steinlin <gaudenz@debian.org>
Subject: Re: [Ceph-maintainers] statically allocated uid/gid for ceph
Date: Wed, 15 Apr 2015 19:14:35 +0200
Message-ID: <87bnip2u10.fsf@meteor.durcheinandertal.bofh>
References: <alpine.DEB.2.00.1412061245410.18213@cobra.newdream.net> <5488919E.4090109@redhat.com> <alpine.DEB.2.00.1412101044300.22847@cobra.newdream.net> <5488FC46.5080106@suse.com> <alpine.DEB.2.00.1504131802400.32097@cobra.newdream.net> <552C9182.5030605@suse.com> <alpine.DEB.2.00.1504140819190.4469@cobra.newdream.net> <552D3C74.2000104@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from vechigen.cirrax.com ([217.197.128.12]:34949 "EHLO
	mail.cirrax.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756658AbbDORYX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Apr 2015 13:24:23 -0400
In-Reply-To: <552D3C74.2000104@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, Sage Weil <sweil@redhat.com>, Tim Serong <tserong@suse.com>
Cc: ceph-devel@vger.kernel.org, cjwatson@debian.org, ceph-maintainers@ceph.com, timm@fnal.gov

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi

Ken Dreyer <kdreyer@redhat.com> writes:

> On 04/14/2015 09:21 AM, Sage Weil wrote:
>> I think we still want them to be static across a distro; it's the=20
>> cross-distro change that will be relatively rare.  So a fixed ID from ea=
ch=20
>> distro family ought to be okay?
>
> Sounds sane to me. I've filed https://fedorahosted.org/fpc/ticket/524 to
> request one from Fedora.

I have now requested the same for Debian. If the request is granted we
will most likely get the uid/gid 64045. Maybe others could use the same.
It seems that only Debian has a range of reserved ids for this purpose.
I would expect Ubuntu to use the same id, but that's up to them finally.

Gaudenz

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBVS6cfM3PKyWkzVd5AQon6Q//RpFiKHX+q5RJJ4yO0NJqI1/rVE9ObmAp
p0r4eHK1dYjWrFWAfMCOij9LAFBMKElh608p3oMjODHPlobUcbev7EbphQ0hr4qJ
g4tuSUp0NgeAqtKBSRQruKuzUzm0Z5U/IgIFWNBiQhZ8k77Bl0o43dDPCBJeBtj0
UtPtcTYIHya41O31GU0K7EA4y5m+/VDLrji2bhJeCgnH16Em2+lpTZAzmdoM1RjZ
kfnLKquP2XVGAevvFwF9LFRWlLviFy/PdguaKcm5LTqBnsM4E+33CA186RI0TIPZ
5uu880JS1V2cFMV35r2v1/oe6s+UDXr+ezxHsfTp9kMNaAMYIdbd3WgSDzEbZ32y
bSUqo0SDaoZQKrMjUxn3jSIwiq5mnVakYMedU7iJR1bKP5wdLiMubrflDrX7KTpP
AmjDY3yuDxiQaTalP0Vc6JTdTe9T3u4MBwJB3O7enj4XjCAJV8i7VPcrfSTQ5utE
WyoPaebSIMBQSRUwnnW8Afd66yMp6nIkgRCq2KhJ0efuYGHEkd4hFhE6LFAeJY1i
TfbeVBul7WbdjcjD9UbX1GJEblYIKh+dfljQ3xMWEXoYmkD1B7hln5JcBIIhDyjL
6cgqxVOPW1yOxlmF8YuibgjLdzRPUZkd2wxUlcRg52Xhsr8I6fQpv8SwOzX2/174
NgPutW7HNvc=
=4SLF
-----END PGP SIGNATURE-----
--=-=-=--
