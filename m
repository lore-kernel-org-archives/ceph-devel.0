From: Loic Dachary <loic@dachary.org>
Subject: Re: Running a single teuthology job locally using containers
Date: Thu, 03 Sep 2015 12:09:10 +0200
Message-ID: <55E81C46.6060805@dachary.org>
References: <1559779519.12046158.1441271711230.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5J8soMlxXrJqSRwgUmBRE0L2cMTqGLAwG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48775 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752369AbbICKJN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Sep 2015 06:09:13 -0400
In-Reply-To: <1559779519.12046158.1441271711230.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ivo Jimenez <ivo@redhat.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5J8soMlxXrJqSRwgUmBRE0L2cMTqGLAwG
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/09/2015 11:15, Ivo Jimenez wrote:
> This describes how to run teuthology jobs using docker in three
> "easy" steps, with the goal of shortening the develop/build/test
> cycle for integration-tested code.
>=20
>  1. Write a file containing an entire teuthology job (tasks, targets
>     and roles in a YAML file):
>=20
>     ```yaml
>     sshkeys: ignore
>     roles:
>     - [mon.0, osd.0, osd.1, osd.2, client.0]
>     tasks:
>     - install.ship_utilities:
>     - ceph:
>         conf:
>           mon:
>             debug mon: 20
>             debug ms: 1
>             debug paxos: 20
>           osd:
>             debug filestore: 20
>             debug journal: 20
>             debug ms: 1
>             debug osd: 20
>     - radosbench:
>         clients: [client.0]
>     targets:
>       'root@localhost:2222': ssh-dss ignored
>     ```
>=20
>     The `sshkeys` option is required and the `install.ship_utilities`
>     should be the first task to execute. Also, `~/.teuthology.yaml`
>     should look like this:
>=20
>     ```yaml
>     lab_domain: ''
>     lock_server: ''
>     ```
>=20
>  2. Initialize a `cephdev` container (the following assumes `$PWD` is=20
>     the folder containing the ceph code in your machine):
>=20
>     ```bash
>     docker run \
>       --name remote0
>       -p 2222:22
>       -d -e AUTHORIZED_KEYS=3D"`cat ~/.ssh/id_rsa.pub`" \
>       -v `pwd`:/ceph \
>       -v /dev:/dev \
>       -v /tmp/ceph_data/$RANDOM:/var/lib/ceph \
>       --cap-add=3DSYS_ADMIN --privileged \
>       --device /dev/fuse
>       ivotron/cephdev
>     ```

$PWD is ceph built from sources ? Could you share the dockerfile you used=
 to create ivotron/cephdev ?

>=20
>  3. Execute teuthology using the `wip-11892-docker` branch:
>=20
>     ```bash
>     teuthology \
>       -a ~/archive/`date +%s` \
>       --suite-path /path/to/ceph-qa-suite/ \
>       ~/test.yml
>     ```
>=20
> Caveats:
>=20
>   * only a single job can be executed and has to be manually=20
>     assembled. I plan to work on supporting suites, which, in short,=20
>     implies stripping out the `install` task from existing suites and=20
>     leaving only the `install.ship_utilities` subtask instead (the=20
>     container image has all the dependencies in it already).

Maybe there could be a script to transform config files such as http://qa=
-proxy.ceph.com/teuthology/loic-2015-09-02_15:41:18-rbd-master---basic-mu=
lti/1042448/config.yaml into a config file suitable for this use case ? T=
ogether with git clone -b $sha1 + make in the container, it would be a ni=
ce way to replay / debug a failed job using a single vm and without going=
 through packages.=20

>   * I have only tried the above with the `radosbench` and `ceph-fuse`=20
>     tasks. Using `--cap-add=3DALL` and `-v /lib/modules:/lib/modules`=20
>     flags allows a container to load kernel modules so, in principle,
>     it should work for `rbd` and  `kclient` tasks but I haven't tried
>     it yet.
>   * For jobs specifying multiple remotes, multiple containers can be=20
>     launched (one per remote). While it is possible to run these=20
>     on the same docker host, the way ceph daemons dynamically
>     bind to ports in the 6800-7300 range makes it difficult to
>     determine which ports to expose from each container (exposing the
>     same port from multiple containers in the same host is not
>     allowed, for obvious reasons). So either each remote runs on a
>     distinct docker host machine, or a deterministic port assignment
>     is implemented such that, for example, 6800 is always assigned to
>     osd.0, regardless of where it runs.

Would docker run --publish-all=3Dtrue help ?=20

Clever hack, congrats :-)

Cheers

>=20
> Cheers,
> ivo
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--5J8soMlxXrJqSRwgUmBRE0L2cMTqGLAwG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXoHEYACgkQ8dLMyEl6F22DUQCgnZn7Ybbo9a93f1vPGz75AQ0z
SbcAoKY0Z+pDqqV96lmvlQx2uoa+t0xn
=jwti
-----END PGP SIGNATURE-----

--5J8soMlxXrJqSRwgUmBRE0L2cMTqGLAwG--
