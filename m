From: Roald van Loon <roaldvanloon@gmail.com>
Subject: Re: compilation error
Date: Fri, 13 Sep 2013 21:50:04 +0200
Message-ID: <CAN04cT4ULLk0eHL+tpTem3PrkU8CCkHPepwYdJOZMeQuet5Amw@mail.gmail.com>
References: <CAKD2hyHbXtgGy9JNJVckuMOOkvvkcESujv89ciQszKUGPrtmog@mail.gmail.com>
	<CAN04cT6NrzAAYOWvzpDkfvk_wuY3oFMPQrrkqQx789UZHjurUw@mail.gmail.com>
	<CAKD2hyFs4MM5ezmFFpUUpueOc397THmO0--JY4fAkNtfeBLEYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:45247 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354Ab3IMTuF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Sep 2013 15:50:05 -0400
Received: by mail-ob0-f170.google.com with SMTP id va2so1517721obc.15
        for <ceph-devel@vger.kernel.org>; Fri, 13 Sep 2013 12:50:04 -0700 (PDT)
In-Reply-To: <CAKD2hyFs4MM5ezmFFpUUpueOc397THmO0--JY4fAkNtfeBLEYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Llu=EDs_P=E0mies_i_Ju=E1rez?= <llpamies@pamies.cat>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Lluis,

Something strange is happening here; seems like automake does not add
any of the library dependencies.

Is this only with ceph-dencoder, or also with other targets? Try a
"make clean", "./do_autogen.sh", and "make V=3D1 check". I'd really lik=
e
to see that output.

Roald


On Fri, Sep 13, 2013 at 9:04 PM, Llu=EDs P=E0mies i Ju=E1rez
<llpamies@pamies.cat> wrote:
> Hi Roald,
>
> I'm using git version 1.8.1.2, and run a plain "./configure" with no =
extra args.
>
> Thank you.
>
> On Fri, Sep 13, 2013 at 11:23 AM, Roald van Loon <roaldvanloon@gmail.=
com> wrote:
>> Hi,
>>
>> I haven't seen this error before. What's your git version? And could
>> you give us your configure command, config.status file and the outpu=
t
>> of a make V=3D1?
>>
>> Roald
>>
>> On Fri, Sep 13, 2013 at 6:06 PM, Llu=EDs P=E0mies i Ju=E1rez
>> <llpamies@pamies.cat> wrote:
>>> Hello,
>>>
>>> I'm having problems to compile the main git branch. I tried compili=
ng
>>> from a new clone, and I get the same error. I attach a dump of the
>>> error. Does anyone else have this problem?
>>>
>>> --
>>> Llu=EDs P=E0mies i Ju=E1rez
>>> http://lluis.pamies.cat
>
>
>
> --
> Llu=EDs P=E0mies i Ju=E1rez
> http://lluis.pamies.cat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
