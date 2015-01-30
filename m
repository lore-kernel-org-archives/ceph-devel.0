From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: radosgw: bad content length
Date: Fri, 30 Jan 2015 09:03:20 -0800
Message-ID: <CABBk=J8ufgB-e8vMua=nk1jYrywy7VB+zNgmCJRXGysB9rJOxg@mail.gmail.com>
References: <loom.20150130T152219-712@post.gmane.org>
	<CABBk=J9G-pQauPiaiixmbZ6U=aLgb16i99WS5Ck0QcZ7ZcGdig@mail.gmail.com>
	<02c301d03cae$090b3590$1b21a0b0$@dunkel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:45752 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbbA3RDV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jan 2015 12:03:21 -0500
Received: by mail-pa0-f52.google.com with SMTP id kx10so54408212pab.11
        for <ceph-devel@vger.kernel.org>; Fri, 30 Jan 2015 09:03:21 -0800 (PST)
In-Reply-To: <02c301d03cae$090b3590$1b21a0b0$@dunkel.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Axel Dunkel <ad@dunkel.de>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Jan 30, 2015 at 8:58 AM, Axel Dunkel <ad@dunkel.de> wrote:
> Hi,
>
> the connection is not being shut down, also not idle (constantly
> transferring with more than 100 Mbit/s). It (really :-) ) is the spec=
ial
> modified libapache2-mod-fastcgi, 2.4.7~0910052141-ceph1.
>
> Telling from the source code the issue seems not to be that the conte=
nt
> lengths do not match, rather that the http-header Content-Length is n=
ot
> parseable (allthough the header is displayed fine in the debug output=
). If
> strict_strtol returns an error, to be exact - ?
>

In that case the time is meaningless. How big is Content-Length when it=
 fails?

Yehuda

> Best regards
> Axel Dunkel
>
> -----Urspr=C3=BCngliche Nachricht-----
> Von: yehuda@inktank.com [mailto:yehuda@inktank.com] Im Auftrag von Ye=
huda
> Sadeh
> Gesendet: Freitag, 30. Januar 2015 17:39
> An: Axel Dunkel
> Cc: ceph-devel
> Betreff: Re: radosgw: bad content length
>
> On Fri, Jan 30, 2015 at 8:22 AM, Axel Dunkel <ad@dunkel.de> wrote:
>> Hi,
>>
>> there are issues with radosgw and large file transfers without using
>> multiparts (like with "s3cmd --disable-multipart put") which seem to
>> be somehow known, but unsolved.
>>
>> Things run fine if the request takes no longer than 180sec. If it
>> takes longer, rgw_rest.cc (line 1236) gives the error "bad content
>> length, aborting" AFTER the request has been fully completed (so no
>> timeout issue). If the s3cmd runs less than 180sec things go through
>> fine, if it takes longer, the same command fails.
>>
>> This error is given if the variable Content-Length can not be parsed=
 -
>> is it possible that some timer causes this variable to get corrupted=
?
>> I did not find any 180sec timer, though...
>>
>> This is with ceph version 0.87
>> (c51c8f9d80fa4e0168aa52685b8de40e42758578),
>> Ubuntu 14.04.
>>
> That would happen if the connection is shut down for some reason (eit=
her
> client to apache tcp connection, or apache module to radosgw connecti=
on).
> This may very well be due to inactivity. At that point, rgw will get =
some
> kind of EOF status, and will verify that total received content is eq=
ual to
> the Content-Length field. If it's not equal you'd get that response. =
Are
> you, by any chance, using mod_fcgid as the fastcgi module (as opposed=
 to
> mod_fastcgi, or mod_proxy_fcgi)?
>
> Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
