From: Mohamad Gebai <mgebai@suse.com>
Subject: Re: Bug 19198: Double the memory caused by page alignment
Date: Thu, 29 Jun 2017 17:11:06 -0400
Message-ID: <3822b2e0-69b2-1213-ff9e-bb5f576dc43f@suse.com>
References: <39ba1efe-0c32-249a-8bea-183a1eab13b2@suse.com>
 <alpine.DEB.2.11.1706291920450.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:37630 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753347AbdF2VLV (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Thu, 29 Jun 2017 17:11:21 -0400
In-Reply-To: <alpine.DEB.2.11.1706291920450.3424@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage,

On 06/29/2017 03:25 PM, Sage Weil wrote:
> On Thu, 29 Jun 2017, Mohamad Gebai wrote:
>> If the page-aligned allocations are large, and if they are sparse (ie.
>> there are random smaller non-page-aligned allocations in between), the
>> heap is much less fragmented, and it won't seem like the memory is
>> wasted. Does that seem like a reasonable hypothesis or did I completely
>> misunderstand the bug report?
> This all sounds right.
>
> The problem is that it is common and expected for bluestore to ask for a 
> 4kb page-aligned buffer.  There is the 4kb aligned allocation for the 
> buffer itself, and there is the small buffer::raw tracking struct 
> with the ref count and so on.  This should end up consuming 4kb + a little 
> bit, not 8kb.

Right, 4kb for the data and a few extra bytes for the rest. So in total,
two pages are touched and accounted for the process for each
page-aligned allocation.

> First, it would be good to confirm the allocator actually does behave this 
> way.  (Ick.)

I was able to reproduce this quite easily outside of Ceph, if you're
interested the code is here:
https://github.com/mogeb/utils/tree/master/mempool. This is simply a
standalone version of the attachment in the tracker. The output of the
program is as follows:

Mem before2: VmRSS:       10900 kB
Mem after2: VmRSS:     8399680 kB
Mem actually used: 8590110720 bytes
Mem that should be used: 4294967296 bytes
Difference: 4295143424 bytes, 4.00016 gb

Also, preloading libtcmalloc makes this behavior disappear (at least for
this program), which confirms further the hypothesis, since tcmalloc
does larger allocations internally.

Mohamad


