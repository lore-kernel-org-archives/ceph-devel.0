From: Piotr =?utf-8?B?RGHFgmVr?= <branch@predictor.org.pl>
Subject: Re: OSDs are flapping and marked down wrongly
Date: Mon, 17 Oct 2016 09:51:41 +0200
Message-ID: <20161017075141.GA28088@predictor>
References: <BY2PR02MB3964B80170065D0141B7931F4D00@BY2PR02MB396.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from predictor.org.pl ([185.5.97.54]:53411 "EHLO predictor.org.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932503AbcJQH4F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 17 Oct 2016 03:56:05 -0400
Content-Disposition: inline
In-Reply-To: <BY2PR02MB3964B80170065D0141B7931F4D00@BY2PR02MB396.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@lists.ceph.com, Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel@vger.kernel.org

On Mon, Oct 17, 2016 at 07:16:44AM +0000, Somnath Roy wrote:
> Hi Sage et. al,
> 
> I know this issue is reported number of times in community and attributed to either network issue or unresponsive OSDs.
> Recently, we are seeing this issue when our all SSD cluster (Jewel based)  is stressed with large block size and very high QD. Lowering QD it is working just fine.
> We are seeing the lossy connection message like below and followed by the osd marked down by monitor.
> 
> 2016-10-15 14:30:13.957534 7f6297bff700  0 -- 10.10.10.94:6810/2461767 submit_message osd_op_reply(1463 rbd_data.55246b8b4567.000000000000d633 [set-alloc-hint object_size 4194304 write_size 4194304,write 3932160~262144] v222'95890 uv95890 ondisk = 0) v7 remote, 10.10.10.98:0/1174431362, dropping message
> 
> In the monitor log, I am seeing the osd is reported down by peers and subsequently monitor is marking it down.
> OSDs is rejoining the cluster after detecting it is marked down wrongly and rebalancing started. This is hurting performance very badly.
> 
> My question is the following.
> 
> 1. I have 40Gb network and I am seeing network is not utilized beyond 10-12Gb/s , no network error is reported. So, why this lossy connection message is coming ? what could go wrong here ? Is it network prioritization issue of smaller ping packets ? I tried to gaze ping round time during this and nothing seems abnormal.
> 
> 2. Nothing is saturated on the OSD side , plenty of network/memory/cpu/disk is left. So, I doubt my osds are unresponsive but yes it is really busy on IO path. Heartbeat is going through separate messenger and threads as well, so, busy op threads should not be making heartbeat delayed. Increasing osd heartbeat grace is only delaying this phenomenon , but, eventually happens after several hours. Anything else we can tune here ?

There's a bunch of messengers in OSD code, if ANY of them doesn't respond
to heartbeat messages in reasonable time, it is marked as down. Since packets
are processed in FIFO/synchronous manner, overloading OSD with large I/O will
cause it to time-out on at least one messenger. 
There was an idea to have heartbeat messages go in the OOB TCP/IP stream and
process them asynchronously, but I don't know if that went beyond the idea
stage.
 
> 3. What could be the side effect of big grace period ? I understand that detecting a faulty osd will be delayed, anything else ?

Yes - stalled ops. Assume that primary OSD goes down and replicas are still
alive. Having big grace period will cause all ops going to that OSD to
stall until that particular OSD is marked down or resumes normal operation.
 
> 4. I saw if an OSD is crashed, monitor will detect the down osd almost instantaneously and it is not waiting till this grace period. How it is distinguishing between unresponsive and crashed osds ? In which scenario this heartbeat grace is coming into picture ?

This is the effect of my PR#8558 (https://github.com/ceph/ceph/pull/8558) 
which causes any OSD that crash to be immediately marked as down, preventing
stalled I/Os in most common cases. Grace period is only applied to
unresponsive OSDs (i.e. temporary packet loss, bad cases of network lags,
routing issues, in other words, everything that is known to be at least
possible to resolve by itself in a finite amount of time). OSDs that crash 
and burn won't respond - instead, OS will respond with ECONNREFUSED
indicating that OSD is not listening and in that case the OSD will be
immediately marked down.

-- 
Piotr Dałek
branch@predictor.org.pl
http://blog.predictor.org.pl
