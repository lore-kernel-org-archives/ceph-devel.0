From: Colin Patrick McCabe <colin.mccabe@dreamhost.com>
Subject: Re: JSON generation in C/C++
Date: Mon, 1 Aug 2011 10:49:01 -0700
Message-ID: <CA+qbEUOZYF6vTT8MNTU=x4tYEEJje_d3yYN2LtrZuLyQ7CDcMA@mail.gmail.com>
References: <CAORUGqA91fXDjUSB-YT+5_C6d0Ap8SE7kqcKKZvt4or-VxuTPw@mail.gmail.com>
	<CAORUGqAhp4bSHojzGXOzVFekoUjg5vc_TbTw8hKxMxYwyy0adg@mail.gmail.com>
	<Pine.LNX.4.64.1108010941200.6290@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48088 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753598Ab1HARtE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2011 13:49:04 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 0A2B2C068
	for <ceph-devel@vger.kernel.org>; Mon,  1 Aug 2011 10:50:19 -0700 (PDT)
Received: from mail-fx0-f46.google.com (mail-fx0-f46.google.com [209.85.161.46])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id AB388C065
	for <ceph-devel@vger.kernel.org>; Mon,  1 Aug 2011 10:50:18 -0700 (PDT)
Received: by fxh19 with SMTP id 19so4772789fxh.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2011 10:49:01 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1108010941200.6290@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Tommi Virtanen <tommi.virtanen@dreamhost.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Aug 1, 2011 at 9:42 AM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 1 Aug 2011, Tommi Virtanen wrote:
>> On Mon, Aug 1, 2011 at 09:24, Tommi Virtanen
>> <tommi.virtanen@dreamhost.com> wrote:
>> > We've talked about generating/parsing JSON a few times, and how we=
've
>> > run into edge cases whenever we've rolled our own functions for th=
at.
>> > I've mentioned this C library a few times, but I'm not sure if I'v=
e
>> > actually sent the link to anyone.. Here's a C library for
>> > generating/parsing JSON, written by an ex-cow-orker of mine.
>>
>> D'oh!
>>
>> https://github.com/akheron/jansson
>
> Ah, yeah. =A0The problem with the current code is it's assuming the
> string to dump is ASCII. =A0We need to do this:
>
> https://github.com/akheron/jansson/blob/master/src/dump.c#L67
>

That piece of code only comes into effect if you pass in 1 for
"ascii". Basically, that activates a special mode in the Jansson
library where it mashes all utf-8 into ascii with escape sequences.

However, you do not need to activate this mode, and you probably
shouldn't, because as RFC4627 says (
http://www.ietf.org/rfc/rfc4627.txt ):
"JSON text SHALL be encoded in Unicode.  The default encoding is UTF-8.=
"

JSON only gives you a 4 byte long escape sequence. As you may know, a
4-byte escape sequence cannot fully represent an arbitrary utf-8
character. This is unfortunate, but it doesn't really matter, because
the only characters you NEED to escape are control characters.

See this parse table for json: http://www.json.org/string.gif

So basically, there is no problem with using utf8 in JSON. We already
have a function to do the necessary escaping of slash, quote, and so
on, in rgw_escape.c. I wrote it when fixing bug #939:
http://tracker.newdream.net/issues/939. It lives here:

http://ceph.newdream.net/git/?p=3Dceph.git;a=3Dblob;f=3Dsrc/rgw/rgw_esc=
ape.c;h=3Daa19720f43e75e4ebb6db4f88993e8c4830421f8;hb=3Dmaster

And yes, it has unit tests. :)

cheers,
Colin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
