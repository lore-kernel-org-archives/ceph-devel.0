From: Christian Baun <cray@unix-ag.uni-kl.de>
Subject: Re: Chunk size in Ceph
Date: Mon, 28 Jun 2010 23:03:31 +0200
Message-ID: <201006282303.31753.cray@unix-ag.uni-kl.de>
References: <201006281627.54957.cray@unix-ag.uni-kl.de> <i0aghl$7jd$1@dough.gmane.org> <59AE22D6-8E1B-478E-8F03-04791D9C4FCC@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailgw1.uni-kl.de ([131.246.120.220]:55853 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478Ab0F1VDs convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Jun 2010 17:03:48 -0400
In-Reply-To: <59AE22D6-8E1B-478E-8F03-04791D9C4FCC@cs.ucsc.edu>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?q?Alex=E2=80=8E_Nelson?= <ajnelson@cs.ucsc.edu>
Cc: Thomas Mueller <thomas@chaschperli.ch>, ceph-devel@vger.kernel.org

Thanks a lot! :-)

Best Regards
     Christian=20

Am Montag, 28. Juni 2010 schrieb Alex=E2=80=8E Nelson:
> Hello all,
>=20
> Sage informed me of the place where the default size is set a while b=
ack.  In src/config.cc, the struct g_default_file_layout has a few defa=
ult size parameters.  He advised me that fl_stripe_unit and fl_object_s=
ize should be the same.  He also told me there's a way to set those on =
individual files, though that's potentially a pain and could be easier =
by just setting the default at compile time.
>=20
> There's also a feature request in on alternate methods of setting the=
se.  I'm sure the Ceph team would welcome input on this.
>=20
> http://tracker.newdream.net/issues/185
>=20
> --Alex
>=20
>=20
> On Jun 28, 2010, at 08:53 , Thomas Mueller wrote:
>=20
> > Am Mon, 28 Jun 2010 16:27:54 +0200 schrieb Christian Baun:
> >=20
> >> Hi,
> >>=20
> >> What is the chunk size of Ceph?
> >> I couldn't find this information.
> >>=20
> >> Best Regards
> >>   Christian
> >=20
> > IMHO 4mb=20
> >=20
> > found in first link if I google "ceph chunk size":
> > http://lmgtfy.com/?q=3Dceph+chunk+size
> >=20
> > (http://www.usenix.org/events/fast09/wips_posters/molina_wip.pdf)
> >=20
> > :)
> >=20
> > - Thomas
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
