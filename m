From: Axel Dunkel <ad@dunkel.de>
Subject: AW: radosgw: bad content length
Date: Fri, 30 Jan 2015 17:58:57 +0100 (CET)
Message-ID: <02c301d03cae$090b3590$1b21a0b0$@dunkel.de>
References: <loom.20150130T152219-712@post.gmane.org> <CABBk=J9G-pQauPiaiixmbZ6U=aLgb16i99WS5Ck0QcZ7ZcGdig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay.rod.mail.dunkel.de ([88.215.200.254]:53316 "EHLO
	relay.rod.mail.dunkel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758757AbbA3RFq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 12:05:46 -0500
In-Reply-To: <CABBk=J9G-pQauPiaiixmbZ6U=aLgb16i99WS5Ck0QcZ7ZcGdig@mail.gmail.com>
Content-Language: de
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

the connection is not being shut down, also not idle (constantly=20
transferring with more than 100 Mbit/s). It (really :-) ) is the specia=
l=20
modified libapache2-mod-fastcgi, 2.4.7~0910052141-ceph1.

Telling from the source code the issue seems not to be that the content=
=20
lengths do not match, rather that the http-header Content-Length is not=
=20
parseable (allthough the header is displayed fine in the debug output).=
 If=20
strict_strtol returns an error, to be exact - ?

Best regards
Axel Dunkel

-----Urspr=C3=BCngliche Nachricht-----
Von: yehuda@inktank.com [mailto:yehuda@inktank.com] Im Auftrag von Yehu=
da=20
Sadeh
Gesendet: Freitag, 30. Januar 2015 17:39
An: Axel Dunkel
Cc: ceph-devel
Betreff: Re: radosgw: bad content length

On Fri, Jan 30, 2015 at 8:22 AM, Axel Dunkel <ad@dunkel.de> wrote:
> Hi,
>
> there are issues with radosgw and large file transfers without using
> multiparts (like with "s3cmd --disable-multipart put") which seem to
> be somehow known, but unsolved.
>
> Things run fine if the request takes no longer than 180sec. If it
> takes longer, rgw_rest.cc (line 1236) gives the error "bad content
> length, aborting" AFTER the request has been fully completed (so no
> timeout issue). If the s3cmd runs less than 180sec things go through
> fine, if it takes longer, the same command fails.
>
> This error is given if the variable Content-Length can not be parsed =
-
> is it possible that some timer causes this variable to get corrupted?
> I did not find any 180sec timer, though...
>
> This is with ceph version 0.87
> (c51c8f9d80fa4e0168aa52685b8de40e42758578),
> Ubuntu 14.04.
>
That would happen if the connection is shut down for some reason (eithe=
r=20
client to apache tcp connection, or apache module to radosgw connection=
).=20
This may very well be due to inactivity. At that point, rgw will get so=
me=20
kind of EOF status, and will verify that total received content is equa=
l to=20
the Content-Length field. If it's not equal you'd get that response. Ar=
e=20
you, by any chance, using mod_fcgid as the fastcgi module (as opposed t=
o=20
mod_fastcgi, or mod_proxy_fcgi)?

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
