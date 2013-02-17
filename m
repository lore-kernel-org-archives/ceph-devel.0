From: Sage Weil <sage@inktank.com>
Subject: Re: Hit suicide timeout after adding new osd
Date: Sun, 17 Feb 2013 09:52:44 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1302170949490.25660@cobra.newdream.net>
References: <50F80C3A.9020007@mermaidconsulting.dk> <50F9C051.7070900@mermaidconsulting.dk> <alpine.DEB.2.00.1301181342410.8622@cobra.newdream.net> <50FA6681.10507@mermaidconsulting.dk> <alpine.DEB.2.00.1301190737110.29915@cobra.newdream.net>
 <50FADE65.5050403@mermaidconsulting.dk> <alpine.DEB.2.00.1301191016320.29915@cobra.newdream.net> <50FAE8AB.5000602@mermaidconsulting.dk> <alpine.DEB.2.00.1301201613130.31658@cobra.newdream.net> <50FCE759.9070309@mermaidconsulting.dk>
 <alpine.DEB.2.00.1301202310260.29915@cobra.newdream.net> <50FFD420.7000604@mermaidconsulting.dk> <51004F2A.2010009@mermaidconsulting.dk> <CABYiri8yXr2Q7-fQSnO1LjyZ34-MGNzkfTyty9MOAZ0C13639A@mail.gmail.com> <alpine.DEB.2.00.1301232037130.10201@cobra.newdream.net>
 <CABYiri_LcsJxwd73gORHmzixUBQJRYh4zSCCMhb16O5-=akj_g@mail.gmail.com> <alpine.DEB.2.00.1301241000020.13935@cobra.newdream.net> <CABYiri9T+obP1aruYMTktaftKyZi1-r6ocRH71575v5QOJ5h8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42065 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab3BQRwp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Feb 2013 12:52:45 -0500
In-Reply-To: <CABYiri9T+obP1aruYMTktaftKyZi1-r6ocRH71575v5QOJ5h8w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: =?ISO-8859-15?Q?Jens_Kristian_S=F8gaard?= <jens@mermaidconsulting.dk>, Stefan Priebe <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 17 Feb 2013, Andrey Korolyov wrote:
> On Thu, Jan 24, 2013 at 10:01 PM, Sage Weil <sage@inktank.com> wrote:
> > On Thu, 24 Jan 2013, Andrey Korolyov wrote:
> >> On Thu, Jan 24, 2013 at 8:39 AM, Sage Weil <sage@inktank.com> wrote:
> >> > On Thu, 24 Jan 2013, Andrey Korolyov wrote:
> >> >> On Thu, Jan 24, 2013 at 12:59 AM, Jens Kristian S?gaard
> >> >> <jens@mermaidconsulting.dk> wrote:
> >> >> > Hi Sage,
> >> >> >
> >> >> >>> I think the problem now is just that 'osd target transaction size' is
> >> >> >>
> >> >> >> I set it to 50, and that seems to have solved all my problems.
> >> >> >>
> >> >> >> After a day or so my cluster got to a HEALTH_OK state again. It has been
> >> >> >> running for a few days now without any crashes!
> >> >> >
> >> >> >
> >> >> > Hmm, one of the OSDs crashed again, sadly.
> >> >> >
> >> >> > It logs:
> >> >> >
> >> >> >    -2> 2013-01-23 18:01:23.563624 7f67524da700  1 heartbeat_map is_healthy
> >> >> > 'FileStore::op_tp thread 0x7f673affd700' had timed out after 60
> >> >> >     -1> 2013-01-23 18:01:23.563657 7f67524da700  1 heartbeat_map is_healthy
> >> >> > 'FileStore::op_tp thread 0x7f673affd700' had suicide timed out after 180
> >> >> >      0> 2013-01-23 18:01:24.257996 7f67524da700 -1 common/HeartbeatMap.cc:
> >> >> > In function 'bool ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*,
> >> >> > const char*, time_t)' thread 7f67524da700 time 2013-01-23 18:01:23.563677
> >> >> >
> >> >> > common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")
> >> >> >
> >> >> >
> >> >> > With this stack trace:
> >> >> >
> >> >> >  ceph version 0.56.1-26-g3bd8f6b (3bd8f6b7235eb14cab778e3c6dcdc636aff4f539)
> >> >> >  1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char const*,
> >> >> > long)+0x2eb) [0x846ecb]
> >> >> >  2: (ceph::HeartbeatMap::is_healthy()+0x8e) [0x8476ae]
> >> >> >  3: (ceph::HeartbeatMap::check_touch_file()+0x28) [0x8478d8]
> >> >> >  4: (CephContextServiceThread::entry()+0x55) [0x8e0f45]
> >> >> >  5: /lib64/libpthread.so.0() [0x3cbc807d14]
> >> >> >  6: (clone()+0x6d) [0x3cbc0f167d]
> >> >> >
> >> >> >
> >> >> > I have saved the core file, if there's anything in there you need?
> >> >> >
> >> >> > Or do you think I just need to set the target transaction size even lower
> >> >> > than 50?
> >> >> >
> >> >> >
> >> >>
> >> >> I was able to catch this too on rejoin to very busy cluster and seems
> >> >> I need to lower this value at least at start time. Also
> >> >> c5fe0965572c074a2a33660719ce3222d18c1464 has increased overall time
> >> >> before restarted or new osd will join a cluster, and for 2M objects/3T
> >> >> of replicated data restart of the cluster was took almost a hour
> >> >> before it actually begins to work. The worst thing is that a single
> >> >> osd, if restarted, will mark as up after couple of minutes, then after
> >> >> almost half of hour(eating 100 percent of one cpu, ) as down and then
> >> >> cluster will start to redistribute data after 300s timeout, osd still
> >> >> doing something.
> >> >
> >> > Okay, something is very wrong.  Can you reproduce this with a log?  Or
> >> > even a partial log while it is spinning?  You can adjust the log level on
> >> > a running process with
> >> >
> >> >   ceph --admin-daemon /var/run/ceph-osd.NN.asok config set debug_osd 20
> >> >   ceph --admin-daemon /var/run/ceph-osd.NN.asok config set debug_ms 1
> >> >
> >> > We haven't been able to reproduce this, so I'm very much interested in any
> >> > light you can shine here.
> >> >
> >>
> >> Unfortunately cluster finally hit ``suicide timeout'' by every osd, so
> >> there was no logs, only some backtraces[1].
> >> Yesterday after an osd was not able to join cluster in a hour, I
> >> decided to wait until data is remapped, then tried to restart cluster,
> >> leaving it overnight, to morning all osd processes are dead, with the
> >> same backtraces. Before it, after a silly node crash(related to
> >> deadlocks in kernel kvm code), some pgs remains to stay in peering
> >> state without any blocker in json output, so I had decided to restart
> >> osd to which primary copy belongs, because it helped before. So most
> >> interesting part is missing, but I`ll reformat cluster soon and will
> >> try to catch this again after filling some data in.
> >>
> >> [1]. http://xdel.ru/downloads/ceph-log/osd-heartbeat/
> >
> > Thanks, I believe I see the problem.  The peering workqueue is way behind,
> > and it is trying to it all in one lump, timing out the work queue.  The
> > workaround is to increase the timeout.  We'll put together a proper fix.
> >
> > sage
> 
> Hi Sage,
> 
> Single OSDs still not able to join a cluster after restart, osd
> process eats one core and reads disk by long continuous periods, about
> hundreds of seconds, then staying eating 100% of core, then repeat. On
> relatively new cluster, it is not repeatable even with almost same
> data commit, only week or two of writes, snapshot creation, etc.
> exposes that. Please see log below:

This sounds like the fixed code chewing through PGs with very old epochs 
due to the (now fixed) bug in .2.  Are there some pools that were 
completely idle on this cluster prior to the upgrade?  The problem before 
was that we weren't persisting the new osdmap epochs for those PGs if they 
never saw any IO, which means they have to do catch-up on restart.  They 
will come up eventually.

Alternatively, you can stop ceph-osd and manually delete those PG 
directories (i'm guessing its the data and metadata pools).  And/or, you 
can delete those pools from the cluster prior to the restart.

Sorry about this--I should have made a specific mention about this 
possibility in the .3 release notes.  I'll add something there today.

sage


> 
> 2013-02-17 12:08:17.503992 7fbe8795c780  0 ceph version
> 0.56.3-2-g290a352 (290a352c3f9e241deac562e980ac8c6a74033ba6), process
> ceph-osd, pid 29283
> starting osd.26 at :/0 osd_data /var/lib/ceph/osd/26
> /var/lib/ceph/osd/journal/journal26
> 2013-02-17 12:08:17.508193 7fbe8795c780  1 accepter.accepter.bind
> my_inst.addr is 0.0.0.0:6803/29283 need_addr=1
> 2013-02-17 12:08:17.508222 7fbe8795c780  1 accepter.accepter.bind
> my_inst.addr is 0.0.0.0:6804/29283 need_addr=1
> 2013-02-17 12:08:17.508244 7fbe8795c780  1 accepter.accepter.bind
> my_inst.addr is 0.0.0.0:6805/29283 need_addr=1
> 2013-02-17 12:08:17.508665 7fbe8795c780  5
> filestore(/var/lib/ceph/osd/26) basedir /var/lib/ceph/osd/26 journal
> /var/lib/ceph/osd/journal/journal26
> 2013-02-17 12:08:17.508712 7fbe8795c780 10
> filestore(/var/lib/ceph/osd/26) mount fsid is
> 67783a66-178e-430a-a031-757bd45ae718
> 2013-02-17 12:08:17.512110 7fbe8795c780  0
> filestore(/var/lib/ceph/osd/26) mount FIEMAP ioctl is supported and
> appears to work
> 2013-02-17 12:08:17.512122 7fbe8795c780  0
> filestore(/var/lib/ceph/osd/26) mount FIEMAP ioctl is disabled via
> 'filestore fiemap' config option
> 2013-02-17 12:08:17.512590 7fbe8795c780  0
> filestore(/var/lib/ceph/osd/26) mount did NOT detect btrfs
> 2013-02-17 12:08:17.532726 7fbe8795c780  0
> filestore(/var/lib/ceph/osd/26) mount syncfs(2) syscall fully
> supported (by glibc and kernel)
> 2013-02-17 12:08:17.532901 7fbe8795c780  0
> filestore(/var/lib/ceph/osd/26) mount found snaps <>
> 2013-02-17 12:08:17.532929 7fbe8795c780  5
> filestore(/var/lib/ceph/osd/26) mount op_seq is 53467469
> 2013-02-17 12:08:17.534953 7fbe8795c780 20 filestore
> (init)dbobjectmap: seq is 852347
> 2013-02-17 12:08:17.534981 7fbe8795c780 10
> filestore(/var/lib/ceph/osd/26) open_journal at
> /var/lib/ceph/osd/journal/journal26
> 2013-02-17 12:08:17.535035 7fbe8795c780  0
> filestore(/var/lib/ceph/osd/26) mount: enabling WRITEAHEAD journal
> mode: btrfs not detected
> 2013-02-17 12:08:17.535046 7fbe8795c780 10
> filestore(/var/lib/ceph/osd/26) list_collections
> 2013-02-17 12:08:17.668919 7fbe83ba2700 20
> filestore(/var/lib/ceph/osd/26) sync_entry waiting for max_interval
> 5.000000
> 2013-02-17 12:08:17.669993 7fbe80b9c700 20
> filestore(/var/lib/ceph/osd/26) flusher_entry start
> 2013-02-17 12:08:17.670012 7fbe80b9c700 20
> filestore(/var/lib/ceph/osd/26) flusher_entry sleeping
> 2013-02-17 12:08:17.670104 7fbe8795c780  5
> filestore(/var/lib/ceph/osd/26) umount /var/lib/ceph/osd/26
> 2013-02-17 12:08:17.670126 7fbe83ba2700 20
> filestore(/var/lib/ceph/osd/26) sync_entry force_sync set
> 2013-02-17 12:08:17.670162 7fbe80b9c700 20
> filestore(/var/lib/ceph/osd/26) flusher_entry awoke
> 2013-02-17 12:08:17.670169 7fbe80b9c700 20
> filestore(/var/lib/ceph/osd/26) flusher_entry finish
> 
> 
