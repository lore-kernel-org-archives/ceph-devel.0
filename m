From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: Designing a cluster guide
Date: Mon, 21 May 2012 17:36:12 +0200
Message-ID: <CAMvP8PADFfE-eENK_oq9_GsB0t35xd+j5yVvoh+k7qvc0pgUog@mail.gmail.com>
References: <8423c457-a8bb-4d26-a643-9573a8bb11a5@mailpro> <4FB8A3A5.5090809@profihost.ag>
 <CAJafhzRKCcSr37HjviAKRoMztv+twd5r+4Z99heUSy40G1rjag@mail.gmail.com>
 <4FB8B1CE.1080803@icukhosting.co.uk> <CAJafhzQp1SeGZUdUL5XszaRw-0bU0f38r3ghLgmTvZrF0oB_=w@mail.gmail.com>
 <4FBA599F.5050000@profihost.ag> <CAMvP8PBSxybik20238UAX6TKfqGBb=wEqmFyEHk4fSAzU_Fjxg@mail.gmail.com>
 <CANT588uxL7jrf1BfowUeer_AnDTfGjzkWVFhS4aNMaMSst_jyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40027 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753967Ab2EUPgd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 May 2012 11:36:33 -0400
Received: by yhmm54 with SMTP id m54so4487600yhm.19
        for <ceph-devel@vger.kernel.org>; Mon, 21 May 2012 08:36:33 -0700 (PDT)
In-Reply-To: <CANT588uxL7jrf1BfowUeer_AnDTfGjzkWVFhS4aNMaMSst_jyA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Project is indeed very interesting, but requires to patch a kernel
source. For me using lkm is safer ;)


On Mon, May 21, 2012 at 5:30 PM, Kiran Patil <kirantpatil@gmail.com> wr=
ote:
> Hello,
>
> Has someone looked into bcache (http://bcache.evilpiepirate.org/) ?
>
> It seems, it is superior to flashcache.
>
> Lwn.net article: https://lwn.net/Articles/497024/
>
> Mailing list: http://news.gmane.org/gmane.linux.kernel.bcache.devel
>
> Source code: http://evilpiepirate.org/cgi-bin/cgit.cgi/linux-bcache.g=
it/
>
> Thanks,
> Kiran Patil.
>
>
> On Mon, May 21, 2012 at 8:42 PM, Tomasz Paszkowski <ss7pro@gmail.com>=
 wrote:
>>
>> If you're using Qemu/KVM you can use 'info blockstats' command for
>> measruing I/O on particular VM.
>>
>>
>> On Mon, May 21, 2012 at 5:05 PM, Stefan Priebe - Profihost AG
>> <s.priebe@profihost.ag> wrote:
>> > Am 21.05.2012 16:59, schrieb Christian Brunner:
>> >> Apart from that you should calculate the sum of the IOPS your gue=
sts
>> >> genereate. In the end everything has to be written on your backen=
d
>> >> storage and is has to be able to deliver the IOPS.
>> > How to measure the IOPs of a dedicated actual system?
>> >
>> > Stefan
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
>>
>>
>>
>> --
>> Tomasz Paszkowski
>> SS7, Asterisk, SAN, Datacenter, Cloud Computing
>> +48500166299
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
>



--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
