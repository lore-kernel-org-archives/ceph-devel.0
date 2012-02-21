From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: rbd benchmark details
Date: Tue, 21 Feb 2012 13:41:12 -0800
Message-ID: <82E6D940-29AD-462A-8FC7-14AD18920E65@cs.ucsc.edu>
References: <AE277795-A081-4CCA-9816-E5BA717A6946@cs.ucsc.edu> <CAF3hT9BcBui8VH9F=4egWpvoHH+ENcPOgaDSpTCsqVN7KwuL1w@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:43997 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755670Ab2BUVlM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 16:41:12 -0500
In-Reply-To: <CAF3hT9BcBui8VH9F=4egWpvoHH+ENcPOgaDSpTCsqVN7KwuL1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Noah Watkins <jayhawk@soe.ucsc.edu>, ceph-devel@vger.kernel.org, Adam Manzanares <nmtadam@gmail.com>


On Feb 21, 2012, at 12:40 PM, Gregory Farnum wrote:

> On Tue, Feb 21, 2012 at 12:25 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> 
> That's pretty much expected. -t is not actually controlling the number
> of threads, but the number of requests the rados tool will dispatch at
> a time. With -t 1 you're telling it to send a single request, wait for
> it to commit, then dispatch another request. (ie, latency bound) With
> -t 10 you are dispatching 10 requests and dispatching a new one
> whenever one of those comes back. (ie, mostly bandwidth bound)

Makes sense, thanks. So the bottleneck is very sneaky. 

> -Greg
