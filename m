From: Gregory Farnum <greg@gregs42.com>
Subject: Re: rbd top
Date: Tue, 16 Jun 2015 03:04:31 -0700
Message-ID: <CAC6JEv-f1CsoXZKK5etzOXeM-Kvn7y_u_ViKjsvrRz8QiGPgtQ@mail.gmail.com>
References: <CAANLjFp4+tkSj5=we88nGDFh0NtmX4jYc+sE__1N8L_4X30dfw@mail.gmail.com>
	<CAC6JEv8qB6xStrp1EL+gyDWAzVo91DvtDQKyMs9VDB2KtoVR6A@mail.gmail.com>
	<alpine.DEB.2.00.1506150647030.18741@cobra.newdream.net>
	<557EE94C.10108@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:34440 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932926AbbFPKEd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 06:04:33 -0400
Received: by igboe5 with SMTP id oe5so50948315igb.1
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 03:04:32 -0700 (PDT)
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com. [209.85.213.180])
        by mx.google.com with ESMTPSA id v3sm826475igk.1.2015.06.16.03.04.31
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2015 03:04:31 -0700 (PDT)
Received: by igbos3 with SMTP id os3so39702702igb.0
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 03:04:31 -0700 (PDT)
In-Reply-To: <557EE94C.10108@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>, "sjust@redhat.com" <sjust@redhat.com>
Cc: Sage Weil <sage@newdream.net>, Robert LeBlanc <robert@leblancnet.us>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Jun 15, 2015 at 8:03 AM, John Spray <john.spray@redhat.com> wrote:
>
>
> On 15/06/2015 14:52, Sage Weil wrote:
>>
>>
>> I seem to remember having a short conversation about something like this a
>> few CDS's back... although I think it was 'rados top'.  IIRC the basic
>> idea we had was for each OSD to track it's top clients (using some
>> approximate LRU type algorithm) and then either feed this relatively small
>> amount of info (say, top 10-100 clients) back to the mon for summation,
>> or dump via the admin socket for calamari to aggregate.
>>
>> This doesn't give you the rbd image name, but I bet we could infer that
>> without too much trouble (e.g., include a recent object or two with the
>> client).  Or, just assume that client id is enough (it'll include an IP
>> and PID... enough info to find the /var/run/ceph admin socket or the VM
>> process.
>>
>> If we were going to do top clients, I think it'd make sense to also have a
>> top objects list as well, so you can see what the hottest objects in the
>> cluster are.
>
>
> The following is a bit of a tangent...
>
> A few weeks ago I was thinking about general solutions to this problem (for
> the filesystem).  I played with (very briefly on wip-live-query) the idea of
> publishing a list of queries to the MDSs/OSDs, that would allow runtime
> configuration of what kind of thing we're interested in and how we want it
> broken down.
>
> If we think of it as an SQL-like syntax, then for the RBD case we would have
> something like:
>   SELECT read_bytes, write_bytes WHERE pool=rbd GROUP BY rbd_image
>
> (You'd need a protocol-specific module of some kind to define what
> "rbd_image" meant here, which would do a simple mapping from object
> attributes to an identifier (similar would exist for e.g. cephfs inode))
>
> Each time an OSD does an operation, it consults the list of active
> "performance queries" and updates counters according to the value of the
> GROUP BY parameter for the query (so the above example each OSD would be
> keeping a result row for each rbd image touchd).
>
> The LRU part could be implemented as LIMIT BY + SORT parameters, such that
> the result rows would be periodically sorted and the least-touched results
> would drop off the list.  That would probably be used in conjunction with a
> decay operator on the sorted-by field, like:
>   SELECT read_bytes, write_bytes,ops WHERE pool=rbd GROUP BY rbd_image SORT
> BY movingAverage(derivative(ops)) LIMIT 100
>
> Combining WHERE clauses would let the user "drill down" (apologies for
> buzzword) by doing things like identifying the most busy clients, and then
> for each of those clients identify which images/files/objects the client is
> most active on, or vice versa identify busy objects and then see which
> clients are hitting them. Usually keeping around enough stats to enable this
> is prohibitive at scale, but it's fine when you're actively creating custom
> queries for the results you're really interested in, instead of keeping
> N_clients*N_objects stats, and when you have the LIMIT part to ensure
> results never get oversized.
>
> The GROUP BY options would also include metadata sent from clients, e.g. the
> obvious cases like VM instance names, or rack IDs, or HPC job IDs.  Maybe
> also some less obvious ones like decorating cephfs IOs with the inode of the
> directory containing the file, so that OSDs could accumulate per-directory
> bandwidth numbers, and user could ask "which directory is
> bandwidth-hottest?" as well as "which file is bandwidth-hottest?".
>
> Then, after implementing all that craziness, you get some kind of wild
> multicolored GUI that shows you where the action is in your system at a
> cephfs/rgw/rbd level.

I *like* that idea. We should discuss with Sam before doing too much
though as I know he's thought about various online computations in
RADOS before. Something like this is also interesting in comparison to
our long-theorized "PG classes", etc.
-Greg
