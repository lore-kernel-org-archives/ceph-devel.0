From: Karol Jurak <karol.jurak@gmail.com>
Subject: Re: Modifying RBD image changes it's snapshot
Date: Thu, 27 Jun 2013 14:13:02 +0200
Message-ID: <1492235.pCU3O3CnoC@karol-esprimo-p5925>
References: <1805042.yIbHV06QAO@karol-esprimo-p5925> <51CB2FC6.6070803@inktank.com> <51CB6043.5020109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49553 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199Ab3F0MMM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Jun 2013 08:12:12 -0400
Received: by mail-ee0-f46.google.com with SMTP id d41so351217eek.33
        for <ceph-devel@vger.kernel.org>; Thu, 27 Jun 2013 05:12:10 -0700 (PDT)
In-Reply-To: <51CB6043.5020109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Wednesday 26 of June 2013 14:42:27 Josh Durgin wrote:
> On 06/26/2013 11:15 AM, Josh Durgin wrote:
> > On 06/26/2013 05:40 AM, Karol Jurak wrote:
> >> Hi,
> >> 
> >> I'm using ceph 0.56.6 and kernel 3.9.7 and it looks like modifying RBD
> >> image
> >> also changes it's snapshot. I can reproduce this as follows:
> > 
> > Just reproduced on 3.10-rc7 as well. It seems the snapshot context
> > loading is broken for format 1 a t least, since unmapping and mapping
> > after the snapshot exists still has the same problem. I added
> > http://tracker.ceph.com/issues/5464 to track this.
> > 
> > Apparently the regression test for this hasn't been running, or we
> > would've caught this sooner.
> 
> There's a fix for this on the stable kernel in the wip-snapc-3.9.y
> branch of ceph-client.git.

Thanks for the fix. Snapshots work as expected now.

-- 
Karol Jurak
