From: Sage Weil <sage@newdream.net>
Subject: Re: all OSDs crash at more or less the same time
Date: Mon, 7 Mar 2016 06:08:12 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1603070607070.25897@cpach.fuggernut.com>
References: <56DCBF57.10008@digiware.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43592 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbcCGLIf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Mar 2016 06:08:35 -0500
In-Reply-To: <56DCBF57.10008@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 7 Mar 2016, Willem Jan Withagen wrote:
> Hi,
> 
> While running cephtool-test-rados.sh "all of a sudden" the OSDs
> disapear, I had one of the logs open which contained at the end:
> 
>     -2> 2016-03-06 21:56:02.073226 80569ed00  1 heartbeat_map is_healthy
> 'OSD::osd_op_tp thread 0x806795200' had timed out after 15
>     -1> 2016-03-06 21:56:02.073248 80569ed00  1 heartbeat_map is_healthy
> 'OSD::osd_op_tp thread 0x806795200' had suicide timed out after 150
>      0> 2016-03-06 21:56:02.113948 80569ed00 -1 common/HeartbeatMap.cc:
> In function 'bool ceph::HeartbeatMap::_check(const ceph::heartbeat_handle_d
> *, const char *, time_t)' thread 80569ed00 time 2016-03-06 21:56:02.073269
> common/HeartbeatMap.cc: 86: FAILED assert(0 == "hit suicide timeout")
> 
> the monitor is still running. It claims the heartbeat_map is valid, but
> still it suicides??
> 
> And what messages would prevent this from happening?
> Receiving heartbeats from other OSDs?
> 
> IF so how would a 2 OSD server even survive when its connection would be
> split for longer than 2,5 minute?

This is an internal heartbeat indicating that the osd_op_to thread got 
stuck somewhere.  Search backward in the log for the thread id 806795200 
to see the last thing that it did...

sage
