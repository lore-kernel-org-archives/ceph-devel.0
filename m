From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Hit suicide timeout after adding new osd
Date: Thu, 17 Jan 2013 15:35:38 +0100
Message-ID: <50F80C3A.9020007@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.stofanet.dk ([212.10.10.12]:35371 "EHLO mx02.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756586Ab3AQOfl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 17 Jan 2013 09:35:41 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi guys,

I had a functioning Ceph system that reported HEALTH_OK. It was running=
=20
with 3 osds on 3 servers.

Then I added an extra osd on 1 of the servers using the commands from=20
the documentation here:

http://ceph.com/docs/master/rados/operations/add-or-rm-osds/

Shortly after I did that 2 of the existing osds crashed.

I restarted them and after some hours they were up and running again,=20
but soon one of them crashed again - and a third existing osd crashed a=
s=20
well. I restarted those two and waited some hours for them to come up. =
A=20
short while later one of them crashed again.

I have then restarted restarted that last one and watched the logs=20
closely. It seems the same patterns repeats itself every time. It start=
s=20
up doing its normal maintenance before going "up" (takes a long while).=
=20
Then it seems to be running, but logs the following every 5 seconds:

heartbeat_map is_healthy 'OSD::op_tp thread 0x7f051b7f6700' had timed=20
out after 30

After some time it logs:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
heartbeat_map is_healthy 'OSD::op_tp thread 0x7f051b7f6700' had suicide=
=20
timed out after 300

2013-01-17 15:24:35.051524 7f053f149700 -1 common/HeartbeatMap.cc: In=20
function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*,=20
const char*, time_t)' thread 7f053f149700 time 2013-01-17 15:24:33.8496=
54
common/HeartbeatMap.cc: 78: FAILED assert(0 =3D=3D "hit suicide timeout=
")

  ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
  1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*=
,=20
long)+0x2eb) [0x8462bb]
  2: (ceph::HeartbeatMap::is_healthy()+0x8e) [0x846a9e]
  3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x846cc8]
  4: (CephContextServiceThread::entry()+0x55) [0x8e01c5]
  5: /lib64/libpthread.so.0() [0x360de07d14]
  6: (clone()+0x6d) [0x360d6f167d]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
needed to interpret this.

2013-01-17 15:24:35.301183 7f053f149700 -1 *** Caught signal (Aborted) =
**
  in thread 7f053f149700

  ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
  1: /usr/bin/ceph-osd() [0x82ea90]
  2: /lib64/libpthread.so.0() [0x360de0efe0]
  3: (gsignal()+0x35) [0x360d635925]
  4: (abort()+0x148) [0x360d6370d8]
  5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x3611660dad]
  NOTE: a copy of the executable, or `objdump -rdS <executable>` is=20
needed to interpret this.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

How can I avoid this? - is it a bug, or have I done something wrong?

I'm running Ceph 0.56.1 from the official RPMs on Fedora 17.
The underlying disks and network connectivity has been tested and=20
nothing seems to be wrong there.

Thanks in advance for your assistance!
--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
