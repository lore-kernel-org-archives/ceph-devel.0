From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: dynamically move busy pg's to fast storage
Date: Wed, 19 Jun 2013 06:57:59 -0500
Message-ID: <51C19CC7.2010203@inktank.com>
References: <6035A0D088A63A46850C3988ED045A4B5C218596@BITCOM1.int.sbss.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:45968 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934052Ab3FSL6B (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 07:58:01 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so13115172ieb.10
        for <ceph-devel@vger.kernel.org>; Wed, 19 Jun 2013 04:58:01 -0700 (PDT)
In-Reply-To: <6035A0D088A63A46850C3988ED045A4B5C218596@BITCOM1.int.sbss.com.au>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Harper <james.harper@bendigoit.com.au>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 06/19/2013 05:46 AM, James Harper wrote:
> Suppose you had two classes of OSD, one fast (eg SSD's or 15K SAS drives) and the other slow (eg 7200RPM SATA drives). The fast storage is expensive so you might not have so much of it. Rather than try and map whole volumes to the best class of storage (eg fast for databases, slow for user files), it would be nice if ceph could monitor activity and move busy pg's to the fast OSD's, and move idle pg's to the slower OSD's.
>
> What I had in mind initially was a daemon external to ceph that would monitor the statistics to determine what pg's were currently being hit hard, and make decisions about placement, moving pg's around to maximise performance. As a minimum such a daemon would need access to the following information:
> . read and write count for each pg (to determine io rate)
> . class of each osd (fast/slow/etc). Ideally this would be defined as part of the osd definition but an external config file would suffice for a proof of concept.
> . an api to actually manually place pg's and not have ceph make its own decisions and move them back (this may the sticking point...)
> . a way to make sure that moving pg's didn't break the desired redundancy (tricky?)
>
> A pg with a high write rate would need the primary pg and all replica's on fast storage. A pg with low write but high read rate could have the primary on fast storage and the replica's on slow storage.
>
>  From reading the docs it seems ceph doesn't do this already. There is a reweight-by-utilization command which may give some of the same benefit.
>
> Obviously there is a cost to moving pg's around, but it should be fairly easy to balance the cost of moving vs the benefit of having the busy pg's on a fast osd. None of the decisions to move pg's would need to be made particularly quickly, and the rate at which move requests were initiated would be limited to minimise impact.
>
> Is something like this possible? Or useful? (I think it would be if you want to maximise the use of your expensive SSD's) Is a pg a small enough unit for this or too coarse?

Note:  I just woke up and haven't had coffee. :)

My thought here is that data distribution to PGs in a pool should be 
psuedo-random, so ideally all of the PGs should be getting hit more or 
less evenly if your pools are well distributed.  This doesn't always 
work out to be true all the time, but it's the general goal.  Some edge 
cases are when you are doing something like small random reads from a 
small set of objects that all just happen to be on the same PGs, but 
cache should quickly handle that with sufficient read ahead.

I think the way I would handle this would be to have multiple pools that 
target PGs on different backend hardware and have some kind of automatic 
tiering between pools.  That lets you do things like set different 
replication levels (or even erasure coding!) for each tier.  It's also 
at the object level rather than at the PG level so you aren't 
indiscriminately moving around both cold and hot data based on the 
overall PG utilization.

If you look at our roadmap, this is more or less what we are planning on 
doing:

http://www.inktank.com/about-inktank/roadmap/

Input is welcome! :)
>
> Thanks
>
> James
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

