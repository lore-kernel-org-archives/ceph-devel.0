From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Linking error with rocksdb
Date: Wed, 21 Sep 2016 13:38:59 +0200
Message-ID: <a703a996-11c7-815c-c991-9fa4dbec5b64@digiware.nl>
References: <17b328e5-93d0-2004-f928-3331a645fc1f@digiware.nl>
 <CAF-wwdG=RCdgXZmh1qnoxthFpairjD-i1rg2_Q26Or8oLNuzVQ@mail.gmail.com>
 <78c336e7-17a1-4133-682e-04fefa188b3d@digiware.nl>
 <CAF-wwdGLGdf0t_EH=bedKSS58dj82dxroNUBx4V=rVwk_OthOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:32371 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933502AbcIULjF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 21 Sep 2016 07:39:05 -0400
In-Reply-To: <CAF-wwdGLGdf0t_EH=bedKSS58dj82dxroNUBx4V=rVwk_OthOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 21-9-2016 12:36, Brad Hubbard wrote:
> On Wed, Sep 21, 2016 at 8:29 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>> $ git submodule update --force --init --recursive
>>> $ git submodule foreach --recursive git clean -fdx
>>>
>>> and try building again.
>>
>> I will, but the complete tree was freshly fetched.
>> So it really should have been all up to date.
>>
> 
> That's good information to put in your OP along with platform, arch,
> distro, etc.
> 
Sorry,

I've been spamming this list for FreeBSD issues so much, I forgot to add
this:

FreeBSD 11.0 / amd64
Clang 3.8.0
binutils 2.25.1

So it is not your std-run-of-the-mill problem. 8-D

--WjW

