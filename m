From: Leander Yu <leander.yu@gmail.com>
Subject: Re: mds suicide
Date: Tue, 5 Oct 2010 14:04:59 +0800
Message-ID: <AANLkTikd75pvw58ixsbco-+GsiW4u9bbWrnrG9E3M8zC@mail.gmail.com>
References: <AANLkTikArjoBY7D6M5q3eKBH249hpd4BTVhgiVKE9RFn@mail.gmail.com>
	<Pine.LNX.4.64.1010042151480.21681@cobra.newdream.net>
	<Pine.LNX.4.64.1010042157100.21681@cobra.newdream.net>
	<AANLkTi=DG74g=fTcQzRoRM-Zpd9=ttz71wHyiUEXoONV@mail.gmail.com>
	<Pine.LNX.4.64.1010042213350.21681@cobra.newdream.net>
	<AANLkTi=rk8unODtsWcEZRXbnnof3SkrCM4J_cuhsP-f0@mail.gmail.com>
	<Pine.LNX.4.64.1010042233230.21681@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53789 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754154Ab0JEGFA convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Oct 2010 02:05:00 -0400
Received: by wwj40 with SMTP id 40so5172992wwj.1
        for <ceph-devel@vger.kernel.org>; Mon, 04 Oct 2010 23:04:59 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1010042233230.21681@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

it seem like the cosd(asgc-osd9) is idle now. it didn't send any
hearbeat out. but the process is still running.
This is the netstat output
---------------------------------------------
Proto Recv-Q Send-Q Local Address               Foreign Address
     State
tcp        0      0 0.0.0.0:8649                0.0.0.0:*
     LISTEN
tcp        0      0 0.0.0.0:8139                0.0.0.0:*
     LISTEN
tcp        0      0 0.0.0.0:587                 0.0.0.0:*
     LISTEN
tcp        0      0 0.0.0.0:8651                0.0.0.0:*
     LISTEN
tcp        0      0 0.0.0.0:8652                0.0.0.0:*
     LISTEN
tcp        0      0 192.168.1.9:50000           0.0.0.0:*
     LISTEN
tcp        0      0 0.0.0.0:6800                0.0.0.0:*
     LISTEN
tcp        0      0 192.168.1.9:50001           0.0.0.0:*
     LISTEN
tcp        0      0 0.0.0.0:465                 0.0.0.0:*
     LISTEN
tcp        0      0 0.0.0.0:6801                0.0.0.0:*
     LISTEN
tcp        0      0 0.0.0.0:22                  0.0.0.0:*
     LISTEN
tcp        0      0 192.168.1.9:50008           0.0.0.0:*
     LISTEN
tcp        0      0 0.0.0.0:25                  0.0.0.0:*
     LISTEN
tcp        0      0 192.168.1.9:50011           0.0.0.0:*
     LISTEN
tcp        0      0 127.0.0.1:8649              127.0.0.1:38054
     TIME_WAIT
tcp        0      0 127.0.0.1:8649              127.0.0.1:38055
     TIME_WAIT
tcp        0      0 192.168.1.9:22              192.168.1.101:35785
     ESTABLISHED
tcp        0      0 127.0.0.1:8649              127.0.0.1:38053
     TIME_WAIT
tcp        0      0 192.168.1.9:22              192.168.1.101:56473
     ESTABLISHED
tcp        0      0 127.0.0.1:8649              127.0.0.1:38052
     TIME_WAIT
tcp        0      0 :::587                      :::*
     LISTEN
tcp        0      0 :::465                      :::*
     LISTEN
tcp        0      0 :::22                       :::*
     LISTEN
tcp        0      0 :::25                       :::*
     LISTEN

Regards,
Leander Yu.



On Tue, Oct 5, 2010 at 1:40 PM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 5 Oct 2010, Leander Yu wrote:
>> I have another OSD was marked as down however I can still access the
>> machine by ssh and I saw the cosd process is running.
>> the log shows the same pipe fault error like:
>>
>> 192.168.1.9:6801/1537 >> 192.168.1.25:6801/29084 pipe(0x7f7b680e2620
>> sd=3D-1 pgs=3D437 cs=3D1 l=3D0).fault with nothing to send, going to=
 standby
>
> That error means there was a socket error (usually connection dropped=
,
> but it could lots of things), but the connection wasn't in use.
>
> This one looks like the heartbeat channel. =A0Most likely that connec=
tion
> reconnected shortly after that (the osds send heartbeats every couple
> seconds). =A0They're marked down when peer osds expected a heartbeat =
and
> don't get one. =A0The monitor log ($mon_data/log) normally has inform=
ation
> about who reported the failure, but it looks like you've turned it of=
f.
>
> In any case, usually the error is harmless. =A0And probably unrelated=
 to the
> MDS error (unless perhaps the same network glitch was to blame).
>
> sage
>
>
>
>>
>> are those two cases related?
>>
>> Regards,
>> Leander Yu.
>>
>>
>> On Tue, Oct 5, 2010 at 1:15 PM, Sage Weil <sage@newdream.net> wrote:
>> > On Tue, 5 Oct 2010, Leander Yu wrote:
>> >> Hi Sage,
>> >> Thanks a lot for your prompt answer.
>> >> So is the behavior normal? I mean if we assume there was a networ=
k issue.
>> >> In this case will it be better to restart the mds instead of suic=
ide?
>> >> or leave it there as standby?
>> >
>> > The mds has lots of internal state that would be tricky to clean u=
p
>> > properly, so one way or another the old instance should die.
>> >
>> > But you're right: probably it should just respawn a new instance i=
nstead
>> > of exiting? =A0The new instance will come back up in standby mode.=
 Maybe
>> > re-exec with the same set of arguments the original instance was e=
xectued
>> > with?
>> >
>> > sage
>> >
>> >
>> >>
>> >> Regards,
>> >> Leander Yu.
>> >>
>> >> On Tue, Oct 5, 2010 at 1:00 PM, Sage Weil <sage@newdream.net> wro=
te:
>> >> > On Mon, 4 Oct 2010, Sage Weil wrote:
>> >> >> On Tue, 5 Oct 2010, Leander Yu wrote:
>> >> >> > Hi,
>> >> >> > I have a 46 machines cluster(44 osd/mon + 2 mds) running cep=
h now. MDS
>> >> >> > is running in active/standby mode.
>> >> >> > This morning one of the MDS suicide the log shows:
>> >> >> >
>> >> >> > -------------------------------------------
>> >> >> > 2010-10-04 22:24:19.450022 7f2e5a1ee710 mds0.cache.ino(10000=
002b87)
>> >> >> > pop_projected_snaprealm 0x7f2e50cd9f70 seq1
>> >> >> > 2010-10-04 22:26:12.180854 7f2debbfb710 -- 192.168.1.103:680=
0/2081 >>
>> >> >> > 192.168.1.106:0/2453428678 pipe(0x7f2e380013d0 sd=3D-1 pgs=3D=
2 cs=3D1
>> >> >> > l=3D0).fault with nothing to send, going to standby
>> >> >> > 2010-10-04 22:26:12.181019 7f2e481dc710 -- 192.168.1.103:680=
0/2081 >>
>> >> >> > 192.168.1.111:0/18905730 pipe(0x7f2e38002250 sd=3D-1 pgs=3D2=
 cs=3D1
>> >> >> > l=3D0).fault with nothing to send, going to standby
>> >> >> > 2010-10-04 22:26:12.181041 7f2dc3fff710 -- 192.168.1.103:680=
0/2081 >>
>> >> >> > 192.168.1.114:0/1945631186 pipe(0x7f2e38000f00 sd=3D-1 pgs=3D=
2 cs=3D1
>> >> >> > l=3D0).fault with nothing to send, going to standby
>> >> >> > 2010-10-04 22:26:12.181149 7f2deaef6710 -- 192.168.1.103:680=
0/2081 >>
>> >> >> > 192.168.1.113:0/521184914 pipe(0x7f2e38002f90 sd=3D-1 pgs=3D=
2 cs=3D1
>> >> >> > l=3D0).fault with nothing to send, going to standby
>> >> >> > 2010-10-04 22:26:12.181563 7f2deb5f5710 -- 192.168.1.103:680=
0/2081 >>
>> >> >> > 192.168.1.112:0/4272114728 pipe(0x7f2e38002ac0 sd=3D-1 pgs=3D=
2 cs=3D1
>> >> >> > l=3D0).fault with nothing to send, going to standby
>> >> >> > 2010-10-04 22:26:13.777624 7f2e5a1ee710 mds-1.3 handle_mds_m=
ap i
>> >> >> > (192.168.1.103:6800/2081) dne in the mdsmap, killing myself
>> >> >> > 2010-10-04 22:26:13.777649 7f2e5a1ee710 mds-1.3 suicide. =A0=
wanted
>> >> >> > up:active, now down:dne
>> >> >> > 2010-10-04 22:26:13.777769 7f2e489e4710 -- 192.168.1.103:680=
0/2081 >>
>> >> >> > 192.168.1.101:0/15702 pipe(0x7f2e380008c0 sd=3D-1 pgs=3D1847=
 cs=3D1
>> >> >> > l=3D0).fault with nothing to send, going to standby
>> >> >> > ------------------------------------------------------------=
------------------
>> >> >> > Would you suggest how do I trouble shooting this issue? or s=
hould I
>> >> >> > just restart the mds to recover it?
>> >> >>
>> >> >> The MDS killed itself because it was removed from the mdsmap. =
=A0The
>> >> >> monitor log will tell you why if you had logging turned up. =A0=
If not, you
>> >> >> might find some clue by looking at each mdsmap iteration. =A0I=
f you do
>> >> >>
>> >> >> =A0$ ceph mds stat
>> >> >>
>> >> >> it will tell you the map epoch (e###). =A0You can then dump an=
y map
>> >> >> iteration with
>> >> >>
>> >> >> =A0$ ceph mds dump 123 -o -
>> >> >>
>> >> >> Work backward a few iterations until you find which epoch remo=
ved that mds
>> >> >> instance. =A0The one prior to that might have some clue (maybe=
 it was
>> >> >> laggy?)...
>> >> >
>> >> > Okay, looking at the maps on your cluster, it looks like there =
was a
>> >> > standby mds, and the live one was marked down. =A0Probably some=
 intermittent
>> >> > network issue preventing it from sending the monitor beacon on =
time, and
>> >> > the monitor decided it was dead/unresponsive. =A0The standby cm=
ds took over
>> >> > successfully. =A0The recovery looks like it took about 20 secon=
ds.
>> >> >
>> >> > sage
>> >> >
>> >> --
>> >> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>> >> the body of a message to majordomo@vger.kernel.org
>> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>> >>
>> >>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
