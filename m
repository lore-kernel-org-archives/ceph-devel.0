From: Mark Nelson <mnelson@redhat.com>
Subject: Re: pg_stat_t is 500+ bytes
Date: Wed, 24 Aug 2016 11:12:24 -0500
Message-ID: <e20c13f4-ae6f-e06a-ac1b-c5736737e642@redhat.com>
References: <alpine.DEB.2.11.1608231807270.25681@piezo.us.to>
 <CACJqLyYaXy81jvFj2jiofucYLPY4cmQQtDohJwRTb5ddLzOedA@mail.gmail.com>
 <CACJqLybzJHWrVF-gOZy6nvUTb0weZJRtqt4rJBO_Nn1viBjDgw@mail.gmail.com>
 <alpine.DEB.2.11.1608241607360.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754513AbcHXQM4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 24 Aug 2016 12:12:56 -0400
In-Reply-To: <alpine.DEB.2.11.1608241607360.25681@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Haomai Wang <haomai@xsky.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 08/24/2016 11:09 AM, Sage Weil wrote:
> On Wed, 24 Aug 2016, Haomai Wang wrote:
>> On Wed, Aug 24, 2016 at 11:01 AM, Haomai Wang <haomai@xsky.com> wrote:
>>> On Wed, Aug 24, 2016 at 2:13 AM, Sage Weil <sweil@redhat.com> wrote:
>>>> This is huge.  It takes the pg_info_t str from 306 bytes to 847 bytes, and
>>>> this _info omap key is rewritten on *every* IO.
>>>>
>>>> We could shrink this down significant with varint and/or delta encoding
>>>> since a huge portion of it is just a bunch of uint64_t counters.  This
>>>> will probably cost some CPU time, but OTOH it'll also shrink our metadata
>>>> down a fair bit too which will pay off later.
>>>>
>>>> Anybody want to tackle this?
>>>
>>> what about separating "object_stat_collection_t stats" from pg_stat_t?
>>> pg info should be unchanged for most of times, we could only update
>>> object related stats. This may help to reduce half bytes.
>
> I don't think this will work, since every op changes last_update in
> pg_info_t *and* the stats (write op count, total bytes, objects, etc.).
>
>> Or we only store increment values and keep the full in memory(may
>> reduce to 20-30bytes). In period time we store the full structure(only
>> hundreds of bytes)....
>
> A delta is probably very compressible (only a few fields in the stats
> struct change).  The question is how fast can we make it in CPU time.
> Probably a simple delta (which will be almost all 0's) and a trivial
> run-length-encoding scheme that just gets rid of the 0's would do well
> enough...

Do we have any rough idea of how many/often consecutive 0s we end up 
with in the current encoding?

>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
