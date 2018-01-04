From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: rbd image snapshot timestamps?
Date: Thu, 4 Jan 2018 10:43:12 -0500
Message-ID: <CAGbvivLVY-2gCHYt2VJ3LMuW2QBshz+MjeEXCYbnSjGk+2RD2A@mail.gmail.com>
References: <CAGbviv+MXNSaFdQ6oWmDVEvE0gRNmjmNT=+7Tpkcrsj_w_+VhA@mail.gmail.com>
 <CA+aFP1B9A8Fq9We_wLy=2oVQUf9qoe42jDnE+8dwdKi=fppJng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:37646 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753120AbeADPnN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Jan 2018 10:43:13 -0500
Received: by mail-it0-f46.google.com with SMTP id d137so2820579itc.2
        for <ceph-devel@vger.kernel.org>; Thu, 04 Jan 2018 07:43:13 -0800 (PST)
In-Reply-To: <CA+aFP1B9A8Fq9We_wLy=2oVQUf9qoe42jDnE+8dwdKi=fppJng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thanks!  Latest release being Luminous, correct?



On Thu, Jan 4, 2018 at 10:35 AM, Jason Dillaman <jdillama@redhat.com> wrote:
> Yes, it's possible w/ the recent release of rbd:
>
> # rbd snap ls foo
> SNAPID NAME     SIZE TIMESTAMP
>      4 1    10240 MB Thu Jan  4 10:33:41 2018
>
> On Thu, Jan 4, 2018 at 9:51 AM, Wyllys Ingersoll
> <wyllys.ingersoll@keepertech.com> wrote:
>> Is there any way to find out when an RBD image snapshot was created?
>> None of the query tools ("rbd info pool/image@snapshot") appear to
>> return any timestamp related information.
>>
>> -Wyllys Ingersoll
>>  Keeper Technology, LLC
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Jason
