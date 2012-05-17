From: Tommi Virtanen <tv@inktank.com>
Subject: Re: pushed it to a crash
Date: Thu, 17 May 2012 09:38:56 -0700
Message-ID: <CADvuQRGq7GnfusUdvWjZ+H9MtBUY1hvbt=588G_fkQsM5Giq7g@mail.gmail.com>
References: <1337244589-sup-609@fewbar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54955 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755099Ab2EQQjQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 12:39:16 -0400
Received: by dady13 with SMTP id y13so2638033dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 17 May 2012 09:39:16 -0700 (PDT)
In-Reply-To: <1337244589-sup-609@fewbar.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Clint Byrum <clint@fewbar.com>
Cc: ceph-devel@vger.kernel.org

[Added ceph-devel to Cc:]

On Thu, May 17, 2012 at 1:56 AM, Clint Byrum <clint@fewbar.com> wrote:
> Hi Tommi.
>
> I got home and just had to finish the refactor. Now I get a crash, wh=
ich I've pasted below.

Well, I've never seen that one before. Anyone else have a clue? Sage, G=
reg?

=46or others: that's using a setup where one of the monitors
(mon.cmon-0) gets a monmap with itself as the only member, and others
(mon.cmon-1) get a monmap that has the IP of mon.cmon-0.

> Its reproducible with the charm I have.. which I've pushed to this bz=
r branch:
>
> lp:~clint-fewbar/charms/precise/ceph-mon/rewrite
>
> If you are brave enough to try juju:
>
> juju bootstrap
> juju deploy --repository ~/charms local:ceph-mon -n 3
> ... wait
> juju set ceph-mon initializing-unit=3Dceph-mon/0
>
> The crash is on the "leader" (renamed to the initializing-unit to rem=
ove confusion).
>
> I've left this running, if you'd like to do anything as far as debugg=
ing.
>
> Anyway, the log from the non-leaders looks like this:
>
> 2012-05-17 08:48:12.077550 7fd3e11d1780 =C2=A00 store(/mnt/mon.cmon-1=
) created monfs at /mnt/mon.cmon-1 for cmon-1
> 2012-05-17 08:48:13.714240 7fd5b13ed780 =C2=A01 mon.cmon-1@-1(probing=
) e0 init fsid f56c6f22-9ffc-11e1-bae9-22000afc46fb
> 2012-05-17 08:48:13.789339 7fd5ac46a700 =C2=A00 log [INF] : mon.cmon-=
1 calling new monitor election
> 2012-05-17 08:48:14.416376 7fd5ab468700 =C2=A00 -- 10.252.87.112:6800=
/0 >> 10.252.70.251:6789/0 pipe(0x2346500 sd=3D17 pgs=3D2 cs=3D1 l=3D0)=
=2Efault initiating reconnect
>
> And here is the crash log:
>
> root@ip-10-252-70-251:~# cat /var/log/ceph/ceph-mon.cmon-0.log
> 2012-05-17 08:47:42.647248 7fc7c734d780 =C2=A00 store(/mnt/mon.cmon-0=
) created monfs at /mnt/mon.cmon-0 for cmon-0
> 2012-05-17 08:47:48.263011 7f1657506780 =C2=A01 mon.cmon-0@0(probing)=
 e0 init fsid f56c6f22-9ffc-11e1-bae9-22000afc46fb
> 2012-05-17 08:47:48.263654 7f1657506780 =C2=A01 mon.cmon-0@0(probing)=
 e0 win_standalone_election
> 2012-05-17 08:47:48.263748 7f1657506780 =C2=A00 log [INF] : mon.cmon-=
0@0 won leader election with quorum 0
> 2012-05-17 08:47:48.297184 7f1657506780 =C2=A01 mon.cmon-0@0(leader).=
osd e1 e1: 0 osds: 0 up, 0 in
> 2012-05-17 08:47:48.528721 7f1657506780 =C2=A01 mon.cmon-0@0(probing)=
 e1 win_standalone_election
> 2012-05-17 08:47:48.528829 7f1657506780 =C2=A00 log [INF] : mon.cmon-=
0@0 won leader election with quorum 0
> 2012-05-17 08:48:13.749820 7f1652583700 =C2=A00 mon.cmon-0@0(leader).=
monmap v1 adding cmon-2 at 10.252.33.186:6800/0 to monitor cluster
> 2012-05-17 08:48:13.752916 7f1652583700 =C2=A00 log [INF] : mon.cmon-=
0 calling new monitor election
> 2012-05-17 08:48:13.881387 7f1652583700 -1 mon/MonMap.h: In function =
'entity_inst_t MonMap::get_inst(unsigned int) const' thread 7f165258370=
0 time 2012-05-17 08:48:13.880187
> mon/MonMap.h: 167: FAILED assert(m < rank_addr.size())
>
> =C2=A0ceph version 0.46-219-g54bc094 (commit:54bc09417917d8d0ca99d8ed=
8285498b7d5aa369)
> =C2=A01: (Elector::defer(int)+0x6da) [0x5162aa]
> =C2=A02: (Elector::handle_propose(MMonElection*)+0x573) [0x516903]
> =C2=A03: (Elector::dispatch(Message*)+0xc73) [0x519863]
> =C2=A04: (Monitor::_ms_dispatch(Message*)+0x3f3) [0x4865a3]
> =C2=A05: (Monitor::ms_dispatch(Message*)+0x32) [0x493752]
> =C2=A06: (SimpleMessenger::dispatch_entry()+0x863) [0x5bf653]
> =C2=A07: (SimpleMessenger::DispatchThread::entry()+0xd) [0x589e3d]
> =C2=A08: (()+0x7e9a) [0x7f16570dce9a]
> =C2=A09: (clone()+0x6d) [0x7f16558954bd]
> =C2=A0NOTE: a copy of the executable, or `objdump -rdS <executable>` =
is needed to interpret this.
>
> --- begin dump of recent events ---
> =C2=A0 -10> 2012-05-17 08:47:48.253421 7f1657506780 =C2=A01 store(/mn=
t/mon.cmon-0) mount
> =C2=A0 =C2=A0-9> 2012-05-17 08:47:48.257204 7f1657506780 =C2=A00 ceph=
 version 0.46-219-g54bc094 (commit:54bc09417917d8d0ca99d8ed8285498b7d5a=
a369), process ceph-mon, pid 7640
> =C2=A0 =C2=A0-8> 2012-05-17 08:47:48.263011 7f1657506780 =C2=A01 mon.=
cmon-0@0(probing) e0 init fsid f56c6f22-9ffc-11e1-bae9-22000afc46fb
> =C2=A0 =C2=A0-7> 2012-05-17 08:47:48.263654 7f1657506780 =C2=A01 mon.=
cmon-0@0(probing) e0 win_standalone_election
> =C2=A0 =C2=A0-6> 2012-05-17 08:47:48.263748 7f1657506780 =C2=A00 log =
[INF] : mon.cmon-0@0 won leader election with quorum 0
> =C2=A0 =C2=A0-5> 2012-05-17 08:47:48.297184 7f1657506780 =C2=A01 mon.=
cmon-0@0(leader).osd e1 e1: 0 osds: 0 up, 0 in
> =C2=A0 =C2=A0-4> 2012-05-17 08:47:48.528721 7f1657506780 =C2=A01 mon.=
cmon-0@0(probing) e1 win_standalone_election
> =C2=A0 =C2=A0-3> 2012-05-17 08:47:48.528829 7f1657506780 =C2=A00 log =
[INF] : mon.cmon-0@0 won leader election with quorum 0
> =C2=A0 =C2=A0-2> 2012-05-17 08:48:13.749820 7f1652583700 =C2=A00 mon.=
cmon-0@0(leader).monmap v1 adding cmon-2 at 10.252.33.186:6800/0 to mon=
itor cluster
> =C2=A0 =C2=A0-1> 2012-05-17 08:48:13.752916 7f1652583700 =C2=A00 log =
[INF] : mon.cmon-0 calling new monitor election
> =C2=A0 =C2=A0 0> 2012-05-17 08:48:13.881387 7f1652583700 -1 mon/MonMa=
p.h: In function 'entity_inst_t MonMap::get_inst(unsigned int) const' t=
hread 7f1652583700 time 2012-05-17 08:48:13.880187
> mon/MonMap.h: 167: FAILED assert(m < rank_addr.size())
>
> =C2=A0ceph version 0.46-219-g54bc094 (commit:54bc09417917d8d0ca99d8ed=
8285498b7d5aa369)
> =C2=A01: (Elector::defer(int)+0x6da) [0x5162aa]
> =C2=A02: (Elector::handle_propose(MMonElection*)+0x573) [0x516903]
> =C2=A03: (Elector::dispatch(Message*)+0xc73) [0x519863]
> =C2=A04: (Monitor::_ms_dispatch(Message*)+0x3f3) [0x4865a3]
> =C2=A05: (Monitor::ms_dispatch(Message*)+0x32) [0x493752]
> =C2=A06: (SimpleMessenger::dispatch_entry()+0x863) [0x5bf653]
> =C2=A07: (SimpleMessenger::DispatchThread::entry()+0xd) [0x589e3d]
> =C2=A08: (()+0x7e9a) [0x7f16570dce9a]
> =C2=A09: (clone()+0x6d) [0x7f16558954bd]
> =C2=A0NOTE: a copy of the executable, or `objdump -rdS <executable>` =
is needed to interpret this.
>
> --- end dump of recent events ---
> 2012-05-17 08:48:13.882910 7f1652583700 -1 *** Caught signal (Aborted=
) **
> =C2=A0in thread 7f1652583700
>
> =C2=A0ceph version 0.46-219-g54bc094 (commit:54bc09417917d8d0ca99d8ed=
8285498b7d5aa369)
> =C2=A01: /usr/bin/ceph-mon() [0x622e9a]
> =C2=A02: (()+0xfcb0) [0x7f16570e4cb0]
> =C2=A03: (gsignal()+0x35) [0x7f16557d9445]
> =C2=A04: (abort()+0x17b) [0x7f16557dcbab]
> =C2=A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f165612=
769d]
> =C2=A06: (()+0xb5846) [0x7f1656125846]
> =C2=A07: (()+0xb5873) [0x7f1656125873]
> =C2=A08: (()+0xb596e) [0x7f165612596e]
> =C2=A09: (ceph::__ceph_assert_fail(char const*, char const*, int, cha=
r const*)+0x282) [0x5dcd52]
> =C2=A010: (Elector::defer(int)+0x6da) [0x5162aa]
> =C2=A011: (Elector::handle_propose(MMonElection*)+0x573) [0x516903]
> =C2=A012: (Elector::dispatch(Message*)+0xc73) [0x519863]
> =C2=A013: (Monitor::_ms_dispatch(Message*)+0x3f3) [0x4865a3]
> =C2=A014: (Monitor::ms_dispatch(Message*)+0x32) [0x493752]
> =C2=A015: (SimpleMessenger::dispatch_entry()+0x863) [0x5bf653]
> =C2=A016: (SimpleMessenger::DispatchThread::entry()+0xd) [0x589e3d]
> =C2=A017: (()+0x7e9a) [0x7f16570dce9a]
> =C2=A018: (clone()+0x6d) [0x7f16558954bd]
> =C2=A0NOTE: a copy of the executable, or `objdump -rdS <executable>` =
is needed to interpret this.
>
> --- begin dump of recent events ---
> =C2=A0 =C2=A0 0> 2012-05-17 08:48:13.882910 7f1652583700 -1 *** Caugh=
t signal (Aborted) **
> =C2=A0in thread 7f1652583700
>
> =C2=A0ceph version 0.46-219-g54bc094 (commit:54bc09417917d8d0ca99d8ed=
8285498b7d5aa369)
> =C2=A01: /usr/bin/ceph-mon() [0x622e9a]
> =C2=A02: (()+0xfcb0) [0x7f16570e4cb0]
> =C2=A03: (gsignal()+0x35) [0x7f16557d9445]
> =C2=A04: (abort()+0x17b) [0x7f16557dcbab]
> =C2=A05: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f165612=
769d]
> =C2=A06: (()+0xb5846) [0x7f1656125846]
> =C2=A07: (()+0xb5873) [0x7f1656125873]
> =C2=A08: (()+0xb596e) [0x7f165612596e]
> =C2=A09: (ceph::__ceph_assert_fail(char const*, char const*, int, cha=
r const*)+0x282) [0x5dcd52]
> =C2=A010: (Elector::defer(int)+0x6da) [0x5162aa]
> =C2=A011: (Elector::handle_propose(MMonElection*)+0x573) [0x516903]
> =C2=A012: (Elector::dispatch(Message*)+0xc73) [0x519863]
> =C2=A013: (Monitor::_ms_dispatch(Message*)+0x3f3) [0x4865a3]
> =C2=A014: (Monitor::ms_dispatch(Message*)+0x32) [0x493752]
> =C2=A015: (SimpleMessenger::dispatch_entry()+0x863) [0x5bf653]
> =C2=A016: (SimpleMessenger::DispatchThread::entry()+0xd) [0x589e3d]
> =C2=A017: (()+0x7e9a) [0x7f16570dce9a]
> =C2=A018: (clone()+0x6d) [0x7f16558954bd]
> =C2=A0NOTE: a copy of the executable, or `objdump -rdS <executable>` =
is needed to interpret this.
>
> --- end dump of recent events ---
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
