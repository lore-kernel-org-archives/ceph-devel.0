From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Wed, 26 Mar 2014 00:04:55 +0100
Message-ID: <1395788695.2076.35.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
		 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
		 <53317BC2.9010700@ieee.org>
		 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
		 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>
		 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>
		 <5331C05D.1060008@ieee.org> <1395773582.2076.10.camel@localhost>
		 <5331D2E8.6060002@ieee.org>
		 <CALFYKtD5e6J4dtcCa53FkxM1UjYbLf6mq+1sO3Lq0uQWoEo1mA@mail.gmail.com>
		 <1395778894.2076.12.camel@localhost> <1395780835.2076.15.camel@localhost>
		 <1395781847.2076.21.camel@localhost>
		 <CALFYKtBuraQUWw7y6a=uiZDv1tgyz+sBQs7LHMR35nDAPYDSTQ@mail.gmail.com>
		 <1395782577.2076.23.camel@localhost>
		 <CALFYKtAhTmAJMxSNH5Zo2MVoj3wWeJxMybKUh3EMgFYuDwxZ7g@mail.gmail.com>
		 <1395783675.2076.26.camel@localhost>
		 <CALFYKtBFMbo91ZJngJDru8V3bNn7GXhr9_vgQAwiRk42wP1g1A@mail.gmail.com>
		 <1395784476.2076.28.camel@localhost> <1395785839.2076.30.camel@localhost>
	 <5332075F.8080105@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:43919 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbaCYXFJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 19:05:09 -0400
In-Reply-To: <5332075F.8080105@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Le mardi 25 mars 2014 =C3=A0 17:46 -0500, Alex Elder a =C3=A9crit :
> On 03/25/2014 05:17 PM, Olivier Bonvalet wrote:
> >=20
> > I now have this one very often (here 5 minutes after the host boot)=
 :
>=20
> I am fairly sure this indicates a use-after-free scenario,
> likely caused by something getting deleted before every
> user was done with it.
>=20
> I believe Ilya is done for the night; I'm going to spend some
> time looking at this to try to determine the cause.  If you
> are willing I'd love to have you try whatever fix I come up
> with.  I'd rather find a fix than just collect more information,
> but I may need to get more, we'll see.
>=20
> Thank you for all your reports, they help a lot.
>=20
> 					-Alex

Ok. I can apply some patch to help debug that yes.
I will try to reproduce on a different host, without customer data.

But I think I will stop here for the night too.

Thanks for your time,
Olivier

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
