From: Gregory Farnum <greg@inktank.com>
Subject: Re: Paxos and long-lasting deleted data
Date: Sun, 3 Feb 2013 13:46:21 -0800
Message-ID: <9D4D1E35A663400D9BC055C2C879DF8A@inktank.com>
References: <CABYiri8fbbpuhh0RguqdsmYEbEkYz_+PKO4UJqWqKb1TwDcc6A@mail.gmail.com>
 <CAPYLRzjwn4LxnzbX9SBJL7x7AtX6=pmv84HXBGykNGHn7zVLTA@mail.gmail.com>
 <CABYiri82rCvVD79rnhm3mFPoegnF7w4SNyUrFr+axEoty69n1A@mail.gmail.com>
 <CAPYLRzieYDDOrbpj_Cs0czxA3uFrLez6A5gKdQoMFT2dyA9vqA@mail.gmail.com>
 <CABYiri-Q=N+N9TQrTkex+WVF0wu94CuXMx_FHXBsEsrjaO1kPQ@mail.gmail.com>
 <CABYiri-A=_YnR31uZ57Jqu=oWOpcm9yauezB=0=okLbQA3wYtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:60011 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751558Ab3BCVqY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Feb 2013 16:46:24 -0500
Received: by mail-pb0-f52.google.com with SMTP id mc8so2092892pbc.25
        for <ceph-devel@vger.kernel.org>; Sun, 03 Feb 2013 13:46:23 -0800 (PST)
In-Reply-To: <CABYiri-A=_YnR31uZ57Jqu=oWOpcm9yauezB=0=okLbQA3wYtg@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrey Korolyov <andrey@xdel.ru>
Cc: Dan Mick <dan.mick@inktank.com>, Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sunday, February 3, 2013 at 11:45 AM, Andrey Korolyov wrote:
> Just an update: this data stayed after pool deletion, so there is
> probably a way to delete garbage bytes on live pool without doing any
> harm(hope so), since it is can be dissected from actual pool pool dat=
a
> placement, in theory.


What? You mean you deleted the pool and the data in use by the cluster =
didn't drop? If that's the case, check and see if it's still at the sam=
e level =E2=80=94 pool deletes are asynchronous and throttled to preven=
t impacting client operations too much.
-Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
