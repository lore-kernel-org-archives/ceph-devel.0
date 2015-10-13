From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Initial performance cluster SimpleMessenger vs AsyncMessenger
 results
Date: Tue, 13 Oct 2015 10:52:51 -0500
Message-ID: <561D28D3.3060107@redhat.com>
References: <561BE4E3.7050404@redhat.com> <CAJ4mKGYOOgL7WPzFtkO6r12B7kL+mTekC-OUayckA2bdV7P1qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47323 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752702AbbJMPwy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 13 Oct 2015 11:52:54 -0400
In-Reply-To: <CAJ4mKGYOOgL7WPzFtkO6r12B7kL+mTekC-OUayckA2bdV7P1qg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

On 10/12/2015 11:12 PM, Gregory Farnum wrote:
> On Mon, Oct 12, 2015 at 9:50 AM, Mark Nelson <mnelson@redhat.com> wrote:
>> Hi Guy,
>>
>> Given all of the recent data on how different memory allocator
>> configurations improve SimpleMessenger performance (and the effect of memory
>> allocators and transparent hugepages on RSS memory usage), I thought I'd run
>> some tests looking how AsyncMessenger does in comparison.  We spoke about
>> these a bit at the last performance meeting but here's the full write up.
>> The rough conclusion as of right now appears to be:
>>
>> 1) AsyncMessenger performance is not dependent on the memory allocator like
>> with SimpleMessenger.
>>
>> 2) AsyncMessenger is faster than SimpleMessenger with TCMalloc + 32MB (ie
>> default) thread cache.
>>
>> 3) AsyncMessenger is consistently faster than SimpleMessenger for 128K
>> random reads.
>>
>> 4) AsyncMessenger is sometimes slower than SimpleMessenger when memory
>> allocator optimizations are used.
>>
>> 5) AsyncMessenger currently uses far more RSS memory than SimpleMessenger.
>>
>> Here's a link to the paper:
>>
>> https://drive.google.com/file/d/0B2gTBZrkrnpZS1Q4VktjZkhrNHc/view
>
> Can you clarify these tests a bit more? I can't make the number of
> nodes, OSDs, and SSDs work out properly. Were the FIO jobs 256
> concurrent ops per job, or in aggregate? Is there any more info that
> might suggest why the 128KB rand-read (but not read nor write, and not
> 4k rand-read) was so asymmetrical?
>

Hi Greg,

Resending this to the list for posterity as I realized I only sent it 
you earlier:

- 4 Nodes
- 4 P3700s per node
- 4 OSDs per P3700 (Similar to Intel's setup in Jiangang and Jian's paper)

Each node also acted as an fio client using the librbd engine:

- 4 Nodes
- 2 volumes per node
- 1 fio process per volume
- 32 concurrent IOs per fio process

The 128KB random read results are interesting.  In memory allocator 
tests I saw performance decrease with more threadcache or when TCMalloc 
was used, and in the past I've seen odd performance characteristics 
around this IO size.  I think it must be a difficult case for the memory 
allocator to handle consistently well and AsyncMesseneger maybe just 
sidesteps the problem.

Mark
