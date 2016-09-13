From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Mismatching nonce for 'ceph osd.0 tell'
Date: Tue, 13 Sep 2016 13:35:04 -0700
Message-ID: <CAJ4mKGa+wydRuMtvCYiOe823v9UkN2Qk0FkViqHhLAPmGeFoGA@mail.gmail.com>
References: <f54dda71-dabf-cab2-948c-83b9f2007aff@digiware.nl>
 <CACJqLybyu1_rKj7g7qSfrtZCVMhJvgcvU2Q7vfoRUvs-3hT3JQ@mail.gmail.com>
 <14688c37-068c-0bc6-615d-de2f8f5bfdc6@digiware.nl> <CAJ4mKGawPKP=rGB9t1wkwn00sYcBE8T9ac327mGLv90Z4MFxpg@mail.gmail.com>
 <3df7e2ed-eb34-8ba8-8a8d-9d7b66e45315@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:35368 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbcIMUfG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Sep 2016 16:35:06 -0400
Received: by mail-yw0-f181.google.com with SMTP id u82so48304876ywc.2
        for <ceph-devel@vger.kernel.org>; Tue, 13 Sep 2016 13:35:05 -0700 (PDT)
In-Reply-To: <3df7e2ed-eb34-8ba8-8a8d-9d7b66e45315@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Haomai Wang <haomai@xsky.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Sep 13, 2016 at 1:29 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 13-9-2016 21:52, Gregory Farnum wrote:
>> Is osd.0 actually running? If so it *should* have a socket, unless
>> you've disabled them somehow. Check the logs and see if there are
>> failures when it gets set up, I guess?
>>
>> Anyway, something has indeed gone terribly wrong here. I know at one
>> point you had some messenger patches you were using to try and get
>> stuff going on BSD; if you still have some there I think you need to
>> consider them suspect. Otherwise, uh...the network stack is behaving
>> very differently than Linux's?
>
> So what is the expected result of an osd down/up?
>
> Before it is connected to ports like:
>         127.0.0.1:{6800,,6801,6802}/{nonce=pid-like}
> after the osd has gone down/up the sockets work be:
>         127.0.0.1:{6800,,6801,6802}/{(nonce=pid-like)+1000000}
>
> or are the ports also incremented?

IIRC, it should usually be the same ports and different nonce. But the
port is *allowed* to change; that happens sometimes if there was an
unclean shutdown and the port is still considered in-use by the OS for
instance.
