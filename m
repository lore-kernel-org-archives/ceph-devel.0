From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Wed, 23 Jan 2013 20:39:49 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301232037130.10201@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F81A9F.2090104@profihost.ag> <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk> <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net>
 <50F930EE.9070201@mermaidconsulting.dk> <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net> <50FA6681.10507@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net> <50FADE65.5050403@mermaidconsulting.dk> <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net> <50FAE8AB.5000602@mermaidconsulting.dk> <alpine.DEB.2.00.1301201613130.31658@cobra.newdream.net>
 <50FCE759.9070309@mermaidconsulting.dk> <alpine.DEB.2.00.1301202310260.29915@cobra.newdream.net> <50FFD420.7000604@mermaidconsulting.dk> <51004F2A.2010009@mermaidconsulting.dk> <CABYiri8yXr2Q7-fQSnO1LjyZ34-MGNzkfTyty9MOAZ0C13639A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59359 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab3AXEjt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Jan 2013 23:39:49 -0500
In-Reply-To: <CABYiri8yXr2Q7-fQSnO1LjyZ34-MGNzkfTyty9MOAZ0C13639A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 24 Jan 2013, Andrey Korolyov wrote:
> On Thu, Jan 24, 2013 at 12:59 AM, Jens Kristian S?gaard
> <jens@mermaidconsulting.dk> wrote:
> > Hi Sage,
> >
> >>> I think the problem now is just that 'osd target transaction size' is
> >>
> >> I set it to 50, and that seems to have solved all my problems.
> >>
> >> After a day or so my cluster got to a HEALTH_OK state again. It has been
> >> running for a few days now without any crashes!
> >
> >
> > Hmm, one of the OSDs crashed again, sadly.
> >
> > It logs:
> >
> >    -2> 2013-01-23 18:01:23.563624 7f67524da700  1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f673affd700' had timed out after 60
> >     -1> 2013-01-23 18:01:23.563657 7f67524da700  1 heartbeat_map is_healthy
> > 'FileStore::op_tp thread 0x7f673affd700' had suicide timed out after 180
> >      0> 2013-01-23 18:01:24.257996 7f67524da700 -1 common/HeartbeatMap.cc:
> > In function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*,
> > const char*, time_t)' thread 7f67524da700 time 2013-01-23 18:01:23.563677
> >
> > common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")
> >
> >
> > With this stack trace:
> >
> >  ceph version 0.56.1-26-g3bd8f6b (3bd8f6b7235eb14cab778e3c6dcdc636aff4f539)
> >  1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*,
> > long)+0x2eb) [0x846ecb]
> >  2: (ceph::HeartbeatMap::is_healthy()+0x8e) [0x8476ae]
> >  3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x8478d8]
> >  4: (CephContextServiceThread::entry()+0x55) [0x8e0f45]
> >  5: /lib64/libpthread.so.0() [0x3cbc807d14]
> >  6: (clone()+0x6d) [0x3cbc0f167d]
> >
> >
> > I have saved the core file, if there's anything in there you need?
> >
> > Or do you think I just need to set the target transaction size even lower
> > than 50?
> >
> >
> 
> I was able to catch this too on rejoin to very busy cluster and seems
> I need to lower this value at least at start time. Also
> c5fe0965572c074a2a33660719ce3222d18c1464 has increased overall time
> before restarted or new osd will join a cluster, and for 2M objects/3T
> of replicated data restart of the cluster was took almost a hour
> before it actually begins to work. The worst thing is that a single
> osd, if restarted, will mark as up after couple of minutes, then after
> almost half of hour(eating 100 percent of one cpu, ) as down and then
> cluster will start to redistribute data after 300s timeout, osd still
> doing something.

Okay, something is very wrong.  Can you reproduce this with a log?  Or 
even a partial log while it is spinning?  You can adjust the log level on 
a running process with 

  ceph --admin-daemon /var/run/ceph-osd.NN.asok config set debug_osd 20
  ceph --admin-daemon /var/run/ceph-osd.NN.asok config set debug_ms 1

We haven't been able to reproduce this, so I'm very much interested in any 
light you can shine here.

Thanks!
sage


