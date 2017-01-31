From: Mark Nelson <mnelson@redhat.com>
Subject: Re: RGW Indexing-in-PostgreSQL?
Date: Mon, 30 Jan 2017 18:09:44 -0600
Message-ID: <28fa42fd-4d60-9d73-bfd0-997b183b1320@redhat.com>
References: <20170130235629.y2upkq4k7oxwhua3@134d30345a13d6cf85884e4b>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753525AbdAaAKM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Jan 2017 19:10:12 -0500
In-Reply-To: <20170130235629.y2upkq4k7oxwhua3@134d30345a13d6cf85884e4b>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>, Ceph Development <ceph-devel@vger.kernel.org>



On 01/30/2017 05:56 PM, Martin Millnert wrote:
> Hi,
>
> we're running RGW with indexes placed on fast pools, whereas the data is
> placed on slow pools. The write throughput is approximately 10% of rados
> bench and I guess we're experiencing some locking/syncronization
> feature, because parallelisation doesn't really speed it up.
> I've seen the sharding option, and the indexless option, but neither one
> of these seems like /the/ fix to me.
> My limited knowledge of the RGW code makes me guess it's due to the
> indexes, and possibly even additional metadata that RGW keeps
> up-to-date?
>
> Assuming that the index objectes must be downloaded, rewritten, and
> re-uploaded to the index pools by RGW (and that this should be
> locking?), the thought that I've had for a while now is:
> How hard is it to abstract these index operations and add support for
> actually using PostgreSQL as a backend?

The indexes are definitely something to watch!  It would be very 
interesting to see how your write benchmark does with indexless buckets. 
  Another thing we've seen in the past is when the bucket indexes are 
slow (in that particular case because the bucket index pool only had 8 
PGs!), RGW is spending most of it's time waiting on bucket index 
updates.  You can grab a couple of GDB stacktraces of the RGW process to 
see if this is happening in your case.

>
> I don't mean to say bad words vis-a-vis a completely self-contained data
> management system, etc, but (more) right(*) (optional) tool for the job has some
> quality to it too. :-)
>
> I'd be willing to take a look at it, I guess.
>
> Thoughts?

I think first figure out if it's actually the bucket indexes.  Like you 
said, there's more metadata associated with RGW, so at least some of 
what you are seeing could be metadata getting pushed out of the inode 
and into separate extents.  Are you writing out lots of really small 
objects or fewer larger objects?

>
> Best,
> Martin
>
> (* Latency/HA/etc tradeoffs may vary based on use-case and
> requirements.)
>
