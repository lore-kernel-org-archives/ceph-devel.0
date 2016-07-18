From: John Spray <jspray@redhat.com>
Subject: Re: ceph-mgr update
Date: Mon, 18 Jul 2016 14:28:38 +0100
Message-ID: <CALe9h7f_dLRSVTDfj0S3FiTc9nicCKd1iZm5ykOcQT5xnnfcFg@mail.gmail.com>
References: <CALe9h7fdMEtxSKQGi4B6OeeWV77=Fbv5LzV8231Pz28+wHzfrw@mail.gmail.com>
 <CALqRxCzyB=F5Ttmh6_=u90VU1D0aW9jcgzZqR6tduNunes+Dpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36827 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbcGRN27 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jul 2016 09:28:59 -0400
Received: by mail-qk0-f181.google.com with SMTP id x1so71756396qkb.3
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jul 2016 06:28:58 -0700 (PDT)
In-Reply-To: <CALqRxCzyB=F5Ttmh6_=u90VU1D0aW9jcgzZqR6tduNunes+Dpg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 18, 2016 at 2:23 PM, Ken Dreyer <kdreyer@redhat.com> wrote:
> On Mon, Jul 18, 2016 at 5:40 AM, John Spray <jspray@redhat.com> wrote:
>> Hi all,
>>
>> The ceph-mgr code has come on a long way since my last update, and
>> there are now pull requests open:
>> https://github.com/ceph/ceph/pull/10328
>> https://github.com/ceph/ceph-qa-suite/pull/1086
>>
>
> "tools: remove legacy `cephfs` tool" is near and dear to my heart, and
> it could be its own PR, right? It may be easier/faster to review
> separately.

Already is: https://github.com/ceph/ceph/pull/10243

Just happens to be on this branch as well (I probably should have
cleaned that up before opening the PR...)

John

>
> - Ken
