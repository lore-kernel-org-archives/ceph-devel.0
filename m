From: David Zafman <dzafman@redhat.com>
Subject: Re: Error handling during recovery read
Date: Fri, 4 Dec 2015 18:24:46 -0800
Message-ID: <56624AEE.7020605@redhat.com>
References: <DUB403-EAS1052ED1A42AB6DFDA68D8BD50C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59057 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753247AbbLECYs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Dec 2015 21:24:48 -0500
In-Reply-To: <DUB403-EAS1052ED1A42AB6DFDA68D8BD50C0@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Markus Blank-Burian <burian@muenster.de>
Cc: 'Ceph Development' <ceph-devel@vger.kernel.org>



I can't remember the details now, but I know that recovery needed 
additional work.   If it were a simple fix
I would have done it when implementing that code.

I found this bug related to recovery and ec errors 
(http://tracker.ceph.com/issues/13493)
BUG #13493: osd: for ec, cascading crash during recovery if one shard is 
corrupted

David

On 12/4/15 2:03 AM, Markus Blank-Burian wrote:
> Hi David,
>
>   
>
> I am using ceph 9.2.0 with an erasure coded pool and have some problems with
> missing objects.
>
>   
>
> Reads for degraded/backfilling objects on an EC pool, which detect an error
> (-2 in my case) seem to be aborted immediately instead of reading from the
> remaining shards. Why is there an explicit check for "!rop.for_recovery" in
> ECBackend::handle_sub_read_reply? Would it be possible to remove this check
> and let the recovery read be completed from the remaining good shards?
>
>   
>
> Markus
>
>   
>
>

