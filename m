From: Mark Nelson <mnelson@redhat.com>
Subject: Re: bluestore onode diet and encoding overhead
Date: Tue, 12 Jul 2016 10:37:39 -0500
Message-ID: <47766d61-03f4-b55b-6d08-c090747c54b6@redhat.com>
References: <9b80fe95-9da5-bffe-c869-a7ba51da70b3@redhat.com>
 <BLUPR0201MB1524775973993917A1A59078E8300@BLUPR0201MB1524.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33406 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932331AbcGLPhm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 Jul 2016 11:37:42 -0400
In-Reply-To: <BLUPR0201MB1524775973993917A1A59078E8300@BLUPR0201MB1524.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>



On 07/12/2016 10:20 AM, Allen Samuels wrote:
> Good analysis.
>
> My original comments about putting the oNode on a diet included the idea of a "custom" encode/decode path for certain high-usage cases. At the time, Sage resisted going down that path hoping that a more optimized generic case would get the job done. Your analysis shows that while we've achieved significant space reduction this has come at the expense of CPU time -- which dominates small object performance (I suspect that eventually we'd discover that the variable length decode path would be responsible for a substantial read performance degradation also -- which may or may not be part of the read performance drop-off that you're seeing). This isn't a surprising result, though it is unfortunate.
>
> I believe we need to revisit the idea of custom encode/decode paths for high-usage cases, only now the gains need to be focused on CPU utilization as well as space efficiency.

I'm not against it, but it might be worth at least a quick attempt at 
preallocating the append_buffer and/or Piotr's idea to directly memcpy 
without doing the append at all.  It may be that helps quite a bit 
(though perhaps it's not enough in the long run).

A couple of other thoughts:

I still think SIMD encode approaches are interesting if we can lay data 
out in memory in a friendly way (This feels like it might be painful 
though):

http://arxiv.org/abs/1209.2137

But on the other hand, Kenton Varda who was previously a primary author 
on google's protocol buffers ended up doing something a little different 
than varint:

https://capnproto.org/encoding.html

Look specifically at the packing section.  It looks somewhat attractive 
to me.

Mark

>
> I believe this activity can also address some of the memory consumption issues that we're seeing now. I believe that the current lextent/blob/pextent usage of standard STL maps is both space and time inefficient -- in a place where it matters a lot. Sage has already discussed usage of something like flat_map from the boost library as a way to reduce the memory overhead, etc. I believe this is the right direction.
>
> Where are we on getting boost into our build?
>
> Allen Samuels
> SanDisk |a Western Digital brand
> 2880 Junction Avenue, Milpitas, CA 95134
> T: +1 408 801 7030| M: +1 408 780 6416
> allen.samuels@SanDisk.com
>
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: Tuesday, July 12, 2016 12:03 AM
>> To: ceph-devel <ceph-devel@vger.kernel.org>
>> Subject: bluestore onode diet and encoding overhead
>>
>> Hi All,
>>
>> With Igor's patch last week I was able to get some bluestore performance
>> runs in without segfaulting and started looking int the results.
>> Somewhere along the line we really screwed up read performance, but
>> that's another topic.  Right now I want to focus on random writes.
>> Before we put the onode on a diet we were seeing massive amounts of read
>> traffic in RocksDB during compaction that caused write stalls during 4K
>> random writes.  Random write performance on fast hardware like NVMe
>> devices was often below filestore at anything other than very large IO sizes.
>> This was largely due to the size of the onode compounded with RocksDB's
>> tendency toward read and write amplification.
>>
>> The new test results look very promising.  We've dramatically improved
>> performance of random writes at most IO sizes, so that they are now
>> typically quite a bit higher than both filestore and older bluestore code.
>> Unfortunately for very small IO sizes performance hasn't improved much.
>> We are no longer seeing huge amounts of RocksDB read traffic and fewer
>> write stalls.  We are however seeing huge memory usage (~9GB RSS per
>> OSD) and very high CPU usage.  I think this confirms some of the memory
>> issues somnath was continuing to see.  I don't think it's a leak exactly based
>> on how the OSDs were behaving, but we need to run through massif still to
>> be sure.
>>
>> I ended up spending some time tonight with perf and digging through the
>> encode code.  I wrote up some notes with graphs and code snippets and
>> decided to put them up on the web.  Basically some of the encoding changes
>> we implemented last month to reduce the onode size also appear to result in
>> more buffer::list appends and the associated overhead.
>> I've been trying to think through ways to improve the situation and thought
>> other people might have some ideas too.  Here's a link to the short writeup:
>>
>> https://drive.google.com/file/d/0B2gTBZrkrnpZeC04eklmM2I4Wkk/view?us
>> p=sharing
>>
>> Thanks,
>> Mark
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
