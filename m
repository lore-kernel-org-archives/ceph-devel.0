From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Linking error with rocksdb
Date: Thu, 22 Sep 2016 12:00:49 +0200
Message-ID: <fbc8c9aa-664c-9a38-fcb8-2d834980dac2@digiware.nl>
References: <17b328e5-93d0-2004-f928-3331a645fc1f@digiware.nl>
 <CAF-wwdG=RCdgXZmh1qnoxthFpairjD-i1rg2_Q26Or8oLNuzVQ@mail.gmail.com>
 <78c336e7-17a1-4133-682e-04fefa188b3d@digiware.nl>
 <CAF-wwdGLGdf0t_EH=bedKSS58dj82dxroNUBx4V=rVwk_OthOg@mail.gmail.com>
 <a703a996-11c7-815c-c991-9fa4dbec5b64@digiware.nl>
 <20160922030056.GE6020@rskikr.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:31755 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753566AbcIVKA6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Sep 2016 06:00:58 -0400
In-Reply-To: <20160922030056.GE6020@rskikr.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 22-9-2016 05:00, Brad Hubbard wrote:
> On Wed, Sep 21, 2016 at 9:38 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> On 21-9-2016 12:36, Brad Hubbard wrote:
>>> On Wed, Sep 21, 2016 at 8:29 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>>> $ git submodule update --force --init --recursive
>>>>> $ git submodule foreach --recursive git clean -fdx
>>>>>
>>>>> and try building again.
>>>>
>>>> I will, but the complete tree was freshly fetched.
>>>> So it really should have been all up to date.
>>>>
>>>
>>> That's good information to put in your OP along with platform, arch,
>>> distro, etc.
>>>
>> Sorry,
>>
>> I've been spamming this list for FreeBSD issues so much, I forgot to add
>> this:
>>
>> FreeBSD 11.0 / amd64
>> Clang 3.8.0
>> binutils 2.25.1
> 
> Ahh, I didn't recognise the email address but, now that you mention it...
> 
>>
>> So it is not your std-run-of-the-mill problem. 8-D
> 
> If this is specific to FreeBSD then I'm not sure I can be much help I'm afraid.

Found the problem in the mean time.

I had a package of rocksdb installed that does not have those calls (yet).
So now I have to figure out how I get -I/usr/local/include as last
resort on the compiler commandline.

--WjW


