From: AnnyRen <annyren6@gmail.com>
Subject: Re: All osd are marked down and out...
Date: Fri, 29 Apr 2011 16:42:05 +0800
Message-ID: <BANLkTim3quk4omvi12HMYoHntxoRRzxqOA@mail.gmail.com>
References: <BANLkTikmS+PesggpexM+MDnzVE6R2c8pEA@mail.gmail.com>
	<1304065314.2932.102.camel@wido-desktop>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016364d1d29feb78b04a20aa530
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:47064 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab1D2ImI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Apr 2011 04:42:08 -0400
Received: by ewy4 with SMTP id 4so1077335ewy.19
        for <ceph-devel@vger.kernel.org>; Fri, 29 Apr 2011 01:42:06 -0700 (PDT)
In-Reply-To: <1304065314.2932.102.camel@wido-desktop>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

--0016364d1d29feb78b04a20aa530
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2011/4/29 Wido den Hollander <wido@widodh.nl>:
> Hi,
>
> On Fri, 2011-04-29 at 15:20 +0800, AnnyRen wrote:
>> Hi,
>>
>> I Set up a Ceph environment with 3 mon, 2 mds and 30 osd,
>> Recently, we are testing the stalibility of mon,
>>
>> The following are my test steps:
>> 1. on MON1(where mon.0 running):
>> =A0 =A0 -> ceph mon remove 0
>>
>> 2. on MON2 (where mon.1 running)
>> =A0 =A0 --> ceph mon add 0 192.268.200.181:6789 (mon.0 ip:port)
>>
>> 3. on MON2: =A0rsync
>> =A0 =A0 --> rsync -av /data1/mon1/ MON1:/data1/mon0
>>
>> 4. on MON1: start mon.0 daemon
>> =A0 =A0--> cmon -i 0 -c /etc/ceph/ceph.conf
>
> I'm missing what you did here? You say you have 3 monitors, but here you
> see to have two monitors?

originally, I have 3 monitor, I want to remove the leader monitor to
see whether removing a monitor will affect client writes files.
so I use ceph mon remove instruction to modify monmap, and It's ok and
works well,

but when I use 'ceph mon add' to modify monmap, and rsync monmap to
the removed monitor, and then start the mon service on that rejoined
monitor.

>
> And why did you rsync your data from MON2 to MON1? If a monitor has been
> down for a while you don't have to sync the data.
>
> What were you trying to achieve here? Expand the number of monitors? If
> so, please refer to
> http://ceph.newdream.net/wiki/Monitor_cluster_expansion
>
>>
>> 5. Using 'ceph -w' to watch the message
>>
>> I saw osd 30 , 30 up, 30 in...
>>
>>
>> but later, all the osd are marked down and out....
>
> Are you sure the OSD processes are still running?

yes, I execute  'ps aux|grep cosd'  on all OSD host
the service of osd are running.

>
> If I read your command sequence correctly it could be that all your
> OSD's got cut off from the cluster if not all three monitors were in the
> monmap from the time the OSD's started. By removing the first monitor
> and adding the second one afterwards it could be that you cut off the
> monitors.
>
> Could you sent your ceph.conf?
>

ceph.conf is as attachment.

Dear Wido, thanks for your quickly response!!

> Wido
>
>>
>> 2011-04-29 06:51:57.309468 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 0.
>> Marking down!
>> 2011-04-29 06:51:57.309499 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 1.
>> Marking down!
>> 2011-04-29 06:51:57.309513 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 2.
>> Marking down!
>> 2011-04-29 06:51:57.309523 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 3.
>> Marking down!
>> 2011-04-29 06:51:57.309532 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 4.
>> Marking down!
>> 2011-04-29 06:51:57.309541 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 5.
>> Marking down!
>> 2011-04-29 06:51:57.309550 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 6.
>> Marking down!
>> 2011-04-29 06:51:57.309558 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 7.
>> Marking down!
>> 2011-04-29 06:51:57.309567 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 8.
>> Marking down!
>> 2011-04-29 06:51:57.309576 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd 9.
>> Marking down!
>> 2011-04-29 06:51:57.309585 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 10. Marking down!
>> 2011-04-29 06:51:57.309594 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 11. Marking down!
>> 2011-04-29 06:51:57.309603 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 12. Marking down!
>> 2011-04-29 06:51:57.309613 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 13. Marking down!
>> 2011-04-29 06:51:57.309622 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 14. Marking down!
>> 2011-04-29 06:51:57.309631 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 15. Marking down!
>> 2011-04-29 06:51:57.309648 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 16. Marking down!
>> 2011-04-29 06:51:57.309657 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 17. Marking down!
>> 2011-04-29 06:51:57.309666 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 18. Marking down!
>> 2011-04-29 06:51:57.309674 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 19. Marking down!
>> 2011-04-29 06:51:57.309682 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 20. Marking down!
>> 2011-04-29 06:51:57.309691 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 21. Marking down!
>> 2011-04-29 06:51:57.309699 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 22. Marking down!
>> 2011-04-29 06:51:57.309707 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 23. Marking down!
>> 2011-04-29 06:51:57.309716 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 24. Marking down!
>> 2011-04-29 06:51:57.309724 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 25. Marking down!
>> 2011-04-29 06:51:57.309732 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 26. Marking down!
>> 2011-04-29 06:51:57.309741 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 27. Marking down!
>> 2011-04-29 06:51:57.309749 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 28. Marking down!
>> 2011-04-29 06:51:57.309757 7fb17da56710 mon.0@0(leader).osd e148
>> OSDMonitor::handle_osd_timeouts: never got MOSDPGStat info from osd
>> 29. Marking down!
>>
>> 2011-04-29 06:57:02.359021 7fb17da56710 log [INF] : osd0 out (down for
>> 304.884685)
>> 2011-04-29 06:57:02.359070 7fb17da56710 log [INF] : osd1 out (down for
>> 304.884684)
>> 2011-04-29 06:57:02.359090 7fb17da56710 log [INF] : osd2 out (down for
>> 304.884684)
>> 2011-04-29 06:57:02.359109 7fb17da56710 log [INF] : osd3 out (down for
>> 304.884683)
>> 2011-04-29 06:57:02.359126 7fb17da56710 log [INF] : osd4 out (down for
>> 304.884683)
>> 2011-04-29 06:57:02.359145 7fb17da56710 log [INF] : osd5 out (down for
>> 304.884682)
>> 2011-04-29 06:57:02.359162 7fb17da56710 log [INF] : osd6 out (down for
>> 304.884682)
>> 2011-04-29 06:57:02.359179 7fb17da56710 log [INF] : osd7 out (down for
>> 304.884682)
>> 2011-04-29 06:57:02.359197 7fb17da56710 log [INF] : osd8 out (down for
>> 304.884682)
>> 2011-04-29 06:57:02.359215 7fb17da56710 log [INF] : osd9 out (down for
>> 304.884682)
>> 2011-04-29 06:57:02.359234 7fb17da56710 log [INF] : osd10 out (down
>> for 304.884681)
>> 2011-04-29 06:57:02.359252 7fb17da56710 log [INF] : osd11 out (down
>> for 304.884681)
>> 2011-04-29 06:57:02.359270 7fb17da56710 log [INF] : osd12 out (down
>> for 304.884681)
>> 2011-04-29 06:57:02.359289 7fb17da56710 log [INF] : osd13 out (down
>> for 304.884680)
>> 2011-04-29 06:57:02.359308 7fb17da56710 log [INF] : osd14 out (down
>> for 304.884680)
>> 2011-04-29 06:57:02.359328 7fb17da56710 log [INF] : osd15 out (down
>> for 304.884680)
>> 2011-04-29 06:57:02.359347 7fb17da56710 log [INF] : osd16 out (down
>> for 304.884679)
>> 2011-04-29 06:57:02.359367 7fb17da56710 log [INF] : osd17 out (down
>> for 304.884679)
>> 2011-04-29 06:57:02.359386 7fb17da56710 log [INF] : osd18 out (down
>> for 304.884679)
>> 2011-04-29 06:57:02.359406 7fb17da56710 log [INF] : osd19 out (down
>> for 304.884679)
>> 2011-04-29 06:57:02.359425 7fb17da56710 log [INF] : osd20 out (down
>> for 304.884678)
>> 2011-04-29 06:57:02.359458 7fb17da56710 log [INF] : osd21 out (down
>> for 304.884678)
>> 2011-04-29 06:57:02.359480 7fb17da56710 log [INF] : osd22 out (down
>> for 304.884678)
>> 2011-04-29 06:57:02.359499 7fb17da56710 log [INF] : osd23 out (down
>> for 304.884677)
>> 2011-04-29 06:57:02.359518 7fb17da56710 log [INF] : osd24 out (down
>> for 304.884677)
>> 2011-04-29 06:57:02.359538 7fb17da56710 log [INF] : osd25 out (down
>> for 304.884677)
>> 2011-04-29 06:57:02.359557 7fb17da56710 log [INF] : osd26 out (down
>> for 304.884676)
>> 2011-04-29 06:57:02.359577 7fb17da56710 log [INF] : osd27 out (down
>> for 304.884676)
>> 2011-04-29 06:57:02.359596 7fb17da56710 log [INF] : osd28 out (down
>> for 304.884676)
>> 2011-04-29 06:57:02.359616 7fb17da56710 log [INF] : osd29 out (down
>> for 304.884675)
>>
>>
>> root@MON1:~# ceph -s
>> 2011-04-29 07:17:00.226534 =A0 =A0pg v3025: 7920 pgs: 7920 active+clean;
>> 3650 MB data, 0 KB used, 0 KB / 0 KB avail
>> 2011-04-29 07:17:00.239044 =A0 mds e42: 1/1/1 up {0=3Dup:active}, 1 up:s=
tandby
>> 2011-04-29 07:17:00.239080 =A0 osd e151: 30 osds: 0 up, 0 in
>> 2011-04-29 07:17:00.239175 =A0 log 2011-04-29 06:57:02.359625 mon0
>> 192.168.200.181:6789/0 71 : [INF] osd29 out (down for 304.884675)
>> 2011-04-29 07:17:00.239233 =A0 mon e3: 3 mons at
>> {0=3D192.168.200.181:6789/0,1=3D192.168.200.182:6789/0,2=3D192.168.200.1=
83:6789/0}
>>
>>
>> Anyone knows how to fix my environment to make ceph be health?
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>
>

--0016364d1d29feb78b04a20aa530
Content-Type: text/plain; charset=US-ASCII; name="ceph.conf.txt"
Content-Disposition: attachment; filename="ceph.conf.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gn2vq19d0

DQpbZ2xvYmFsXQ0KICAgICAgICBwaWQgZmlsZSA9IC92YXIvcnVuL2NlcGgvJG5hbWUucGlkDQog
ICAgICAgIDsgZGVidWcgbXMgPTENCg0KICAgICAgICA7IGVuYWJsZSBzZWN1cmUgYXV0aGVudGlj
YXRpb24NCiAgICAgICAgOyBhdXRoIHN1cHBvcnRlZCA9IGNlcGh4DQoNCg0KW21vbl0NCiAgICAg
ICAgbW9uIGRhdGEgPSAvZGF0YTEvbW9uJGlkDQogICAgICAgIGRlYnVnIG1vbiA9IDANCg0KDQpb
bW9uMF0NCiAgICAgICAgaG9zdCA9IE1PTjENCiAgICAgICAgbW9uIGFkZHIgPSAxOTIuMTY4LjIw
MC4xODE6Njc4OQ0KDQpbbW9uMV0NCiAgICAgICAgaG9zdCA9IE1PTjINCiAgICAgICAgbW9uIGFk
ZHIgPSAxOTIuMTY4LjIwMC4xODI6Njc4OQ0KDQpbbW9uMl0NCiAgICAgICAgaG9zdCA9IE1PTjMN
CiAgICAgICAgbW9uIGFkZHIgPSAxOTIuMTY4LjIwMC4xODM6Njc4OQ0KDQoNClttZHNdDQoNCiAg
ICAgICAgZGVidWcgbWRzID0gMA0KDQoNClttZHMwXQ0KICAgICAgICBob3N0ID0gTURTMQ0KW21k
czFdDQogICAgICAgIGhvc3QgPSBNRFMyDQoNCg0KDQpbb3NkXQ0KDQogICAgICAgIG9zZCBkYXRh
ID0gL21udC9leHQ0L29zZCRpZA0KDQogICAgICAgIG9zZCBqb3VybmFsID0gL21udC9leHQ0L29z
ZCRpZC9qb3VybmFsDQogICAgICAgIG9zZCBqb3VybmFsIHNpemUgPSA1MTIgOyBqb3VybmFsIHNp
emUsIGluIG1lZ2FieXRlcw0KDQogICAgICAgIGZpbGVzdG9yZSBidHJmcyBzbmFwID0gZmFsc2UN
CiAgICAgICAgZmlsZXN0b3JlIGZzeW5jIGZsdXNoZXMgam91cm5hbCBkYXRhID0gdHJ1ZQ0KDQog
ICAgICAgIGRlYnVnIG9zZCA9IDANCg0KDQpbb3NkMF0NCiAgICAgICAgaG9zdCA9IE9TRDENCg0K
W29zZDFdDQogICAgICAgIGhvc3QgPSBPU0QxDQoNCltvc2QyXQ0KICAgICAgICBob3N0ID0gT1NE
MQ0KDQpbb3NkM10NCiAgICAgICAgaG9zdCA9IE9TRDINCg0KW29zZDRdDQogICAgICAgIGhvc3Qg
PSBPU0QyDQoNCltvc2Q1XQ0KICAgICAgICBob3N0ID0gT1NEMg0KDQpbb3NkNl0NCiAgICAgICAg
aG9zdCA9IE9TRDMNCg0KW29zZDddDQogICAgICAgIGhvc3QgPSBPU0QzDQoNCltvc2Q4XQ0KICAg
ICAgICBob3N0ID0gT1NEMw0KDQpbb3NkOV0NCiAgICAgICAgaG9zdCA9IE9TRDQNCg0KW29zZDEw
XQ0KICAgICAgICBob3N0ID0gT1NENA0KDQpbb3NkMTFdDQogICAgICAgIGhvc3QgPSBPU0Q0DQoN
Cltvc2QxMl0NCiAgICAgICAgaG9zdCA9IE9TRDUNCg0KW29zZDEzXQ0KICAgICAgICBob3N0ID0g
T1NENQ0KDQpbb3NkMTRdDQogICAgICAgIGhvc3QgPSBPU0Q1DQoNCltvc2QxNV0NCiAgICAgICAg
aG9zdCA9IE9TRDYNCg0KW29zZDE2XQ0KICAgICAgICBob3N0ID0gT1NENg0KDQpbb3NkMTddDQog
ICAgICAgIGhvc3QgPSBPU0Q2DQoNCltvc2QxOF0NCiAgICAgICAgaG9zdCA9IE9TRDcNCg0KW29z
ZDE5XQ0KICAgICAgICBob3N0ID0gT1NENw0KDQpbb3NkMjBdDQogICAgICAgIGhvc3QgPSBPU0Q3
DQoNCltvc2QyMV0NCiAgICAgICAgaG9zdCA9IE9TRDgNCg0KW29zZDIyXQ0KICAgICAgICBob3N0
ID0gT1NEOA0KDQpbb3NkMjNdDQogICAgICAgIGhvc3QgPSBPU0Q4DQoNCltvc2QyNF0NCiAgICAg
ICAgaG9zdCA9IE9TRDkNCg0KW29zZDI1XQ0KICAgICAgICBob3N0ID0gT1NEOQ0KDQpbb3NkMjZd
DQogICAgICAgIGhvc3QgPSBPU0Q5DQoNCltvc2QyN10NCiAgICAgICAgaG9zdCA9IE9TRDEwDQoN
Cltvc2QyOF0NCiAgICAgICAgaG9zdCA9IE9TRDEwDQoNCltvc2QyOV0NCiAgICAgICAgaG9zdCA9
IE9TRDEw
--0016364d1d29feb78b04a20aa530--
