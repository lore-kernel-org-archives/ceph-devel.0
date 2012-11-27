From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: OSD and MON memory usage
Date: Tue, 27 Nov 2012 17:23:50 +0000
Message-ID: <20121127172350.b6d21634.ctpm@ist.utl.pt>
References: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
	<50AFA848.4050109@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.ist.utl.pt ([193.136.128.22]:56632 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab2K0RXy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 27 Nov 2012 12:23:54 -0500
In-Reply-To: <50AFA848.4050109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joao Eduardo Luis <joao.luis@inktank.com>
Cc: ceph-devel@vger.kernel.org


On Fri, 23 Nov 2012 16:46:00 +0000 Joao Eduardo Luis <joao.luis@inktank=
=2Ecom> wrote:
> On 11/16/2012 05:24 PM, Cl=C3=A1udio Martins wrote:
> >  As for the monitor daemon on this cluster (running on a dedicated
> > machine), it is currently using 3.2GB of memory, and it got to that
> > point again in a matter of minutes after being restarted. Would it =
be
> > good if we tested with the changes from the wip-mon-leaks-fix branc=
h?
>=20
> Following up on this, wip-mon-leaks-fix was merged into master a coup=
le
> of days ago. If you have the chance to check if that fixes your memor=
y
> consumption issues on the monitor, it would be much appreciated!
>=20

 Hi Jo=C3=A3o,

 I've had a chance to test it and it does indeed seem to make a big
difference on mon memory usage.

 As for the OSD memory usage issue, it's still looking really bad. I'm
preparing to do more testing and send more info about this, but a lot
of unrelated stuff crept up this week and things are going slowly on
this front. I hope to talk more about this before the weekend.

Thanks!

Cl=C3=A1udio

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
