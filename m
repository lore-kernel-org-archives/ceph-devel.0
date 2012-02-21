From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: rbd benchmark details
Date: Tue, 21 Feb 2012 14:03:18 -0800
Message-ID: <CAF3hT9CWeCpoSK4tuHzwejpcz2JNpU2v7rBwdFUBEexrv62sxg@mail.gmail.com>
References: <AE277795-A081-4CCA-9816-E5BA717A6946@cs.ucsc.edu>
	<CAF3hT9BcBui8VH9F=4egWpvoHH+ENcPOgaDSpTCsqVN7KwuL1w@mail.gmail.com>
	<3DF204ED-EE24-4DCC-B8DA-4B351F8AADBE@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58416 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752693Ab2BUWDS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 17:03:18 -0500
Received: by iacb35 with SMTP id b35so9447091iac.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 14:03:18 -0800 (PST)
In-Reply-To: <3DF204ED-EE24-4DCC-B8DA-4B351F8AADBE@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org, Adam Manzanares <nmtadam@gmail.com>

On Tue, Feb 21, 2012 at 1:50 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>
> On Feb 21, 2012, at 12:40 PM, Gregory Farnum wrote:
>
>>
>> That's pretty much expected. -t is not actually controlling the number
>> of threads, but the number of requests the rados tool will dispatch at
>> a time. With -t 1 you're telling it to send a single request, wait for
>> it to commit, then dispatch another request. (ie, latency bound) With
>> -t 10 you are dispatching 10 requests and dispatching a new one
>> whenever one of those comes back. (ie, mostly bandwidth bound)
>
> Should the expectation be 30 MB/s (the slowest disk) or 1/3 of that for triplication? I was under the impression that the ack came back for being in memory on 2 of the 3 nodes.

Acks come back once they're in memory on all nodes. Commits come back
once they're on disk in all nodes. Doing 2 out of 3 is not fail-safe
if you lose the two nodes the data is on. *shrug*
I believe the rados bench requires commits, not acks, but I could be
misremembering.

In any case, working out the expected speeds on a cluster with
heterogenous disks is a challenge we haven't fully automated yet. If
you've got 3 nodes with 3x replication and one node can only handle
30MB/s though, that's what you're going to get in terms of asymptotic
throughput, yes. In a 23-node cluster it's considerably more
complicated and I'd have to draw it out.

-Greg
(not sure if that answered your question or not...)
