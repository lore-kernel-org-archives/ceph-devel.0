From: Sage Weil <sage@newdream.net>
Subject: Re: mds suicide
Date: Tue, 5 Oct 2010 08:44:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010050840330.21681@cobra.newdream.net>
References: <AANLkTikArjoBY7D6M5q3eKBH249hpd4BTVhgiVKE9RFn@mail.gmail.com>
 <Pine.LNX.4.64.1010042151480.21681@cobra.newdream.net>
 <Pine.LNX.4.64.1010042157100.21681@cobra.newdream.net>
 <AANLkTi=DG74g=fTcQzRoRM-Zpd9=ttz71wHyiUEXoONV@mail.gmail.com>
 <Pine.LNX.4.64.1010042213350.21681@cobra.newdream.net>
 <AANLkTi=rk8unODtsWcEZRXbnnof3SkrCM4J_cuhsP-f0@mail.gmail.com>
 <Pine.LNX.4.64.1010042233230.21681@cobra.newdream.net>
 <AANLkTikd75pvw58ixsbco-+GsiW4u9bbWrnrG9E3M8zC@mail.gmail.com>
 <AANLkTi=2Fcrej92oV7smYhnHZSbKiz+w5BacW2Ko2wm+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1382043667-1286293406=:21681"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37472 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab0JEPmg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Oct 2010 11:42:36 -0400
In-Reply-To: <AANLkTi=2Fcrej92oV7smYhnHZSbKiz+w5BacW2Ko2wm+@mail.gmail.com>
Content-ID: <Pine.LNX.4.64.1010050844070.21681@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1382043667-1286293406=:21681
Content-Type: TEXT/PLAIN; CHARSET=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <Pine.LNX.4.64.1010050844071.21681@cobra.newdream.net>

On Tue, 5 Oct 2010, Leander Yu wrote:
> use gdb to attach to the cosd process, most of the threads are in
> pthred_mutext_lock , however there are two thread keep waiting for
> pg->lock()

Yeah.  Either a thread holding the lock is deadlocked somewhere, or the=20
lock was leaked.  Do you still have the stack trace from the other=20
threads?

sage

>=20
> ------------ Thread 184 -----------------
> #0  0x00007f7b801ecc44 in __lll_lock_wait () from /lib64/libpthread.so.0
> #1  0x00007f7b801e7f15 in _L_lock_1056 () from /lib64/libpthread.so.0
> #2  0x00007f7b801e7de7 in pthread_mutex_lock () from /lib64/libpthread.so=
=2E0
> #3  0x000000000047509a in ?? ()
> #4  0x00000000004b4181 in C_OSD_Commit::finish(int) ()
> #5  0x00000000005b57d8 in Finisher::finisher_thread_entry() ()
> #6  0x000000000046c61a in Thread::_entry_func(void*) ()
> #7  0x00007f7b801e5a3a in start_thread () from /lib64/libpthread.so.0
> #8  0x00007f7b7f40377d in clone () from /lib64/libc.so.6
> #9  0x0000000000000000 in ?? ()
>=20
> -------------- Thread 182 -------------------
> #0  0x00007f7b801ecc44 in __lll_lock_wait () from /lib64/libpthread.so.0
> #1  0x00007f7b801e7f15 in _L_lock_1056 () from /lib64/libpthread.so.0
> #2  0x00007f7b801e7de7 in pthread_mutex_lock () from /lib64/libpthread.so=
=2E0
> #3  0x00000000004eb0fa in Mutex::Lock(bool) ()
> #4  0x00000000004bac90 in OSD::_lookup_lock_pg(pg_t) ()
> #5  0x00000000004e6e7f in OSD::handle_sub_op_reply(MOSDSubOpReply*) ()
> #6  0x00000000004e871d in OSD::_dispatch(Message*) ()
> #7  0x00000000004e8fa9 in OSD::ms_dispatch(Message*) ()
> #8  0x000000000045eab9 in SimpleMessenger::dispatch_entry() ()
> #9  0x00000000004589fc in SimpleMessenger::DispatchThread::entry() ()
> #10 0x000000000046c61a in Thread::_entry_func(void*) ()
> #11 0x00007f7b801e5a3a in start_thread () from /lib64/libpthread.so.0
> #12 0x00007f7b7f40377d in clone () from /lib64/libc.so.6
> #13 0x0000000000000000 in ?? ()
>=20
> It seems the dispatch thread was blocked so no message can be handle?
>=20
> Regards,
> Leander Yu.
>=20
>=20
> On Tue, Oct 5, 2010 at 2:04 PM, Leander Yu <leander.yu@gmail.com> wrote:
> > it seem like the cosd(asgc-osd9) is idle now. it didn't send any
> > hearbeat out. but the process is still running.
> > This is the netstat output
> > ---------------------------------------------
> > Proto Recv-Q Send-Q Local Address =A0 =A0 =A0 =A0 =A0 =A0 =A0 Foreign A=
ddress
> > =A0 =A0 State
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:8649 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:8139 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:587 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 0.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:8651 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:8652 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.1.9:50000 =A0 =A0 =A0 =A0 =A0=
 0.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:6800 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.1.9:50001 =A0 =A0 =A0 =A0 =A0=
 0.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:465 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 0.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:6801 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A00.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:22 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.1.9:50008 =A0 =A0 =A0 =A0 =A0=
 0.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 0.0.0.0:25 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.1.9:50011 =A0 =A0 =A0 =A0 =A0=
 0.0.0.0:*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 127.0.0.1:8649 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0127.0.0.1:38054
> > =A0 =A0 TIME_WAIT
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 127.0.0.1:8649 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0127.0.0.1:38055
> > =A0 =A0 TIME_WAIT
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.1.9:22 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0192.168.1.101:35785
> > =A0 =A0 ESTABLISHED
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 127.0.0.1:8649 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0127.0.0.1:38053
> > =A0 =A0 TIME_WAIT
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 192.168.1.9:22 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0192.168.1.101:56473
> > =A0 =A0 ESTABLISHED
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 127.0.0.1:8649 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0127.0.0.1:38052
> > =A0 =A0 TIME_WAIT
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 :::587 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0:::*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 :::465 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0:::*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 :::22 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 :::*
> > =A0 =A0 LISTEN
> > tcp =A0 =A0 =A0 =A00 =A0 =A0 =A00 :::25 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 :::*
> > =A0 =A0 LISTEN
> >
> > Regards,
> > Leander Yu.
> >
> >
> >
> > On Tue, Oct 5, 2010 at 1:40 PM, Sage Weil <sage@newdream.net> wrote:
> >> On Tue, 5 Oct 2010, Leander Yu wrote:
> >>> I have another OSD was marked as down however I can still access the
> >>> machine by ssh and I saw the cosd process is running.
> >>> the log shows the same pipe fault error like:
> >>>
> >>> 192.168.1.9:6801/1537 >> 192.168.1.25:6801/29084 pipe(0x7f7b680e2620
> >>> sd=3D-1 pgs=3D437 cs=3D1 l=3D0).fault with nothing to send, going to =
standby
> >>
> >> That error means there was a socket error (usually connection dropped,
> >> but it could lots of things), but the connection wasn't in use.
> >>
> >> This one looks like the heartbeat channel. =A0Most likely that connect=
ion
> >> reconnected shortly after that (the osds send heartbeats every couple
> >> seconds). =A0They're marked down when peer osds expected a heartbeat a=
nd
> >> don't get one. =A0The monitor log ($mon_data/log) normally has informa=
tion
> >> about who reported the failure, but it looks like you've turned it off=
=2E
> >>
> >> In any case, usually the error is harmless. =A0And probably unrelated =
to the
> >> MDS error (unless perhaps the same network glitch was to blame).
> >>
> >> sage
> >>
> >>
> >>
> >>>
> >>> are those two cases related?
> >>>
> >>> Regards,
> >>> Leander Yu.
> >>>
> >>>
> >>> On Tue, Oct 5, 2010 at 1:15 PM, Sage Weil <sage@newdream.net> wrote:
> >>> > On Tue, 5 Oct 2010, Leander Yu wrote:
> >>> >> Hi Sage,
> >>> >> Thanks a lot for your prompt answer.
> >>> >> So is the behavior normal? I mean if we assume there was a network=
 issue.
> >>> >> In this case will it be better to restart the mds instead of suici=
de?
> >>> >> or leave it there as standby?
> >>> >
> >>> > The mds has lots of internal state that would be tricky to clean up
> >>> > properly, so one way or another the old instance should die.
> >>> >
> >>> > But you're right: probably it should just respawn a new instance in=
stead
> >>> > of exiting? =A0The new instance will come back up in standby mode. =
Maybe
> >>> > re-exec with the same set of arguments the original instance was ex=
ectued
> >>> > with?
> >>> >
> >>> > sage
> >>> >
> >>> >
> >>> >>
> >>> >> Regards,
> >>> >> Leander Yu.
> >>> >>
> >>> >> On Tue, Oct 5, 2010 at 1:00 PM, Sage Weil <sage@newdream.net> wrot=
e:
> >>> >> > On Mon, 4 Oct 2010, Sage Weil wrote:
> >>> >> >> On Tue, 5 Oct 2010, Leander Yu wrote:
> >>> >> >> > Hi,
> >>> >> >> > I have a 46 machines cluster(44 osd/mon + 2 mds) running ceph=
 now. MDS
> >>> >> >> > is running in active/standby mode.
> >>> >> >> > This morning one of the MDS suicide the log shows:
> >>> >> >> >
> >>> >> >> > -------------------------------------------
> >>> >> >> > 2010-10-04 22:24:19.450022 7f2e5a1ee710 mds0.cache.ino(100000=
02b87)
> >>> >> >> > pop_projected_snaprealm 0x7f2e50cd9f70 seq1
> >>> >> >> > 2010-10-04 22:26:12.180854 7f2debbfb710 -- 192.168.1.103:6800=
/2081 >>
> >>> >> >> > 192.168.1.106:0/2453428678 pipe(0x7f2e380013d0 sd=3D-1 pgs=3D=
2 cs=3D1
> >>> >> >> > l=3D0).fault with nothing to send, going to standby
> >>> >> >> > 2010-10-04 22:26:12.181019 7f2e481dc710 -- 192.168.1.103:6800=
/2081 >>
> >>> >> >> > 192.168.1.111:0/18905730 pipe(0x7f2e38002250 sd=3D-1 pgs=3D2 =
cs=3D1
> >>> >> >> > l=3D0).fault with nothing to send, going to standby
> >>> >> >> > 2010-10-04 22:26:12.181041 7f2dc3fff710 -- 192.168.1.103:6800=
/2081 >>
> >>> >> >> > 192.168.1.114:0/1945631186 pipe(0x7f2e38000f00 sd=3D-1 pgs=3D=
2 cs=3D1
> >>> >> >> > l=3D0).fault with nothing to send, going to standby
> >>> >> >> > 2010-10-04 22:26:12.181149 7f2deaef6710 -- 192.168.1.103:6800=
/2081 >>
> >>> >> >> > 192.168.1.113:0/521184914 pipe(0x7f2e38002f90 sd=3D-1 pgs=3D2=
 cs=3D1
> >>> >> >> > l=3D0).fault with nothing to send, going to standby
> >>> >> >> > 2010-10-04 22:26:12.181563 7f2deb5f5710 -- 192.168.1.103:6800=
/2081 >>
> >>> >> >> > 192.168.1.112:0/4272114728 pipe(0x7f2e38002ac0 sd=3D-1 pgs=3D=
2 cs=3D1
> >>> >> >> > l=3D0).fault with nothing to send, going to standby
> >>> >> >> > 2010-10-04 22:26:13.777624 7f2e5a1ee710 mds-1.3 handle_mds_ma=
p i
> >>> >> >> > (192.168.1.103:6800/2081) dne in the mdsmap, killing myself
> >>> >> >> > 2010-10-04 22:26:13.777649 7f2e5a1ee710 mds-1.3 suicide. =A0w=
anted
> >>> >> >> > up:active, now down:dne
> >>> >> >> > 2010-10-04 22:26:13.777769 7f2e489e4710 -- 192.168.1.103:6800=
/2081 >>
> >>> >> >> > 192.168.1.101:0/15702 pipe(0x7f2e380008c0 sd=3D-1 pgs=3D1847 =
cs=3D1
> >>> >> >> > l=3D0).fault with nothing to send, going to standby
> >>> >> >> > -------------------------------------------------------------=
-----------------
> >>> >> >> > Would you suggest how do I trouble shooting this issue? or sh=
ould I
> >>> >> >> > just restart the mds to recover it?
> >>> >> >>
> >>> >> >> The MDS killed itself because it was removed from the mdsmap. =
=A0The
> >>> >> >> monitor log will tell you why if you had logging turned up. =A0=
If not, you
> >>> >> >> might find some clue by looking at each mdsmap iteration. =A0If=
 you do
> >>> >> >>
> >>> >> >> =A0$ ceph mds stat
> >>> >> >>
> >>> >> >> it will tell you the map epoch (e###). =A0You can then dump any=
 map
> >>> >> >> iteration with
> >>> >> >>
> >>> >> >> =A0$ ceph mds dump 123 -o -
> >>> >> >>
> >>> >> >> Work backward a few iterations until you find which epoch remov=
ed that mds
> >>> >> >> instance. =A0The one prior to that might have some clue (maybe =
it was
> >>> >> >> laggy?)...
> >>> >> >
> >>> >> > Okay, looking at the maps on your cluster, it looks like there w=
as a
> >>> >> > standby mds, and the live one was marked down. =A0Probably some =
intermittent
> >>> >> > network issue preventing it from sending the monitor beacon on t=
ime, and
> >>> >> > the monitor decided it was dead/unresponsive. =A0The standby cmd=
s took over
> >>> >> > successfully. =A0The recovery looks like it took about 20 second=
s.
> >>> >> >
> >>> >> > sage
> >>> >> >
> >>> >> --
> >>> >> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
> >>> >> the body of a message to majordomo@vger.kernel.org
> >>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >>> >>
> >>> >>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1382043667-1286293406=:21681--
