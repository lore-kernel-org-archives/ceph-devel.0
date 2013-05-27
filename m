From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Subject: AW: Numerical argument out of domain
Date: Mon, 27 May 2013 20:03:29 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA56045030CBD7@SMBXKO5.cgm.ag>
References: <5EFBD28BA42C604BB012164C72CA56045030CBB3@SMBXKO5.cgm.ag>
 <51A3BB2A.3050106@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko1.compugroup.com ([193.47.161.177]:45724 "EHLO
	SMXKO1.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757011Ab3E0UDk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 May 2013 16:03:40 -0400
In-Reply-To: <51A3BB2A.3050106@inktank.com>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

but mon.a and mon.c runs..

ceph.conf:

[global]
        auth cluster required =3D none
        auth service required =3D none
        auth client required =3D none
        public network =3D 172.25.99.0/24
        cluster network =3D 192.168.99.0/24

[osd]
        osd journal size =3D 1000
        osd mkfs type =3D xfs
        osd mkfs options xfs =3D "-f"   # default for xfs is "-f"
        osd mount options xfs =3D "rw,noatime" # default mount option i=
s "rw,noatime"

[mon.a]

        host =3D hcmonko1
        mon addr =3D 172.25.99.181:6789

#[mon.b]
#
#       host =3D hcmonko2
  #      mon addr =3D 172.25.99.182:6789

[mon.c]

        host =3D hcmonko3
        mon addr =3D 172.25.99.183:6789

[mon.d]

        host =3D hcmonko4
        mon addr =3D 172.25.99.184:6789


[osd.0]
        host =3D hcosdko1
        devs =3D /dev/sdb
        public addr =3D 172.25.99.171
        cluster addr =3D 192.168.99.171
[osd.1]
        host =3D hcosdko1
        devs =3D /dev/sdc
        public addr =3D 172.25.99.171
        cluster addr =3D 192.168.99.171

[osd.2]
        host =3D hcosdko1
        devs =3D /dev/sdd
        public addr =3D 172.25.99.171
        cluster addr =3D 192.168.99.171


Thanks

Regards

Philipp

-----Urspr=FCngliche Nachricht-----
Von: Joao Eduardo Luis [mailto:joao.luis@inktank.com]=20
Gesendet: Montag, 27. Mai 2013 22:00
An: J=E4ger, Philipp
Cc: ceph-devel@vger.kernel.org
Betreff: Re: Numerical argument out of domain

On 05/27/2013 08:31 PM, J=E4ger, Philipp wrote:
> Hello,
>
> i've set up a rados cluster, but the second of three mons will not st=
art:
>
> [19057]: (33) Numerical argument out of domain
> failed: 'ulimit -n 8192;  /usr/bin/ceph-mon -i d --pid-file /var/run/=
ceph/mon.d.pid -c /etc/ceph/ceph.conf '
>
>
> Added a 4. Mon, same problem.
> Tested with Ubuntu 12.04LTS and Debian 7.
> ceph version 0.61.2
>
> Also when I type in "usr/bin/ceph-mon -I d" only, I get the error mes=
sage and the mon service does not start.
>
> Do you know where the problem is?

Most likely, in ceph.conf.

   -Joao

--=20
Joao Eduardo Luis
Software Engineer | http://inktank.com | http://ceph.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
