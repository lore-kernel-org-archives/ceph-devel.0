From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: rocksdb with jemalloc
Date: Tue, 12 May 2015 14:09:38 -0700
Message-ID: <CAFkUHxch5NDO7Fw031L=WFdzsv8zcARV_f_miVy06ByFMa6qyg@mail.gmail.com>
References: <CAFkUHxeqZGTiipGdb1voLzRGChDnumRnOgd50Ce8LjBm6eL0Hg@mail.gmail.com>
	<55516BB9.6000709@redhat.com>
	<6F3FA899187F0043BA1827A69DA2F7CC021EF61E@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35330 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbbELVJi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 17:09:38 -0400
Received: by pabtp1 with SMTP id tp1so26417355pab.2
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 14:09:38 -0700 (PDT)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC021EF61E@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Mark Nelson <mnelson@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, May 12, 2015 at 1:11 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> wrote:
> Hi Neo,
>           Did you hit the error when doing configure? The error message looks like
>                 configure: error: --with-jemalloc called with --with-librocksdb_static, turn off
>                                 --with-librocksdb-static or --with-jemalloc

Yes, this is what I am talking about.

>           This is because RocksDB use tcmalloc so we cannot build it with jemalloc.

Thats not true ? RocksDB can be made to build with jemalloc.
I will send a PR soon.

>           But if you manually clone RocksDB from facebook , compile it and install, then use ./configure --with-librocksdb --with-jemalloc, seems we can pass the build.
>

I tried this, build succeeds, however newstore keeps crashing with
this approach, I havent got around to why it crashes.

-Neo

>                                                                                                         Xiaoxi
>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
>> owner@vger.kernel.org] On Behalf Of Mark Nelson
>> Sent: Tuesday, May 12, 2015 10:56 AM
>> To: kernel neophyte; ceph-devel@vger.kernel.org
>> Subject: Re: rocksdb with jemalloc
>>
>> On 05/11/2015 08:41 PM, kernel neophyte wrote:
>> > Hi,
>> >
>> >
>> > I am trying to use newstore + rocksdb + jemalloc. Currently rocksdb in
>> > ceph compiles only with tcmalloc and not with jemalloc.
>> >
>> > Is there any reason for this limitation ?
>>
>> Heya, I'm guessing it's not by design, simply no one's tried doing it yet.  What
>> are you running into?
>>
>> >
>> > -Neo
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> > in the body of a message to majordomo@vger.kernel.org More
>> majordomo
>> > info at  http://vger.kernel.org/majordomo-info.html
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info at
>> http://vger.kernel.org/majordomo-info.html
