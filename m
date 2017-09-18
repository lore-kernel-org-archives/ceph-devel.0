From: =?UTF-8?B?5YWz5LqR6aOe?= <gyfelectric@gmail.com>
Subject: Re: There is a big risk in function bufferlist::claim_prepend()
Date: Mon, 18 Sep 2017 20:00:40 +0800
Message-ID: <CAF3FU87581w6JNr8GoQ1_Sx0Zs0gynxCsyB83wTTXZZ4BM+j3g@mail.gmail.com>
References: <350174ad-7e1d-4ab8-b149-0762e91d19e8@me.com> <CAJE9aOPEAV8POJTSo2BZxGLYdsTe6Vu9zdwS6MuogFRjc+9FzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35835 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753887AbdIRMAm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 08:00:42 -0400
Received: by mail-lf0-f67.google.com with SMTP id c8so168467lfe.2
        for <ceph-devel@vger.kernel.org>; Mon, 18 Sep 2017 05:00:41 -0700 (PDT)
In-Reply-To: <CAJE9aOPEAV8POJTSo2BZxGLYdsTe6Vu9zdwS6MuogFRjc+9FzA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: kefu chai <tchaikov@gmail.com>
Cc: =?UTF-8?B?5YWz5LqR6aOe?= <seven.guanyunfei@icloud.com>, Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I agree with that point that would hurts the performance and
i removed the step of 1-3, please help to review.
But the kind of situation you said should not appear.
If we realloc a mem chunk to replace the first memory ptr with it
when do claim_prepend every time the ptr of bufferslit will not exist
bubbles except for the first ptr.

2017-09-18 16:57 GMT+08:00 kefu chai <tchaikov@gmail.com>:
> On Mon, Sep 18, 2017 at 2:41 PM, =E5=85=B3=E4=BA=91=E9=A3=9E <seven.guany=
unfei@icloud.com> wrote:
>>
>> hello kefu chai,
>>
>>
>> These two days I carefully considered the pr https://github.com/ceph/cep=
h/pull/17661 and looked the code about bufferlist and I still think the ste=
ps of 1-3
>> is needed. Although the ptr::_off can guarantee bufferlist to be copied/=
read/decode/write_file rightly, this will lead a bufferlist not clean and w=
ill waste memory
>> like picture below.
>>
>> Of course, it's also possible that i am not thinking about it, do you ha=
ve any suggestions?
>
> i think it's the user of the bufferlist's choice to defrag the
> element(s) in it or not. and it's not a pure win: it hurts the
> performance in some cases. in the case of PR#17661, we are trying to
> realloc a smaller mem chunk to replace the first memory ptr with it,
> if it has "bubbles". what about the second element, or the third one
> in the buffer::list, shall we also take care of them as well?
>
> --
> Regards
> Kefu Chai
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
