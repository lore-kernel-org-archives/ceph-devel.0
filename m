From: Konstantin Danilov <kdanilov@mirantis.com>
Subject: Re: Get IO request execution profile
Date: Mon, 23 Jan 2017 17:59:54 +0200
Message-ID: <CACxKWaz6FxPO2VcFJy1+coOewFCwF2=0+feR5sDb3DrnGgvW4A@mail.gmail.com>
References: <CACxKWaxt5+9BiQEM-fG=iHkwHJsPYK9EukNoyPtPNQunq65adw@mail.gmail.com>
 <CALe9h7ePYu5_JYTU9NppGhsvUr5FQJJMTw5kcj1yb2kyF+MXHQ@mail.gmail.com> <CA+aFP1Av7jHmT4sFD4ysCeeFk_GwZSsAS2W8Zs-9nmcB3sCd4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:34767 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbdAWQAG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 11:00:06 -0500
Received: by mail-ua0-f180.google.com with SMTP id 35so112975978uak.1
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 08:00:00 -0800 (PST)
In-Reply-To: <CA+aFP1Av7jHmT4sFD4ysCeeFk_GwZSsAS2W8Zs-9nmcB3sCd4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

> Potentially interesting idea, although it's not obvious to me why it's
useful to have this dumped on the client rather than the server?

The idea is to monitor requests execution time per stage.
dump_historic_ops covers large part of this idea, meanwhile in case of
large cluster
it hard follow particular request. You have to calculate primary OSD
for it. Historic
store only slowest requests. To get a timing profile historic ops buffer have to
increased to fit all requests.

So if you like to get a requests execution profile(and potentially
monitor how it changes over time)
you can very easily get it for slowest requests, but for all kind of
requests it requires tricks and
put unnecessary additional load on OSD nodes.

> Have you looked at the Zipkin tracking PR [1]?
Nope. Is there any plans to merge it?

Thanks

On Mon, Jan 23, 2017 at 3:59 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> Have you looked at the Zipkin tracking PR [1]?
>
> [1] https://github.com/ceph/ceph/pull/11053
>
> On Mon, Jan 23, 2017 at 7:54 AM, John Spray <jspray@redhat.com> wrote:
>> On Mon, Jan 23, 2017 at 12:36 PM, Konstantin Danilov
>> <kdanilov@mirantis.com> wrote:
>>> Hi all,
>>>
>>> is there a way to get something like 'dump historic ops' for particular request?
>>> Probably from client side. Ideally I'd like to send a normal IO
>>> request with special
>>> flag and get execution profile in response metadata.
>>> If it's not possible right now - is this an interesting feature to
>>> implement, or I miss
>>> something and it's useless?
>>
>> Potentially interesting idea, although it's not obvious to me why it's
>> useful to have this dumped on the client rather than the server?
>> Would be it equally useful to be able to tag a specific client on the
>> server side to have its requests dumped like this?
>>
>> John
>>
>>>
>>> Thanks
>>>
>>> --
>>> Kostiantyn Danilov aka koder.ua
>>> Principal software engineer, Mirantis
>>>
>>> skype:koder.ua
>>> http://koder-ua.blogspot.com/
>>> http://mirantis.com
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Jason



-- 
Kostiantyn Danilov aka koder.ua
Principal software engineer, Mirantis

skype:koder.ua
http://koder-ua.blogspot.com/
http://mirantis.com
