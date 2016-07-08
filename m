From: Patrick McLean <patrickm@gaikai.com>
Subject: Re: deadlocks in rbd unmap and map
Date: Fri, 8 Jul 2016 10:51:51 -0700
Message-ID: <CAE2NFgW0ntzuFkRup5QCGfYMBuHo4Er9+y+OtKDTeaXBBtgE3g@mail.gmail.com>
References: <CAE2NFgVL6_+6JmW7aFO+v3j37BFnxXEneaOHk0eOCx-Vj1pAOA@mail.gmail.com>
 <CAOi1vP8NhgYHpfZT8w=meFf6vwPrS-izRZnvSPwrRc+3vwvAWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36004 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932600AbcGHRvx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jul 2016 13:51:53 -0400
Received: by mail-io0-f173.google.com with SMTP id s93so7552044ioi.3
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jul 2016 10:51:52 -0700 (PDT)
In-Reply-To: <CAOi1vP8NhgYHpfZT8w=meFf6vwPrS-izRZnvSPwrRc+3vwvAWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 8, 2016 at 4:40 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Fri, Jul 8, 2016 at 3:28 AM, Patrick McLean <patrickm@gaikai.com> wrote:
>> This is on linus git master as of 2016/07/01
>>
>> These appear to be two separate deadlocks, one on a a map operation,
>> and one on an unmap operation. We can reproduce these pretty
>> regularly, but it seems like there is some sort of race condition, as
>> it happens no where near every time.
>>

>
> It's a single deadlock between "rbd map" and a kworker thread, a later
> "rbd unmap" is just a victim.
>
> Are you mapping the same image more than once?
>

We shouldn't be, there is a higher-level locking system that is
supposed to prevent that.

Thanks,
Patrick
