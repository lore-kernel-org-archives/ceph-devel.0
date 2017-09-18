From: kefu chai <tchaikov@gmail.com>
Subject: Re: There is a big risk in function bufferlist::claim_prepend()
Date: Mon, 18 Sep 2017 16:57:08 +0800
Message-ID: <CAJE9aOPEAV8POJTSo2BZxGLYdsTe6Vu9zdwS6MuogFRjc+9FzA@mail.gmail.com>
References: <350174ad-7e1d-4ab8-b149-0762e91d19e8@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:45771 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbdIRI5J (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 04:57:09 -0400
Received: by mail-io0-f175.google.com with SMTP id g32so455907ioj.2
        for <ceph-devel@vger.kernel.org>; Mon, 18 Sep 2017 01:57:09 -0700 (PDT)
In-Reply-To: <350174ad-7e1d-4ab8-b149-0762e91d19e8@me.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?5YWz5LqR6aOe?= <seven.guanyunfei@icloud.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Sep 18, 2017 at 2:41 PM, =E5=85=B3=E4=BA=91=E9=A3=9E <seven.guanyun=
fei@icloud.com> wrote:
>
> hello kefu chai,
>
>
> These two days I carefully considered the pr https://github.com/ceph/ceph=
/pull/17661 and looked the code about bufferlist and I still think the step=
s of 1-3
> is needed. Although the ptr::_off can guarantee bufferlist to be copied/r=
ead/decode/write_file rightly, this will lead a bufferlist not clean and wi=
ll waste memory
> like picture below.
>
> Of course, it's also possible that i am not thinking about it, do you hav=
e any suggestions?

i think it's the user of the bufferlist's choice to defrag the
element(s) in it or not. and it's not a pure win: it hurts the
performance in some cases. in the case of PR#17661, we are trying to
realloc a smaller mem chunk to replace the first memory ptr with it,
if it has "bubbles". what about the second element, or the third one
in the buffer::list, shall we also take care of them as well?

--=20
Regards
Kefu Chai
