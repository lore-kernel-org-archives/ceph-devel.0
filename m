From: =?ISO-8859-1?Q?Sz=E9kelyi?= Szabolcs <szekelyi@niif.hu>
Subject: Re: global_init_daemonize: BUG: there are 1 child threads already started that will now die!
Date: Thu, 17 May 2012 19:19:01 +0200
Message-ID: <5352012.m3lbF3EvYq@mranderson>
References: <12500703.xTHoDB74aK@mranderson> <Pine.LNX.4.64.1205170902090.7019@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.ki.iif.hu ([193.6.222.241]:55930 "EHLO mail.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753495Ab2EQRTM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 May 2012 13:19:12 -0400
In-Reply-To: <Pine.LNX.4.64.1205170902090.7019@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 2012. May 17. 09:02:45 Sage Weil wrote:
> On Thu, 17 May 2012, Sz=E9kelyi Szabolcs wrote:
> > I get the $subject message when starting Ceph with the init script.=
 I have
> > to try it 15-20 times until the start suceeds. I've seen this messa=
ge
> > emitted by the monitor and MDS daemons, but never by OSDs. Is this =
really
> > a bug as the message says? I have two theoretically identical clust=
ers,
> > and only one of them produces this error, so something might be wro=
ng on
> > my side, but what?
>=20
> This is just a broken/racy check.  There's a patch in the stable bran=
ch
> that removes it.  It'll also be fixed in 0.47, out tomorrow most like=
ly.

Great, thank you both!

--=20
cc


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
