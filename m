From: =?UTF-8?B?5YWz5LqR6aOe?= <gyfelectric@gmail.com>
Subject: =?UTF-8?B?UmU6IFtjZXBoL2NlcGhdIGxpYnJhZG9zOiBGaXggYSBwb3RlbnRpYWwgcmlzayBvZiBidQ==?=
        =?UTF-8?B?ZmZlcjo6bGlzdDo6Y2xhaW1fcHJlcGVuZChsaXN0JiBi4oCmICgjMTc2NjEp?=
Date: Mon, 18 Sep 2017 16:58:06 +0800
Message-ID: <CAF3FU87G8nS_vtxCWX3L3qsKybnRP-NcsO4+NmX5AgZcxoy4_A@mail.gmail.com>
References: <CAF3FU86j+f16H+KOK7bRfjbfBjpDcPfVKg-2es0egFjy6VoB0Q@mail.gmail.com>
 <e08cd364-a997-b282-a164-c4e79d00a98f@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:48762 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbdIRI6I (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Sep 2017 04:58:08 -0400
Received: by mail-lf0-f46.google.com with SMTP id q132so7179654lfe.5
        for <ceph-devel@vger.kernel.org>; Mon, 18 Sep 2017 01:58:08 -0700 (PDT)
In-Reply-To: <e08cd364-a997-b282-a164-c4e79d00a98f@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?UGlvdHIgRGHFgmVr?= <piotr.dalek@corp.ovh.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

ok, thanks. I will update my PR 17661 only keep the step 5.

src/common/buffer.cc
_len +=3D bl._len;
if (!(flags & CLAIM_ALLOW_NONSHAREABLE))
bl.make_shareable();
_buffers.splice(_buffers.begin(), bl._buffers );
bl._len =3D 0;
bl.last_p =3D bl.begin();
+
+ // 5. update the last_p point to the lasted ptr
+ last_p =3D begin();

2017-09-18 16:05 GMT+08:00 Piotr Da=C5=82ek <piotr.dalek@corp.ovh.com>:
> On 17-09-18 09:47 AM, =E5=85=B3=E4=BA=91=E9=A3=9E wrote:
>>
>> hello kefu chai,
>>
>> These two days I carefully considered the pr 17661 and looked the code
>> about bufferlist and I still think the steps of 1-3 is needed.
>>   Although the ptr::_off can guarantee bufferlist to be
>> copied/read/decode/write_file rightly, this will lead a bufferlist not
>> clean and
>> will waste memory like the picture in annex.
>>
>> Of course, it's also possible that i am not thinking about it, do you
>> have any suggestions?
>
>
> In your diagram, you show the case where allocated memory blocks are
> underutilized, wasting memory. If I understand you (and code from your PR=
)
> correctly, you want to move data from the middle of allocated blocks to
> front of them to reclaim memory - but the way you propose isn't any good
> really, you allocate new block of memory (and accompanying bufferptr), co=
py
> data from existing block to newly allocated one, then destroy old - this =
is
> very expensive CPU-wise, way more expensive than leaving these bytes wast=
ed.
> Most of the time it wouldn't matter anyway, as most of bufferlists have
> limited lifetime and would get destroyed soon.
>
> --
> Piotr Da=C5=82ek
> piotr.dalek@corp.ovh.com
> https://www.ovh.com/us/
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
