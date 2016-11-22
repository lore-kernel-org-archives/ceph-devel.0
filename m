From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: crush multi-pick anomaly
Date: Tue, 22 Nov 2016 12:30:13 -0500
Message-ID: <20161122173013.GA20744@ultraspiritum.eng.arb.redhat.com>
References: <alpine.DEB.2.11.1611221521220.11236@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756104AbcKVRbZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 22 Nov 2016 12:31:25 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EE721F44F3
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2016 17:31:24 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1611221521220.11236@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: sjust@redhat.com, ceph-devel@vger.kernel.org

On 22/11/2016, Sage Weil wrote:
> Hi Adam,
>
> Sam had a suggestion about the CRUSH weight anomaly[1]. Instead of
> adjusting the weight for a given bucket based on an expected num_rep
> value, instead we could store a vector of weight values for every bucket
> in the tree for a range of num_reps (2..15, or whatever range is
> appropriate given the min_size/max_size values for the rules).  In general
> the tools will show the normal weight (which is a sum of the children) but
> we'd also keep the adjusted values for any given num_rep and use those for
> the actual choose.
>
> What do you think?

I thought of something along those lines, though it makes me a bit
uneasy. Right now, if I have a bunch of objects stored on a bunch of
hosts and we increase the replication count, objects migrate are
copied to the NEW hosts but don't migrate between hosts. (This is part
of the RUSH family monotonicity guarantee.)

This seems like it might catch users by surprise and result in
undesired behavior. Having Ceph operate this way would violate the
/expectations/ people have from looking at a description of our
algorithm.

Rather than having CRUSH automagically pick the distribution based on
the replication count, could we make it more explicit? I'm not sure
what the best form would be. We might have 'auxiliary weightings' in
straw2 and list buckets and a way for a CRUSH rule to select one of
the alternates. That way we wouldn't have to replicate the entire
hierarchy of devices, and people could 'opt in' explicitly.

That might be a bit too fiddly, but I think you get the idea. I'm very
uneasy about having 'magic replication count' behavior sneak up on
people.

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
