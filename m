From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: idempotent mon commands
Date: Mon, 30 Jan 2012 11:18:23 -0800
Message-ID: <CAORUGqCZCjTOZMnJ4eOS84exhRDywEtX-Kc0w+Dy92h=z4g-NA@mail.gmail.com>
References: <Pine.LNX.4.64.1201301039050.23054@cobra.newdream.net> <CAC-hyiFYHtPYPdWRfkdcMhx6uSk75WEa77PmO7ckuEUOGkP4LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:64906 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028Ab2A3TSo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2012 14:18:44 -0500
Received: by werb13 with SMTP id b13so3781927wer.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2012 11:18:43 -0800 (PST)
In-Reply-To: <CAC-hyiFYHtPYPdWRfkdcMhx6uSk75WEa77PmO7ckuEUOGkP4LA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehuda@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org

+1 on both of these.

On Mon, Jan 30, 2012 at 10:52, Yehuda Sadeh Weinraub
<yehuda@hq.newdream.net> wrote:
> On Mon, Jan 30, 2012 at 10:42 AM, Sage Weil <sage@newdream.net> wrote=
:
>>
>> One of the failure we see in qa during osd thrashing is failure from
>> commands like 'ceph osd out 2'. =C2=A0A transient (say, network) err=
or can
>> prevent the ceph command from getting the reply, and when it is rese=
nt we
>> get EINVAL 'already marked down' or similar.
>>
>> In general, should we make these commands return success in those ca=
ses?
>> Or should callers be prepared to tolerate those sorts of errors?
>
>
> I'd say that in any case where the end result is the expected state,
> then we should return success (e.g., avoid error when already marked
> down). Where there's real error we sholdn't hide it.
>
>>
>> The in/out/down ones seem pretty straightward to me. =C2=A0A tricker=
 one is
>> 'ceph osd create 123', which currently fails if 123 already exists (=
and
>> you thus do not get to use that id). =C2=A0Not that we do that; the =
chef stuff
>> will do 'ceph osd create' and a newly allocated id will be part of t=
he
>> reply.
>>
> We can let the client decide whether this is an error or not by addin=
g
> 'exclusive' flag to the request (and make it the default behavior).
>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
