From: Aleksei Gutikov <aleksey.gutikov@synesis.ru>
Subject: Re: rgw: possibility to put several small S3 objects into single
 rados object
Date: Wed, 27 Dec 2017 20:15:06 +0300
Message-ID: <c2a2f6fd-4394-8155-7e80-5daf62f1e25c@synesis.ru>
References: <094c2abd-b861-3fcd-7b5c-176d23beed0c@synesis.ru>
 <robbat2-20171223T012457-622692797Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:43508 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdL0RPJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Dec 2017 12:15:09 -0500
Received: by mail-lf0-f43.google.com with SMTP id o26so28708809lfc.10
        for <ceph-devel@vger.kernel.org>; Wed, 27 Dec 2017 09:15:08 -0800 (PST)
In-Reply-To: <robbat2-20171223T012457-622692797Z@orbis-terrarum.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: zhang.david2011@gmail.com

I'm testing currently very simple implementation
that stores content in custom xattr (as I understand xattrs lay in same
key-value storage as omap)
Most objects are less than 8k.
Initial intention was to eliminate crashes of allocator like this 
http://tracker.ceph.com/issues/22510
I expected that if there will be only key-values it will be somehow 
easier for allocator.
And reduce space overhead of cause.
In current test at least S3 latency decreased by 30%.
I'll tell if this approach will show any useful results.



On 12/23/2017 04:38 AM, Robin H. Johnson wrote:
> On Thu, Dec 21, 2017 at 07:35:26PM +0300, Aleksei Gutikov wrote:
>> Hi all.
>>
>> While rgw bucket index, theoretically, with reasonable latency can
>> handle up to 10M objects (100 shards of 100k each),
>> and rgw user's bucket index can handle, theoretically again, up to 100k
>> buckets.
> One of the scaling concerns I'd talked about before was bucket indices:
> even with shards as you note, performance of large buckets isn't great.
> I have pondered about how to redesign the index for performance, and one
> of the better performing options I decided at least for the moment was
> probably going to be via multiple levels of index.
> 
>> Or, maybe it is possible to store small pieces of data in omap?
>> As I understand space overhead would be much smaller in this case.
>> And what about backfilling and remapping for omap?
> I'd go for the OMAP rather than packing into a single RADOS object.
> However, how small are you talking about?
> Beyond 128 bytes I think it would still be better in an object.
> 

-- 

Best regards,
Aleksei Gutikov
Software Engineer | synesis.ru | Minsk. BY
