From: Sage Weil <sweil@redhat.com>
Subject: Re: crush multi-pick anomaly
Date: Tue, 22 Nov 2016 21:45:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611222139450.15296@piezo.us.to>
References: <alpine.DEB.2.11.1611221521220.11236@piezo.us.to> <20161122173013.GA20744@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751055AbcKVVzq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Nov 2016 16:55:46 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1197B5455F
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 21:45:11 +0000 (UTC)
In-Reply-To: <20161122173013.GA20744@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: sjust@redhat.com, ceph-devel@vger.kernel.org

On Tue, 22 Nov 2016, Adam C. Emerson wrote:
> On 22/11/2016, Sage Weil wrote:
> > Hi Adam,
> >
> > Sam had a suggestion about the CRUSH weight anomaly[1]. Instead of
> > adjusting the weight for a given bucket based on an expected num_rep
> > value, instead we could store a vector of weight values for every bucket
> > in the tree for a range of num_reps (2..15, or whatever range is
> > appropriate given the min_size/max_size values for the rules).  In general
> > the tools will show the normal weight (which is a sum of the children) but
> > we'd also keep the adjusted values for any given num_rep and use those for
> > the actual choose.
> >
> > What do you think?
> 
> I thought of something along those lines, though it makes me a bit
> uneasy. Right now, if I have a bunch of objects stored on a bunch of
> hosts and we increase the replication count, objects migrate are
> copied to the NEW hosts but don't migrate between hosts. (This is part
> of the RUSH family monotonicity guarantee.)
> 
> This seems like it might catch users by surprise and result in
> undesired behavior. Having Ceph operate this way would violate the
> /expectations/ people have from looking at a description of our
> algorithm.
> 
> Rather than having CRUSH automagically pick the distribution based on
> the replication count, could we make it more explicit? I'm not sure
> what the best form would be. We might have 'auxiliary weightings' in
> straw2 and list buckets and a way for a CRUSH rule to select one of
> the alternates. That way we wouldn't have to replicate the entire
> hierarchy of devices, and people could 'opt in' explicitly.
> 
> That might be a bit too fiddly, but I think you get the idea. I'm very
> uneasy about having 'magic replication count' behavior sneak up on
> people.

Hmm.  What if the weights are alternatives based on num_rep, but rather 
based on r (or rather which replica we are choosing).  So the first choice 
is based on the actual weights.  The second choice is based on the r=2 
weights.  The third choice is based on r=3 weights.

In a perfect world, those weights are actually a function of our previous 
selection(s); in this case, since that is not computationally feasible 
(right?), we can precalculate values that are "average" for possible prior 
choices. It'd be a bit more complicated, but assume for a moment that we 
could do this...

Then, if you move from 2x to 3x for a given mapping, the selection of the 
first 2 replicas won't be any different than before, but the third replica 
will use different effective weights.

sage
