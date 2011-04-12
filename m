From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: osd stops
Date: Tue, 12 Apr 2011 20:05:58 +0200 (CEST)
Message-ID: <688456938.14487.1302631558862.JavaMail.root@mail.linserv.se>
References: <64610990.14485.1302631358989.JavaMail.root@mail.linserv.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:42036 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755442Ab1DLSNA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 14:13:00 -0400
In-Reply-To: <64610990.14485.1302631358989.JavaMail.root@mail.linserv.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Thanks for the answer, now I know the reson. Some of my osd had 90% of =
data, dmesg also shows error with the btrfs on the hosts. I will run th=
e test with another file system ext3 :-) or is any other filesystem bet=
ter. It's a backuppc filesystem with a lot of hardlinks and data I woul=
d like to test to run in ceph.

----- Ursprungligt meddelande -----=20
=46r=C3=A5n: "Gregory Farnum" <gregory.farnum@dreamhost.com>=20
Till: "Martin Wilderoth" <martin.wilderoth@linserv.se>=20
Kopia: ceph-devel@vger.kernel.org=20
Skickat: tisdag, 12 apr 2011 19:24:27=20
=C3=84mne: Re: osd stops=20

Ah. It looks like you're running btrfs and you have a very full disk. U=
nfortunately btrfs doesn't handle low-disk situations (above ~80% utili=
zation -- yes, it's annoying) very well and so it's failing to perform =
pretty basic tasks and is propagating those failures up to the OSD. If =
you really need to run that close to full utilization you're going to n=
eed to use another underlying filesystem, or add more disks/nodes to sp=
read the data across.=20
Sorry. :(=20

-Greg=20
On Tuesday, April 12, 2011 at 9:26 AM, Martin Wilderoth wrote:=20
I have been done some tests and it seems as I always get the same probl=
em.=20
> I have been transfering data and suddenly I get I/O error and superbl=
ock problem.=20
> This occurs when the filesystem is filled to aprox 80%=20
>=20
> ceph health reports no error. I restart the system -a stop -a start=20
> after that the system is degraded and the osd stopes.=20
>=20
> The log shows of the fist failing osd=20
>=20
> 2011-04-12 17:51:07.716513 7f02365b8700 -- 0.0.0.0:6802/20180 >> 10.0=
=2E6.12:6802/13633 pipe(0x2e1da00 sd=3D22 pgs=3D0 cs=3D0 l=3D0).fault f=
irst fault=20
> 2011-04-12 17:51:07.716868 7f02365b8700 -- 0.0.0.0:6802/20180 >> 10.0=
=2E6.12:6802/13633 pipe(0x2e1da00 sd=3D22 pgs=3D0 cs=3D0 l=3D0).connect=
 claims to be 0.0.0.0:6802/15976 not 10.0.6.12:6802/13633 - wrong node!=
=20
> os/FileStore.cc: In function 'void FileStore::sync_entry()', in threa=
d '0x7f023f9ce700'=20
> os/FileStore.cc: 2674: FAILED assert(r =3D=3D 0)=20
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)=20
> 1: (FileStore::sync_entry()+0x1975) [0x59f165]=20
> 2: (FileStore::SyncThread::entry()+0xd) [0x5a8a7d]=20
> 3: (()+0x68ba) [0x7f024602b8ba]=20
> 4: (clone()+0x6d) [0x7f0244cc002d]=20
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)=20
> 1: (FileStore::sync_entry()+0x1975) [0x59f165]=20
> 2: (FileStore::SyncThread::entry()+0xd) [0x5a8a7d]=20
> 3: (()+0x68ba) [0x7f024602b8ba]=20
> 4: (clone()+0x6d) [0x7f0244cc002d]=20
> *** Caught signal (Aborted) **=20
> in thread 0x7f023f9ce700=20
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)=20
> 1: /usr/bin/cosd() [0x61e42c]=20
> 2: (()+0xef60) [0x7f0246033f60]=20
> 3: (gsignal()+0x35) [0x7f0244c23165]=20
> 4: (abort()+0x180) [0x7f0244c25f70]=20
> 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f02454b6dc5]=20
> 6: (()+0xcb166) [0x7f02454b5166]=20
> 7: (()+0xcb193) [0x7f02454b5193]=20
> 8: (()+0xcb28e) [0x7f02454b528e]=20
> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char cons=
t*)+0x373) [0x6061e3]=20
> 10: (FileStore::sync_entry()+0x1975) [0x59f165]=20
> 11: (FileStore::SyncThread::entry()+0xd) [0x5a8a7d]=20
> 12: (()+0x68ba) [0x7f024602b8ba]=20
> 13: (clone()+0x6d) [0x7f0244cc002d]=20
>=20
> the second failing osd=20
>=20
> 2011-04-12 18:03:36.036420 7f39c6ce7700 FileStore: sync_entry timed o=
ut after 600 seconds.=20
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)=20
> 2011-04-12 18:03:36.036494 1: (SafeTimer::timer_thread()+0x36b) [0x60=
1afb]=20
> 2011-04-12 18:03:36.036509 2: (SafeTimerThread::entry()+0xd) [0x6042c=
d]=20
> 2011-04-12 18:03:36.036528 3: (()+0x68ba) [0x7f39d034a8ba]=20
> 2011-04-12 18:03:36.036541 4: (clone()+0x6d) [0x7f39cefdf02d]=20
> 2011-04-12 18:03:36.036551 os/FileStore.cc: In function 'virtual void=
 SyncEntryTimeout::finish(int)', in thread '0x7f39c6ce7700'=20
> os/FileStore.cc: 2573: FAILED assert(0)=20
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)=20
> 1: (SyncEntryTimeout::finish(int)+0xf4) [0x5a0b34]=20
> 2: (SafeTimer::timer_thread()+0x36b) [0x601afb]=20
> 3: (SafeTimerThread::entry()+0xd) [0x6042cd]=20
> 4: (()+0x68ba) [0x7f39d034a8ba]=20
> 5: (clone()+0x6d) [0x7f39cefdf02d]=20
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)=20
> 1: (SyncEntryTimeout::finish(int)+0xf4) [0x5a0b34]=20
> 2: (SafeTimer::timer_thread()+0x36b) [0x601afb]=20
> 3: (SafeTimerThread::entry()+0xd) [0x6042cd]=20
> 4: (()+0x68ba) [0x7f39d034a8ba]=20
> 5: (clone()+0x6d) [0x7f39cefdf02d]=20
> *** Caught signal (Aborted) **=20
> in thread 0x7f39c6ce7700=20
> ceph version 0.26 (commit:9981ff90968398da43c63106694d661f5e3d07d5)=20
> 1: /usr/bin/cosd() [0x61e42c]=20
> 2: (()+0xef60) [0x7f39d0352f60]=20
> 3: (gsignal()+0x35) [0x7f39cef42165]=20
> 4: (abort()+0x180) [0x7f39cef44f70]=20
> 5: (__gnu_cxx::__verbose_terminate_handler()+0x115) [0x7f39cf7d5dc5]=20
> 6: (()+0xcb166) [0x7f39cf7d4166]=20
> 7: (()+0xcb193) [0x7f39cf7d4193]=20
> 8: (()+0xcb28e) [0x7f39cf7d428e]=20
> 9: (ceph::__ceph_assert_fail(char const*, char const*, int, char cons=
t*)+0x373) [0x6061e3]=20
> 10: (SyncEntryTimeout::finish(int)+0xf4) [0x5a0b34]=20
> 11: (SafeTimer::timer_thread()+0x36b) [0x601afb]=20
> 12: (SafeTimerThread::entry()+0xd) [0x6042cd]=20
> 13: (()+0x68ba) [0x7f39d034a8ba]=20
> 14: (clone()+0x6d) [0x7f39cefdf02d]=20
>=20
> regards Martin=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in=20
> the body of a message to majordomo@vger.kernel.org=20
> More majordomo info at http://vger.kernel.org/majordomo-info.html=20
>=20

--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
