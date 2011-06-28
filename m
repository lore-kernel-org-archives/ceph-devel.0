From: huang jun <hjwsm1989@gmail.com>
Subject: Re: workload balance
Date: Tue, 28 Jun 2011 08:25:50 +0800
Message-ID: <BANLkTi=rSvuawL_VqVYZqpif=GEj+iivmQ@mail.gmail.com>
References: <BANLkTikHkttLd6vMeZxVm4FNeGJ+-E9uTg@mail.gmail.com>
	<4E08F0E5.4080501@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41030 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754939Ab1F1AZw convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2011 20:25:52 -0400
Received: by wyg8 with SMTP id 8so1417942wyg.19
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jun 2011 17:25:51 -0700 (PDT)
In-Reply-To: <4E08F0E5.4080501@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

thanks=A3=ACJosh
By default=A3=ACwe set two replicas for each PG,so if we use ceph
as back-end storage of a website, you know, some files will be frequent=
ly read,
if then of thousands clients do this, some osd's workload will be very =
high.
so in this circumstance, how to balance the whole  cluster's workload?

=D4=DA 2011=C4=EA6=D4=C228=C8=D5 =C9=CF=CE=E75:06=A3=ACJosh Durgin <jos=
h.durgin@dreamhost.com> =D0=B4=B5=C0=A3=BA
> On 06/27/2011 02:34 AM, huang jun wrote:
>> hi=A3=ACall
>> Here is a problem confused me a lot. Some OSD's workload will be ver=
y high
>> when the client read a file continuously. So i think the cluster mus=
t
>> have a strategy to balance workload
>> there are two classes "MovingAverager and  IATAverager ",but i can n=
ot
>> figure out what the class IATAverager mean here?
>> and futhermore, can we bring tiered storage theory in ceph?
>>
>> thanks!
>
> Those classes were attempts to use some statistics to discard some
> reads, but they did not work so they've been removed from master.
> Our current strategy is simply striping files across objects.
>
> Josh
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
