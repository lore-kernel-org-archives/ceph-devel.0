From: Gregory Farnum <greg@gregs42.com>
Subject: Re: MDS has inconsistent performance
Date: Thu, 15 Jan 2015 11:28:09 -0800
Message-ID: <CAC6JEv_1Gx3pnmutej7UmABC+eyB+VvoBo6X1OZhHFu+==6fjA@mail.gmail.com>
References: <CAD=PzH+UxcrF-0=fpAWrXsv-CB=q1nbAxbBHSn9A_P-hS1-fGg@mail.gmail.com>
	<CAC6JEv9fXSm+xEcFPiJ90kQNKjoWdFZCs02ZHKD4kJGd4_2Q8w@mail.gmail.com>
	<CAD=PzHLahg1TPu3-zjFk6hO4cXeYg+-TjdR5cw0XNSoVA+_Ebw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:49526 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbbAOT2L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Jan 2015 14:28:11 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so16812613ier.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 11:28:10 -0800 (PST)
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com. [209.85.213.179])
        by mx.google.com with ESMTPSA id j82sm1499343iod.12.2015.01.15.11.28.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 11:28:09 -0800 (PST)
Received: by mail-ig0-f179.google.com with SMTP id l13so16395100iga.0
        for <ceph-devel@vger.kernel.org>; Thu, 15 Jan 2015 11:28:09 -0800 (PST)
In-Reply-To: <CAD=PzHLahg1TPu3-zjFk6hO4cXeYg+-TjdR5cw0XNSoVA+_Ebw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Sevilla <mikesevilla3@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Can you post the full logs somewhere to look at? These bits aren't
very helpful on their own (except to say, yes, the client cleared its
I_COMPLETE for some reason).

On Tue, Jan 13, 2015 at 3:45 PM, Michael Sevilla <mikesevilla3@gmail.com> wrote:
> On Tue, Jan 13, 2015 at 11:13 AM, Gregory Farnum <greg@gregs42.com> wrote:
>> On Mon, Jan 12, 2015 at 10:17 PM, Michael Sevilla
>> <mikesevilla3@gmail.com> wrote:
>>> I can't get consistent performance with 1 MDS. I have 2 clients create
>>> 100,000 files (separate directories) in a CephFS mount. I ran the
>>> experiment 5 times (deleting the pools/fs and restarting the MDS in
>>> between each run). I graphed the metadata throughput (requests per
>>> second): https://github.com/michaelsevilla/mds/blob/master/graphs/thruput.png
>>
>> So that top line is ~20,000 processed requests/second, as measured at
>> the MDS? (Looking at perfcounters?) And the fast run is doing 10k
>> create requests/second? (This number is much higher than I expected!)
>
> Yes - top line was 20K req/s from perf counter dump and the fast run
> does about 13K creates/s. We were surprised, too... In fact, the
> performance of 1 client per MDS gives us similar performance to
> IndexFS - a system that came out in a paper at Supercomputing this
> year. Here is a throughput graph, normalized to the # of clients, that
> shows how powerful one MDS can actually be:
> https://github.com/michaelsevilla/mds/blob/master/graphs/thruput-norm.png
>
> Keep in mind that runs with more than 1 client aren't creates/s, but ops/sec. ;)
>
>>
>>> Sometimes (run0, run3), both clients issue 2 lookups per create to the
>>> MDS - this makes throughput high but the runtime long since the MDS
>>> processes many more requests.
>>> Sometimes (run2, run4), 1 client does 2 lookups per create and the
>>> other doesn't do any lookups.
>>> Sometimes (run1), neither client does any lookups - this has the
>>> fastest runtime.
>>>
>>> Does anyone know why the client behaves differently for the same exact
>>> experiment? Reading the client logs, it looks like sometimes the
>>> client enters add_update_cap() and clears the inode->flags in
>>> check_cap_issue(), then when a lookup occurs (in _lookup()), the
>>> client can't return ENOENT locally -- forcing it ask the MDS to do the
>>> lookup. But this only happens sometimes (e.g., run0 and run3).
>>
>> If you provide the logs I can check more carefully, but my guess is
>> that you've got another client mounting it, or are looking at both
>> directories from one of the clients, and this is inadvertently causing
>> them to go into shared rather than exclusive mode.
>
> I think you are right! Here is a subset of the client log:
> https://github.com/michaelsevilla/mds/blob/master/scratch/client0.log
>
> These snippets are zoomed into when the client stops sending "create,
> create, create, create..." and starts sending "lookup, lookup, create,
> lookup, lookup, create..."
>
> $ cat client0.log | grep "send_request client"
> create ...file.2098
> create ...file.2099
> create ...file.2100
> create ...file.2101
> lookup ...file.2102
> lookup ...file.2102
> create ...file.2102
> lookup ...file.2103
> lookup ...file.2103
> create ...file.2103
> lookup ...file.2104
> lookup ...file.2104
> create ...file.2104
>
> I think what you are looking for is on line 687:
> ... clearing (I_COMPLETE|I_DIR_ORDERED)
> ... add_update_cap issued pAsLsXs -> pAsLsXsFsx
>
> It looks like we lose the exclusive mode on the file... but I don't
> understand why the MDS revokes it for 1 client but not the other. The
> MDS log is here:
> https://raw.githubusercontent.com/michaelsevilla/mds/master/scratch/mds.log
>
>
>>
>> How are you trying to keep the directories private during the
>> workload? Some of the more naive solutions won't stand up to
>> repetitive testing given how various components of the system
>> currently behave.
> Is there a way to keep the directories private (i.e. keep the always
> in exclusive mode? That'd be perfect... In my runs, one client does
> mkdir /mnt/cephfs/dir0 and there other does mdkir /mnt/cephfs/dir1...
>
>>
>>>
>>> Details of the experiment:
>>> Workload: 2 clients, 100,000 creates in separate directories, using
>>> the FUSE client
>>> MDS config: client_cache_size = 100000000, mds_cache_size = 16384000
>>
>> That client_cache_size only has any effect if it's applied to the
>> client-side config. ;)
> Yes - I copy the ceph.conf to the client, too. I think it works
> because the 1 client, 1 MDS test caches all the inodes, according the
> perf counters.
>
> Thanks so much, Greg!
>
> Mike
>
>> -Greg
