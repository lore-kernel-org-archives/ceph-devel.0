From: Elita Lobo <loboelita@gmail.com>
Subject: Re: Which IDE do you use for ceph-development?
Date: Fri, 16 Sep 2016 07:25:39 +0530
Message-ID: <CAA8xDw2cU8DN6=SQ3kNCZsXTNrmeZdyKxAhuMV46SjugsGthAw@mail.gmail.com>
References: <CAA8xDw3OPGikoYF3Knef5tBrCsg+Hvekhyh7BVGJZCq4Yn93Fw@mail.gmail.com>
 <CAA8xDw1RA2RhZ=ERPKK0ZjD1Zc4iWYgm_zSvNHHEdJ+q7FcJag@mail.gmail.com>
 <CAF-wwdEE9KC=4agvTyrxNQcoSjo408SV8DNTfF0Kj2us3Nawkw@mail.gmail.com> <CAA8xDw2MirA6WW7ZxSUG_jLzw7md4Ws7JwzBQQ66Vcu3Q1-1jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:36080 "EHLO
        mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753441AbcIPBzk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Sep 2016 21:55:40 -0400
Received: by mail-oi0-f46.google.com with SMTP id q188so95052899oia.3
        for <ceph-devel@vger.kernel.org>; Thu, 15 Sep 2016 18:55:40 -0700 (PDT)
In-Reply-To: <CAA8xDw2MirA6WW7ZxSUG_jLzw7md4Ws7JwzBQQ66Vcu3Q1-1jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

@Brad,
Hi Brad,

Thanks again :) ! Will try it out.

@ Joao, @Mark,
Thanks for the suggestion. I was using vim but I hadn't configured it
to index the files, hence it was becoming very difficult to search for
definitions/declarations etc (Was using grep) . Also, I was hoping I
could build the code on atleast one IDE which could show me all the
local function calls made in each process.
I tried using gdb, added debugging symbols etc but still couldnt trace
the local function calls.
I have somehow managed to figure out the flow using logs/printfs and
experimenting with the ceph commands.


Thanks and Regards,
Elita Lobo


On Fri, Sep 16, 2016 at 7:15 AM, Elita Lobo <loboelita@gmail.com> wrote:
> Hi Brad,
>
> Thanks :) ! Will try it out. Currently managing with Code Blocks.
>
>
> Regards,
> Elita
>
> On Tue, Sep 13, 2016 at 11:53 AM, Brad Hubbard <bhubbard@redhat.com> wrote:
>>
>> Pretty sure I built it OK in QtCreator but it was some time ago now.
>>
>> --
>> Cheers,
>> Brad
>>
>> On Mon, Sep 12, 2016 at 2:33 AM, Elita Lobo <loboelita@gmail.com> wrote:
>> > Hi,
>> >
>> > I tried using NEtbeans and Eclipse . Netbeans gave this error.
>> > https://paste.fedoraproject.org/426622/61053414/
>> >
>> > And Eclipse is not able to detect header files although I added the
>> > path of the include directory.
>> >
>> > Has anyone successfully built the ceph code on any IDE?
>> >
>> >
>> > Regards,
>> > Elita Lobo
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
