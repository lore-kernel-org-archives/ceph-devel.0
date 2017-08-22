From: Linux Chips <linux.chips@gmail.com>
Subject: Re: High memory usage kills OSD while peering
Date: Tue, 22 Aug 2017 11:37:19 +0300
Message-ID: <bde9c53e-1847-c21c-a814-7645e0b4ef09@gmail.com>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com>
 <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com>
 <15fa2de0-27ad-cc51-6a6c-f306b9f330d2@gmail.com>
 <59f1de4f-9d5a-323d-2d13-cf5a4cee6f34@gmail.com>
 <CACJqLyYASEkirVm1=o9Ltw+m-YkT7bqJsS554Q4M38dfOEWwgw@mail.gmail.com>
 <93debf2d-12cb-eceb-e9cd-5226ad49cc16@gmail.com>
 <CACJqLyaHC03P6o+MmMFCgk4-_GYxsOs4B6UVFLK6fXZVt53SCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38265 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932132AbdHVIhW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Aug 2017 04:37:22 -0400
Received: by mail-wr0-f193.google.com with SMTP id k10so8733558wre.5
        for <ceph-devel@vger.kernel.org>; Tue, 22 Aug 2017 01:37:21 -0700 (PDT)
In-Reply-To: <CACJqLyaHC03P6o+MmMFCgk4-_GYxsOs4B6UVFLK6fXZVt53SCQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/21/2017 06:18 PM, Haomai Wang wrote:
> from your previous mail, not dive into too much. but do you try ms
> type = simple to see? although I don't find any obvious thing to do
> this.
> 
> On Mon, Aug 21, 2017 at 11:14 PM, Linux Chips <linux.chips@gmail.com> wrote:
>> we tried it, same thing. we lowered it to "2" along with other osd_map*
>> values, little better, but we still get alot of oom kills and unable to
>> fully start the cluster.
>> we need to squeeze more memory out of those OSD.
>>
>>
>> On 08/21/2017 04:07 PM, Haomai Wang wrote:
>>
>> do you try to lower osd_map_cache_size = 20 ?
>>
>> On Mon, Aug 21, 2017 at 6:57 PM, Linux Chips <linux.chips@gmail.com> wrote:
>>
we did try the "ms type = simple". not that difference.
