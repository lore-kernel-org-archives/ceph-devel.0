From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: Can't start Ceph with CentOS 5.6
Date: Thu, 14 Apr 2011 10:41:44 -0700
Message-ID: <BANLkTi=hhYAuqRA8s34Jz3uLPxJuXhZZ4w@mail.gmail.com>
References: <4DA69AB6.9050508@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:57634 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758542Ab1DNRlq convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Apr 2011 13:41:46 -0400
Received: by fxm17 with SMTP id 17so1335127fxm.19
        for <ceph-devel@vger.kernel.org>; Thu, 14 Apr 2011 10:41:44 -0700 (PDT)
In-Reply-To: <4DA69AB6.9050508@science-computing.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christoph Raible <c.raible@science-computing.de>
Cc: ceph-devel@vger.kernel.org

Hi Christoph,

As Zenon pointed out, you have to install src/init-ceph yourself (as
/etc/init.d/ceph). The RPM package should do this for you.

We considered having "make install" perform this step for users, but
unfortunately every Linux distribution puts the init scripts in a
slightly different place. And some are moving to alternate, non sysV
init systems, of course.

P.S. If you're using CentOS, you should either compile a new kernel
(with an up-to-date Ceph kernel module) or use FUSE.

cheers,
Colin



On Wed, Apr 13, 2011 at 11:56 PM, Christoph Raible
<c.raible@science-computing.de> wrote:
> Hi @all,
>
> I compilied & configured ceph 0.26 today =A0and now i want to start c=
eph with
> =A0/etc/init.d/ceph -a start =A0oder service ceph -a start =A0 but th=
e service is
> unknown and in /etc/init.d =A0there is noch such file!
>
> I compiled ceph with following commands:
>
>
>
> ######################
>
> =A0./autogen.sh
>
> =A0CXXFLAGS=3D"-g -O2" ./configure --prefix=3D/usr --sbindir=3D/sbin
> =A0--localstatedir=3D/var --sysconfdir=3D/etc
>
> =A0make
>
> =A0make install
>
>
> ########################
>
>
>
>
> My ceph.conf in /etc/ceph/ looks like this:
>
>
> #######################
>
> ; global
> [global]
> =A0 =A0 =A0 =A0; enable secure authentication
> =A0 =A0 =A0 =A0auth supported =3D cephx
>
> ; monitors
> ; =A0You need at least one. =A0You need at least three if you want to
> ; =A0tolerate any node failures. =A0Always create an odd number.
> [mon]
> =A0 =A0 =A0 =A0mon data =3D /data/mon$id
>
> =A0 =A0 =A0 =A0; some minimal logging (just message traffic) to aid d=
ebugging
> =A0 =A0 =A0 =A0debug ms =3D 1
>
> [mon0]
> =A0 =A0 =A0 =A0host =3D ceph0
> =A0 =A0 =A0 =A0mon addr =3D 10.1.9.45:6789
>
> [mon1]
> =A0 =A0 =A0 =A0host =3D ceph1
> =A0 =A0 =A0 =A0mon addr =3D 10.1.9.46:6789
>
> ....
>
> ; mds
> ; =A0You need at least one. =A0Define two to get a standby.
> [mds]
> =A0 =A0 =A0 =A0; where the mds keeps its secret encryption keys
> =A0 =A0 =A0 =A0keyring =3D /data/keyring.$name
>
> [mds.0]
> =A0 =A0 =A0 =A0host =3D ceph0
> =A0 =A0 =A0 =A0mds standby replay =3D true
> =A0 =A0 =A0 =A0mds standby for name =3D ceph1
> [mds.1]
> =A0 =A0 =A0 =A0host =3D ceph1
> =A0 =A0 =A0 =A0mds standby replay =3D true
> =A0 =A0 =A0 =A0mds standby for name =3D ceph2
> ....
>
>
>
> ; osd
> ; =A0You need at least one. =A0Two if you want data to be replicated.
> ; =A0Define as many as you like.
> [osd]
> =A0 =A0 =A0 =A0; This is where the btrfs volume will be mounted.
> =A0 =A0 =A0 =A0osd data =3D /data/osd$id
>
> =A0 =A0 =A0 =A0; Ideally, make this a separate disk or partition. =A0=
A few GB
> =A0 =A0 =A0 =A0; is usually enough; more if you have fast disks. =A0Y=
ou can use
> =A0 =A0 =A0 =A0; a file under the osd data dir if need be
> =A0 =A0 =A0 =A0; (e.g. /data/osd$id/journal), but it will be slower t=
han a
> =A0 =A0 =A0 =A0; separate disk or partition.
> =A0 =A0 =A0 =A0osd journal =3D /data/osd$id/journal
>
> =A0 =A0 =A0 =A0; If the OSD journal is a file, you need to specify th=
e size. This is
> specified in MB.
> =A0 =A0 =A0 =A0osd journal size =3D 512
>
>
>
> [osd0]
> ; if 'btrfs devs' is not specified, you're responsible for
> =A0 =A0 =A0 =A0; setting up the 'osd data' dir. =A0if it is not btrfs=
, things
> =A0 =A0 =A0 =A0; will behave up until you try to recover from a crash=
 (which
> =A0 =A0 =A0 =A0; usually fine for basic testing).
> =A0 =A0 =A0 =A0host =3D ceph0
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb1
>
> [osd1]
> =A0 =A0 =A0 =A0host =3D ceph1
> =A0 =A0 =A0 =A0btrfs devs =3D /dev/sdb1
>
> ....
>
> #######################
>
>
> When I want to start ceph with ceph -c /etc/ceph/ceph.conf =A0I got f=
ollowing
> messages:
>
> #######################
>
>
> 2011-04-14 08:59:59.236688 4049d940 -- :/10014 >> 10.1.9.45:6789/0
> pipe(0x7f1ff4000ad0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:02.237107 41190940 -- :/10014 >> 10.1.9.48:6789/0
> pipe(0x7f1ff4001570 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:05.237271 4049d940 -- :/10014 >> 10.1.9.47:6789/0
> pipe(0x7f1ff4000ad0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:08.237502 41190940 -- :/10014 >> 10.1.9.48:6789/0
> pipe(0x7f1ff4001570 sd=3D4 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:11.237709 4049d940 -- :/10014 >> 10.1.9.47:6789/0
> pipe(0x7f1ff4000ad0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:14.237554 41190940 -- :/10014 >> 10.1.9.46:6789/0
> pipe(0x7f1ff4001570 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:17.238122 4049d940 -- :/10014 >> 10.1.9.47:6789/0
> pipe(0x7f1ff4000ad0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:20.238162 41190940 -- :/10014 >> 10.1.9.46:6789/0
> pipe(0x7f1ff4001570 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:23.238641 4049d940 -- :/10014 >> 10.1.9.45:6789/0
> pipe(0x7f1ff4000ad0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:26.238939 41190940 -- :/10014 >> 10.1.9.48:6789/0
> pipe(0x7f1ff4001570 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:29.239232 4049d940 -- :/10014 >> 10.1.9.45:6789/0
> pipe(0x7f1ff4000ad0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:32.239554 41190940 -- :/10014 >> 10.1.9.47:6789/0
> pipe(0x7f1ff4001570 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
> 2011-04-14 09:00:35.239555 4049d940 -- :/10014 >> 10.1.9.46:6789/0
> pipe(0x7f1ff4000ad0 sd=3D3 pgs=3D0 cs=3D0 l=3D0).fault first fault
>
>
> #######################
>
>
>
> I realy hope someone can help me....
>
>
> Best regards,
>
> Christoph Raible
> --
> Vorstand/Board of Management:
> Dr. Bernd Finkbeiner, Dr. Roland Niemeier, Dr. Arno Steitz, Dr. Ingri=
d Zech
> Vorsitzender des Aufsichtsrats/
> Chairman of the Supervisory Board:
> Philippe Miltin
> Sitz/Registered Office: Tuebingen
> Registergericht/Registration Court: Stuttgart
> Registernummer/Commercial Register No.: HRB 382196
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
