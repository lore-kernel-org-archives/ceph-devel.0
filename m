From: =?ISO-8859-1?Q?Jens_Kristian_S=F8gaard?=
	<jens@mermaidconsulting.dk>
Subject: Re: Hit suicide timeout after adding new osd
Date: Wed, 23 Jan 2013 21:59:22 +0100
Message-ID: <51004F2A.2010009@mermaidconsulting.dk>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80EFF.7020803@widodh.nl> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk> <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net> <50FA6681.10507@mermaidconsulting.dk> <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net> <50FADE65.5050403@mermaidconsulting.dk> <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net> <50FAE8AB.5000602@mermaidconsulting.dk> <alpine.DEB.2.00.1301201613130.31658@cobra.newdr
 eam.net> <50FCE759.9070309@mermaidconsulting.dk> <alpine.DEB.2.00.1301202310260.29915@cobra.newdream.net> <50FFD420.7000604@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx02.stofanet.dk ([212.10.10.12]:35636 "EHLO mx02.stofanet.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751490Ab3AWU72 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 23 Jan 2013 15:59:28 -0500
In-Reply-To: <50FFD420.7000604@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

>> I think the problem now is just that 'osd target transaction size' i=
s
> I set it to 50, and that seems to have solved all my problems.
> After a day or so my cluster got to a HEALTH_OK state again. It has b=
een
> running for a few days now without any crashes!

Hmm, one of the OSDs crashed again, sadly.

It logs:

    -2> 2013-01-23 18:01:23.563624 7f67524da700  1 heartbeat_map=20
is_healthy 'FileStore::op_tp thread 0x7f673affd700' had timed out after=
 60
     -1> 2013-01-23 18:01:23.563657 7f67524da700  1 heartbeat_map=20
is_healthy 'FileStore::op_tp thread 0x7f673affd700' had suicide timed=20
out after 180
      0> 2013-01-23 18:01:24.257996 7f67524da700 -1=20
common/HeartbeatMap.cc: In function 'bool=20
ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*,=20
time_t)' thread 7f67524da700 time 2013-01-23 18:01:23.563677
common/HeartbeatMap.cc: 78: FAILED assert(0 =3D=3D "hit suicide timeout=
")


With this stack trace:

  ceph version 0.56.1-26-g3bd8f6b (3bd8f6b7235eb14cab778e3c6dcdc636aff4=
f539)
  1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*=
,=20
long)+0x2eb) [0x846ecb]
  2: (ceph::HeartbeatMap::is_healthy()+0x8e) [0x8476ae]
  3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x8478d8]
  4: (CephContextServiceThread::entry()+0x55) [0x8e0f45]
  5: /lib64/libpthread.so.0() [0x3cbc807d14]
  6: (clone()+0x6d) [0x3cbc0f167d]


I have saved the core file, if there's anything in there you need?

Or do you think I just need to set the target transaction size even=20
lower than 50?

--=20
Jens Kristian S=F8gaard, Mermaid Consulting ApS,
jens@mermaidconsulting.dk,
http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
