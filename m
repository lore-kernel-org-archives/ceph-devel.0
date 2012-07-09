From: Gregory Farnum <greg@inktank.com>
Subject: Re: OSD doesn't start
Date: Mon, 9 Jul 2012 09:18:24 -0700
Message-ID: <CAPYLRziX1Qxm=2qpvX1PQm8431hLQjOmsH6gymfafp9MkCxpQQ@mail.gmail.com>
References: <1563053.ttVafs9Pph@mranderson>
	<F1FB8F95B3FA4FF19D53AE9F060D88F5@inktank.com>
	<4278274.l3AdBruVPA@mranderson>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43522 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376Ab2GIQS0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Jul 2012 12:18:26 -0400
Received: by bkwj10 with SMTP id j10so6169456bkw.19
        for <ceph-devel@vger.kernel.org>; Mon, 09 Jul 2012 09:18:25 -0700 (PDT)
In-Reply-To: <4278274.l3AdBruVPA@mranderson>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?Sz=E9kelyi_Szabolcs?= <szekelyi@niif.hu>
Cc: ceph-devel@vger.kernel.org

On Sun, Jul 8, 2012 at 11:53 AM, Sz=E9kelyi Szabolcs <szekelyi@niif.hu>=
 wrote:
> On 2012. July 4. 09:34:04 Gregory Farnum wrote:
>> Hrm, it looks like the OSD data directory got a little busted someho=
w. How
>> did you perform your upgrade? (That is, how did you kill your daemon=
s, in
>> what order, and when did you bring them back up.)
>
> Just to make sure: what's the recommended upgrade process?

Nominally, you should be able to upgrade however you like, but this
doesn't get much testing. We normally recommend doing the monitors,
and then doing OSDs all together or a rack at a time (depending on
cluster size).

In any case, it sounds like you didn't break anything that way, I was
just looking around for clues. :)
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
