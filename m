From: Loic Dachary <loic@dachary.org>
Subject: Re: Docker task for teuthology
Date: Wed, 08 Jul 2015 10:41:45 +0200
Message-ID: <559CE249.9020400@dachary.org>
References: <971548538.4673346.1435793765362.JavaMail.zimbra@redhat.com> <1354525906.4673455.1435793988737.JavaMail.zimbra@redhat.com> <55953789.5090408@dachary.org> <411240269.5493749.1436297748996.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VL0JFIHSbpooNJ3KrcPFirDJIVHbaW2gU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:46533 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932946AbbGHIls (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Jul 2015 04:41:48 -0400
In-Reply-To: <411240269.5493749.1436297748996.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ivo Jimenez <ivo@redhat.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VL0JFIHSbpooNJ3KrcPFirDJIVHbaW2gU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/07/2015 21:35, Ivo Jimenez wrote:
> Sorry Loic, I thought I had replied to your message.
> =20
>> I did not know about https://github.com/signalfuse/maestro-ng, sound r=
eally
>> interesting ! How is it different from
>> https://github.com/GoogleCloudPlatform/kubernetes or
>> https://github.com/projectatomic or https://coreos.com/ ? I've no expe=
rience
>> in any of them.
>=20
> maestro is very lightweight compared to kubernetes. kubernetes has moni=
toring/dashboard features (among many others) and requires an agent to be=
 installed alongside the docker hosts. maestro communicates directly with=
 the docker daemon, so it doesn't require any external dependencies/confi=
guration. Neither of the two have deployment features. maestro's codebase=
 is much more smaller and it's written in python (vs. golang for kubernet=
es).
>=20
> coreos and projectatomic are Linux distros that provide "just enough op=
erating system" (JeOS) and assume that all applications run in containeri=
zed form. There are projects that combine coreos and kubernetes (plus mor=
e infra) to turn a cluster into a PaaS. Deis is an example (which uses Ce=
ph as its storage backend).
> =20

Thanks for educating me :-) I was under the impression (100% unverified) =
that projectatomic competes with kubernetes in the sense that it knows an=
d handles multiple machines, not just one.

Do you see OpenStack with docker instances more of a Deis competitor or a=
 kubernetes / maestro competitor ?=20

>> You're going in a direction I did not think about: adding a task inste=
ad of
>> modifying teuthology itself. It's an interesting route and maybe bette=
r than
>> the one I took which is to modify the lock/provision files, mostly, to=

>> create OpenStack machines instead of Downburst machines. I'm very inte=
rested
>> to know if that works out. Modifying the internals of teuthology is mo=
re
>> complicated and if your method works, it's likely to be simpler.
>=20
> Yes, the plan is to combine ansible+maestro to make it easier to run in=
tegration tests. My goal is to make it possible to run teuthology on a la=
ptop
>=20
>>
>> I see you wrote tests which is much needed. I found that having integr=
ation
>> tests is better than any kind of unit / functional testing because, in=
 the
>> end, most of teuthology work is to properly assemble and run bits and =
pieces
>> that are external to it. In other words, without integration tests you=
 cover
>> only a fraction of the behavior even if you cover 100% of the LOC.
>>
>> Cheers
>=20
> thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--VL0JFIHSbpooNJ3KrcPFirDJIVHbaW2gU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWc4kkACgkQ8dLMyEl6F22c3ACfdfi2C3Phb+xKhsLFUd1dNL96
hm0AoK0ve9Jk0hLuZxsFFYLPek77SD70
=TDhV
-----END PGP SIGNATURE-----

--VL0JFIHSbpooNJ3KrcPFirDJIVHbaW2gU--
