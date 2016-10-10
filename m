From: Sage Weil <sage@newdream.net>
Subject: Re: issue about the parameter 'paxos_propose_interval'
Date: Mon, 10 Oct 2016 13:23:58 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610101322230.18626@piezo.us.to>
References: <CAHRQ3VVecRDO1kf8BdtB6jd9rZVF+C42r8xDBYhjLvMoosMcng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49252 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752343AbcJJNY7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Oct 2016 09:24:59 -0400
In-Reply-To: <CAHRQ3VVecRDO1kf8BdtB6jd9rZVF+C42r8xDBYhjLvMoosMcng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Songbo Wang <songbo1227@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 9 Oct 2016, Songbo Wang wrote:
> Hi, Sage, Sam
> 
> I got a issue about the parameter 'paxos_propose_interval' with the
> default value 1.0.
> 
> I think this parameter aim to reduce the Monitor pressure to call the
> propose_pending(). But, this introduces another problem, when a osd is
> started,  it will send 3 kinds of requests to Monitor (e.g. MOSDBoot,
> MOSDPGTemp, MOSDAlive). Without other changes, It will take 3 seconds
> at least. which will increase the time that blocks the whole cluster.
> 
> If the parameter 'paxos_propose_interval' is set to 0.05 or smaller,
> it loses the propse it designed.
> 
> I think we can introduce some special process, for some kinds of
> messages (e.g. MOSDPGTemp, MOSDAlive), to process them immediately.

Currently we essentially have two classes of messages: those that are 
processed immediately (no delay), and those that respect the 
paxos_propose_interval.  We can either introduce a second tunable and 
create a third class (process quickly) with something like .05, or we can 
say that all of the current 'no delay' messages should delay for a short 
period (like .05).

Any preferences?

sage

