From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [rbd] should we add iov support to read/write/aio_read/aio_write
Date: Fri, 28 Oct 2016 07:55:42 -0400
Message-ID: <CA+aFP1AsHp6y6jxPTgjjO7VTR6EDEsGFExpAsM03==QpZpMtrg@mail.gmail.com>
References: <CAKZcxgdxpjv1SATfb5vx7SypnCbmywLPu3MYU+TJOwxO-bUV5A@mail.gmail.com>
 <20161028084531.GA1838@h3ckers-pride>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:32943 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbcJ1Lzo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Oct 2016 07:55:44 -0400
Received: by mail-lf0-f50.google.com with SMTP id x79so54933691lff.0
        for <ceph-devel@vger.kernel.org>; Fri, 28 Oct 2016 04:55:43 -0700 (PDT)
In-Reply-To: <20161028084531.GA1838@h3ckers-pride>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Venky Shankar <vshankar@redhat.com>
Cc: Jaze Lee <jazeltq@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

We'll definitely get it into librbd for the Luminous release and
hopefully get a patch submitted to qemu to conditionally use the new
API to eliminate an unnecessary buffer copy.

On Fri, Oct 28, 2016 at 4:45 AM, Venky Shankar <vshankar@redhat.com> wrote:
> On 16-10-28 16:36:18, Jaze Lee wrote:
>> Hi
>>     Should we add iov support at rbd level ?  I think add iov support
>> will be valuable for cloud vm which use ceph as the backend.
>
> There's already a WIP PR by Jason for this: https://github.com/ceph/ceph/pull/5898
>
> Though it hasn't been worked on for quite some time.
>
>>
>>
>>
>>
>>
>> --
>> 谦谦君子
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
