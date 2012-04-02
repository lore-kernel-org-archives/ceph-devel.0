From: Stefan Kleijkers <stefan@unilogicnetworks.net>
Subject: Re: OSD suicide
Date: Mon, 02 Apr 2012 22:14:21 +0200
Message-ID: <4F7A089D.8040904@unilogicnetworks.net>
References: <CAGEBRh0Yr6EoOafQF6PYhDe8TZNwUcc6ZeJW7KhXBSf-VU0J9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-out117.unilogicnetworks.net ([62.133.206.117]:49804 "EHLO
	mail.unilogicnetworks.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751887Ab2DBUdk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Apr 2012 16:33:40 -0400
In-Reply-To: <CAGEBRh0Yr6EoOafQF6PYhDe8TZNwUcc6ZeJW7KhXBSf-VU0J9w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?0JHQvtGA0L7QtNC40L0g0JLQu9Cw0LTQuNC80LjRgA==?= <volk@xakep.ru>
Cc: ceph-devel@vger.kernel.org

Hello,

A while back I had the same errors you are seeing. I had these problems=
=20
only when using mdraid. After doing IO for some time the IO stalled and=
=20
in most cases if you look at the cepg-osd daemon it's in D mode (waitin=
g=20
for IO). Also if you look with top you notice a very high load and IO w=
ait.

I didn't find out what the exact reason was, but I stopped using mdraid=
=20
and use a setup with an OSD per disk and the disks formatted with XFS.=20
This gave me the best stability and performance.

Stefan

On 04/02/2012 04:01 PM, =D0=91=D0=BE=D1=80=D0=BE=D0=B4=D0=B8=D0=BD =D0=92=
=D0=BB=D0=B0=D0=B4=D0=B8=D0=BC=D0=B8=D1=80 wrote:
> Hi all.
>
> I have a cluster with 4 OSDs (mdRAID10 on each of them with XFS) and =
I
> am trying to put into RADOS (through python API) 20 million objects 2=
0
> KB each. I have two problems:
> 1. the speed is not as good as I expect (but that's not the main prob=
lem now),
> 2. after I put 10 million objects, OSDs started to mark itself down
> and out. The logs give something like that:
>
> 2012-04-02 17:05:17.894395 7f2d2a213700 heartbeat_map is_healthy
> 'OSD::op_tp thread 0x7f2d1d0f8700' had timed out after 30
> 2012-04-02 17:05:18.877781 7f2d1a8f3700 osd.47 1673 heartbeat_check:
> no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
> 2012-04-02 17:04:58.87
> 7752)
> 2012-04-02 17:05:19.578112 7f2d1a8f3700 osd.47 1673 heartbeat_check:
> no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
> 2012-04-02 17:04:59.57
> 8079)
> 2012-04-02 17:05:20.678455 7f2d1a8f3700 osd.47 1673 heartbeat_check:
> no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
> 2012-04-02 17:05:00.67
> 8421)
> 2012-04-02 17:05:21.678785 7f2d1a8f3700 osd.47 1673 heartbeat_check:
> no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
> 2012-04-02 17:05:01.67
> 8751)
> 2012-04-02 17:05:22.579101 7f2d1a8f3700 osd.47 1673 heartbeat_check:
> no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
> 2012-04-02 17:05:02.57
> 9069)
> 2012-04-02 17:05:22.894568 7f2d2a213700 heartbeat_map is_healthy
> 'OSD::op_tp thread 0x7f2d1d0f8700' had timed out after 30
> 2012-04-02 17:05:22.894601 7f2d2a213700 heartbeat_map is_healthy
> 'OSD::op_tp thread 0x7f2d1d0f8700' had suicide timed out after 300
> common/HeartbeatMap.cc: In function 'bool
> ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*,
> time_t)' thread 7f2d2a213700 time 2012-04-02 17:
> 05:22.894637
> common/HeartbeatMap.cc: 78: FAILED assert(0 =3D=3D "hit suicide timeo=
ut")
>   ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199de=
e)
>   1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> const*, long)+0x1fe) [0x7634ee]
>   2: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x76381f]
>   3: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x763a50]
>   4: (CephContextServiceThread::entry()+0x5f) [0x65a31f]
>   5: (()+0x69ca) [0x7f2d2beab9ca]
>   6: (clone()+0x6d) [0x7f2d2a4fccdd]
>   ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199de=
e)
>   1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> const*, long)+0x1fe) [0x7634ee]
>   2: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x76381f]
>   3: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x763a50]
>   4: (CephContextServiceThread::entry()+0x5f) [0x65a31f]
>   5: (()+0x69ca) [0x7f2d2beab9ca]
>   6: (clone()+0x6d) [0x7f2d2a4fccdd]
> *** Caught signal (Aborted) **
>   in thread 7f2d2a213700
>   ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199de=
e)
>   1: /usr/bin/ceph-osd() [0x661cb1]
>   2: (()+0xf8f0) [0x7f2d2beb48f0]
>   3: (gsignal()+0x35) [0x7f2d2a449a75]
>   4: (abort()+0x180) [0x7f2d2a44d5c0]
>   5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f2d2acec58d=
]
>   6: (()+0xb7736) [0x7f2d2acea736]
>   7: (()+0xb7763) [0x7f2d2acea763]
>   8: (()+0xb785e) [0x7f2d2acea85e]
>   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> const*)+0x841) [0x667541]
>   10: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> const*, long)+0x1fe) [0x7634ee]
>   11: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x76381f]
>   12: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x763a50]
>   13: (CephContextServiceThread::entry()+0x5f) [0x65a31f]
>   14: (()+0x69ca) [0x7f2d2beab9ca]
>   15: (clone()+0x6d) [0x7f2d2a4fccdd]
>
> Or something like that:
>
> ...
> 2012-04-02 17:01:38.673223 7f7855486700 heartbeat_map is_healthy
> 'OSD::op_tp thread 0x7f7847369700' had timed out after 30
> 2012-04-02 17:01:38.673267 7f7855486700 heartbeat_map is_healthy
> 'OSD::op_tp thread 0x7f7847b6a700' had timed out after 30
> 2012-04-02 17:01:38.833509 7f7847369700 heartbeat_map reset_timeout
> 'OSD::op_tp thread 0x7f7847369700' had timed out after 30
> 2012-04-02 17:01:39.031229 7f7847b6a700 heartbeat_map reset_timeout
> 'OSD::op_tp thread 0x7f7847b6a700' had timed out after 30
> 2012-04-02 17:02:06.971487 7f784324b700 -- 84.201.161.48:6803/17442>>
> 84.201.161.49:6802/15581 pipe(0x47197280 sd=3D50 pgs=3D0 cs=3D0 l=3D0=
).accept
> we reset (peer sent cseq 2), sending RESETSESSION
> 2012-04-02 17:02:49.321812 7f784324b700 -- 84.201.161.48:6803/17442>>
> 84.201.161.49:6802/15581 pipe(0x47197280 sd=3D50 pgs=3D53 cs=3D1 l=3D=
0).fault
> with nothing to send, going to standby
> 2012-04-02 17:03:11.677528 7f784a470700 osd.48 1675 from dead osd.49,
> dropping, sharing map
> 2012-04-02 17:05:26.355673 7f784344d700 -- 84.201.161.48:0/17442>>
> 84.201.161.47:6802/17587 pipe(0x1bb4280 sd=3D375 pgs=3D783 cs=3D1 l=3D=
0).fault
> with nothing to send, going to standby
> 2012-04-02 17:05:26.355767 7f7844059700 -- 84.201.161.48:6804/17442>>
> 84.201.161.47:0/17587 pipe(0x4ba5c500 sd=3D201 pgs=3D17 cs=3D1 l=3D0)=
=2Efault
> initiating reconnect
> 2012-04-02 17:05:26.355936 7f7843b54700 -- 84.201.161.48:6803/17442>>
> 84.201.161.47:6801/17587 pipe(0x3ad97780 sd=3D36 pgs=3D138 cs=3D1 l=3D=
0).fault
> with nothing to send, going to standby
> 2012-04-02 17:18:43.624220 7f7843049700 -- 84.201.161.48:6803/17442>>
> 84.201.161.49:6804/15581 pipe(0x47197a00 sd=3D37 pgs=3D55 cs=3D1 l=3D=
0).fault
> with nothing to send, going to standby
> 2012-04-02 17:18:43.974073 7f784445d700 -- 84.201.161.48:6804/17442>>
> 84.201.161.49:0/15581 pipe(0x4be36000 sd=3D38 pgs=3D15 cs=3D1 l=3D0).=
fault
> with nothing to send, going to standby
> 2012-04-02 17:18:47.556758 7f7842c45700 -- 84.201.161.48:6803/17442>>
> 84.201.161.50:6802/7906 pipe(0x47197c80 sd=3D41 pgs=3D178 cs=3D1 l=3D=
0).fault
> with nothing to send, going to standby
> 2012-04-02 17:18:47.775391 7f7844760700 -- 84.201.161.48:6804/17442>>
> 84.201.161.50:0/7906 pipe(0x46f10280 sd=3D42 pgs=3D31 cs=3D1 l=3D0).f=
ault
> initiating reconnect
> 2012-04-02 17:20:54.798971 7f784fc7b700 osd.48 1678 heartbeat_check:
> no heartbeat from osd.47 since 2012-04-02 17:05:22.574731 (cutoff
> 2012-04-02 17:20:34.798943)
> ...
> 2012-04-02 17:20:56.846736 7f784fc7b700 osd.48 1678 heartbeat_check:
> no heartbeat from osd.47 since 2012-04-02 17:05:22.574731 (cutoff
> 2012-04-02 17:20:36.846704)
> 2012-04-02 17:21:15.408175 7f7842b44700 -- 84.201.161.48:6803/17442>>
> 84.201.161.49:6804/15581 pipe(0x47197a00 sd=3D50 pgs=3D55 cs=3D2
> l=3D0).connect got RESETSESSION
> 2012-04-02 17:22:11.678030 7f784fc7b700 osd.48 1680 heartbeat_check:
> no heartbeat from osd.47 since 2012-04-02 17:05:22.574731 (cutoff
> 2012-04-02 17:21:51.678001)
> ...
> 2012-04-02 17:22:26.012018 7f7844b64700 -- 84.201.161.48:6803/17442>>
> 84.201.161.50:6802/7906 pipe(0x47197c80 sd=3D39 pgs=3D178 cs=3D2
> l=3D0).connect got RESETSESSION
> 2012-04-02 17:22:26.064256 7f7842d46700 -- 84.201.161.48:6803/17442>>
> 84.201.161.49:6804/15581 pipe(0x47197a00 sd=3D50 pgs=3D64 cs=3D1 l=3D=
0).fault
> initiating reconnect
> 2012-04-02 17:22:26.065367 7f7842b44700 -- 84.201.161.48:6803/17442>>
> 84.201.161.49:6804/15581 pipe(0x47197a00 sd=3D41 pgs=3D64 cs=3D2
> l=3D0).connect got RESETSESSION
> 2012-04-02 17:24:07.987587 7f784ac71700 log [WRN] : map e1706 wrongly
> marked me down or wrong addr
>
> In first case the OSD process terminates, it is marked out by the
> cluster and re-replication is started. In second case the OSD resumes
> over several time and then goes down again etc...
>
> It seems that the problem is that the OSDs don't send/receive
> heartbeat-messages, but why? The network seems to be good and time is
> synchronized. The problem appeared only when I put a lot of objects
> (and took more than a half of free space availible). I can give the
> config file and any logs if needed.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
