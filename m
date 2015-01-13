From: Gregory Farnum <greg@gregs42.com>
Subject: Re: MDS has inconsistent performance
Date: Tue, 13 Jan 2015 11:13:41 -0800
Message-ID: <CAC6JEv9fXSm+xEcFPiJ90kQNKjoWdFZCs02ZHKD4kJGd4_2Q8w@mail.gmail.com>
References: <CAD=PzH+UxcrF-0=fpAWrXsv-CB=q1nbAxbBHSn9A_P-hS1-fGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:37731 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbbAMTNm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Jan 2015 14:13:42 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so4652225iec.1
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jan 2015 11:13:42 -0800 (PST)
Received: from mail-ie0-f175.google.com (mail-ie0-f175.google.com. [209.85.223.175])
        by mx.google.com with ESMTPSA id j82sm10752627iod.12.2015.01.13.11.13.41
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 Jan 2015 11:13:41 -0800 (PST)
Received: by mail-ie0-f175.google.com with SMTP id x19so4628398ier.6
        for <ceph-devel@vger.kernel.org>; Tue, 13 Jan 2015 11:13:41 -0800 (PST)
In-Reply-To: <CAD=PzH+UxcrF-0=fpAWrXsv-CB=q1nbAxbBHSn9A_P-hS1-fGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Michael Sevilla <mikesevilla3@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Jan 12, 2015 at 10:17 PM, Michael Sevilla
<mikesevilla3@gmail.com> wrote:
> I can't get consistent performance with 1 MDS. I have 2 clients create
> 100,000 files (separate directories) in a CephFS mount. I ran the
> experiment 5 times (deleting the pools/fs and restarting the MDS in
> between each run). I graphed the metadata throughput (requests per
> second): https://github.com/michaelsevilla/mds/blob/master/graphs/thruput.png

So that top line is ~20,000 processed requests/second, as measured at
the MDS? (Looking at perfcounters?) And the fast run is doing 10k
create requests/second? (This number is much higher than I expected!)

> Sometimes (run0, run3), both clients issue 2 lookups per create to the
> MDS - this makes throughput high but the runtime long since the MDS
> processes many more requests.
> Sometimes (run2, run4), 1 client does 2 lookups per create and the
> other doesn't do any lookups.
> Sometimes (run1), neither client does any lookups - this has the
> fastest runtime.
>
> Does anyone know why the client behaves differently for the same exact
> experiment? Reading the client logs, it looks like sometimes the
> client enters add_update_cap() and clears the inode->flags in
> check_cap_issue(), then when a lookup occurs (in _lookup()), the
> client can't return ENOENT locally -- forcing it ask the MDS to do the
> lookup. But this only happens sometimes (e.g., run0 and run3).

If you provide the logs I can check more carefully, but my guess is
that you've got another client mounting it, or are looking at both
directories from one of the clients, and this is inadvertently causing
them to go into shared rather than exclusive mode.

How are you trying to keep the directories private during the
workload? Some of the more naive solutions won't stand up to
repetitive testing given how various components of the system
currently behave.

>
> Details of the experiment:
> Workload: 2 clients, 100,000 creates in separate directories, using
> the FUSE client
> MDS config: client_cache_size = 100000000, mds_cache_size = 16384000

That client_cache_size only has any effect if it's applied to the
client-side config. ;)
-Greg
