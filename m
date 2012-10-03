From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-commit] teuthology lock_server error
Date: Wed, 3 Oct 2012 08:08:50 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1210030808080.21194@cobra.newdream.net>
References: <CABpo6hLzP1n8MSyi=bNmuJxeKb9yRd6oEnjSxYP3gJ_Nt0EVaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-741150462-1349276930=:21194"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33983 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932361Ab2JCPIu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 11:08:50 -0400
In-Reply-To: <CABpo6hLzP1n8MSyi=bNmuJxeKb9yRd6oEnjSxYP3gJ_Nt0EVaQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lokesh Krishnappa <lokesh.professional.it@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-commit@lists.ceph.newdream.net, ceph-commit-ceph.newdream.net-confirm+6595873e5e2f1b9f5abaa524fb44a53e238a71e4@lists.ceph.newdream.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-741150462-1349276930=:21194
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

If you are not actually running the lock server (which you probably don't=
=20
need anyway), add

check-lcoks: false

to your yaml.  I think that will get you going...

sage

On Wed, 3 Oct 2012, Lokesh Krishnappa wrote:

> Hi all,
>=20
> Am new to git and playing around git qa suite , trying to test rbd on l=
ocal
> machine .
> and local test bed setup as ;
>=20
> OS :=A0 Ubuntu 12.04LTS
> teuthology version: 0.0.1
> ceph : 0.48.1 arganaut
>=20
> we are running server, and the client on locale in a single machine .
> yaml file format :
> roles:
> - [mon.a, osd.0, osd.1]
>=20
> targets:
> =A0=A0 lokesh@lokesh: ssh-rsaAAAAB3NzaC1yc2EAAAADAQABAAABAQDmSb/VpYpdSQ=
Lp4unsKUNV/DKV2f55M1QSXHu10Qvco33
> rYopOF/l5+eYlINCHF1v/SA+bLOMT/4OHGkZR67TajAoXFpyolVSxZKRoJHLV2iJ+MrRiax=
Shct
> MYWpLOjc4iRA4BG3FTG5TTPKJweDj8dDdUIqZ9PuSpP5VuOriCpQkPWECL2hJqAYwnknK1U=
hg3r
> YV0XxL14Iep9KCZf2PcJNw3Eur6XKDAczu/sAUlOiLrBsQpFmOaPY5jFDaM3U7KpJvqiI4D=
rq33
> 1iMh9n3GuA+JvcTMKuT7CN36GswlvGuakTzaDoR66JaYYKkGzDl977K94XrAdQwa2NKLu1X=
H
>=20
>=20
> tasks:
> - ceph:
> - ceph-fuse:
> - workunit:
> =A0=A0=A0 clients:
> =A0=A0=A0=A0=A0 client.0:
> =A0=A0=A0=A0=A0=A0=A0 - rbd/test_cls_rbd.sh
> #-interactive-on-error: true
>=20
> and my .teutholgy.yaml file format is:
>=20
> lock_server: http://lokesh/lock
> queue_host: lokesh
> queue_port: 4000
>=20
> while am trying to execute test suite as:
> lokesh@lokesh:~/Downloads/ceph-teuthology-78b7b02$
> ./virtualenv/bin/teuthology rbd_cls_tests1.yaml
>=20
> i met error as:
> INFO:teuthology.run_tasks:Running task internal.save_config...
> INFO:teuthology.task.internal:Saving configuration
> INFO:teuthology.run_tasks:Running task internal.check_lock...
> INFO:teuthology.task.internal:Checking locks...
> INFO:teuthology.lock:GET request to 'http://lokesh/lock/lokesh@lokesh' =
with
> body 'None' failed with response code 404
> ERROR:teuthology.run_tasks:Saw exception from tasks
> Traceback (most recent call last):
> =A0 File
> "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/run_tasks.py=
",
> line 25, in run_tasks
> =A0=A0=A0 manager =3D _run_one_task(taskname, ctx=3Dctx, config=3Dconfi=
g)
> =A0 File
> "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/run_tasks.py=
",
> line 14, in _run_one_task
> =A0=A0=A0 return fn(**kwargs)
> =A0 File"/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/task=
/internal.py
> ", line 110, in check_lock
> =A0=A0=A0 'could not read lock status for {name}'.format(name=3Dmachine=
)
> AssertionError: could not read lock status for lokesh@lokesh
>=20
> i didnt get idea abt it . but the server is working fine.. any idea pls
> reply.
>=20
>=20
>=20
> With Regards,
>=20
> Lokesh K
>=20
>=20
>=20
>=20
>=20
--557981400-741150462-1349276930=:21194--
