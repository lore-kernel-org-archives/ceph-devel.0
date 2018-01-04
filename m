From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: rbd image snapshot timestamps?
Date: Thu, 4 Jan 2018 10:45:16 -0500
Message-ID: <CA+aFP1AzC4bRq95wOJW28scmKhbo7WeXvEm14AMkDKkkr3Dczw@mail.gmail.com>
References: <CAGbviv+MXNSaFdQ6oWmDVEvE0gRNmjmNT=+7Tpkcrsj_w_+VhA@mail.gmail.com>
 <CA+aFP1B9A8Fq9We_wLy=2oVQUf9qoe42jDnE+8dwdKi=fppJng@mail.gmail.com> <CAGbvivLVY-2gCHYt2VJ3LMuW2QBshz+MjeEXCYbnSjGk+2RD2A@mail.gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yb0-f182.google.com ([209.85.213.182]:41849 "EHLO
        mail-yb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753259AbeADPpS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jan 2018 10:45:18 -0500
Received: by mail-yb0-f182.google.com with SMTP id o84so757686yba.8
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jan 2018 07:45:17 -0800 (PST)
In-Reply-To: <CAGbvivLVY-2gCHYt2VJ3LMuW2QBshz+MjeEXCYbnSjGk+2RD2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Correct -- but it will only work for snapshots created after the
upgrade (since that's when we started recording the timestamp).

On Thu, Jan 4, 2018 at 10:43 AM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> Thanks!  Latest release being Luminous, correct?
>
>
>
> On Thu, Jan 4, 2018 at 10:35 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>> Yes, it's possible w/ the recent release of rbd:
>>
>> # rbd snap ls foo
>> SNAPID NAME     SIZE TIMESTAMP
>>      4 1    10240 MB Thu Jan  4 10:33:41 2018
>>
>> On Thu, Jan 4, 2018 at 9:51 AM, Wyllys Ingersoll
>> <wyllys.ingersoll@keepertech.com> wrote:
>>> Is there any way to find out when an RBD image snapshot was created?
>>> None of the query tools ("rbd info pool/image@snapshot") appear to
>>> return any timestamp related information.
>>>
>>> -Wyllys Ingersoll
>>>  Keeper Technology, LLC
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Jason



-- 
Jason
