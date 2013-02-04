From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Paxos and long-lasting deleted data
Date: Mon, 4 Feb 2013 08:31:34 +0300
Message-ID: <CABYiri-i8LYcp2K60gxjnm=oQjMTziWYpNzvgOn7eBuP=2SaYQ@mail.gmail.com>
References: <CABYiri8fbbpuhh0RguqdsmYEbEkYz_+PKO4UJqWqKb1TwDcc6A@mail.gmail.com>
 <CAPYLRzjwn4LxnzbX9SBJL7x7AtX6=pmv84HXBGykNGHn7zVLTA@mail.gmail.com>
 <CABYiri82rCvVD79rnhm3mFPoegnF7w4SNyUrFr+axEoty69n1A@mail.gmail.com>
 <CAPYLRzieYDDOrbpj_Cs0czxA3uFrLez6A5gKdQoMFT2dyA9vqA@mail.gmail.com>
 <CABYiri-Q=N+N9TQrTkex+WVF0wu94CuXMx_FHXBsEsrjaO1kPQ@mail.gmail.com>
 <CABYiri-A=_YnR31uZ57Jqu=oWOpcm9yauezB=0=okLbQA3wYtg@mail.gmail.com> <9D4D1E35A663400D9BC055C2C879DF8A@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:48398 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714Ab3BDFbz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 00:31:55 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so6268640oag.32
        for <ceph-devel@vger.kernel.org>; Sun, 03 Feb 2013 21:31:54 -0800 (PST)
In-Reply-To: <9D4D1E35A663400D9BC055C2C879DF8A@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Dan Mick <dan.mick@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Feb 4, 2013 at 1:46 AM, Gregory Farnum <greg@inktank.com> wrote=
:
> On Sunday, February 3, 2013 at 11:45 AM, Andrey Korolyov wrote:
>> Just an update: this data stayed after pool deletion, so there is
>> probably a way to delete garbage bytes on live pool without doing an=
y
>> harm(hope so), since it is can be dissected from actual pool pool da=
ta
>> placement, in theory.
>
>
> What? You mean you deleted the pool and the data in use by the cluste=
r didn't drop? If that's the case, check and see if it's still at the s=
ame level =E2=80=94 pool deletes are asynchronous and throttled to prev=
ent impacting client operations too much.

Yep, of course, I meant this exactly - I have waited until ``ceph -w''
values was stabilized for a long period, then checked that a bunch of
files with same prefix as in deleted pool remains, then I purged them
manually. I`m not sure if this data was in use at the moment of pool
removal, as I mentioned above, it`s just garbage produced during
periods when cluster was degraded heavily.

> -Greg
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
