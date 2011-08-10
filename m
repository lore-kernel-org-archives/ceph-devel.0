From: huang jun <hjwsm1989@gmail.com>
Subject: Re: osd down after adding OSDs
Date: Wed, 10 Aug 2011 08:13:17 +0800
Message-ID: <CABAwU-aRtKR6FdM5jDy_p3U6-TJVgxfhbsA7gsaXw-vKBz_LDA@mail.gmail.com>
References: <CABAwU-amM1mTyyquDFyc+BQsh21D6vkw-ER+X4ZPNm7_CH5PPQ@mail.gmail.com>
	<4E407BB0.1020409@dreamhost.com>
	<CABAwU-ZVhwSRyZgy9n1EG7gUWpxgcH97YnKjPjQn4C+TvomALQ@mail.gmail.com>
	<4E416B1E.5040904@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:37191 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981Ab1HJANS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Aug 2011 20:13:18 -0400
Received: by vxi9 with SMTP id 9so441469vxi.19
        for <ceph-devel@vger.kernel.org>; Tue, 09 Aug 2011 17:13:17 -0700 (PDT)
In-Reply-To: <4E416B1E.5040904@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

=D4=DA 2011=C4=EA8=D4=C210=C8=D5 =C9=CF=CE=E71:15=A3=ACJosh Durgin <jos=
h.durgin@dreamhost.com> =D0=B4=B5=C0=A3=BA
> On 08/08/2011 06:29 PM, huang jun wrote:
>> thanks=A3=ACJosh
>> Here the osd.10.log for the second condition.
>> and osd.15-tail.log for the first, because osd.15.log is about 130MB=
,
>> i'm not permitted to upload it, so i tail 70000 lines of it.
>> btw if the recovery statechart in GetInfo state, what will happened =
if
>> we recept a MOSDPGLog message, the statechart going to Crashed state=
?
>
> It depends on when the message was sent. If it was sent during a
> previous peering, it is ignored before it reaches the state machine b=
y
> checking pg->old_peering_msg in OSD::handle_pg_log.
>
> Otherwise, if the log was sent after the current peering attempt
> started, the primary does enter the Crashed state. It's a bug that a =
log
> was received in this case, since GetInfo is the first stage of peerin=
g,
> and no logs were requested yet.
>
thanks=A3=ACJosh
That explains the error i encountered,in GetInfo state,the peer OSD sho=
uld send
MOSDPGNotify msg but not MOSDPGLog msg,so it's strange in upper conditi=
on.
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
