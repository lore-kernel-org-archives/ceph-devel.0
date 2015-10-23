From: "ronny.hegewald@online.de" <ronny.hegewald@online.de>
Subject: Aw: Re: [PATCH] mark rbd requiring stable pages
Date: Fri, 23 Oct 2015 21:00:38 +0200
Message-ID: <trinity-bd8d28a8-eb31-4d51-a40a-9cb6baa3d514-1445626837983@3capp-1and1-bs05>
References: <201510151850.48348.ronny.hegewald@online.de>
 <562860F2.8070208@cs.wisc.edu>
 <CAOi1vP_e1aY4zMyYgRLy=D+jBs44g9++0VKutRm7D6q0OALJ3Q@mail.gmail.com>
 <201510222356.58184.ronny.hegewald@online.de>,
 <CAOi1vP-nEmqUTR5ouMEfWiVY_zc2j6-Vf4T9u=eNa0erehmoxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:56283 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbbJWTA7 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Oct 2015 15:00:59 -0400
In-Reply-To: <CAOi1vP-nEmqUTR5ouMEfWiVY_zc2j6-Vf4T9u=eNa0erehmoxw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Mike Christie <michaelc@cs.wisc.edu>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>

> Could you share the entire log snippet for those 10 minutes?
=C2=A0
Thats all in the logs.=C2=A0 But if more information would be useful te=
ll me which logs=20
to activate and i will give it another run. At least this part is easy =
to reproduce.

> Which kernel was this on?

The latest kernel i used which produced the corruption was 3.19.8.=20
The earliest one was 3.11.=20

> You really should have reported all of this as soon as you hit it - i=
t
> sounds like you've been dealing with this issue for a while. There's
> definitely more than stable pages in play here, I'll look into it.

I didn't report it as i didn't have any conclusive to report. There wer=
e a lot
of other things that could have created this in my configuration, espec=
ially as=20
there were no other reports of this kind. And in the meantime i have ch=
ecked=20
all kinds of this variables and could verify that they don't change any=
thing.=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
