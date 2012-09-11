From: Sage Weil <sage@inktank.com>
Subject: Re: does ceph consider the device performance for distributing
 data?
Date: Mon, 10 Sep 2012 21:07:27 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209102105580.32347@cobra.newdream.net>
References: <CAB7xdi=XvPL=pkht-gVnmMwyfA6aVn2HWV9_v4Taitjegc=zWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35662 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726Ab2IKEH1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Sep 2012 00:07:27 -0400
In-Reply-To: <CAB7xdi=XvPL=pkht-gVnmMwyfA6aVn2HWV9_v4Taitjegc=zWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 10 Sep 2012, sheng qiu wrote:
> HI,
> 
> i have a simple question.
> for distribution workload among OSDs, does ceph do any online modeling
> for OSDs, i.e. collect the online IO latency and try to distribute
> more workloads to lower latency OSDs? or only based on
> capacity/utilization balance?

Nope.  It would be nice if it did, but there are a limit number of things 
we can do in those cases to direct traffic accordingly without moving data 
around, which is expensive... and the data temperature that is driving the 
imbalance may be temporary/transient.

sage


> 
> Thanks,
> Sheng
> 
> -- 
> Sheng Qiu
> Texas A & M University
> Room 332B Wisenbaker
> email: herbert1984106@gmail.com
> College Station, TX 77843-3259
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
