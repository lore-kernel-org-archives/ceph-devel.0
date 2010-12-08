From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: installation: where do I start debugging this error?
Date: Wed, 8 Dec 2010 10:33:17 +0800
Message-ID: <1291775597.1958.5.camel@cephhost>
References: <AANLkTinfNC1fXqynJ8abp8Ms8GpkLN806MgpCvGaJiCe@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:28762 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754770Ab0LHCbw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Dec 2010 21:31:52 -0500
In-Reply-To: <AANLkTinfNC1fXqynJ8abp8Ms8GpkLN806MgpCvGaJiCe@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>







=E5=9C=A8 2010-12-08=E4=B8=89=E7=9A=84 09:53 +0800=EF=BC=8CBrian Chrism=
an=E5=86=99=E9=81=93=EF=BC=9A
> I've built and installed RPMs for ceph for RHEL6beta.
> I've placed the below ceph.conf in /etc/ceph on both of my test nodes
> (test10, test11).
>=20
> I build a ceph filesystem and hide the key
> mkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs -k /etc/ceph/keyring.bin
> cauthtool --print-key /etc/ceph/keyring.bin > /etc/ceph/secret
> chmod 600 /etc/ceph/secret
> scp -p /etc/ceph/secret test11:/etc/ceph
>=20
> Then I start the daemons on each node:
> service ceph start
>=20
> My daemons start up on both nodes with 'service ceph -a start'
> root      3199     1  0 17:18 ?        00:00:00 /usr/local/bin/cmon -=
i
> 0 -c /tmp/ceph.conf.5365
> root      3228     1  0 17:18 ?        00:00:00 /usr/local/bin/cmds -=
i
> test10 -c /tmp/ceph.conf.5365
> root      3285     1  0 17:18 ?        00:00:00 /usr/local/bin/cosd -=
i
> 0 -c /tmp/ceph.conf.5365
> (similar output on other node)
>=20
> I attempt to mount the ceph filesystem on test10 (using test11's IP):
> mount -t ceph -o name=3Dadmin,secretfile=3D/etc/ceph/keyring.bin
> 10.200.98.111:/ /mnt/ceph
> mount error 5 =3D Input/output error
>=20

Hi ,i take the followng steps , fail to mount,too.

## save auth secret to a file:
$cauthtool --print-key /etc/ceph/keyring.bin > /etc/ceph/secret
chmod 600 /etc/ceph/secret
## future ,support,read a secret from a file
$ mount -t ceph 172.16.50.10:6789:/foo /mnt/ceph =20
   -o name=3Dadmin,secretfile=3Dsecret

but ,the following steps ,mount ceph is successful.


# enable cephx, add a user and secret
    $ mount -t ceph -o name=3Dadmin,secret=3D<secret>=20
       1.2.3.4:/ /mnt/ceph
$ mount -t ceph 172.16.50.10:6791:/foo /mnt/ceph=20
    -o name=3Dadmin,secret=3D=E2=80=98AQArWtdMiI1uDRAAVbNRMeiwsjK+DEMeB=
7ewLg=3D=3D=E2=80=99

# cauthtool --list keyring.bin=20
client.admin
 key: AQArWtdMiI1uDRAAVbNRMeiwsjK+DEMeB7ewLg=3D=3D
auid: 0
caps: [mds] allow
caps: [mon] allow *
caps: [osd] allow *





> /var/log/messages seems to show me what the problem is:
> Dec  7 17:45:19 test10 kernel: libceph: mon0 10.200.98.111:6789
> connection failed
> (a few more of those before mount fails)
> on test11, the daemon is up and listening on that port:
> tcp        0      0 10.200.98.111:6789          10.200.98.111:56805
>      ESTABLISHED 7781/cmon
>=20
> And here's /var/log/ceph/mon.1.log on test11 (the .111 node)
> 2010-12-07 17:36:20.136921 --- 7780 opened log /var/log/ceph/mon.1.lo=
g ---
> ceph version 0.24~rc (commit:378d13df9505e4ea9a32f42cb713cdcf7aaccda0=
)
> 2010-12-07 17:36:20.137164 7f80c51e3720 store(/data/mon1) mount
> 2010-12-07 17:36:20.138241 7f80c51e3720 mon.1@1(starting) e1 init fsi=
d
> 1b4cabdb-30d2-752d-005f-517a7fa982f8
> 2010-12-07 17:36:20.165407 7f80c51e3720 log [INF] : mon.1 calling new
> monitor election
> 2010-12-07 17:36:20.192343 7f80c51e1710 -- 10.200.98.111:6789/0 >>
> 10.200.98.110:6789/0 pipe(0x1cafd20 sd=3D6 pgs=3D0 cs=3D0 l=3D0).faul=
t first
> fault
>=20
> And for test10 (the .110 node)
> 2010-12-07 17:36:49.183357 --- 5767 opened log /var/log/ceph/mon.0.lo=
g ---
> ceph version 0.24~rc (commit:378d13df9505e4ea9a32f42cb713cdcf7aaccda0=
)
> 2010-12-07 17:36:49.183545 7ff24669c720 store(/data/mon0) mount
> 2010-12-07 17:36:49.184556 7ff24669c720 mon.0@0(starting) e1 init fsi=
d
> 1b4cabdb-30d2-752d-005f-517a7fa982f8
> 2010-12-07 17:36:49.600650 7ff24669c720 log [INF] : mon.0 calling new
> monitor election
> 2010-12-07 17:36:49.645875 7ff24669a710 -- 10.200.98.110:6789/0 >>
> 10.200.98.111:6789/0 pipe(0xac7d20 sd=3D6 pgs=3D0 cs=3D0 l=3D0).fault=
 first
> fault
>=20
>=20
> Does this mean my cmon on 111 is getting into a state where it's not
> receiving incoming connections?
> Any suggestions on where to go from here?
>=20
> thanks,
> Brian Chrisman
>=20
>=20
>=20
> ----- ceph.conf in /etc/ceph -----
> ; From sample:
> [global]
> 	auth supported =3D cephx
>=20
> [mon]
> 	mon data =3D /data/mon$id
>=20
> 	; logging, for debugging monitor crashes, in order of
> 	; their likelihood of being helpful :)
> 	;debug ms =3D 1
> 	;debug mon =3D 20
> 	;debug paxos =3D 20
> 	;debug auth =3D 20
>=20
> [mon0]
> 	host =3D test10
> 	mon addr =3D 10.200.98.110:6789
>=20
> [mon1]
> 	host =3D test11
> 	mon addr =3D 10.200.98.111:6789
>=20
> [mds]
> 	keyring =3D /data/keyring.$name
> 	;debug ms =3D 1
> 	;debug mds =3D 20
>=20
> [mds.test10]
> 	host =3D test10
>=20
> [mds.test11]
> 	host =3D test11
>=20
> [osd]
> 	osd data =3D /data/osd$id
> 	osd journal =3D /data/osd$id/journal
> 	osd journal size =3D 1000 ; journal size, in megabytes
> 	;debug ms =3D 1
> 	;debug osd =3D 20
> 	;debug filestore =3D 20
> 	;debug journal =3D 20
>=20
> [osd0]
> 	host =3D test10
> 	btrfs devs =3D /dev/sdd4
>=20
> [osd1]
> 	host =3D test11
> 	btrfs devs =3D /dev/sdd4
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
