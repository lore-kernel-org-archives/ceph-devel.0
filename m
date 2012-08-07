From: Gregory Farnum <greg@inktank.com>
Subject: Re: Crash of almost full ceph
Date: Tue, 7 Aug 2012 12:35:26 -0700
Message-ID: <CAPYLRzg1OxcZJKoGBLF0iSS+2-mRY+hML4-5+Ovq13M7sYOb8w@mail.gmail.com>
References: <501CFB7C.1040601@bashkirtsev.com>
	<CAPYLRzgTCu-_mvKBQNaHrmXqmBVib0cvcGKPmaL-yWGZ=uioww@mail.gmail.com>
	<501FF332.3060005@bashkirtsev.com>
	<CAPYLRzgzZHuZQbCe6TY+hFJYn5MiC32QTdWSnxSNB=bR5r3CBA@mail.gmail.com>
	<5020B458.40106@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:55844 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab2HGTf1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Aug 2012 15:35:27 -0400
Received: by lboi8 with SMTP id i8so60924lbo.19
        for <ceph-devel@vger.kernel.org>; Tue, 07 Aug 2012 12:35:26 -0700 (PDT)
In-Reply-To: <5020B458.40106@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>, Samuel Just <sam.just@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Aug 6, 2012 at 11:23 PM, Vladimir Bashkirtsev
<vladimir@bashkirtsev.com> wrote:
>> Oh, I see what you're saying. Given how distributed Ceph is this is
>> actually harder than it sounds =97 we could get closer by refusing t=
o
>> mark OSDs out whenever the full list is non-empty, but we could not
>> for instance do partial recovery and then stop once an OSD gets full=
=2E
>> In any case, I've made a bug (http://tracker.newdream.net/issues/291=
1)
>> since this isn't something I can hack together right now. :)
>> -Greg
>
> Refusing to mark OSDs out when full list is non-empty will definitely=
 be a
> big step in right direction. It will prevent cascading failure I have
> described originally. But on other hand I think the way around compli=
cation
> of distributed nature is to have OSD itself to refuse backfill when i=
t has
> reached full state regardless of where backfill coming from. In this =
case
> backfill will stall while clients activity still will be handled as p=
er
> normal. Or OSD does not distinguish backfill requests from other OSDs=
 and
> clients requests? Question of course is what other OSD will do when i=
ts peer
> refuses to accept backfill while it is still marked as in. There some
> stand-off period required on OSD which sends backfill. So it looks li=
ke OSD
> should have two things:
> 1. When receiving backfill check if already full and if it is drop re=
quest,
> don't ack back.
> 2. When sending backfill if ack did not arrive in reasonable time ret=
ry
> later after some time has passed (something tells me that such functi=
onality
> already in place).
>
> I should admit I have not read ceph code but with all experience whic=
h I
> have got with ceph it seems that it should be fairly easy to implemen=
t.

That's one possibility, but it has a lot of side effects which could
be troubling =97=A0for instance, it means that pg_temp entries go from
being around until backfill completes, to being around until the OSD
is no longer full and backfill completes. The chances for map growth
etc are high and worrying.

Do you have any thoughts, Sam?
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
