From: Sage Weil <sage@newdream.net>
Subject: Re: unstable branch won't come online
Date: Thu, 15 Apr 2010 10:23:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1004151018580.15369@cobra.newdream.net>
References: <1271345141.4713.25.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-907806109-1271352222=:15369"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55420 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755019Ab0DORVl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Apr 2010 13:21:41 -0400
In-Reply-To: <1271345141.4713.25.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@pcextreme.nl>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-907806109-1271352222=:15369
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Wido,

A fix for the monitor problem is pushed to the unstable branch.  We've=20
been testing with cephx authentication enabled, and in this case it was=20
getting confused when it was off.

I can't tell from the assertion alone why the OSD is crashing.  Can you=20
reproduce with the osd log turned on (debug osd =3D 20 in ceph.conf), and=
=20
let us know what error code it's getting?

Thanks!
sage



On Thu, 15 Apr 2010, Wido den Hollander wrote:

> Hi,
>=20
> Since i had some troubles with the "stable" branch regarding snapshots
> en stalling writebacks i'm trying to get the unstable branch to work.
>=20
> My setup consists of 7 machines in total:
>=20
> - ceph01 (mon / mds): 192.168.6.209
> - ceph02 (mon / mds): 192.168.6.210
> - osd1 (osd): 192.168.6.211
> - osd2 (osd): 192.168.6.212
> - osd3 (osd): 192.168.6.213
> - osd4 (osd): 192.168.6.214
> - osd5 (osd): 192.168.6.215
>=20
> All these machines are running Ubuntu 9.10 (AMD64) with kernel version
> 2.6.34 fetched from:
> http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/2010-04-05-karmic/
>=20
> According to the build log these packages were build with 2.6.34-rc3
>=20
> The problem right now is, my setup is not working. I did a complete
> cleanup of alle 7 machines, gave them a re-install to be sure they were
> all clean.
>=20
> I've attached my ceph.conf for the reference, but imho there seems to be
> a problem with the mon's, this is what i see in my logfiles:
>=20
> cephx keyserverdata: get_caps: name=3Dmon.
> cephx keyserverdata: get_secret: num of caps=3D0
> cephx: verify_authorizer_reply exception in decode_decrypt with
> LR1SttT3gGUDYMC5Ylp4ww=3D=3D (10.04.15 16:59:52.104714)
> -- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a0d40 sd=3D7
> pgs=3D0 cs=3D0 l=3D0).failed verifying authorize reply
> -- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a0d40 sd=3D-1
> pgs=3D0 cs=3D0 l=3D0).fault first fault
> cephx keyserverdata: get_caps: name=3Dmon.
> cephx keyserverdata: get_secret: num of caps=3D0
> cephx: verify_authorizer_reply exception in decode_decrypt with
> 2FUG2YqeiNqm0cxFgialag=3D=3D (10.04.15 16:59:52.107835)
> -- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a0d40 sd=3D7
> pgs=3D0 cs=3D0 l=3D0).failed verifying authorize reply
> 7f0406603910 -- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0
> pipe(0x25a40a0 sd=3D7 pgs=3D0 cs=3D0 l=3D0).accept connect_seq 0 vs exist=
ing 0
> state 1
> 7f0406603910 -- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0
> pipe(0x25a40a0 sd=3D-1 pgs=3D5 cs=3D1 l=3D0).fault initiating reconnect
> cephx keyserverdata: get_caps: name=3Dmon.
> cephx keyserverdata: get_secret: num of caps=3D0
> cephx: verify_authorizer_reply exception in decode_decrypt with
> U9X7DcmEIlSzQ5TIZgUT+g=3D=3D (10.04.15 16:59:52.235836)
> -- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a40a0 sd=3D7
> pgs=3D5 cs=3D2 l=3D0).failed verifying authorize reply
> -- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a40a0 sd=3D-1
> pgs=3D5 cs=3D2 l=3D0).fault first fault
> cephx keyserverdata: get_caps: name=3Dmon.
> cephx keyserverdata: get_secret: num of caps=3D0
> cephx: verify_authorizer_reply exception in decode_decrypt with
> PBYNd7534Bft/AoQ0xRObw=3D=3D (10.04.15 16:59:52.243187)
> -- 192.168.6.210:6789/0 >> 192.168.6.209:6789/0 pipe(0x25a40a0 sd=3D7
> pgs=3D5 cs=3D2 l=3D0).failed verifying authorize reply
>=20
> The messages are the same on mon0 and mon1.
>=20
> Now, on my osd's i see:=20
>=20
> 10.04.15 17:11:26.791702 7ff980706710 -- 0.0.0.0:6800/24247 --> mon1
> 192.168.6.210:6789/0 -- auth(proto 0 26 bytes) -- ?+0 0xd0f8e0
> 10.04.15 17:11:26.800456 7ff978811910 -- 192.168.6.211:6800/24247
> learned my addr 192.168.6.211:6800/24247
> os/FileStore.cc: In function 'void FileStore::sync_entry()':
> os/FileStore.cc:1628: FAILED assert(r =3D=3D 0)
>  1: (FileStore::SyncThread::entry()+0xd) [0x4e8e5d]
>  2: (Thread::_entry_func(void*)+0x7) [0x46a057]
>  3: /lib/libpthread.so.0 [0x7ff9800dda04]
>  4: (clone()+0x6d) [0x7ff97f31580d]
>  NOTE: a copy of the executable, or `objdump -rdS <executable>` is
> needed to interpret this.
>=20
> To be sure, my git branch is "unstable"
>=20
> root@osd1:/usr/src/ceph# git status|head -n 2
> # On branch unstable
> # Changed but not updated:
> root@osd1:/usr/src/ceph#
>=20
> I used "dpkg-buildpackage" on osd1 (fastest CPU) to build .deb's for
> unstable, this because i wanted to test the new rbd block driver and for
> that i needed rbdtool.
>=20
> So to me there seem to be two issues:
>=20
> 1. Mon's cant authenticate with eachother
> 2. OSD's are crashing
>=20
> Any ideas? If needed, i can arrange access to these machines.
>=20
> --=20
> Met vriendelijke groet,
>=20
> Wido den Hollander
> Hoofd Systeembeheer / CSO
> Telefoon Support Nederland: 0900 9633 (45 cpm)
> Telefoon Support Belgi=EB: 0900 70312 (45 cpm)
> Telefoon Direct: (+31) (0)20 50 60 104
> Fax: +31 (0)20 50 60 111
> E-mail: support@pcextreme.nl
> Website: http://www.pcextreme.nl
> Kennisbank: http://support.pcextreme.nl/
> Netwerkstatus: http://nmc.pcextreme.nl
>=20
>=20
>=20
--557981400-907806109-1271352222=:15369--
