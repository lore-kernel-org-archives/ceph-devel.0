From: Sage Weil <sage@newdream.net>
Subject: Re: mkmonfs error
Date: Tue, 11 May 2010 09:27:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1005110927040.32173@cobra.newdream.net>
References: <AANLkTin_nfsvA5jqFQ5BhsuzI1IVLmU2ubk6YKPTFagX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53653 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab0EKQYb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 May 2010 12:24:31 -0400
In-Reply-To: <AANLkTin_nfsvA5jqFQ5BhsuzI1IVLmU2ubk6YKPTFagX@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Chiang <paul_chiang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

Hi Paul,

On Tue, 11 May 2010, Paul Chiang wrote:
> I'm getting an error with mkmonfs while trying to expand the monitor
> cluster as per the instructions on the wiki.

Yeah, this is indeed broken.  We should have a fix sometime today.

sage


> 
> The error seems to originate from line 951~970 of Monitor.cc
> 
> Suppose we start with map epoch 3:
> 1. create_pending() increments the epoch to 4
> 2. create_initial() then sets it back to 3
> 3. encode_pending() finds 3+1 != 3, throws an error and dies
> 
> Not sure if this is a bug or there's something wrong with my proceedure.
> 
> Thanks in advance,
> Paul Chiang
> 
> P.S. I'm using the unstable branch
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
