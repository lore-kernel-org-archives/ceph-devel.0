From: Alphe Salas Michels <asalas@kepler.cl>
Subject: Re: emperor leftovers
Date: Tue, 26 Nov 2013 18:46:50 -0300
Message-ID: <529516CA.3000505@kepler.cl>
References: <3566795634879164586@unknownmsgid> <alpine.DEB.2.00.1311072123240.17150@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:50995 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754569Ab3KZVqy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Nov 2013 16:46:54 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so4539513yha.31
        for <ceph-devel@vger.kernel.org>; Tue, 26 Nov 2013 13:46:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1311072123240.17150@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

I started reading the libcepfs related code. and it is still a hudge ta=
sk.
Cygwin seems to me to be the more complete set of ported gnu libraries=20
to win32.

MSVC is not the tool I will use for the port ... since your work is=20
slown and hidden most
of the time below a tons of click to do thingies...

Code:block /mingWin or cygwin seems to me the more producing perspectiv=
e.
first it is closer to tools used by linux developers.

A full porting to Win32 meas you will have to write ceph code in=20
microsoft compilers C++ or .NET
ways, then you will have to write a port in the same way for each side=20
libraries that ceph use
and that doesn t exists on MS windows visual studio stuffs...
I m not talking about adapting cout << "you're a coder be happy"; but=20
rather adapting pthread lib which is everywhere in ceph code.
that can be done... but if it is already done why not using it ?


But truelly the biggest problem in ceph world is that we have two=20
concurent ways to access
the data on ceph. As far as I understand rbd and cephfs are not=20
compatible you can t see what
the other did.

We have Rbd and ceph-fs/ceph-fuse so who use what? for what purpose?=20
with what results?
 From that depends what a client port to windows will be.
Can we port everything ceph is on windows? well ceph is a hudge project=
=2E=20
just a quick isolation
of files related to libcephfs.cc shows a 400+ files. Now I try to see i=
f=20
all those files are needed and if
that number can be reduced.

Regards

signature

*Alph=E9 Salas*
Ingeniero T.I


On 11/08/13 02:24, Sage Weil wrote:
> On Thu, 7 Nov 2013, Cesar Mello wrote:
>> Yes MSVC and straight win32 is the rock solid way to go. That's wher=
e I
>> would put my late night effort to help.
> Me too.  I think the main primitives (mutex, cond, thread) are alread=
y
> well abstracted, so hopefully this is a matter of providing win32 (is=
 it
> really still called that??) implementations and adding new wrappers f=
or
> other components as needed.
>
> sage
>
>> Best regards
>> Mello
>>
>> Enviado pelo meu Windows Phone De: Matt W. Benjamin
>> Enviada em: 07/11/2013 23:34
>> Para: Noah Watkins
>> Cc: Patrick McGarry; Ceph Devel; Noah Watkins; Sage Weil; Cesar Mell=
o
>> Assunto: Re: emperor leftovers
>> Or, MSVC, frankly.
>>
>> ----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:
>>
>>> Yes.  But you may wish to think about mingwXX porting rather than
>>> Cygwin,
>>> if you prefer native results.
>>>
>>> Matt
>>>
>>> ----- "Noah Watkins" <noah.watkins@inktank.com> wrote:
>>>
>>>> On Thu, Nov 7, 2013 at 5:15 PM, Sage Weil <sage@inktank.com> wrote=
:
>>>>
>>>>> curious if the discussion on windows portability is relevant here
>>> or
>>>> if
>>>>> it's better treated as a separate but related effort.
>>>> The kernel space talk that's been tossed around probably isn't
>>>> relevant, but I'd be nice to learn about cygwin porting if anyone
>>> has
>>>> knowledge in this area.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>> ceph-devel"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> Matt Benjamin
>>> The Linux Box
>>> 206 South Fifth Ave. Suite 150
>>> Ann Arbor, MI  48104
>>>
>>> http://linuxbox.com
>>>
>>> tel.  734-761-4689
>>> fax.  734-769-8938
>>> cel.  734-216-5309
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --=20
>> Matt Benjamin
>> The Linux Box
>> 206 South Fifth Ave. Suite 150
>> Ann Arbor, MI  48104
>>
>> http://linuxbox.com
>>
>> tel.  734-761-4689
>> fax.  734-769-8938
>> cel.  734-216-5309
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
