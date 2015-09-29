From: Loic Dachary <loic@dachary.org>
Subject: Re: [ceph-users] [puppet] Moving puppet-ceph to the Openstack big
 tent
Date: Wed, 30 Sep 2015 00:11:28 +0200
Message-ID: <560B0C90.1000500@dachary.org>
References: <CAH7C+Pr2rA65O8gm3B1A64fFPctb_-q=jE=a6AHKJcfHNY1OEw@mail.gmail.com> <CACEfbZjcC7AR3SXNrepxM=KAX64WXCtGxeHhnOKQ-PmCZU73gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="jdn9xvp4Ml4dqVjnP6ouQep0nxF1iUdml"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:34755 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754258AbbI2WLa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Sep 2015 18:11:30 -0400
In-Reply-To: <CACEfbZjcC7AR3SXNrepxM=KAX64WXCtGxeHhnOKQ-PmCZU73gg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Woodward <xarses@gmail.com>, David Moreau Simard <dms@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>, Ceph User Committee <ceph-community@lists.ceph.com>
Cc: openstack-dev@lists.openstack.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jdn9xvp4Ml4dqVjnP6ouQep0nxF1iUdml
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Good move :-)

On 29/09/2015 23:45, Andrew Woodward wrote:
> [I'm cross posting this to the other Ceph threads to ensure that it's s=
een]
>=20
> We've discussed this on Monday on IRC and again in the puppet-openstack=
 IRC meeting. The current census is that we will move from the deprecated=
 stackforge organization and will be moved to the openstack one. At this =
time we will not be perusing membership as a formal OpenStack project. Th=
is will allow puppet-ceph to retain the tight relationship with OpenStack=
 community and tools for the time being.=20
>=20
> On Mon, Sep 28, 2015 at 8:32 AM David Moreau Simard <dms@redhat.com <ma=
ilto:dms@redhat.com>> wrote:
>=20
>     Hi,
>=20
>     puppet-ceph currently lives in stackforge [1] which is being retire=
d
>     [2]. puppet-ceph is also mirrored on the Ceph Github organization [=
3].
>     This version of the puppet-ceph module was created from scratch and=

>     not as a fork of the (then) upstream puppet-ceph by Enovance [4].
>     Today, the version by Enovance is no longer officially maintained
>     since Red Hat has adopted the new release.
>=20
>     Being an Openstack project under Stackforge or Openstack brings a l=
ot
>     of benefits but it's not black and white, there are cons too.
>=20
>     It provides us with the tools, the processes and the frameworks to
>     review and test each contribution to ensure we ship a module that i=
s
>     stable and is held to the highest standards.
>     But it also means that:
>     - We forego some level of ownership back to the Openstack foundatio=
n,
>     it's technical committee and the Puppet Openstack PTL.
>     - puppet-ceph contributors will also be required to sign the
>     Contributors License Agreement and jump through the Gerrit hoops [5=
]
>     which can make contributing to the project harder.
>=20
>     We have put tremendous efforts into creating a quality module and a=
s
>     such it was the first puppet module in the stackforge organization =
to
>     implement not only unit tests but also integration tests with third=

>     party CI.
>     Integration testing for other puppet modules are just now starting =
to
>     take shape by using the Openstack CI inrastructure.
>=20
>     In the context of Openstack, RDO already ships with a mean to insta=
ll
>     Ceph with this very module and Fuel will be adopting it soon as wel=
l.
>     This means the module will benefit from real world experience and
>     improvements by the Openstack community and packagers.
>     This will help further reinforce that not only Ceph is the best
>     unified storage solution for Openstack but that we have means to
>     deploy it in the real world easily.
>=20
>     We all know that Ceph is also deployed outside of this context and
>     this is why the core reviewers make sure that contributions remain
>     generic and usable outside of this use case.
>=20
>     Today, the core members of the project discussed whether or not we
>     should move puppet-ceph to the Openstack big tent and we had a
>     consensus approving the move.
>     We would also like to hear the thoughts of the community on this to=
pic.
>=20
>     Please let us know what you think.
>=20
>     Thanks,
>=20
>     [1]: https://github.com/stackforge/puppet-ceph
>     [2]: https://review.openstack.org/#/c/192016/
>     [3]: https://github.com/ceph/puppet-ceph
>     [4]: https://github.com/redhat-cip/puppet-ceph
>     [5]: https://wiki.openstack.org/wiki/How_To_Contribute
>=20
>     David Moreau Simard
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>     the body of a message to majordomo@vger.kernel.org <mailto:majordom=
o@vger.kernel.org>
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --=20
>=20
> --
>=20
> Andrew Woodward
>=20
> Mirantis
>=20
> Fuel Community Ambassador
>=20
> Ceph Community
>=20
>=20
>=20
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--jdn9xvp4Ml4dqVjnP6ouQep0nxF1iUdml
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYLDJAACgkQ8dLMyEl6F20ZUgCgr5ChXKwrem8gTaPUYBu+UFxt
OhAAn0l5P8ZHpFdY0Uh9XTS9iCioplSI
=zpJq
-----END PGP SIGNATURE-----

--jdn9xvp4Ml4dqVjnP6ouQep0nxF1iUdml--
