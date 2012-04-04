From: Borodin Vladimir <v.a.borodin@gmail.com>
Subject: Re: OSD suicide
Date: Wed, 4 Apr 2012 22:26:10 +0400
Message-ID: <CAGEBRh2hx6zSU3pfM+vmmoiE4iH7r7tD_aeFEhnic=gobfrsEQ@mail.gmail.com>
References: <CAGEBRh0Yr6EoOafQF6PYhDe8TZNwUcc6ZeJW7KhXBSf-VU0J9w@mail.gmail.com>
	<4F79BDF9.7040101@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58847 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932261Ab2DDS0L convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Apr 2012 14:26:11 -0400
Received: by iagz16 with SMTP id z16so638063iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 04 Apr 2012 11:26:11 -0700 (PDT)
In-Reply-To: <4F79BDF9.7040101@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: ceph-devel@vger.kernel.org

Hello Wido,

Yesterday I built from git: $ ceph -v
ceph version 0.44.1-149-ge80126e
(commit:e80126ea689e9a972fbf09e8848fc4a2ade13c59)

The messages are a bit different but the problem seems to be the same.
Below is a part of the osd.48.log. Should I turn debug osd mode more
verbose or give any other information?

Regards,
Vladimir.

2012-04-04 22:17:35.854156 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:15.854125)
2012-04-04 22:17:35.854194 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20588.898191 seconds old
2012-04-04 22:17:36.854360 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:16.854343)
2012-04-04 22:17:36.854405 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20589.898402 seconds old
2012-04-04 22:17:37.027882 7fd55e6f3700 -- 84.201.161.48:0/22705
send_message dropped message osd_ping(ping e1910 stamp 2012-04-04
22:17:37.027859) v2 because of no pipe on con 0x391d89b0
2012-04-04 22:17:37.027908 7fd55e6f3700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:17.027899)
2012-04-04 22:17:37.854569 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:17.854552)
2012-04-04 22:17:37.854593 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20590.898589 seconds old
2012-04-04 22:17:38.854768 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:18.854750)
2012-04-04 22:17:38.854795 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20591.898792 seconds old
2012-04-04 22:17:39.854960 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:19.854943)
2012-04-04 22:17:39.854986 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20592.898982 seconds old
2012-04-04 22:17:39.928092 7fd55e6f3700 -- 84.201.161.48:0/22705
send_message dropped message osd_ping(ping e1910 stamp 2012-04-04
22:17:39.928071) v2 because of no pipe on con 0x391d89b0
2012-04-04 22:17:39.928117 7fd55e6f3700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:19.928107)
2012-04-04 22:17:40.087719 7fd57a531700 heartbeat_map is_healthy
'OSD::disk_tp thread 0x7fd55f6f5700' had timed out after 60
2012-04-04 22:17:40.855154 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:20.855137)
2012-04-04 22:17:40.855178 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20593.899174 seconds old
2012-04-04 22:17:41.855368 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:21.855350)
2012-04-04 22:17:41.855409 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20594.899406 seconds old
2012-04-04 22:17:42.855579 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:22.855562)
2012-04-04 22:17:42.855605 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20595.899601 seconds old
2012-04-04 22:17:43.855768 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:23.855751)
2012-04-04 22:17:43.855793 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20596.899789 seconds old
2012-04-04 22:17:44.628337 7fd55e6f3700 -- 84.201.161.48:0/22705
send_message dropped message osd_ping(ping e1910 stamp 2012-04-04
22:17:44.628298) v2 because of no pipe on con 0x391d89b0
2012-04-04 22:17:44.628373 7fd55e6f3700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:24.628363)
2012-04-04 22:17:44.855969 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:24.855953)
2012-04-04 22:17:44.856001 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20597.899997 seconds old
2012-04-04 22:17:45.087874 7fd57a531700 heartbeat_map is_healthy
'OSD::disk_tp thread 0x7fd55f6f5700' had timed out after 60
2012-04-04 22:17:45.856191 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:25.856162)
2012-04-04 22:17:45.856230 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20598.900227 seconds old
2012-04-04 22:17:46.856388 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:26.856371)
2012-04-04 22:17:46.856432 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20599.900428 seconds old
2012-04-04 22:17:47.856603 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:27.856586)
2012-04-04 22:17:47.856628 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20600.900625 seconds old
2012-04-04 22:17:48.128570 7fd55e6f3700 -- 84.201.161.48:0/22705
send_message dropped message osd_ping(ping e1910 stamp 2012-04-04
22:17:48.128545) v2 because of no pipe on con 0x391d89b0
2012-04-04 22:17:48.128595 7fd55e6f3700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:28.128587)
2012-04-04 22:17:48.856819 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:28.856791)
2012-04-04 22:17:48.856858 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20601.900854 seconds old
2012-04-04 22:17:49.857044 7fd575527700 osd.48 1910 heartbeat_check:
no reply from osd.49 since 2012-04-04 19:33:38.761585 (cutoff
2012-04-04 22:17:29.857019)
2012-04-04 22:17:49.857080 7fd575527700 --OSD::tracker--
ops_in_flight.size: 9; oldest is 20602.901076 seconds old
2012-04-04 22:17:50.088035 7fd57a531700 heartbeat_map is_healthy
'OSD::disk_tp thread 0x7fd55f6f5700' had timed out after 60

2012/4/2 Wido den Hollander <wido@widodh.nl>:
> Hi,
>
>
> On 04/02/2012 04:01 PM, =E2=CF=D2=CF=C4=C9=CE =F7=CC=C1=C4=C9=CD=C9=D2=
 wrote:
>>
>> Hi all.
>>
>> I have a cluster with 4 OSDs (mdRAID10 on each of them with XFS) and=
 I
>> am trying to put into RADOS (through python API) 20 million objects =
20
>> KB each. I have two problems:
>> 1. the speed is not as good as I expect (but that's not the main pro=
blem
>> now),
>> 2. after I put 10 million objects, OSDs started to mark itself down
>> and out. The logs give something like that:
>>
>> 2012-04-02 17:05:17.894395 7f2d2a213700 heartbeat_map is_healthy
>> 'OSD::op_tp thread 0x7f2d1d0f8700' had timed out after 30
>> 2012-04-02 17:05:18.877781 7f2d1a8f3700 osd.47 1673 heartbeat_check:
>> no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
>> 2012-04-02 17:04:58.87
>> 7752)
>> 2012-04-02 17:05:19.578112 7f2d1a8f3700 osd.47 1673 heartbeat_check:
>> no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
>> 2012-04-02 17:04:59.57
>> 8079)
>> 2012-04-02 17:05:20.678455 7f2d1a8f3700 osd.47 1673 heartbeat_check:
>> no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
>> 2012-04-02 17:05:00.67
>> 8421)
>> 2012-04-02 17:05:21.678785 7f2d1a8f3700 osd.47 1673 heartbeat_check:
>> no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
>> 2012-04-02 17:05:01.67
>> 8751)
>> 2012-04-02 17:05:22.579101 7f2d1a8f3700 osd.47 1673 heartbeat_check:
>> no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
>> 2012-04-02 17:05:02.57
>> 9069)
>> 2012-04-02 17:05:22.894568 7f2d2a213700 heartbeat_map is_healthy
>> 'OSD::op_tp thread 0x7f2d1d0f8700' had timed out after 30
>> 2012-04-02 17:05:22.894601 7f2d2a213700 heartbeat_map is_healthy
>> 'OSD::op_tp thread 0x7f2d1d0f8700' had suicide timed out after 300
>> common/HeartbeatMap.cc: In function 'bool
>> ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*,
>> time_t)' thread 7f2d2a213700 time 2012-04-02 17:
>> 05:22.894637
>> common/HeartbeatMap.cc: 78: FAILED assert(0 =3D=3D "hit suicide time=
out")
>> =9Aceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199=
dee)
>> =9A1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
>> const*, long)+0x1fe) [0x7634ee]
>> =9A2: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x76381f]
>> =9A3: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x763a50]
>> =9A4: (CephContextServiceThread::entry()+0x5f) [0x65a31f]
>> =9A5: (()+0x69ca) [0x7f2d2beab9ca]
>> =9A6: (clone()+0x6d) [0x7f2d2a4fccdd]
>> =9Aceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199=
dee)
>> =9A1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
>> const*, long)+0x1fe) [0x7634ee]
>> =9A2: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x76381f]
>> =9A3: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x763a50]
>> =9A4: (CephContextServiceThread::entry()+0x5f) [0x65a31f]
>> =9A5: (()+0x69ca) [0x7f2d2beab9ca]
>> =9A6: (clone()+0x6d) [0x7f2d2a4fccdd]
>> *** Caught signal (Aborted) **
>> =9Ain thread 7f2d2a213700
>> =9Aceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199=
dee)
>> =9A1: /usr/bin/ceph-osd() [0x661cb1]
>> =9A2: (()+0xf8f0) [0x7f2d2beb48f0]
>> =9A3: (gsignal()+0x35) [0x7f2d2a449a75]
>> =9A4: (abort()+0x180) [0x7f2d2a44d5c0]
>> =9A5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f2d2acec5=
8d]
>> =9A6: (()+0xb7736) [0x7f2d2acea736]
>> =9A7: (()+0xb7763) [0x7f2d2acea763]
>> =9A8: (()+0xb785e) [0x7f2d2acea85e]
>> =9A9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
>> const*)+0x841) [0x667541]
>> =9A10: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
>> const*, long)+0x1fe) [0x7634ee]
>> =9A11: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x76381f]
>> =9A12: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x763a50]
>> =9A13: (CephContextServiceThread::entry()+0x5f) [0x65a31f]
>> =9A14: (()+0x69ca) [0x7f2d2beab9ca]
>> =9A15: (clone()+0x6d) [0x7f2d2a4fccdd]
>>
>> Or something like that:
>
>
> I reported this one a couple of days ago:
> http://tracker.newdream.net/issues/2219
>
>
>>
>> ...
>> 2012-04-02 17:01:38.673223 7f7855486700 heartbeat_map is_healthy
>> 'OSD::op_tp thread 0x7f7847369700' had timed out after 30
>> 2012-04-02 17:01:38.673267 7f7855486700 heartbeat_map is_healthy
>> 'OSD::op_tp thread 0x7f7847b6a700' had timed out after 30
>> 2012-04-02 17:01:38.833509 7f7847369700 heartbeat_map reset_timeout
>> 'OSD::op_tp thread 0x7f7847369700' had timed out after 30
>> 2012-04-02 17:01:39.031229 7f7847b6a700 heartbeat_map reset_timeout
>> 'OSD::op_tp thread 0x7f7847b6a700' had timed out after 30
>> 2012-04-02 17:02:06.971487 7f784324b700 -- 84.201.161.48:6803/17442>=
>
>> 84.201.161.49:6802/15581 pipe(0x47197280 sd=3D50 pgs=3D0 cs=3D0 l=3D=
0).accept
>> we reset (peer sent cseq 2), sending RESETSESSION
>> 2012-04-02 17:02:49.321812 7f784324b700 -- 84.201.161.48:6803/17442>=
>
>> 84.201.161.49:6802/15581 pipe(0x47197280 sd=3D50 pgs=3D53 cs=3D1 l=3D=
0).fault
>> with nothing to send, going to standby
>> 2012-04-02 17:03:11.677528 7f784a470700 osd.48 1675 from dead osd.49=
,
>> dropping, sharing map
>> 2012-04-02 17:05:26.355673 7f784344d700 -- 84.201.161.48:0/17442>>
>> 84.201.161.47:6802/17587 pipe(0x1bb4280 sd=3D375 pgs=3D783 cs=3D1 l=3D=
0).fault
>> with nothing to send, going to standby
>> 2012-04-02 17:05:26.355767 7f7844059700 -- 84.201.161.48:6804/17442>=
>
>> 84.201.161.47:0/17587 pipe(0x4ba5c500 sd=3D201 pgs=3D17 cs=3D1 l=3D0=
).fault
>> initiating reconnect
>> 2012-04-02 17:05:26.355936 7f7843b54700 -- 84.201.161.48:6803/17442>=
>
>> 84.201.161.47:6801/17587 pipe(0x3ad97780 sd=3D36 pgs=3D138 cs=3D1 l=3D=
0).fault
>> with nothing to send, going to standby
>> 2012-04-02 17:18:43.624220 7f7843049700 -- 84.201.161.48:6803/17442>=
>
>> 84.201.161.49:6804/15581 pipe(0x47197a00 sd=3D37 pgs=3D55 cs=3D1 l=3D=
0).fault
>> with nothing to send, going to standby
>> 2012-04-02 17:18:43.974073 7f784445d700 -- 84.201.161.48:6804/17442>=
>
>> 84.201.161.49:0/15581 pipe(0x4be36000 sd=3D38 pgs=3D15 cs=3D1 l=3D0)=
=2Efault
>> with nothing to send, going to standby
>> 2012-04-02 17:18:47.556758 7f7842c45700 -- 84.201.161.48:6803/17442>=
>
>> 84.201.161.50:6802/7906 pipe(0x47197c80 sd=3D41 pgs=3D178 cs=3D1 l=3D=
0).fault
>> with nothing to send, going to standby
>> 2012-04-02 17:18:47.775391 7f7844760700 -- 84.201.161.48:6804/17442>=
>
>> 84.201.161.50:0/7906 pipe(0x46f10280 sd=3D42 pgs=3D31 cs=3D1 l=3D0).=
fault
>> initiating reconnect
>> 2012-04-02 17:20:54.798971 7f784fc7b700 osd.48 1678 heartbeat_check:
>> no heartbeat from osd.47 since 2012-04-02 17:05:22.574731 (cutoff
>> 2012-04-02 17:20:34.798943)
>> ...
>> 2012-04-02 17:20:56.846736 7f784fc7b700 osd.48 1678 heartbeat_check:
>> no heartbeat from osd.47 since 2012-04-02 17:05:22.574731 (cutoff
>> 2012-04-02 17:20:36.846704)
>> 2012-04-02 17:21:15.408175 7f7842b44700 -- 84.201.161.48:6803/17442>=
>
>> 84.201.161.49:6804/15581 pipe(0x47197a00 sd=3D50 pgs=3D55 cs=3D2
>> l=3D0).connect got RESETSESSION
>> 2012-04-02 17:22:11.678030 7f784fc7b700 osd.48 1680 heartbeat_check:
>> no heartbeat from osd.47 since 2012-04-02 17:05:22.574731 (cutoff
>> 2012-04-02 17:21:51.678001)
>> ...
>> 2012-04-02 17:22:26.012018 7f7844b64700 -- 84.201.161.48:6803/17442>=
>
>> 84.201.161.50:6802/7906 pipe(0x47197c80 sd=3D39 pgs=3D178 cs=3D2
>> l=3D0).connect got RESETSESSION
>> 2012-04-02 17:22:26.064256 7f7842d46700 -- 84.201.161.48:6803/17442>=
>
>> 84.201.161.49:6804/15581 pipe(0x47197a00 sd=3D50 pgs=3D64 cs=3D1 l=3D=
0).fault
>> initiating reconnect
>> 2012-04-02 17:22:26.065367 7f7842b44700 -- 84.201.161.48:6803/17442>=
>
>> 84.201.161.49:6804/15581 pipe(0x47197a00 sd=3D41 pgs=3D64 cs=3D2
>> l=3D0).connect got RESETSESSION
>> 2012-04-02 17:24:07.987587 7f784ac71700 log [WRN] : map e1706 wrongl=
y
>> marked me down or wrong addr
>>
>> In first case the OSD process terminates, it is marked out by the
>> cluster and re-replication is started. In second case the OSD resume=
s
>> over several time and then goes down again etc...
>>
>> It seems that the problem is that the OSDs don't send/receive
>> heartbeat-messages, but why? The network seems to be good and time i=
s
>> synchronized. The problem appeared only when I put a lot of objects
>> (and took more than a half of free space availible). I can give the
>> config file and any logs if needed.
>
>
> Last week new heartbeat code was merged into the master tree. The up/=
down
> going of OSDs was something I was seeing over the last months.
>
> Sage wrote some new code, it might be worth trying that.
>
> Since I'm running that code I haven't seen any suicides, so it could =
be
> related.
>
> It's this commit:
> https://github.com/ceph/ceph/commit/374bef9c97266600b4c6b83100485d725=
0363213
>
> Could you try to build from git?
>
> git clone https://github.com/ceph/ceph.git
> cd ceph
> git submodule init
> git submodule update
> dpkg-buildpackage (if you are using Debian).
>
> Wido
>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =9Ahttp://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
