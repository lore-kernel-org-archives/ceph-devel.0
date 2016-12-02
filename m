From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: Computation in the storage
Date: Fri, 2 Dec 2016 21:49:18 +1000
Message-ID: <CAF-wwdHPXaX3fe+dk9ovdAfc00N5xQrzj2TaRAuBOjH77L4yDg@mail.gmail.com>
References: <26283_1480676624_58415510_26283_122_1_EBBC07637B509B40B2E594A11E62C54F022DA808@OPEXCLILM32.corporate.adroot.infra.ftgroup>
 <d8129d7a-af37-ad74-38c8-f5a9d59f183b@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38017 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758128AbcLBLtV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Dec 2016 06:49:21 -0500
Received: by mail-wm0-f44.google.com with SMTP id f82so13423033wmf.1
        for <ceph-devel@vger.kernel.org>; Fri, 02 Dec 2016 03:49:20 -0800 (PST)
In-Reply-To: <d8129d7a-af37-ad74-38c8-f5a9d59f183b@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao@suse.de>
Cc: nebil.benmabrouk@orange.com, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Dec 2, 2016 at 9:40 PM, Joao Eduardo Luis <joao@suse.de> wrote:
> On 12/02/2016 11:03 AM, nebil.benmabrouk@orange.com wrote:
>>
>> Hello,
>>
>> I  am interested in embedding some specific data processing in the storage
>> close to the data.
>> I read that, we can integrate some code (e.g., java classes) in Ceph, but
>> I find no documentation about it.
>
>
> What you are looking is actually 'rados object classes' (or ceph classes,
> according to the docs), and you may find a brief remark about that here
>
>  http://docs.ceph.com/docs/master/architecture/#extending-ceph
>
> which contains pointers to the code you should look into.
>
> Somehow it feels like there should be some more information about this
> somewhere, but I can't really recall where.

Hmmm... that needs updating. Any takers?

Look at the following.

src/objclass/objclass.h
src/test/fooclass.cc
src/test/barclass.cc

All the code below src/cls/, especially "hello".

>
>   -Joao
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
