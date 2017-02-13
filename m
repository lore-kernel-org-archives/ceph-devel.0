From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: Complete stuck requests to OSD with EIO
Date: Mon, 13 Feb 2017 15:15:41 +0100
Message-ID: <CAOi1vP--uJ8Lg6h68ZC9AY2fp1D=uxPe7zguM1gSsEWSdYrqjw@mail.gmail.com>
References: <4e080919-2df5-1b75-3c8a-3ae95eb8f08d@synesis.ru>
 <1486726280.4233.1.camel@redhat.com> <CAOi1vP_SJD7Vh97WBU2=EsYfWruXqQe06BND+uaq10=V7ZGH1g@mail.gmail.com>
 <CAOi1vP-1EPasYZUPoqwh1Ykgq59xEAf1oeGZH5Y8Kpo9ooQMow@mail.gmail.com> <e2a7b8c7-a1e7-e280-2ef3-e412c2df9848@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:33480 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753129AbdBMOPn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 09:15:43 -0500
Received: by mail-ua0-f173.google.com with SMTP id i68so66096782uad.0
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 06:15:42 -0800 (PST)
In-Reply-To: <e2a7b8c7-a1e7-e280-2ef3-e412c2df9848@synesis.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Artur Molchanov <artur.molchanov@synesis.ru>
Cc: Jeff Layton <jlayton@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 13, 2017 at 10:54 AM, Artur Molchanov
<artur.molchanov@synesis.ru> wrote:
> Hi Ilya,
>
> On 02/13/2017 12:11 PM, Ilya Dryomov wrote:
>>
>> Hi Artur,
>>
>> How about the attached patch?  handle_timeout() is going to iterate
>> over all but the homeless OSD anyway; all it costs us is a couple of
>> tests, so I don't think a separate work is needed.
>>
>> abort_request() is a simple wrapper around complete_request(), making
>> it safe to call at any time -- replace it with complete_request() for
>> now if you want to try this out.
>
>
> Using one job for sending keepalive requests and completing stuck requests
> brings us to the need to check that osd_keepalive_timeout is not larger then
> osd_request_timeout. So we should not forget to say about it in the
> documentation.

I'll make a note to mention that it is osd_keepalive_timeout-precise.

> Is it worth creating a correlation between osd_keepalive_timeout and
> osd_request_timeout?

No, probably not.  osd_keepalive_timeout and osd_idle_ttl are similarly
related and we don't have any.

Thanks,

                Ilya
