From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Backend ObjectStore engine performance bench with FIO
Date: Wed, 30 Sep 2015 09:57:04 -0400 (EDT)
Message-ID: <1995924083.23911468.1443621424366.JavaMail.zimbra@redhat.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03BD7EFC9@SSIEXCH-MB3.ssi.samsung.com> <720951445.22040695.1443205323581.JavaMail.zimbra@redhat.com> <727310273.23482377.1443557176794.JavaMail.zimbra@redhat.com> <6F3FA899187F0043BA1827A69DA2F7CC036269EB@shsmsx102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:53125 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbbI3N5H convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Sep 2015 09:57:07 -0400
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC036269EB@shsmsx102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <xiaoxi.chen@intel.com>
Cc: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, ceph-devel@vger.kernel.org

Hi Xiaoxi,

I pushed a new branch wip-fio-objectstore to ceph's github. I look forw=
ard to seeing James' work!

Thanks,
Casey

----- Original Message -----
> Hi Casey,
>       Would it better if we create an integration brunch on
>       ceph/ceph/wip-fio-objstore to allow more people try and improve=
 it?
>       Seems James has some patches.
>=20
> -Xiaoxi
>=20
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Casey Bodley
> > Sent: Wednesday, September 30, 2015 4:06 AM
> > To: James (Fei) Liu-SSI
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: Backend ObjectStore engine performance bench with FIO
> >=20
> > Hi James/Haomai/Xiaoxi,
> >=20
> > I spent some more time on the fio-objectstore branch, and pushed an
> > update.
> >=20
> > In testing, I realized that it was using the io_unit's start time t=
o name
> > the
> > objects, which meant that every write operation was creating a sepa=
rate
> > object.
> > In addition to fixing this to use fio's filenames for object names,=
 I also
> > added
> > support for the open_file() and close_file() functions. It now crea=
tes
> > objects
> > of the proper size on startup, so read-only jobs will work normally=
=2E
> > It also removes its objects on exit.
> >=20
> > On startup, it no longer calls create_collection() if it already ex=
ists, so
> > I was
> > able to re-run fio jobs over and over again without having to clear=
 the
> > data
> > directory (tested with FileStore and KeyValueStore).
> >=20
> > Casey
> >=20
> > ----- Original Message -----
> > > Great work James!
> > >
> > > ----- Original Message -----
> > > > From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
> > > > To: "Xiaoxi Chen" <xiaoxi.chen@intel.com>, "Casey Bodley"
> > > > <cbodley@redhat.com>
> > > > Cc: "Sage Weil" <sage@newdream.net>, ceph-devel@vger.kernel.org
> > > > Sent: Friday, September 25, 2015 1:55:29 PM
> > > > Subject: Backend ObjectStore engine performance bench with FIO
> > > >
> > > > Hi Xiaoxi,
> > > >
> > > >    With changing the IO mode from aio to sync, we make fio agai=
nst
> > newstore
> > > >    works. Even  with sync engine(I am still debugging the aio e=
ngine in
> > > >    newstore with Xiaoxi) in newstore, Newstore still performing=
 the
> > > >    best
> > > >    among all of backstore engine with our initial setup(Thoroug=
hly test
> > > >    will
> > > >    be run soon). Attachment is the initial data we collected fo=
r your
> > > >    reference. Thanks for great help from Xiaoxi from regarding =
to
> > Newstore
> > > >    development to support FIO.
> > > >
> > > > Hi Casey,
> > > >   Let me know if you need any help to put fio-ceph-objectstore =
into
> > > >   upstream.
> > > >   After then , I can commit all of mine into upstream.
> > >
> > > My pull request at https://github.com/ceph/ceph/pull/5943 is stil=
l
> > > pending.
> > > If you have patches that you'd like included, I would be happy to=
 pull
> > > them in; just point me to a branch.
> > >
> > > >
> > > >   Thanks,
> > > >   James
> > > >
> > >
> > > Thanks,
> > > Casey
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
> > > in the body of a message to majordomo@vger.kernel.org More
> > majordomo
> > > info at  http://vger.kernel.org/majordomo-info.html
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the
> > body of a message to majordomo@vger.kernel.org More majordomo info =
at
> > http://vger.kernel.org/majordomo-info.html
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
