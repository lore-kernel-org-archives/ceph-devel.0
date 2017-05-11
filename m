From: Forumulator V <forumulator@gmail.com>
Subject: Re: GSoC participant Pranjal Agrawal
Date: Thu, 11 May 2017 05:48:28 -0400
Message-ID: <CAN1NP8ioYMAfdsv09YuRFoua9s9_ExaQwECafXh3kU4N8GB83A@mail.gmail.com>
References: <1434908636.6039724.1494290728770.JavaMail.zimbra@redhat.com>
 <2014928941.6040021.1494290915738.JavaMail.zimbra@redhat.com> <CAF-wwdFwLHqpBjS6=kW=fZTaWVaGjsZp7QQWAX-em19b3=ob-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f179.google.com ([209.85.217.179]:34277 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932086AbdEKJs3 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 11 May 2017 05:48:29 -0400
Received: by mail-ua0-f179.google.com with SMTP id g49so23790400uaa.1
        for <ceph-devel@vger.kernel.org>; Thu, 11 May 2017 02:48:29 -0700 (PDT)
In-Reply-To: <CAF-wwdFwLHqpBjS6=kW=fZTaWVaGjsZp7QQWAX-em19b3=ob-A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Ali Maredia <amaredia@redhat.com>, Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, Orit Wasserman <owasserm@redhat.com>, Casey Bodley <cbodley@redhat.com>, Matt Benjamin <mbenjami@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi everyone,

Sorry for the delayed reply, I was travelling. I'm really happy to
have been selected to work on the file backend,
and looking forward to it. Also excited to work with all of you.

My plan is basically to create a new backend first(first 1/2 of the
project), and then integrate it into RGW(2nd half)
via an abstraction replacing the RGW Rados class. For that, I'll need
to decouple the Ceph specific calls from
RGW ops, and since the task is pretty big, I'd like to get ahead in
the communit bonding period itself, making a list
of calls that I need to refactor and so forth.

For anyone who's interested, here's my GSoC proposal, in which I have
listed my entire plan so far:
https://docs.google.com/document/d/1sEzGJB7u5zBkpeY6WKKePKIqYfrsMHyG3t3l-0Sl6uQ/edit?usp=sharing

The main section of interest is the interface and implementation
section. Please feel free to comment with any
thoughts you might have.

I'll be asking all my questions here, once I'm actively doing the RGW
refactoring part itself.

Regards,
Pranjal

On Tue, May 9, 2017 at 12:17 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
> Welcome aboard Pranjal!
>
> On Tue, May 9, 2017 at 10:48 AM, Ali Maredia <amaredia@redhat.com> wrote:
>> Adding Ceph-devel. Pranjal will be working on the first steps toward decoupling the RGW from the rest of Ceph.
>>
>> Welcome!
>>
>> -Ali
>>
>> ----- Original Message -----
>>> From: "Ali Maredia" <amaredia@redhat.com>
>>> To: "Yehuda Sadeh-Weinraub" <ysadehwe@redhat.com>, "Orit Wasserman" <owasserm@redhat.com>, "Casey Bodley"
>>> <cbodley@redhat.com>, "Matt Benjamin" <mbenjami@redhat.com>
>>> Cc: "Forumulator V" <forumulator@gmail.com>
>>> Sent: Monday, May 8, 2017 8:45:28 PM
>>> Subject: GSoC participant Pranjal Agrawal
>>>
>>> Hey everyone I'd like to welcome one of our GSoC participants Pranjal
>>> Agrawal! He is from India and studies at the Indian Institute of Technology
>>> Guwahati. He'll be working on the local back-end for the RGW.
>>>
>>> Pranjal, Yehuda is the tech lead for the RGW and Orit, Casey, and Matt are
>>> also heavy contributors to the RGW, and have forgotten more about the RGW
>>> then I've learned ;).
>>>
>>> -Ali
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Cheers,
> Brad
