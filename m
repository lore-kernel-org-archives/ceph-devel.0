From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: osd down after adding OSDs
Date: Tue, 09 Aug 2011 10:15:10 -0700
Message-ID: <4E416B1E.5040904@dreamhost.com>
References: <CABAwU-amM1mTyyquDFyc+BQsh21D6vkw-ER+X4ZPNm7_CH5PPQ@mail.gmail.com>	<4E407BB0.1020409@dreamhost.com> <CABAwU-ZVhwSRyZgy9n1EG7gUWpxgcH97YnKjPjQn4C+TvomALQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:57483 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753893Ab1HIRPK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2011 13:15:10 -0400
In-Reply-To: <CABAwU-ZVhwSRyZgy9n1EG7gUWpxgcH97YnKjPjQn4C+TvomALQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/08/2011 06:29 PM, huang jun wrote:
> thanks=A3=ACJosh
> Here the osd.10.log for the second condition.
> and osd.15-tail.log for the first, because osd.15.log is about 130MB,
> i'm not permitted to upload it, so i tail 70000 lines of it.
> btw if the recovery statechart in GetInfo state, what will happened i=
f
> we recept a MOSDPGLog message, the statechart going to Crashed state?

It depends on when the message was sent. If it was sent during a
previous peering, it is ignored before it reaches the state machine by
checking pg->old_peering_msg in OSD::handle_pg_log.

Otherwise, if the log was sent after the current peering attempt
started, the primary does enter the Crashed state. It's a bug that a lo=
g
was received in this case, since GetInfo is the first stage of peering,
and no logs were requested yet.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
