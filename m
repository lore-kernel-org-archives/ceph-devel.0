From: Sage Weil <sage@newdream.net>
Subject: Re: OSD suicide
Date: Tue, 3 Apr 2012 10:49:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204031046010.23209@cobra.newdream.net>
References: <CAGEBRh0Yr6EoOafQF6PYhDe8TZNwUcc6ZeJW7KhXBSf-VU0J9w@mail.gmail.com>
 <4F7A089D.8040904@unilogicnetworks.net> <CAGEBRh10=X=m_pEVp-2_i7syRB_YF1MJ4CBFMB+=joaezDhutg@mail.gmail.com>
 <4F7B3659.1010407@unilogicnetworks.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:39084 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755384Ab2DCRtW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Apr 2012 13:49:22 -0400
In-Reply-To: <4F7B3659.1010407@unilogicnetworks.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Kleijkers <stefan@unilogicnetworks.net>
Cc: Borodin Vladimir <v.a.borodin@gmail.com>, ceph-devel@vger.kernel.org

On Tue, 3 Apr 2012, Stefan Kleijkers wrote:
> Hello Vladimir,
> 
> Well in that case you could try BTRFS. With BTRFS it's possible to grab all
> the disks in a node together in a RAID0/RAID1/RAID10 configuration. So you can
> run one or a few OSDs per node. But I would recommend the newest kernel
> possible. I haven't tried with the 3.3 range, but with the early 3.2.x kernels
> I got BTRFS crashes. And with the later 3.2.x kernels I saw a real slowdown
> after some time.

I should mention that the large metadata blocks were just sent upstream 
and merged for 3.4-rc1.  If you specify a larger metadata block size at 
mkfs.btrfs time (I've been told 16 KB seems to work well) the slowdowns 
should go away.  (We haven't verified this yet ourselves.)

It's probably also worth mentioning that these patches all went into the 
SLES 11 SP2 kernel (based on 3.0).

The btrfs tree is also based on 3.0, so you should be able to merge it 
into any kernel since without pain.

sage


> If you get it stabilised with the mdraid, please let me know, I'm still
> interested in that setup. With the current setup I have the problem that with
> a disk crash in most cases I can't umount the filesystem anymore and I have to
> reboot the node. I would like to avoid that and with mdraid it's possible to
> swap a disk without bringing the system down.
> 
> Stefan
> 
> On 04/03/2012 07:16 PM, Borodin Vladimir wrote:
> > Yes, Stefan. You are right. I'm not sure about the D state, but high
> > cpu usage is fact.
> > I do want to try an OSD per disk configuration but a bit later.
> > 
> > Thanks,
> > Vladimir.
> > 
> > 2012/4/3 Stefan Kleijkers<stefan@unilogicnetworks.net>:
> > > Hello,
> > > 
> > > A while back I had the same errors you are seeing. I had these problems
> > > only
> > > when using mdraid. After doing IO for some time the IO stalled and in most
> > > cases if you look at the cepg-osd daemon it's in D mode (waiting for IO).
> > > Also if you look with top you notice a very high load and IO wait.
> > > 
> > > I didn't find out what the exact reason was, but I stopped using mdraid
> > > and
> > > use a setup with an OSD per disk and the disks formatted with XFS. This
> > > gave
> > > me the best stability and performance.
> > > 
> > > Stefan
> > > 
> > > 
> > > On 04/02/2012 04:01 PM, ??????? ???????? wrote:
> > > > Hi all.
> > > > 
> > > > I have a cluster with 4 OSDs (mdRAID10 on each of them with XFS) and I
> > > > am trying to put into RADOS (through python API) 20 million objects 20
> > > > KB each. I have two problems:
> > > > 1. the speed is not as good as I expect (but that's not the main problem
> > > > now),
> > > > 2. after I put 10 million objects, OSDs started to mark itself down
> > > > and out. The logs give something like that:
> > > > 
> > > > 2012-04-02 17:05:17.894395 7f2d2a213700 heartbeat_map is_healthy
> > > > 'OSD::op_tp thread 0x7f2d1d0f8700' had timed out after 30
> > > > 2012-04-02 17:05:18.877781 7f2d1a8f3700 osd.47 1673 heartbeat_check:
> > > > no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
> > > > 2012-04-02 17:04:58.87
> > > > 7752)
> > > > 2012-04-02 17:05:19.578112 7f2d1a8f3700 osd.47 1673 heartbeat_check:
> > > > no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
> > > > 2012-04-02 17:04:59.57
> > > > 8079)
> > > > 2012-04-02 17:05:20.678455 7f2d1a8f3700 osd.47 1673 heartbeat_check:
> > > > no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
> > > > 2012-04-02 17:05:00.67
> > > > 8421)
> > > > 2012-04-02 17:05:21.678785 7f2d1a8f3700 osd.47 1673 heartbeat_check:
> > > > no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
> > > > 2012-04-02 17:05:01.67
> > > > 8751)
> > > > 2012-04-02 17:05:22.579101 7f2d1a8f3700 osd.47 1673 heartbeat_check:
> > > > no heartbeat from osd.49 since 2012-04-02 17:02:49.217108 (cutoff
> > > > 2012-04-02 17:05:02.57
> > > > 9069)
> > > > 2012-04-02 17:05:22.894568 7f2d2a213700 heartbeat_map is_healthy
> > > > 'OSD::op_tp thread 0x7f2d1d0f8700' had timed out after 30
> > > > 2012-04-02 17:05:22.894601 7f2d2a213700 heartbeat_map is_healthy
> > > > 'OSD::op_tp thread 0x7f2d1d0f8700' had suicide timed out after 300
> > > > common/HeartbeatMap.cc: In function 'bool
> > > > ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, const char*,
> > > > time_t)' thread 7f2d2a213700 time 2012-04-02 17:
> > > > 05:22.894637
> > > > common/HeartbeatMap.cc: 78: FAILED assert(0 == "hit suicide timeout")
> > > >   ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199dee)
> > > >   1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> > > > const*, long)+0x1fe) [0x7634ee]
> > > >   2: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x76381f]
> > > >   3: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x763a50]
> > > >   4: (CephContextServiceThread::entry()+0x5f) [0x65a31f]
> > > >   5: (()+0x69ca) [0x7f2d2beab9ca]
> > > >   6: (clone()+0x6d) [0x7f2d2a4fccdd]
> > > >   ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199dee)
> > > >   1: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> > > > const*, long)+0x1fe) [0x7634ee]
> > > >   2: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x76381f]
> > > >   3: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x763a50]
> > > >   4: (CephContextServiceThread::entry()+0x5f) [0x65a31f]
> > > >   5: (()+0x69ca) [0x7f2d2beab9ca]
> > > >   6: (clone()+0x6d) [0x7f2d2a4fccdd]
> > > > *** Caught signal (Aborted) **
> > > >   in thread 7f2d2a213700
> > > >   ceph version 0.44.1 (commit:c89b7f22c8599eb974e75a2f7a5f855358199dee)
> > > >   1: /usr/bin/ceph-osd() [0x661cb1]
> > > >   2: (()+0xf8f0) [0x7f2d2beb48f0]
> > > >   3: (gsignal()+0x35) [0x7f2d2a449a75]
> > > >   4: (abort()+0x180) [0x7f2d2a44d5c0]
> > > >   5: (__gnu_cxx::__verbose_terminate_handler()+0x11d) [0x7f2d2acec58d]
> > > >   6: (()+0xb7736) [0x7f2d2acea736]
> > > >   7: (()+0xb7763) [0x7f2d2acea763]
> > > >   8: (()+0xb785e) [0x7f2d2acea85e]
> > > >   9: (ceph::__ceph_assert_fail(char const*, char const*, int, char
> > > > const*)+0x841) [0x667541]
> > > >   10: (ceph::HeartbeatMap::_check(ceph::heartbeat_handle_d*, char
> > > > const*, long)+0x1fe) [0x7634ee]
> > > >   11: (ceph::HeartbeatMap::is_healthy()+0x7f) [0x76381f]
> > > >   12: (ceph::HeartbeatMap::check_touch_file()+0x20) [0x763a50]
> > > >   13: (CephContextServiceThread::entry()+0x5f) [0x65a31f]
> > > >   14: (()+0x69ca) [0x7f2d2beab9ca]
> > > >   15: (clone()+0x6d) [0x7f2d2a4fccdd]
> > > > 
> > > > Or something like that:
> > > > 
> > > > ...
> > > > 2012-04-02 17:01:38.673223 7f7855486700 heartbeat_map is_healthy
> > > > 'OSD::op_tp thread 0x7f7847369700' had timed out after 30
> > > > 2012-04-02 17:01:38.673267 7f7855486700 heartbeat_map is_healthy
> > > > 'OSD::op_tp thread 0x7f7847b6a700' had timed out after 30
> > > > 2012-04-02 17:01:38.833509 7f7847369700 heartbeat_map reset_timeout
> > > > 'OSD::op_tp thread 0x7f7847369700' had timed out after 30
> > > > 2012-04-02 17:01:39.031229 7f7847b6a700 heartbeat_map reset_timeout
> > > > 'OSD::op_tp thread 0x7f7847b6a700' had timed out after 30
> > > > 2012-04-02 17:02:06.971487 7f784324b700 -- 84.201.161.48:6803/17442>>
> > > > 84.201.161.49:6802/15581 pipe(0x47197280 sd=50 pgs=0 cs=0 l=0).accept
> > > > we reset (peer sent cseq 2), sending RESETSESSION
> > > > 2012-04-02 17:02:49.321812 7f784324b700 -- 84.201.161.48:6803/17442>>
> > > > 84.201.161.49:6802/15581 pipe(0x47197280 sd=50 pgs=53 cs=1 l=0).fault
> > > > with nothing to send, going to standby
> > > > 2012-04-02 17:03:11.677528 7f784a470700 osd.48 1675 from dead osd.49,
> > > > dropping, sharing map
> > > > 2012-04-02 17:05:26.355673 7f784344d700 -- 84.201.161.48:0/17442>>
> > > > 84.201.161.47:6802/17587 pipe(0x1bb4280 sd=375 pgs=783 cs=1 l=0).fault
> > > > with nothing to send, going to standby
> > > > 2012-04-02 17:05:26.355767 7f7844059700 -- 84.201.161.48:6804/17442>>
> > > > 84.201.161.47:0/17587 pipe(0x4ba5c500 sd=201 pgs=17 cs=1 l=0).fault
> > > > initiating reconnect
> > > > 2012-04-02 17:05:26.355936 7f7843b54700 -- 84.201.161.48:6803/17442>>
> > > > 84.201.161.47:6801/17587 pipe(0x3ad97780 sd=36 pgs=138 cs=1 l=0).fault
> > > > with nothing to send, going to standby
> > > > 2012-04-02 17:18:43.624220 7f7843049700 -- 84.201.161.48:6803/17442>>
> > > > 84.201.161.49:6804/15581 pipe(0x47197a00 sd=37 pgs=55 cs=1 l=0).fault
> > > > with nothing to send, going to standby
> > > > 2012-04-02 17:18:43.974073 7f784445d700 -- 84.201.161.48:6804/17442>>
> > > > 84.201.161.49:0/15581 pipe(0x4be36000 sd=38 pgs=15 cs=1 l=0).fault
> > > > with nothing to send, going to standby
> > > > 2012-04-02 17:18:47.556758 7f7842c45700 -- 84.201.161.48:6803/17442>>
> > > > 84.201.161.50:6802/7906 pipe(0x47197c80 sd=41 pgs=178 cs=1 l=0).fault
> > > > with nothing to send, going to standby
> > > > 2012-04-02 17:18:47.775391 7f7844760700 -- 84.201.161.48:6804/17442>>
> > > > 84.201.161.50:0/7906 pipe(0x46f10280 sd=42 pgs=31 cs=1 l=0).fault
> > > > initiating reconnect
> > > > 2012-04-02 17:20:54.798971 7f784fc7b700 osd.48 1678 heartbeat_check:
> > > > no heartbeat from osd.47 since 2012-04-02 17:05:22.574731 (cutoff
> > > > 2012-04-02 17:20:34.798943)
> > > > ...
> > > > 2012-04-02 17:20:56.846736 7f784fc7b700 osd.48 1678 heartbeat_check:
> > > > no heartbeat from osd.47 since 2012-04-02 17:05:22.574731 (cutoff
> > > > 2012-04-02 17:20:36.846704)
> > > > 2012-04-02 17:21:15.408175 7f7842b44700 -- 84.201.161.48:6803/17442>>
> > > > 84.201.161.49:6804/15581 pipe(0x47197a00 sd=50 pgs=55 cs=2
> > > > l=0).connect got RESETSESSION
> > > > 2012-04-02 17:22:11.678030 7f784fc7b700 osd.48 1680 heartbeat_check:
> > > > no heartbeat from osd.47 since 2012-04-02 17:05:22.574731 (cutoff
> > > > 2012-04-02 17:21:51.678001)
> > > > ...
> > > > 2012-04-02 17:22:26.012018 7f7844b64700 -- 84.201.161.48:6803/17442>>
> > > > 84.201.161.50:6802/7906 pipe(0x47197c80 sd=39 pgs=178 cs=2
> > > > l=0).connect got RESETSESSION
> > > > 2012-04-02 17:22:26.064256 7f7842d46700 -- 84.201.161.48:6803/17442>>
> > > > 84.201.161.49:6804/15581 pipe(0x47197a00 sd=50 pgs=64 cs=1 l=0).fault
> > > > initiating reconnect
> > > > 2012-04-02 17:22:26.065367 7f7842b44700 -- 84.201.161.48:6803/17442>>
> > > > 84.201.161.49:6804/15581 pipe(0x47197a00 sd=41 pgs=64 cs=2
> > > > l=0).connect got RESETSESSION
> > > > 2012-04-02 17:24:07.987587 7f784ac71700 log [WRN] : map e1706 wrongly
> > > > marked me down or wrong addr
> > > > 
> > > > In first case the OSD process terminates, it is marked out by the
> > > > cluster and re-replication is started. In second case the OSD resumes
> > > > over several time and then goes down again etc...
> > > > 
> > > > It seems that the problem is that the OSDs don't send/receive
> > > > heartbeat-messages, but why? The network seems to be good and time is
> > > > synchronized. The problem appeared only when I put a lot of objects
> > > > (and took more than a half of free space availible). I can give the
> > > > config file and any logs if needed.
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
