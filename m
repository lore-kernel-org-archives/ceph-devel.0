From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: emperor leftovers
Date: Thu, 7 Nov 2013 17:53:40 -0800
Message-ID: <D5FF9050-92E1-4E07-9020-5768E43B84D6@gmail.com>
References: <1292843520.361.1383875261715.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:52757 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755627Ab3KHBxp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 20:53:45 -0500
Received: by mail-pb0-f47.google.com with SMTP id rq13so1446761pbb.34
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 17:53:45 -0800 (PST)
In-Reply-To: <1292843520.361.1383875261715.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Cesar Mello <cmello@gmail.com>


On Nov 7, 2013, at 5:47 PM, Matt W. Benjamin <matt@linuxbox.com> wrote:

> MSVC is the default windows env.  It's probably the ideal, despite mo=
st
> requirement for moving furthest towards the windows mindset.  It has =
better
> open source tool support than you might expect.

Cool, thanks for the clarification. This might be a good reason for the=
 source code reorganization blueprint, assuming part of its goals are t=
o be able to build Ceph in components. Being able to work on just porti=
ng, say, librados, would be nice/easier.

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/Source_tree_restru=
cturing

>=20
> Matt
>=20
> ----- "Noah Watkins" <noahwatkins@gmail.com> wrote:
>=20
>> Oh, my ignorance of Windows development is enormous :) So there are
>> cygwin, mingw, and msvc. And mingw =93more=94 native than cygwin, bu=
t
>> doesn=92t try to do posix, and msvc just the default/native windows
>> development env?
>>=20
>> On Nov 7, 2013, at 5:34 PM, Matt W. Benjamin <matt@linuxbox.com>
>> wrote:
>>=20
>>> Or, MSVC, frankly.
>>>=20
>>> ----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:
>>>=20
>>>> Yes.  But you may wish to think about mingwXX porting rather than
>>>> Cygwin,
>>>> if you prefer native results.
>>>>=20
>>>> Matt
>>>>=20
>>>> ----- "Noah Watkins" <noah.watkins@inktank.com> wrote:
>>>>=20
>>>>> On Thu, Nov 7, 2013 at 5:15 PM, Sage Weil <sage@inktank.com>
>> wrote:
>>>>>=20
>>>>>> curious if the discussion on windows portability is relevant
>> here
>>>> or
>>>>> if
>>>>>> it's better treated as a separate but related effort.
>>>>>=20
>>>>> The kernel space talk that's been tossed around probably isn't
>>>>> relevant, but I'd be nice to learn about cygwin porting if anyone
>>>> has
>>>>> knowledge in this area.
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> ceph-devel"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at=20
>> http://vger.kernel.org/majordomo-info.html
>>>>=20
>>>> --=20
>>>> Matt Benjamin
>>>> The Linux Box
>>>> 206 South Fifth Ave. Suite 150
>>>> Ann Arbor, MI  48104
>>>>=20
>>>> http://linuxbox.com
>>>>=20
>>>> tel.  734-761-4689=20
>>>> fax.  734-769-8938=20
>>>> cel.  734-216-5309=20
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>=20
>>> --=20
>>> Matt Benjamin
>>> The Linux Box
>>> 206 South Fifth Ave. Suite 150
>>> Ann Arbor, MI  48104
>>>=20
>>> http://linuxbox.com
>>>=20
>>> tel.  734-761-4689=20
>>> fax.  734-769-8938=20
>>> cel.  734-216-5309
>=20
> --=20
> Matt Benjamin
> The Linux Box
> 206 South Fifth Ave. Suite 150
> Ann Arbor, MI  48104
>=20
> http://linuxbox.com
>=20
> tel.  734-761-4689=20
> fax.  734-769-8938=20
> cel.  734-216-5309

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
