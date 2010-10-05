From: Sage Weil <sage@newdream.net>
Subject: Re: mds suicide
Date: Mon, 4 Oct 2010 21:54:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1010042151480.21681@cobra.newdream.net>
References: <AANLkTikArjoBY7D6M5q3eKBH249hpd4BTVhgiVKE9RFn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60842 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab0JEEvv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Oct 2010 00:51:51 -0400
In-Reply-To: <AANLkTikArjoBY7D6M5q3eKBH249hpd4BTVhgiVKE9RFn@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Leander Yu <leander.yu@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 5 Oct 2010, Leander Yu wrote:
> Hi,
> I have a 46 machines cluster(44 osd/mon + 2 mds) running ceph now. MDS
> is running in active/standby mode.
> This morning one of the MDS suicide the log shows:
> 
> -------------------------------------------
> 2010-10-04 22:24:19.450022 7f2e5a1ee710 mds0.cache.ino(10000002b87)
> pop_projected_snaprealm 0x7f2e50cd9f70 seq1
> 2010-10-04 22:26:12.180854 7f2debbfb710 -- 192.168.1.103:6800/2081 >>
> 192.168.1.106:0/2453428678 pipe(0x7f2e380013d0 sd=-1 pgs=2 cs=1
> l=0).fault with nothing to send, going to standby
> 2010-10-04 22:26:12.181019 7f2e481dc710 -- 192.168.1.103:6800/2081 >>
> 192.168.1.111:0/18905730 pipe(0x7f2e38002250 sd=-1 pgs=2 cs=1
> l=0).fault with nothing to send, going to standby
> 2010-10-04 22:26:12.181041 7f2dc3fff710 -- 192.168.1.103:6800/2081 >>
> 192.168.1.114:0/1945631186 pipe(0x7f2e38000f00 sd=-1 pgs=2 cs=1
> l=0).fault with nothing to send, going to standby
> 2010-10-04 22:26:12.181149 7f2deaef6710 -- 192.168.1.103:6800/2081 >>
> 192.168.1.113:0/521184914 pipe(0x7f2e38002f90 sd=-1 pgs=2 cs=1
> l=0).fault with nothing to send, going to standby
> 2010-10-04 22:26:12.181563 7f2deb5f5710 -- 192.168.1.103:6800/2081 >>
> 192.168.1.112:0/4272114728 pipe(0x7f2e38002ac0 sd=-1 pgs=2 cs=1
> l=0).fault with nothing to send, going to standby
> 2010-10-04 22:26:13.777624 7f2e5a1ee710 mds-1.3 handle_mds_map i
> (192.168.1.103:6800/2081) dne in the mdsmap, killing myself
> 2010-10-04 22:26:13.777649 7f2e5a1ee710 mds-1.3 suicide.  wanted
> up:active, now down:dne
> 2010-10-04 22:26:13.777769 7f2e489e4710 -- 192.168.1.103:6800/2081 >>
> 192.168.1.101:0/15702 pipe(0x7f2e380008c0 sd=-1 pgs=1847 cs=1
> l=0).fault with nothing to send, going to standby
> ------------------------------------------------------------------------------
> Would you suggest how do I trouble shooting this issue? or should I
> just restart the mds to recover it?

The MDS killed itself because it was removed from the mdsmap.  The 
monitor log will tell you why if you had logging turned up.  If not, you 
might find some clue by looking at each mdsmap iteration.  If you do

 $ ceph mds stat

it will tell you the map epoch (e###).  You can then dump any map 
iteration with

 $ ceph mds dump 123 -o -

Work backward a few iterations until you find which epoch removed that mds 
instance.  The one prior to that might have some clue (maybe it was 
laggy?)...

sage
