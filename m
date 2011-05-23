From: Fyodor Ustinov <ufm@ufm.su>
Subject: Re: (un)stability of ceph
Date: Mon, 23 May 2011 08:55:50 +0000 (UTC)
Message-ID: <loom.20110523T103350-311@post.gmane.org>
References: <C424A186-75DB-4CC5-A662-A538E7D5BA4C@uni-osnabrueck.de> <Pine.LNX.4.64.1105201238250.25242@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:53692 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548Ab1EWI4D (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 23 May 2011 04:56:03 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1QOQvh-0008K4-CR
	for ceph-devel@vger.kernel.org; Mon, 23 May 2011 10:56:01 +0200
Received: from 94.232.181.14 ([94.232.181.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 10:56:01 +0200
Received: from ufm by 94.232.181.14 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Mon, 23 May 2011 10:56:01 +0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sage Weil <sage <at> newdream.net> writes:

> Based on your requirements, it sounds like Ceph is a good fit.  As for 
> status, here is the latest update:
> 
> - Ceph is not yet ready for production however, we are confident that we 
>   are only a few months away
> - We have not experienced any data loss on our pseudo-production 
>   test clusters for quite some time now.
> - We (DreamHost) have expanded the core team on Ceph to 7 people who are
>   primarily working on stability and performance
> - Each month more and more people are digging in and getting involved in 
>   the project which we hope will accelerate development further
> - We are very close to launching a hosted beta of the object store layer 
>   which will help us identify foundational issues

Requests from "user" :)

1. Stop "featuring". ceph does all what need. :)
2. Fix a bugs. 
And most important:
3. Please, please, please, make documentation. I get along without the
"crushtool: add --reweight-item" - I know how to use the "vi". But I do not know
the meaning of the secret parameter "weight".

I like ceph and I want it quickly became a "ready for production" :)


WBR,
    Fyodor.

