From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Hit suicide timeout after adding new osd
Date: Thu, 24 Jan 2013 10:44:44 +0300
Message-ID: <CABYiri_LcsJxwd73gORHmzixUBQJRYh4zSCCMhb16O5-=akj_g@mail.gmail.com>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F81A9F.2090104@profihost.ag>
 <alpine.DEB.2.00.1301170916420.10574@cobra.newdream.net> <50F85FEC.7030305@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301171402130.21470@cobra.newdream.net> <50F930EE.9070201@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301181327580.8622@cobra.newdream.net> <50F9C051.7070900@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net> <50FA6681.10507@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net> <50FADE65.5050403@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net> <50FAE8AB.5000602@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301201613130.31658@cobra.newdream.net> <50FCE759.9070309@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301202310260.29915@cobra.newdream.net> <50FFD420.7000604@mermaidconsulting.dk>
 <51004F2A.2010009@mermaidconsulting.dk> <CABYiri8yXr2Q7-fQSnO1LjyZ34-MGNzkfTyty9MOAZ0C13639A@mail.gmail.com>
 <alpine.DEB.2.00.1301232037130.10201@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:39669 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161Ab3AXHpG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jan 2013 02:45:06 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so758762obc.34
        for <ceph-devel@vger.kernel.org>; Wed, 23 Jan 2013 23:45:04 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1301232037130.10201@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: =?UTF-8?Q?Jens_Kristian_S=C3=B8gaard?= <jens@mermaidconsulting.dk>, Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jan 24, 2013 at 8:39 AM, Sage Weil <sage@inktank.com> wrote:
> On Thu, 24 Jan 2013, Andrey Korolyov wrote:
>> On Thu, Jan 24, 2013 at 12:59 AM, Jens Kristian S?gaard
>> <jens@mermaidconsulting.dk> wrote:
>> > Hi Sage,
>> >
>> >>> I think the problem now is just that 'osd target transaction size' is
>> >>
>> >> I set it to 50, and that seems to have solved all my problems.
>> >>
>> >> After a day or so my cluster got to a HEALTH_OK state again. It has been
>> >> running for a few days now without any crashes!
>> >
>> >
>> > Hmm, one of the OSDs crashed again, sadly.
>> >
>> > It logs:
>> >
>> >    -2> 2013-01-23 18:01:23.563624 7f67524da700  1 heartbeat_map is_healthy
>> > 'FileStore::op_tp thread 0x7f673affd700' had timed out after 60
>> >     -1> 2013-01-23 18:01:23.563657 7f67524da700  1 heartbeat_map is_healthy
>> > 'FileStore::op_tp thread 0x7f673affd700' had suicide timed out after 180
>> >      0> 2013-01-23 18:01:24.257996 7f67524da700 -1 common/HeartbeatMap.cc:
>> > In function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*,
>> > const char*, time_t)' thread 7f67524da700 time 2013-01-23 18:01:23.563677
>> >
>> > common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")
>> >
>> >
>> > With this stack trace:
>> >
>> >  ceph version 0.56.1-26-g3bd8f6b (3bd8f6b7235eb14cab778e3c6dcdc636aff4f539)
>> >  1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*,
>> > long)+0x2eb) [0x846ecb]
>> >  2: (ceph::HeartbeatMap::is_healthy()+0x8e) [0x8476ae]
>> >  3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x8478d8]
>> >  4: (CephContextServiceThread::entry()+0x55) [0x8e0f45]
>> >  5: /lib64/libpthread.so.0() [0x3cbc807d14]
>> >  6: (clone()+0x6d) [0x3cbc0f167d]
>> >
>> >
>> > I have saved the core file, if there's anything in there you need?
>> >
>> > Or do you think I just need to set the target transaction size even lower
>> > than 50?
>> >
>> >
>>
>> I was able to catch this too on rejoin to very busy cluster and seems
>> I need to lower this value at least at start time. Also
>> c5fe0965572c074a2a33660719ce3222d18c1464 has increased overall time
>> before restarted or new osd will join a cluster, and for 2M objects/3T
>> of replicated data restart of the cluster was took almost a hour
>> before it actually begins to work. The worst thing is that a single
>> osd, if restarted, will mark as up after couple of minutes, then after
>> almost half of hour(eating 100 percent of one cpu, ) as down and then
>> cluster will start to redistribute data after 300s timeout, osd still
>> doing something.
>
> Okay, something is very wrong.  Can you reproduce this with a log?  Or
> even a partial log while it is spinning?  You can adjust the log level on
> a running process with
>
>   ceph --admin-daemon /var/run/ceph-osd.NN.asok config set debug_osd 20
>   ceph --admin-daemon /var/run/ceph-osd.NN.asok config set debug_ms 1
>
> We haven't been able to reproduce this, so I'm very much interested in any
> light you can shine here.
>

Unfortunately cluster finally hit ``suicide timeout'' by every osd, so
there was no logs, only some backtraces[1].
Yesterday after an osd was not able to join cluster in a hour, I
decided to wait until data is remapped, then tried to restart cluster,
leaving it overnight, to morning all osd processes are dead, with the
same backtraces. Before it, after a silly node crash(related to
deadlocks in kernel kvm code), some pgs remains to stay in peering
state without any blocker in json output, so I had decided to restart
osd to which primary copy belongs, because it helped before. So most
interesting part is missing, but I`ll reformat cluster soon and will
try to catch this again after filling some data in.

[1]. http://xdel.ru/downloads/ceph-log/osd-heartbeat/

> Thanks!
> sage
>
>
