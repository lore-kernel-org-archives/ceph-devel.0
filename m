From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Wed, 23 Jan 2013 20:28:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301232028170.10201@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F80FA0.5010504@profihost.ag> <50F819B8.4070004@widodh.nl> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net>
 <50FA6681.10507@mermaidconsulting.dk> <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net> <50FADE65.5050403@mermaidconsulting.dk> <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net> <50FAE8AB.5000602@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301201613130.31658@cobra.newdream.net> <50FCE759.9070309@mermaidconsulting.dk> <alpine.DEB.2.00.1301202310260.29915@cobra.newdream.net> <50FFD420.7000604@mermaidconsulting.dk> <51004F2A.2010009@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59289 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884Ab3AXE2l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 23:28:41 -0500
In-Reply-To: <51004F2A.2010009@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, 23 Jan 2013, Jens Kristian S?gaard wrote:
> Hi Sage,
> 
> > > I think the problem now is just that 'osd target transaction size' is
> > I set it to 50, and that seems to have solved all my problems.
> > After a day or so my cluster got to a HEALTH_OK state again. It has been
> > running for a few days now without any crashes!
> 
> Hmm, one of the OSDs crashed again, sadly.
> 
> It logs:
> 
>    -2> 2013-01-23 18:01:23.563624 7f67524da700  1 heartbeat_map is_healthy
> 'FileStore::op_tp thread 0x7f673affd700' had timed out after 60
>     -1> 2013-01-23 18:01:23.563657 7f67524da700  1 heartbeat_map is_healthy
> 'FileStore::op_tp thread 0x7f673affd700' had suicide timed out after 180
>      0> 2013-01-23 18:01:24.257996 7f67524da700 -1 common/HeartbeatMap.cc: In
> function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const
> char*, time_t)' thread 7f67524da700 time 2013-01-23 18:01:23.563677
> common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")
> 
> 
> With this stack trace:
> 
>  ceph version 0.56.1-26-g3bd8f6b (3bd8f6b7235eb14cab778e3c6dcdc636aff4f539)
>  1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*,
> long)+0x2eb) [0x846ecb]
>  2: (ceph::HeartbeatMap::is_healthy()+0x8e) [0x8476ae]
>  3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x8478d8]
>  4: (CephContextServiceThread::entry()+0x55) [0x8e0f45]
>  5: /lib64/libpthread.so.0() [0x3cbc807d14]
>  6: (clone()+0x6d) [0x3cbc0f167d]
> 
> 
> I have saved the core file, if there's anything in there you need?
> 
> Or do you think I just need to set the target transaction size even lower than
> 50?

Can you share the output from 'thread apply all bt' so we can see what it 
was doing?

thanks!
s
