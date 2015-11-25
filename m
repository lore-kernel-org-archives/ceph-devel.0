From: Sage Weil <sweil@redhat.com>
Subject: Re: cluster busy, cause heartbeat exceptional, cluster becomes more
 busy
Date: Wed, 25 Nov 2015 05:16:13 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511250513520.11017@cobra.newdream.net>
References: <5F4E7462F2F4A14E974FBE17B8EB37210E5C6AAE@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-37162058-1448457376=:11017"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60771 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbbKYNQQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 25 Nov 2015 08:16:16 -0500
In-Reply-To: <5F4E7462F2F4A14E974FBE17B8EB37210E5C6AAE@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chenxiaowei <chen.xiaowei@h3c.com>
Cc: "sjust@redhat.com" <sjust@redhat.com>, Chenjie <chen.jie@h3c.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-37162058-1448457376=:11017
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 25 Nov 2015, Chenxiaowei wrote:
>          We met another serious problem as follows:
> 
> During backfill,rbd client send ops to cluster, slow request came up, and so
> 
> When osd heartbeat came in,  check cct->get_heartbeat_map()->is_healthy()
> return false,
> 
> So other osd will not receive heartbeat and report failure info to monitor,
> monitor mark osd down leading
> 
> to more osd peering, cluster more busy, so here comes the question:
> 
> why osd heartbeat check logic combined with heartbeatmap( check other
> threadpool and so on) ? ? ?
> 
> I am really confused about this logic. Wish your reply.

The idea is simply that if the OSD is not healthy (e.g., stuck op thread) 
it should not respond to heartbeats and tell other OSDs that it is 
healthy.  It should get marked down.  After it recovers 
(wait_for_healthy), then it can rejoin the cluster.  (Or, more likely, it 
the thread is completely stuck and it will suicide.)

I think the issue is that the backfill + client load was enough to make 
is_healthy() fail.. that really shouldn't be happening.  As long as the 
threads are making progress they won't fail their internal heartbeat 
checks--that only happens if they get completely stuck.  I suspect 
something else broke?

sage
--557981400-37162058-1448457376=:11017--
