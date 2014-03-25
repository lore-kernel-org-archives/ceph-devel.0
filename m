From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 19:53:02 +0100
Message-ID: <1395773582.2076.10.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
			 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
			 <53316D18.7040103@ieee.org>
			 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
			 <53317BC2.9010700@ieee.org>
			 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
		 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>
		 <5331853D.40408@ieee.org> <1395767705.9967.5.camel@localhost>
	 <5331C05D.1060008@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:39880 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754581AbaCYSxI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 14:53:08 -0400
In-Reply-To: <5331C05D.1060008@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

Le mardi 25 mars 2014 =C3=A0 12:43 -0500, Alex Elder a =C3=A9crit :
> Please try applying this, on top of the previous patch.
> If you can then reproduce the problem we'll have a bunch
> of new information about the particular request that's
> leading to the failure.  That might tell us what more we
> can do to find the root cause.  Thank you.
>=20
> 					-Alex
>=20
> PS  I hope my mailer doesn't botch the long lines.  It might.
>=20

Here the execution will continue, no more kernel panic after this
debugging display. Is it wanted ?

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
