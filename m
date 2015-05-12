From: kernel neophyte <neophyte.hacker001@gmail.com>
Subject: Re: rocksdb with jemalloc
Date: Tue, 12 May 2015 14:07:13 -0700
Message-ID: <CAFkUHxdQAC-FM6-zEz-3wpMtQY9q1ka1eehFnZYcmg9vr68s9w@mail.gmail.com>
References: <CAFkUHxeqZGTiipGdb1voLzRGChDnumRnOgd50Ce8LjBm6eL0Hg@mail.gmail.com>
	<55516BB9.6000709@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35717 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933128AbbELVHO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 17:07:14 -0400
Received: by pabtp1 with SMTP id tp1so26352357pab.2
        for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 14:07:13 -0700 (PDT)
In-Reply-To: <55516BB9.6000709@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mnelson@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, May 11, 2015 at 7:55 PM, Mark Nelson <mnelson@redhat.com> wrote:
> On 05/11/2015 08:41 PM, kernel neophyte wrote:
>>
>> Hi,
>>
>>
>> I am trying to use newstore + rocksdb + jemalloc. Currently rocksdb in
>> ceph compiles only with tcmalloc and not with jemalloc.
>>
>> Is there any reason for this limitation ?
>
>
> Heya, I'm guessing it's not by design, simply no one's tried doing it yet.
> What are you running into?
>
I run into configure: error: --with-jemalloc called with
--with-librocksdb_static, turn off
                                --with-librocksdb-static or --with-jemalloc

I do not see why  --with-librocksdb-static cannot be called --with-jemalloc

I pulled in changes from mainline rocksdb, I am testing it out, I will
send out a pull request to enable -with-librocksdb-static
--with-jemalloc

-Neo

>>
>> -Neo
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
