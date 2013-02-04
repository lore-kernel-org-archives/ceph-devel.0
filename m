From: Mark Kampe <mark.kampe@inktank.com>
Subject: Re: some performance issue
Date: Mon, 04 Feb 2013 09:29:26 -0800
Message-ID: <510FEFF6.7010709@inktank.com>
References: <CAB7xdinwhd6gmqbzeC7Gp+ugDbJhOcr1TwX-1KYg5=geWbT0+g@mail.gmail.com> <510C2F49.8010401@inktank.com> <CAB7xdi=y-n0P=vptiO-LvRUF7pcuqe1gJVwRtDkWbi+K7U=u8Q@mail.gmail.com> <6F3FA899187F0043BA1827A69DA2F7CC5ECFFC@SHSMSX102.ccr.corp.intel.com> <CAB7xdinzWjS7PfWCf+3HLby7DYVr4Yz21C1WLV6Fa=6CwzjTOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:52845 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab3BDR3a (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 12:29:30 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so4969469ieb.39
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 09:29:28 -0800 (PST)
In-Reply-To: <CAB7xdinzWjS7PfWCf+3HLby7DYVr4Yz21C1WLV6Fa=6CwzjTOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Writes are intrinsically more expensive (in both the file
system and hardware) but it is not uncommon for individual
small random writes to substantially outperform reads even
if O_DIRECT.

If the I/O is not massively parallel, reads are going to be
processed one at a time (e.g. ~6ms seek, ~4ms latency, and
27us transfer).  Writes, however, are commonly accepted by
the drive and then queued, enabling the drive to choose among
the competing requests to significantly (e.g. 2-3x) reduce
both average seek time and rotational latency.

If the I/O is being buffered, the performance advantages for
random writes can be even greater (due to a deeper request
queue and potential request aggregation).  Isolated random
reads (with few cache hits) get a much smaller performance
boost (if any) from buffered I/O.

With massively parallel requests, however, the write
advantage should evaporate.

On 02/04/2013 09:15 AM, sheng qiu wrote:
> Hi Xiaoxi,
>
> thanks for your reply.
>
> On Mon, Feb 4, 2013 at 10:52 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
>> I doubt your data is correct ,even the ext4 data, have you use O_DIRECT when doing the test? It's unusual to have 2X random write IOPS than random read.
>>
>
>   i did not use O_DIRECT. so page cache is used during the test.
> one thing i guess why random write is better than random read is that
> since the io request size is 4KB, so for each write request if miss on
> page cache, it will allocate a new page and write the complete 4KB
> dirty data there (since no partitional writes, no need to fetch the
> missed data from OSDs). While for read requests, it has to wait until
> the data are fetched from the OSDs.
