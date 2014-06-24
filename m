From: Gregory Farnum <greg@inktank.com>
Subject: Re: Disabling CRUSH for erasure code and doing custom placement
Date: Tue, 24 Jun 2014 09:17:44 -0700
Message-ID: <CAPYLRzjBFsb5F2_gygevP6Vjtahi0g7ZMJAaYYrTRMnLqGcQCw@mail.gmail.com>
References: <CALUBZ__98nzUjucW9NmFKEHzPFvu0yY0X5yHEtFH7g9QkhqSAQ@mail.gmail.com>
	<CAPYLRzgeb2DB_tJfRFvK1gk5XEYYd7mgHH5E5URqYsn_2bH4mQ@mail.gmail.com>
	<CALUBZ_8=KE9GGUz4KmGoRtrWXr_MVSmnNMzv9-yyUWv0W1yOQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:56745 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990AbaFXQRp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jun 2014 12:17:45 -0400
Received: by mail-qg0-f48.google.com with SMTP id q108so487650qgd.7
        for <ceph-devel@vger.kernel.org>; Tue, 24 Jun 2014 09:17:44 -0700 (PDT)
In-Reply-To: <CALUBZ_8=KE9GGUz4KmGoRtrWXr_MVSmnNMzv9-yyUWv0W1yOQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shayan Saeed <shayansaeed93@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 24, 2014 at 9:12 AM, Shayan Saeed <shayansaeed93@gmail.com> wrote:
> I assumed that creating a large number of pools might not be scalable.
> If there is no overhead in creating as many pools as I want within an
> OSD, I would probably choose this option.

There is an overhead per-PG, and pools create PGs, but OSDs expect to
hold hundreds, and can generally handle several thousands.

> I just want to specify that
> systematic chunks should be among 'a' racks while distribute others
> among 'b' racks. The only problem is that I want to do this for every
> incoming file (the k and m for erasure coded files can vary too) to
> the cluster and while there are around 10 racks, the various
> combinations might grow to be quite large which would make CRUSH map
> file huge.

Well, you specify the EC rules to use on a per-pool basis. You
*really* aren't going to be able to change this so that a pool
contains objects of different encoding schemes; the encoding is
inherent in how many OSDs are members of the PG, etc.
However, it's quite simple to specify a group of OSDs which are used
for the data chunks, and a separate group of OSDs used for the parity
chunks. Just set up separate CRUSH map roots for each, and then do
multiple take...emit steps within the rule.


> Would this affect my performance if the number of pools,
> CRUSH rules grows abnormally large?
>
> I might go for this option if there is no prohibitive trade off and/or
> changing the source code for this proves really challenging.

The source changes you're talking about will prove really challenging. ;)
-Greg

>
> Regards,
> Shayan Saeed
>
>
> On Tue, Jun 24, 2014 at 11:37 AM, Gregory Farnum <greg@inktank.com> wrote:
>> On Tue, Jun 24, 2014 at 8:29 AM, Shayan Saeed <shayansaeed93@gmail.com> wrote:
>>> Hi,
>>>
>>> CRUSH placement algorithm works really nice with replication. However,
>>> with erasure code, my cluster has some issues which require making
>>> changes that I cannot specify with CRUSH maps.
>>> Sometimes, depending on the type of data, I would like to place them
>>> on different OSDs but in the same pool.
>>
>> Why do you want to keep the data in the same pool?
>>
>>>
>>> I realize that to disable the CRUSH placement algorithm and replacing
>>> it with my own custom algorithm, such as random placement algo or any
>>> other, I have to make changes in the source code. I want to ask if
>>> there is an easy way to do this without going into every code file and
>>> looking where the mapping from objects to PG is done and changing
>>> that. Is there some configuration option which disables crush and
>>> points to my own placement algo file for doing custom placement.
>>
>> What you're asking for really doesn't sound feasible, but the thing
>> that comes closest would probably be resurrecting the "pg preferred"
>> mechanisms in CRUSH and the Ceph codebase. You'll have to go back
>> through the git history to find it, but once upon a time we supported
>> a mechanism that let you specify a specific OSD you wanted a
>> particular object to live on, and then it would place the remaining
>> replicas using CRUSH.
>> -Greg
>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>>>
>>> Let me know about the most neat way to go about it. Appreciate any
>>> help I can get.
>>>
>>> Regards,
>>> Shayan Saeed
>>> Research Assistant, Systems Research Lab
>>> University of Illinois Urbana-Champaign
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
