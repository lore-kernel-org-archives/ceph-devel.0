From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: workload balance
Date: Mon, 27 Jun 2011 14:06:45 -0700
Message-ID: <4E08F0E5.4080501@dreamhost.com>
References: <BANLkTikHkttLd6vMeZxVm4FNeGJ+-E9uTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:60526 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754139Ab1F0VGs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2011 17:06:48 -0400
In-Reply-To: <BANLkTikHkttLd6vMeZxVm4FNeGJ+-E9uTg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 06/27/2011 02:34 AM, huang jun wrote:
> hi=A3=ACall
> Here is a problem confused me a lot. Some OSD's workload will be very=
 high
> when the client read a file continuously. So i think the cluster must
> have a strategy to balance workload
> there are two classes "MovingAverager and  IATAverager ",but i can no=
t
> figure out what the class IATAverager mean here?
> and futhermore, can we bring tiered storage theory in ceph?
>=20
> thanks!

Those classes were attempts to use some statistics to discard some
reads, but they did not work so they've been removed from master.
Our current strategy is simply striping files across objects.

Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
