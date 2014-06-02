From: Loic Dachary <loic@dachary.org>
Subject: Re: Librbd licensing
Date: Mon, 02 Jun 2014 19:02:12 +0200
Message-ID: <538CAE14.4060602@dachary.org>
References: <loom.20140530T192820-478@post.gmane.org> <alpine.DEB.2.00.1405301042200.11044@cobra.newdream.net> <CADXiVcpM8GJcCbDkdOPWzXPoJrDdyiQn0-q4nDH6o0zpg_u8gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="lcWLkNlT3pAIWgFvt9aEIsF0lQMlrreb1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58577 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbaFBRCQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jun 2014 13:02:16 -0400
In-Reply-To: <CADXiVcpM8GJcCbDkdOPWzXPoJrDdyiQn0-q4nDH6o0zpg_u8gg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Steve Taylor <steveftaylor@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lcWLkNlT3pAIWgFvt9aEIsF0lQMlrreb1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The missing "Lesser" is a nice typo :-) There has never been a GPLv2.1 ( =
https://en.wikipedia.org/wiki/GNU_General_Public_License#Version_2 ) and =
I guess it helps disambiguate the interpretation.

Cheers

On 02/06/2014 18:15, Steve Taylor wrote:
> Sorry, my previous reply was rejected by the list because it wasn't in
> plain text. Let's try again.
>=20
> librbd.cc:
> /*
>  * Ceph - scalable distributed file system
>  *
>  * Copyright (C) 2011 New Dream Network
>  *
>  * This is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public
>  * License version 2.1, as published by the Free Software
>  * Foundation.  See file COPYING.
>  *
>  */
>=20
> librbd.h:
> /*
>  * Ceph - scalable distributed file system
>  *
>  * Copyright (C) 2011 New Dream Network
>  *
>  * This is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public
>  * License version 2.1, as published by the Free Software
>  * Foundation.  See file COPYING.
>  *
>  */
>=20
> librbd.hpp:
> /*
>  * Ceph - scalable distributed file system
>  *
>  * Copyright (C) 2011 New Dream Network
>  *
>  * This is free software; you can redistribute it and/or
>  * modify it under the terms of the GNU General Public
>  * License version 2.1, as published by the Free Software
>  * Foundation.  See file COPYING.
>  *
>  */
>=20
> These are the three that I've noticed poking around librbd so far. My
> understanding from COPYING is that they should be LGPL, but these
> copyright headers obviously state GPL instead. I'm just trying to
> understand definitely which it is. :)
>=20
> If a change is in order, of course I'll be happy to make the change
> myself and submit a pull request if you like.
>=20
> Steve
>=20
> On Fri, May 30, 2014 at 11:43 AM, Sage Weil <sage@inktank.com> wrote:
>> Hi Steve,
>>
>> On Fri, 30 May 2014, Steve Taylor wrote:
>>> I am working with a company that wants to utilize librbd in a project=
 to
>>> interact with Ceph storage. For the purposes of this integration,
>>> LGPL-licensed open source code is acceptable, but GPL-licensed code i=
s not.
>>> Well, at least not without other changes to the project, which can be=

>>> accomplished if necessary.
>>>
>>> The COPYING file distributed with the Ceph source code seems to indic=
ate
>>> that librbd would fall under LGPL 2.1, but some of the source files i=
n
>>> librbd reference GPL 2.1 in their copyright headers.
>>
>> Which files?  If there are disparities we should correct them. To the =
best
>> of my knowledge everything in librbd is LGPL.
>>
>> Thanks!
>> sage
>>
>>
>>>
>>> >From what I have found so far, it appears to me that the sources in
>>> question were probably originally LGPL, but were switched to GPL a fe=
w
>>> years back to comply with FUSE licensing, which is GPL. Is my underst=
anding
>>> correct that these librbd source files are now GPL? If so and FUSE is=
 the
>>> reason behind it, is it possible to dual-license those files so they =
could
>>> be LGPL when not used with FUSE?
>>>
>>> I just want to make sure I understand the licensing properly. I apolo=
gize
>>> if this has been discussed previously. I am new to the list and can't=
 seem
>>> to get the archive search feature to work.
>>>
>>> Steve
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--lcWLkNlT3pAIWgFvt9aEIsF0lQMlrreb1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOMrhQACgkQ8dLMyEl6F21nVQCfW3bWK/jpYZZApuMOgWg/q4pw
lXUAn2vB9XobByXeWrvyByBXkQw9dQST
=xao9
-----END PGP SIGNATURE-----

--lcWLkNlT3pAIWgFvt9aEIsF0lQMlrreb1--
