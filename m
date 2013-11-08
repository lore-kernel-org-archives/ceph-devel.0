From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: emperor leftovers
Date: Thu, 7 Nov 2013 17:40:32 -0800
Message-ID: <07C71F0C-A305-4E20-A2ED-4F28D13BF7C9@gmail.com>
References: <1253253910.359.1383874478852.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:34624 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab3KHBke convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 20:40:34 -0500
Received: by mail-pb0-f42.google.com with SMTP id jt11so1450445pbb.1
        for <ceph-devel@vger.kernel.org>; Thu, 07 Nov 2013 17:40:34 -0800 (PST)
In-Reply-To: <1253253910.359.1383874478852.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@linuxbox.com>
Cc: Patrick McGarry <patrick@inktank.com>, Ceph Devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Cesar Mello <cmello@gmail.com>

Oh, my ignorance of Windows development is enormous :) So there are cyg=
win, mingw, and msvc. And mingw =93more=94 native than cygwin, but does=
n=92t try to do posix, and msvc just the default/native windows develop=
ment env?

On Nov 7, 2013, at 5:34 PM, Matt W. Benjamin <matt@linuxbox.com> wrote:

> Or, MSVC, frankly.
>=20
> ----- "Matt W. Benjamin" <matt@linuxbox.com> wrote:
>=20
>> Yes.  But you may wish to think about mingwXX porting rather than
>> Cygwin,
>> if you prefer native results.
>>=20
>> Matt
>>=20
>> ----- "Noah Watkins" <noah.watkins@inktank.com> wrote:
>>=20
>>> On Thu, Nov 7, 2013 at 5:15 PM, Sage Weil <sage@inktank.com> wrote:
>>>=20
>>>> curious if the discussion on windows portability is relevant here
>> or
>>> if
>>>> it's better treated as a separate but related effort.
>>>=20
>>> The kernel space talk that's been tossed around probably isn't
>>> relevant, but I'd be nice to learn about cygwin porting if anyone
>> has
>>> knowledge in this area.
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>> ceph-devel"
>>> in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>=20
>> --=20
>> Matt Benjamin
>> The Linux Box
>> 206 South Fifth Ave. Suite 150
>> Ann Arbor, MI  48104
>>=20
>> http://linuxbox.com
>>=20
>> tel.  734-761-4689=20
>> fax.  734-769-8938=20
>> cel.  734-216-5309=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
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
> cel.  734-216-5309=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
