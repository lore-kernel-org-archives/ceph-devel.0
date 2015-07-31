From: Brian Kroth <bpkroth@gmail.com>
Subject: Re: [ceph-users] dropping old distros: el6, precise 12.04, debian
 wheezy?
Date: Fri, 31 Jul 2015 09:18:26 -0500
Message-ID: <20150731141826.GF15736@gmail.com>
References: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net>
 <20150730155812.GE15736@gmail.com>
 <2085249323.24865068.1438327308865.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:34894 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbbGaOS2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jul 2015 10:18:28 -0400
Received: by iodd187 with SMTP id d187so86518209iod.2
        for <ceph-devel@vger.kernel.org>; Fri, 31 Jul 2015 07:18:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2085249323.24865068.1438327308865.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

That's good to hear.  Thanks for the heads up.  We're going to be=20
getting another pile of hardware in the next couple of weeks and I'd=20
prefer to not have to start with Wheezy just to have to move to Jessie a=20
little bit later on.  As someone said earlier, OS rollouts take some care=
=20
to do in large environments.  In the meantime I'll just keep refreshing=20
http://ceph.com/debian/dists/ every couple of days :)

Cheers,
Brian

Alexandre DERUMIER <aderumier@odiso.com> 2015-07-31 09:21:
>>>As I still haven't heard or seen about any upstream distros for Debian
>>>Jessie (see also [1]),
>
>Gitbuilder is already done for jessie
>
>http://gitbuilder.ceph.com/ceph-deb-jessie-x86_64-basic/
>
>@Sage : Don't known if something is blocking to release package officially=
 ?
>
>
>
>----- Mail original -----
>De: "Brian Kroth" <bpkroth@gmail.com>
>=C0: "Sage Weil" <sweil@redhat.com>
>Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-users@ce=
ph.com>
>Envoy=E9: Jeudi 30 Juillet 2015 17:58:12
>Objet: Re: [ceph-users] dropping old distros: el6, precise 12.04, debian w=
heezy?
>
>Sage Weil <sweil@redhat.com> 2015-07-30 06:54:
>>As time marches on it becomes increasingly difficult to maintain proper
>>builds and packages for older distros. For example, as we make the
>>systemd transition, maintaining the kludgey sysvinit and udev support for
>>centos6/rhel6 is a pain in the butt and eats up time and energy to
>>maintain and test that we could be spending doing more useful work.
>>
>>"Dropping" them would mean:
>>
>> - Ongoing development on master (and future versions like infernalis and
>>jewel) would not be tested on these distros.
>>
>> - We would stop building upstream release packages on ceph.com for new
>>releases.
>>
>> - We would probably continue building hammer and firefly packages for
>>future bugfix point releases.
>>
>> - The downstream distros would probably continue to package them, but the
>>burden would be on them. For example, if Ubuntu wanted to ship Jewel on
>>precise 12.04, they could, but they'd probably need to futz with the
>>packaging and/or build environment to make it work.
>>
>>So... given that, I'd like to gauge user interest in these old distros.
>>Specifically,
>>
>> CentOS6 / RHEL6
>> Ubuntu precise 12.04
>> Debian wheezy
>>
>>Would anyone miss them?
>>
>>In particular, dropping these three would mean we could drop sysvinit
>>entirely and focus on systemd (and continue maintaining the existing
>>upstart files for just a bit longer). That would be a relief. (The
>>sysvinit files wouldn't go away in the source tree, but we wouldn't worry
>>about packaging and testing them properly.)
>>
>>Thanks!
>>sage
>
>As I still haven't heard or seen about any upstream distros for Debian
>Jessie (see also [1]), I am still running Debian Wheezy and as that is
>supposed to be supported for another ~4 years by Debian, it would be
>very nice if there were at least stability and security fixes backported
>for the upstream ceph package repositories for that platform.
>
>Additionally, I'll note that I'm personally likely to continue to use
>sysvinit so long as I still can, even when I am able to make the switch
>to Jessie.
>
>Thanks,
>Brian
>
>[1] <http://www.spinics.net/lists/ceph-users/msg19959.html>
>
>_______________________________________________
>ceph-users mailing list
>ceph-users@lists.ceph.com
>http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlW7g7AACgkQdtkBin+QuSACsgCgy8UodciH5CaKi1VJNetz7Isl
IdUAn3xDley3Rubyn1NNOm9/GeW0sIek
=m0n+
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
