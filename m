From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Linking error with rocksdb
Date: Wed, 21 Sep 2016 20:36:12 +1000
Message-ID: <CAF-wwdGLGdf0t_EH=bedKSS58dj82dxroNUBx4V=rVwk_OthOg@mail.gmail.com>
References: <17b328e5-93d0-2004-f928-3331a645fc1f@digiware.nl>
 <CAF-wwdG=RCdgXZmh1qnoxthFpairjD-i1rg2_Q26Or8oLNuzVQ@mail.gmail.com> <78c336e7-17a1-4133-682e-04fefa188b3d@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35825 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756570AbcIUKgO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 06:36:14 -0400
Received: by mail-wm0-f49.google.com with SMTP id l132so259928922wmf.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 03:36:13 -0700 (PDT)
In-Reply-To: <78c336e7-17a1-4133-682e-04fefa188b3d@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: kefu chai <tchaikov@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Sep 21, 2016 at 8:29 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
>> $ git submodule update --force --init --recursive
>> $ git submodule foreach --recursive git clean -fdx
>>
>> and try building again.
>
> I will, but the complete tree was freshly fetched.
> So it really should have been all up to date.
>

That's good information to put in your OP along with platform, arch,
distro, etc.

-- 
Cheers,
Brad
