From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Linking error with rocksdb
Date: Thu, 22 Sep 2016 13:00:56 +1000
Message-ID: <20160922030056.GE6020@rskikr.localdomain>
References: <17b328e5-93d0-2004-f928-3331a645fc1f@digiware.nl>
 <CAF-wwdG=RCdgXZmh1qnoxthFpairjD-i1rg2_Q26Or8oLNuzVQ@mail.gmail.com>
 <78c336e7-17a1-4133-682e-04fefa188b3d@digiware.nl>
 <CAF-wwdGLGdf0t_EH=bedKSS58dj82dxroNUBx4V=rVwk_OthOg@mail.gmail.com>
 <a703a996-11c7-815c-c991-9fa4dbec5b64@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33736 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933890AbcIVDBK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 23:01:10 -0400
Received: by mail-pf0-f177.google.com with SMTP id 21so25494911pfy.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 20:01:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a703a996-11c7-815c-c991-9fa4dbec5b64@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 21, 2016 at 9:38 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 21-9-2016 12:36, Brad Hubbard wrote:
>> On Wed, Sep 21, 2016 at 8:29 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>>>> $ git submodule update --force --init --recursive
>>>> $ git submodule foreach --recursive git clean -fdx
>>>>
>>>> and try building again.
>>>
>>> I will, but the complete tree was freshly fetched.
>>> So it really should have been all up to date.
>>>
>>
>> That's good information to put in your OP along with platform, arch,
>> distro, etc.
>>
> Sorry,
>
> I've been spamming this list for FreeBSD issues so much, I forgot to add
> this:
>
> FreeBSD 11.0 / amd64
> Clang 3.8.0
> binutils 2.25.1

Ahh, I didn't recognise the email address but, now that you mention it...

>
> So it is not your std-run-of-the-mill problem. 8-D

If this is specific to FreeBSD then I'm not sure I can be much help I'm afraid.

>
> --WjW
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
