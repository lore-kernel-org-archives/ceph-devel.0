From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: [PATCH v2] os/LevelDBStore: tune LevelDB data blocking
 options to be more suitable for PGStat values
Date: Fri, 12 Apr 2013 13:41:34 -0600
Message-ID: <5168636E.6030204@sandia.gov>
References: <1365180692-5233-1-git-send-email-jaschut@sandia.gov>
 <CAPYLRzhaRg42eSOyQMGKLfQoyj81CriHKfsgXb2VnGGRhY2U6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:44407 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296Ab3DLTmO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Apr 2013 15:42:14 -0400
In-Reply-To: <CAPYLRzhaRg42eSOyQMGKLfQoyj81CriHKfsgXb2VnGGRhY2U6g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Greg,


On 04/10/2013 06:39 PM, Gregory Farnum wrote:
> Jim,
> I took this patch as a base for setting up config options which people
> can tune manually and have pushed those changes to wip-leveldb-config.

I was out of the office unexpectedly for a few days,
so I'm just now taking a look.

> Thanks very much for figuring out how to set up the cache et al!

No problem!

> 
> For now I restructured quite a bit of the data ingestion, and I took
> your defaults for the monitor on the write buffer, block size, and
> compression, but I left the cache off. These also don't apply to the
> OSDs at all. In order to enable more experimentation I do pass through
> the options though:
> OPTION(mon_ldb_write_buffer_size, OPT_U64, 32*1024*1024) // monitor's
> leveldb write buffer size
> OPTION(mon_ldb_cache_size, OPT_U64, 0) // monitor's leveldb cache size
> OPTION(mon_ldb_block_size, OPT_U64, 4*1024*1024) // monitor's leveldb block size
> OPTION(mon_ldb_bloom_size, OPT_INT, 0) // monitor's leveldb bloom bits per entry
> OPTION(mon_ldb_max_open_files, OPT_INT, 0) // monitor's leveldb max open files
> OPTION(mon_ldb_compression, OPT_BOOL, false) // monitor's leveldb uses
> compression
> (and similar ones for osd_ldb_*).
> 
> If you have the opportunity to verify that these patches work for you
> (in particular I'm wondering if the OSDs need any more tuning on their
> end which was being masked by your global changes) that would be
> wonderful. :)

I'll be able to take these for a spin next Tuesday, and I'll definitely
keep an eye open for any unexpected behavior on the OSDs.  Sorry for
the delay...

I appreciate you taking a look at this, and fixing it up into
something that's more appropriate.

Thanks --Jim

> Thanks,
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> 
> 


