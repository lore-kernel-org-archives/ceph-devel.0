From: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Subject: Re: idempotent mon commands
Date: Mon, 30 Jan 2012 10:52:57 -0800
Message-ID: <CAC-hyiFYHtPYPdWRfkdcMhx6uSk75WEa77PmO7ckuEUOGkP4LA@mail.gmail.com>
References: <Pine.LNX.4.64.1201301039050.23054@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34501 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab2A3Sw6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2012 13:52:58 -0500
Received: by ghrr11 with SMTP id r11so1937439ghr.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2012 10:52:57 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1201301039050.23054@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Jan 30, 2012 at 10:42 AM, Sage Weil <sage@newdream.net> wrote:
>
> One of the failure we see in qa during osd thrashing is failure from
> commands like 'ceph osd out 2'. =A0A transient (say, network) error c=
an
> prevent the ceph command from getting the reply, and when it is resen=
t we
> get EINVAL 'already marked down' or similar.
>
> In general, should we make these commands return success in those cas=
es?
> Or should callers be prepared to tolerate those sorts of errors?


I'd say that in any case where the end result is the expected state,
then we should return success (e.g., avoid error when already marked
down). Where there's real error we sholdn't hide it.

>
> The in/out/down ones seem pretty straightward to me. =A0A tricker one=
 is
> 'ceph osd create 123', which currently fails if 123 already exists (a=
nd
> you thus do not get to use that id). =A0Not that we do that; the chef=
 stuff
> will do 'ceph osd create' and a newly allocated id will be part of th=
e
> reply.
>
We can let the client decide whether this is an error or not by adding
'exclusive' flag to the request (and make it the default behavior).

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
