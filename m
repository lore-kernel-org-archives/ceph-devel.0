From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: rbd benchmark details
Date: Tue, 21 Feb 2012 13:50:51 -0800
Message-ID: <3DF204ED-EE24-4DCC-B8DA-4B351F8AADBE@cs.ucsc.edu>
References: <AE277795-A081-4CCA-9816-E5BA717A6946@cs.ucsc.edu> <CAF3hT9BcBui8VH9F=4egWpvoHH+ENcPOgaDSpTCsqVN7KwuL1w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:48797 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2BUVvE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 16:51:04 -0500
In-Reply-To: <CAF3hT9BcBui8VH9F=4egWpvoHH+ENcPOgaDSpTCsqVN7KwuL1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Adam Manzanares <nmtadam@gmail.com>


On Feb 21, 2012, at 12:40 PM, Gregory Farnum wrote:

> 
> That's pretty much expected. -t is not actually controlling the number
> of threads, but the number of requests the rados tool will dispatch at
> a time. With -t 1 you're telling it to send a single request, wait for
> it to commit, then dispatch another request. (ie, latency bound) With
> -t 10 you are dispatching 10 requests and dispatching a new one
> whenever one of those comes back. (ie, mostly bandwidth bound)

Should the expectation be 30 MB/s (the slowest disk) or 1/3 of that for triplication? I was under the impression that the ack came back for being in memory on 2 of the 3 nodes.


> -Greg

