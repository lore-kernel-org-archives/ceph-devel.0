From: =?UTF-8?B?Q2zDoXVkaW8=?= Martins <ctpm@ist.utl.pt>
Subject: Re: OSD and MON memory usage
Date: Wed, 28 Nov 2012 23:31:12 +0000
Message-ID: <20121128233112.78e4c3b963dc7132a77e7cd7@ist.utl.pt>
References: <20121116172401.ef3e5e52.ctpm@ist.utl.pt>
	<50AFA848.4050109@inktank.com>
	<20121127172350.b6d21634.ctpm@ist.utl.pt>
	<CA+4uBUYv49DmX0EC5QovOtpgR5=TFM1xK4LPjp0M-8bM9B_0iA@mail.gmail.com>
	<20121128210501.cefc7b4c2877410803d81c7f@ist.utl.pt>
	<CA+4uBUZ4+vZt-BErOeBBFMunwQBsiJURaoPEFpJ5FDrXUmQ2jQ@mail.gmail.com>
	<20121128213032.183913c7e662741850918f32@ist.utl.pt>
	<CAF6-1L4rAv5z15HhdZLHW1Uhy1Cb+cxfVG3FSRoF1L5gDMJ1cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.ist.utl.pt ([193.136.128.22]:52779 "EHLO smtp2.ist.utl.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215Ab2K1XbQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 28 Nov 2012 18:31:16 -0500
In-Reply-To: <CAF6-1L4rAv5z15HhdZLHW1Uhy1Cb+cxfVG3FSRoF1L5gDMJ1cA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: Samuel Just <sam.just@inktank.com>, Joao Eduardo Luis <joao.luis@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On Thu, 29 Nov 2012 00:13:25 +0100 Sylvain Munaut <s.munaut@whatever-co=
mpany.com> wrote:
> Hi,
>=20
> >  If you want, I can try to restart the whole thing tomorrow and col=
lect
> > fresh log output from the dying OSDs, or any other action or debug =
info
> > that you might find useful.
>=20
> Is the clock synchronized on all machines ?
>=20


 Yup. All machines synched by ntp.

Cl=C3=A1udio


> What you describe (growing mem, recovery that doesn't seem to end)
> seems pretty similar to what I experienced when clocks of OSD were of=
f
> ...
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
