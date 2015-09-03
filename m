From: Loic Dachary <loic@dachary.org>
Subject: Re: Fwd: Running a single teuthology job locally using containers
Date: Fri, 04 Sep 2015 00:23:23 +0200
Message-ID: <55E8C85B.600@dachary.org>
References: <1559779519.12046158.1441271711230.JavaMail.zimbra@redhat.com> <55E81C46.6060805@dachary.org> <CAJw4g7W9g6Hkk3w5c=psM5xRviF+AYqxu4hcHLTNzhJC_n8DYg@mail.gmail.com> <CAJw4g7XUek_0BaBFqJnJOaLSK7NVgWmbrJuKpfa5NOzTcPqy-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="EAmkjpdFa9Gddghf4KmGbk4fsKx835kQW"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:49136 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755593AbbICWXa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Sep 2015 18:23:30 -0400
In-Reply-To: <CAJw4g7XUek_0BaBFqJnJOaLSK7NVgWmbrJuKpfa5NOzTcPqy-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ivo Jimenez <ivo@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EAmkjpdFa9Gddghf4KmGbk4fsKx835kQW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 03/09/2015 23:45, Ivo Jimenez wrote:> On Thu, Sep 3, 2015 at 3:09 AM L=
oic Dachary <loic@dachary.org> wrote:
>>
>>>  2. Initialize a `cephdev` container (the following assumes `$PWD` is=

>>>     the folder containing the ceph code in your machine):
>>>
>>>     ```bash
>>>     docker run \
>>>       --name remote0
>>>       -p 2222:22
>>>       -d -e AUTHORIZED_KEYS=3D"`cat ~/.ssh/id_rsa.pub`" \
>>>       -v `pwd`:/ceph \
>>>       -v /dev:/dev \
>>>       -v /tmp/ceph_data/$RANDOM:/var/lib/ceph \
>>>       --cap-add=3DSYS_ADMIN --privileged \
>>>       --device /dev/fuse
>>>       ivotron/cephdev
>>>     ```
>>
>> $PWD is ceph built from sources ? Could you share the dockerfile you u=
sed to create ivotron/cephdev ?
>=20
>=20
> Yes, the idea is to wrap your ceph folder in a container so that it
> becomes a target for teuthology. The link to the dockerfile:
>=20
> https://github.com/ivotron/docker-cephdev

You may want to use install-deps.sh instead of apt-get build-dep to get t=
he packages from sources instead of a presumably older from the source re=
positories.
>=20
>>
>>>
>>> Caveats:
>>>
>>>   * only a single job can be executed and has to be manually
>>>     assembled. I plan to work on supporting suites, which, in short,
>>>     implies stripping out the `install` task from existing suites and=

>>>     leaving only the `install.ship_utilities` subtask instead (the
>>>     container image has all the dependencies in it already).
>>
>> Maybe there could be a script to transform config files such as http:/=
/qa-proxy.ceph.com/teuthology/loic-2015-09-02_15:41:18-rbd-master---basic=
-multi/1042448/config.yaml into a config file suitable for this use case =
?
>=20
>=20
> that's what I have in mind but haven't looked into it yet. I was
> thinking about extending teuthology-suite so that you pass a
> --filter-tasks flag so that we can remove the unwanted tasks, in the
> similar way that --filter leaves some suites out.
>=20
>>
>> Together with git clone -b $sha1 + make in the container, it would be =
a nice way to replay / debug a failed job using a single vm and without g=
oing through packages.
>=20
>=20
> that'd be relatively straight-forward to accomplish, at least the
> docker-side of things (a dockerfile that is given the $SHA1). Prior to
> that, we'd need to have a script that extracts the failed job from
> paddles (does this exist already?), creates a new sha1-predicated

What do you mean by "extract the failed job" ? Do you expect paddles to h=
ave more information than the config.yaml file ( loic-2015-09-02_15:41:18=
-rbd-master---basic-multi/1042448/config.yaml for instance) ?=20

> container and passes the yaml file of the failed job to teuthology
> (which would be invoked with the hypothetical --filter-tasks flag
> mentioned above).

It's probably more than just filtering out tasks. What about a script tha=
t would=20

   dockerize-config < config.yaml > docker-config.yaml

and be smart enough to do whatever is necessary to transform an existing =
config.yaml so that it is suitable to run on docker targets. And fail lou=
dly if it can't ;-)

>=20
>>
>>>   * I have only tried the above with the `radosbench` and `ceph-fuse`=

>>>     tasks. Using `--cap-add=3DALL` and `-v /lib/modules:/lib/modules`=

>>>     flags allows a container to load kernel modules so, in principle,=

>>>     it should work for `rbd` and  `kclient` tasks but I haven't tried=

>>>     it yet.
>>>   * For jobs specifying multiple remotes, multiple containers can be
>>>     launched (one per remote). While it is possible to run these
>>>     on the same docker host, the way ceph daemons dynamically
>>>     bind to ports in the 6800-7300 range makes it difficult to
>>>     determine which ports to expose from each container (exposing the=

>>>     same port from multiple containers in the same host is not
>>>     allowed, for obvious reasons). So either each remote runs on a
>>>     distinct docker host machine, or a deterministic port assignment
>>>     is implemented such that, for example, 6800 is always assigned to=

>>>     osd.0, regardless of where it runs.
>>
>> Would docker run --publish-all=3Dtrue help ?
>=20
>=20
> That option doesn't work with --net=3Dcontainer, which is what we are
> using in this case since we remap sshd's 22 port of the container. In
> other words, for --publish-all to work we need to use --net=3Dhost but
> that disables the virtual network that docker provides. An alternative
> would be to configure the base image we're using
> (https://github.com/tutumcloud/tutum-ubuntu/) so that the port that
> sshd uses is passed in an env var.

Why not use --net=3Dhost then ?

>=20
>>
>>
>> Clever hack, congrats :-)
>=20
>=20
> thanks!
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--EAmkjpdFa9Gddghf4KmGbk4fsKx835kQW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXoyFsACgkQ8dLMyEl6F22yCgCff58WWLEvREV+RIKOpuhurt8D
sdQAmwQ3a5bkXc0gyFlTMf2FMNeesXlM
=R+/M
-----END PGP SIGNATURE-----

--EAmkjpdFa9Gddghf4KmGbk4fsKx835kQW--
