From: Kevin Decherf <kevin@kdecherf.com>
Subject: Re: Crash and strange things on MDS
Date: Mon, 11 Feb 2013 14:05:18 +0100
Message-ID: <20130211130518.GN6997@kdecherf.com>
References: <20130204180154.GO3286@kdecherf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:63251 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757101Ab3BKNFX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 08:05:23 -0500
Received: by mail-wi0-f179.google.com with SMTP id ez12so3067227wid.6
        for <ceph-devel@vger.kernel.org>; Mon, 11 Feb 2013 05:05:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130204180154.GO3286@kdecherf.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: support@clever-cloud.com

On Mon, Feb 04, 2013 at 07:01:54PM +0100, Kevin Decherf wrote:
> Hey everyone,
> 
> It's my first post here to expose a potential issue I found today using
> Ceph 0.56.1.
> 
> The cluster configuration is, briefly: 27 osd of ~900GB and 3 MON/MDS.
> All nodes are running Exherbo (source-based distribution) with Ceph
> 0.56.1 and Linux 3.7.0. We are only using CephFS on this cluster which
> is mounted on ~60 clients (increasing each day). Objects are replicated
> three times and the cluster handles only 7GB of data atm for 350k
> objects.
> 
> In certain conditions (I don't know them atm), some clients hang,
> generate CPU overloads (kworker) and are unable to make any IO on
> Ceph. The active MDS have ~20Mbps in/out during the issue (less than
> 2Mbps in normal activity). I don't know if it's directly linked but we
> also observe a lot of missing files at the same time.
> 
> The problem is similar to this one [1].
> 
> A restart of the client or the MDS was enough before today, but we found
> a new behavior: the active MDS consumes a lot of CPU during 3 to 5 hours
> with ~25% clients hanging.
> 
> In logs I found a segfault with this backtrace [2] and 100,000 dumped
> events during the first hang. We observed another hang which produces
> lot of these events (in debug mode):
>    - "mds.0.server FAIL on ESTALE but attempting recovery"
>    - "mds.0.server reply_request -116 (Stale NFS file handle)
>       client_request(client.10991:1031 getattr As #1000004bab0
>       RETRY=132)"
> 
> We have no profiling tools available on these nodes, and I don't know
> what I should search in the 35 GB log file.
> 
> Note: the segmentation fault occured only once but the problem was
> observed four times on this cluster.
> 
> Any help may be appreciated.
> 
> References:
> [1] http://www.spinics.net/lists/ceph-devel/msg04903.html
> [2] ceph version 0.56.1 (e4a541624df62ef353e754391cbbb707f54b16f7)
>     1: /usr/bin/ceph-mds() [0x817e82]
>     2: (()+0xf140) [0x7f9091d30140]
>     3: (MDCache::request_drop_foreign_locks(MDRequest*)+0x21) [0x5b9dc1]
>     4: (MDCache::request_drop_locks(MDRequest*)+0x19) [0x5baae9]
>     5: (MDCache::request_cleanup(MDRequest*)+0x60) [0x5bab70]
>     6: (MDCache::request_kill(MDRequest*)+0x80) [0x5bae90]
>     7: (Server::journal_close_session(Session*, int)+0x372) [0x549aa2]
>     8: (Server::kill_session(Session*)+0x137) [0x549c67]
>     9: (Server::find_idle_sessions()+0x12a6) [0x54b0d6]
>     10: (MDS::tick()+0x338) [0x4da928]
>     11: (SafeTimer::timer_thread()+0x1af) [0x78151f]
>     12: (SafeTimerThread::entry()+0xd) [0x782bad]
>     13: (()+0x7ddf) [0x7f9091d28ddf]
>     14: (clone()+0x6d) [0x7f90909cc24d]

I found a possible cause/way to reproduce this issue.
We have now ~90 clients for 18GB / 650k objects and the storm occurs
when we execute an "intensive IO" command (tar of the whole pool / rsync
in one folder) on one of our client (the only which uses ceph-fuse,
don't know if it's limited to it or not).

Any idea?

Cheers,
-- 
Kevin Decherf - @Kdecherf
GPG C610 FE73 E706 F968 612B E4B2 108A BD75 A81E 6E2F
http://kdecherf.com
