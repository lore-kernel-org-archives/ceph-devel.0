From: Gregory Farnum <greg@inktank.com>
Subject: Re: [PATCH v2] os/LevelDBStore: tune LevelDB data blocking options to
 be more suitable for PGStat values
Date: Tue, 16 Apr 2013 13:18:30 -0700
Message-ID: <CAPYLRzggH_LMgvJaoJ1aXHF8Q5pjc=zDiAPYdNrap5WypVhmnA@mail.gmail.com>
References: <1365180692-5233-1-git-send-email-jaschut@sandia.gov>
	<CAPYLRzhaRg42eSOyQMGKLfQoyj81CriHKfsgXb2VnGGRhY2U6g@mail.gmail.com>
	<5168636E.6030204@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:34925 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964969Ab3DPUSc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Apr 2013 16:18:32 -0400
Received: by mail-qe0-f48.google.com with SMTP id 2so511899qea.21
        for <ceph-devel@vger.kernel.org>; Tue, 16 Apr 2013 13:18:30 -0700 (PDT)
In-Reply-To: <5168636E.6030204@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jim Schutt <jaschut@sandia.gov>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Apr 12, 2013 at 12:41 PM, Jim Schutt <jaschut@sandia.gov> wrote:
> Hi Greg,
>
>
> On 04/10/2013 06:39 PM, Gregory Farnum wrote:
>> Jim,
>> I took this patch as a base for setting up config options which people
>> can tune manually and have pushed those changes to wip-leveldb-config.
>
> I was out of the office unexpectedly for a few days,
> so I'm just now taking a look.
>
>> Thanks very much for figuring out how to set up the cache et al!
>
> No problem!
>
>>
>> For now I restructured quite a bit of the data ingestion, and I took
>> your defaults for the monitor on the write buffer, block size, and
>> compression, but I left the cache off. These also don't apply to the
>> OSDs at all. In order to enable more experimentation I do pass through
>> the options though:
>> OPTION(mon_ldb_write_buffer_size, OPT_U64, 32*1024*1024) // monitor's
>> leveldb write buffer size
>> OPTION(mon_ldb_cache_size, OPT_U64, 0) // monitor's leveldb cache size
>> OPTION(mon_ldb_block_size, OPT_U64, 4*1024*1024) // monitor's leveldb block size
>> OPTION(mon_ldb_bloom_size, OPT_INT, 0) // monitor's leveldb bloom bits per entry
>> OPTION(mon_ldb_max_open_files, OPT_INT, 0) // monitor's leveldb max open files
>> OPTION(mon_ldb_compression, OPT_BOOL, false) // monitor's leveldb uses
>> compression
>> (and similar ones for osd_ldb_*).

On request from Sage these are now "*_leveldb_*" instead of "*_ldb_*";
I pushed that a couple hours ago. In case you haven't already pulled
down a copy, and so you know for when it gets into mainline and you go
to adjust it. :)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
