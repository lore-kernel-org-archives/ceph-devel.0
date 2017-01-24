From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Get IO request execution profile
Date: Mon, 23 Jan 2017 16:12:16 -0800
Message-ID: <CAJ4mKGayyuOP7FAhyoJvTR8CHBWvicfQabHfKeFW-FWfQ9F-6g@mail.gmail.com>
References: <CACxKWaxt5+9BiQEM-fG=iHkwHJsPYK9EukNoyPtPNQunq65adw@mail.gmail.com>
 <CALe9h7ePYu5_JYTU9NppGhsvUr5FQJJMTw5kcj1yb2kyF+MXHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:33085 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdAXAMS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Jan 2017 19:12:18 -0500
Received: by mail-it0-f49.google.com with SMTP id d9so27104528itc.0
        for <ceph-devel@vger.kernel.org>; Mon, 23 Jan 2017 16:12:18 -0800 (PST)
In-Reply-To: <CALe9h7ePYu5_JYTU9NppGhsvUr5FQJJMTw5kcj1yb2kyF+MXHQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Konstantin Danilov <kdanilov@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jan 23, 2017 at 4:54 AM, John Spray <jspray@redhat.com> wrote:
> On Mon, Jan 23, 2017 at 12:36 PM, Konstantin Danilov
> <kdanilov@mirantis.com> wrote:
>> Hi all,
>>
>> is there a way to get something like 'dump historic ops' for particular request?
>> Probably from client side. Ideally I'd like to send a normal IO
>> request with special
>> flag and get execution profile in response metadata.
>> If it's not possible right now - is this an interesting feature to
>> implement, or I miss
>> something and it's useless?
>
> Potentially interesting idea, although it's not obvious to me why it's
> useful to have this dumped on the client rather than the server?
> Would be it equally useful to be able to tag a specific client on the
> server side to have its requests dumped like this?

We don't have very good client-side op tracking yet (at least, not the
same way we have the OpTracker server-side), but if we did that would
let us identify from a client if server issues were making it very
slow. Could be quite useful!
-Greg

>
> John
>
>>
>> Thanks
>>
>> --
>> Kostiantyn Danilov aka koder.ua
>> Principal software engineer, Mirantis
>>
>> skype:koder.ua
>> http://koder-ua.blogspot.com/
>> http://mirantis.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
