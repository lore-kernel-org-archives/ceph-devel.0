From: Niklas Goerke <niklas@niklasgoerke.de>
Subject: Re: PG distribution scattered
Date: Thu, 10 Oct 2013 15:40:24 +0200
Message-ID: <78144c346f1ae751f6d657a60b105e5e@niklasgoerke.de>
References: <4120b8bc5ae688af65d616f5a487e9bd@niklasgoerke.de>
 <alpine.DEB.2.00.1310100349400.7703@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from niklasgoerke.de ([46.38.232.61]:42998 "EHLO niklasgoerke.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754287Ab3JJNk1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 10 Oct 2013 09:40:27 -0400
In-Reply-To: <alpine.DEB.2.00.1310100349400.7703@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 10 Oct 2013 03:57:17 -0700 (PDT), Sage Weil wrote:
> > [=E2=80=A6]
> I suspect there are a few things going on.
>
> First, the new 'hashpspool' pool flag is not default (yet) but will=20
> make
> it so new pools don't line up on top of old pools and amplify any
> imbalance.  The ability to add the flag to an existing pool hasn't=20
> been
> merged yet, but new pools can get it if you put
>
> 	osd pool default flag hashpspool =3D true
>
> in your [mon] section and restart the mons.
>
> There is also a function call 'reweight-by-utilization' that will=20
> make
> minor adjustments to the (post-crush) weights to correct for the
> inevitable stastical variation.  Try running
>
> 	ceph osd reweight-by-utilization 110
>
> and it will adjust any OSD more than 10% above the mean.
>
> Also not that these utilization will be a bit noisy until there are a=
=20
> lot
> of objects in the systems; the reweight is based on bytes used and=20
> not
> PGs, so don't run it until you have written a fair bit of data to=20
> ceph.
>
> sage
>

Thank you for that quick answer!

The way I read it, the 'hashpool' flag can compensate for the problem=20
if you have multiple pools. This will probably help in many cases but=20
not for my setup. I only have one large pool, so this doesn't really=20
solve it for me.
Reweighing the OSDs seems to be more of a work-around than a fix. I=20
wouldn't want to use it in a productive environment=E2=80=A6


Coming back to the distribution of the PGs:
What distribution is to be expected from rjenkins? I get up to 123 PGs=20
per OSD, where 100 PGs per OSD is the average.
Can I use different parameters on creating the pool to get better=20
results?
Is there a different algorithm, other than rjenkins which can be=20
considered stable?

Thank you very much for your help!

Niklas
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
