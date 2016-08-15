From: Ira Cooper <ira@wakeful.net>
Subject: Re: CephFS and Samba hang on copy of large file
Date: Mon, 15 Aug 2016 10:08:54 -0400
Message-ID: <CAAPGDwLZ3VJ2f9yaTW7EmQkK4p5eK+cKk8ZfW_FGOhc9OaSSfA@mail.gmail.com>
References: <1423426743.2483.1471267435085@ox.pcextreme.nl>
 <CAAPGDwLxomxLJMZNsW7qs9vqjnxH9zbBkUjBok7tsHXA_rt3yA@mail.gmail.com>
 <1197956778.2488.1471268140723@ox.pcextreme.nl> <CAAPGDwKx6w3s5gG9FHu91kLz4kurPD+B1cQNdo8oKYmGu2L-Qg@mail.gmail.com>
 <1951857528.2492.1471269515710@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f175.google.com ([209.85.217.175]:36724 "EHLO
	mail-ua0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881AbcHOOJQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Aug 2016 10:09:16 -0400
Received: by mail-ua0-f175.google.com with SMTP id 97so74549833uav.3
        for <ceph-devel@vger.kernel.org>; Mon, 15 Aug 2016 07:09:16 -0700 (PDT)
In-Reply-To: <1951857528.2492.1471269515710@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 15, 2016 at 9:58 AM, Wido den Hollander <wido@42on.com> wrote:
>
>> Op 15 augustus 2016 om 15:43 schreef Ira Cooper <ira@wakeful.net>:
>>
>>
>> On Mon, Aug 15, 2016 at 9:35 AM, Wido den Hollander <wido@42on.com> wrote:
>> >
>> >> Op 15 augustus 2016 om 15:27 schreef Ira Cooper <ira@wakeful.net>:
>> >>
>> >>
>> >> Have you tried the ceph VFS module in Samba yet?
>> >>
>> >
>> > Yes. That works, but the performance is a lot lower. So for that we are testing/using the CephFS kernel client.
>> >
>> > I would also like to see the VFS module upstream in Samba, you still need to manually patch it in.
>>
>> It is in upstream Samba.
>>
>> https://git.samba.org/?p=samba.git;a=blob;f=source3/modules/vfs_ceph.c;h=59e9b9cf9b3e8e5313a20823994fcacf9e4b4168;hb=f1b42ec778e08875e076df7fdf67dd69bf9b2757
>>
>> It's been there a while now.
>>
>> I'm curious what you are patching in, and what the performance numbers are. :)
>
> No, sorry for that confusion. I meant DEB and/or RPM packages. You have to compile manually which not all companies like.
>
> With the kernel client we see about 200MB/sec and with VFS about 50MB/sec.
>
> However, I still wonder why samba went in status D. That should not happen.

I totally agree about the kernel issue, it should work.

I'm really curious why the kernel client blows the VFS module away.
Can you share any info on your workload?

As far as packaging, Fedora does build it.

Thanks,

-Ira
