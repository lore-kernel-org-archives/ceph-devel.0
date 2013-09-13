From: "=?UTF-8?B?TGx1w61zIFDDoG1pZXMgaSBKdcOhcmV6?=" <llpamies@pamies.cat>
Subject: Re: compilation error
Date: Fri, 13 Sep 2013 13:51:20 -0700
Message-ID: <CAKD2hyF8M85TYx=_1kO5Phfzmw01gCy3OXw--Rep3DoVGbPBKQ@mail.gmail.com>
References: <CAKD2hyHbXtgGy9JNJVckuMOOkvvkcESujv89ciQszKUGPrtmog@mail.gmail.com>
	<CAN04cT6NrzAAYOWvzpDkfvk_wuY3oFMPQrrkqQx789UZHjurUw@mail.gmail.com>
	<CAKD2hyFs4MM5ezmFFpUUpueOc397THmO0--JY4fAkNtfeBLEYw@mail.gmail.com>
	<CAN04cT4ULLk0eHL+tpTem3PrkU8CCkHPepwYdJOZMeQuet5Amw@mail.gmail.com>
	<CAN04cT6T3iZp0_aXYEkn9fvz2B5Cb1UxMPPTGQr7R9hVGmpQJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:42213 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354Ab3IMUvW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Sep 2013 16:51:22 -0400
Received: by mail-yh0-f54.google.com with SMTP id z20so821314yhz.41
        for <ceph-devel@vger.kernel.org>; Fri, 13 Sep 2013 13:51:22 -0700 (PDT)
Received: by mail-ie0-f174.google.com with SMTP id u16so3588401iet.5
        for <ceph-devel@vger.kernel.org>; Fri, 13 Sep 2013 13:51:20 -0700 (PDT)
In-Reply-To: <CAN04cT6T3iZp0_aXYEkn9fvz2B5Cb1UxMPPTGQr7R9hVGmpQJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Roald van Loon <roaldvanloon@gmail.com>
Cc: =?UTF-8?B?TGx1w61zIFDDoG1pZXMgaSBKdcOhcmV6?= <llpamies@pamies.cat>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Roald,

When I did "./do_autogen.sh instead of "./autogen.sh" it worked. Thanks=
!


On Fri, Sep 13, 2013 at 1:13 PM, Roald van Loon <roaldvanloon@gmail.com=
> wrote:
> Oh, and I meant the sha hash you're using (so basically the output of
> git rev-parse HEAD), so I can reproduce it... :-)
>
> On Fri, Sep 13, 2013 at 9:50 PM, Roald van Loon <roaldvanloon@gmail.c=
om> wrote:
>> Hi Lluis,
>>
>> Something strange is happening here; seems like automake does not ad=
d
>> any of the library dependencies.
>>
>> Is this only with ceph-dencoder, or also with other targets? Try a
>> "make clean", "./do_autogen.sh", and "make V=3D1 check". I'd really =
like
>> to see that output.
>>
>> Roald
>>
>>
>> On Fri, Sep 13, 2013 at 9:04 PM, Llu=C3=ADs P=C3=A0mies i Ju=C3=A1re=
z
>> <llpamies@pamies.cat> wrote:
>>> Hi Roald,
>>>
>>> I'm using git version 1.8.1.2, and run a plain "./configure" with n=
o extra args.
>>>
>>> Thank you.
>>>
>>> On Fri, Sep 13, 2013 at 11:23 AM, Roald van Loon <roaldvanloon@gmai=
l.com> wrote:
>>>> Hi,
>>>>
>>>> I haven't seen this error before. What's your git version? And cou=
ld
>>>> you give us your configure command, config.status file and the out=
put
>>>> of a make V=3D1?
>>>>
>>>> Roald
>>>>
>>>> On Fri, Sep 13, 2013 at 6:06 PM, Llu=C3=ADs P=C3=A0mies i Ju=C3=A1=
rez
>>>> <llpamies@pamies.cat> wrote:
>>>>> Hello,
>>>>>
>>>>> I'm having problems to compile the main git branch. I tried compi=
ling
>>>>> from a new clone, and I get the same error. I attach a dump of th=
e
>>>>> error. Does anyone else have this problem?
>>>>>
>>>>> --
>>>>> Llu=C3=ADs P=C3=A0mies i Ju=C3=A1rez
>>>>> http://lluis.pamies.cat
>>>
>>>
>>>
>>> --
>>> Llu=C3=ADs P=C3=A0mies i Ju=C3=A1rez
>>> http://lluis.pamies.cat



--=20
Llu=C3=ADs P=C3=A0mies i Ju=C3=A1rez
http://lluis.pamies.cat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
