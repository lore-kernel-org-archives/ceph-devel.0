From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Linking error with rocksdb
Date: Wed, 21 Sep 2016 12:29:59 +0200
Message-ID: <78c336e7-17a1-4133-682e-04fefa188b3d@digiware.nl>
References: <17b328e5-93d0-2004-f928-3331a645fc1f@digiware.nl>
 <CAF-wwdG=RCdgXZmh1qnoxthFpairjD-i1rg2_Q26Or8oLNuzVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:63611 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757083AbcIUKaH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Sep 2016 06:30:07 -0400
In-Reply-To: <CAF-wwdG=RCdgXZmh1qnoxthFpairjD-i1rg2_Q26Or8oLNuzVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 21-9-2016 11:11, Brad Hubbard wrote:
> On Wed, Sep 21, 2016 at 6:51 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> Hi,
>>
>> I think I had something like this before, but cannot find it in my Email
>> archive...
>>
>> I'm trying to build head, which works for a long way, but it gets into
>> trouble when linking ceph-mon. Errors out on not being able to find some
>> of the references in librocksdb...
>>
>> librocksdb.a is recent:
>>> ll src/rocksdb/librocksdb.a
> 
> rocksdb can be problematic, try this...
> 
> $ git submodule update --force --init --recursive
> $ git submodule foreach --recursive git clean -fdx
> 
> and try building again.

I will, but the complete tree was freshly fetched.
So it really should have been all up to date.

Thanx,
--WjW


