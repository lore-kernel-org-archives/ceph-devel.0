From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: OSD crashed today in os/JournalingObjectStore.cc
Date: Wed, 5 Dec 2012 17:05:47 +0100
Message-ID: <BC8B71E3-1BE1-49ED-B578-34A0CBACAB98@profihost.ag>
References: <50BF1A43.4060605@profihost.ag> <alpine.DEB.2.00.1212050639480.17270@cobra.newdream.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:41535 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab2LEQF4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Dec 2012 11:05:56 -0500
In-Reply-To: <alpine.DEB.2.00.1212050639480.17270@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There was a dump in the attached log.

Stefan

Am 05.12.2012 um 15:41 schrieb Sage Weil <sage@inktank.com>:

> On Wed, 5 Dec 2012, Stefan Priebe - Profihost AG wrote:
>> Hello list,
>> 
>> i updated to latest next from today and then after 20 minutes an OSD was
>> crashing in os/JournalingObjectStore.cc.
>> 
>> Attached is the log.
> 
> Hmm, this is perplexing.  It might just be a bad assert, but I can't see 
> how it could happen.  Any chance you can reproduce with
> 
>    debug journal = 0/10
> 
> in the [osd] section?  That will give us a dump if it fails the assert.
> 
> Thanks!
> s
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
