From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: PG: all requests stuck when acting set < min_size
Date: Tue, 27 Oct 2015 20:19:25 -0400 (EDT)
Message-ID: <629790552.47803809.1445991565199.JavaMail.zimbra@redhat.com>
References: <BLU175-W31BC44F9AFEBFB5588D05CDF220@phx.gbl> <CAJ4mKGYFiLaEkqTpVnc75pSE6L9YtO1=35HOr6xxMHAYaEEYwQ@mail.gmail.com> <CAN=+7FWZ_fm=UjkfmabMsmULLMTSFUqoQvnDCtp5UhYuW1YYDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:59865 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754805AbbJ1AT0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Oct 2015 20:19:26 -0400
In-Reply-To: <CAN=+7FWZ_fm=UjkfmabMsmULLMTSFUqoQvnDCtp5UhYuW1YYDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sjust@redhat.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, GuangYang <yguang11@outlook.com>, ceph-devel@vger.kernel.org

----- Original Message -----
> From: "Samuel Just" <sjust@redhat.com>
> To: "Gregory Farnum" <gfarnum@redhat.com>
> Cc: "GuangYang" <yguang11@outlook.com>, ceph-devel@vger.kernel.org
> Sent: Wednesday, 28 October, 2015 7:05:42 AM
> Subject: Re: PG: all requests stuck when acting set < min_size
>=20
> Actually, we really can't accept reads below min_size and still keep
> the properties we want it to have.  Suppose we have 3 osds (a, b, and
> c) which see writes 0...1000.  min_size is 2.  If a and b are then
> powered off only having committed up to 900 (therefore the client
> could only have seen up to 900 commit), then c would be able to serve
> reads based on updates up to 1000 with a and b stopped (no way to kno=
w
> a and b only committed to 900).  If c then stops and a and b are
> restarted, they would begin serving reads and writes only based on
> commits up to 900 even though we would have exposed the writes up to
> 1000 to the client.

If a and/or b then accept a write you have a recipe for split-brain and=
 no one
wants to see that in Ceph.

Cheers,
Brad

> -Sam
>=20
> On Tue, Oct 27, 2015 at 12:47 PM, Gregory Farnum <gfarnum@redhat.com>=
 wrote:
> > On Tue, Oct 27, 2015 at 11:47 AM, GuangYang <yguang11@outlook.com> =
wrote:
> >> Hi there,
> >> Is there any reason we stuck read only requests as well for a PG w=
hen the
> >> acting set size is less than min_size?
> >
> > A few.
> > The most important reason: PGs don't have any concept of a read-onl=
y
> > mode in the code. They are "active" or not, and an active PG handle=
s
> > writes. (The full flags and other things which block writes but all=
ow
> > reads are at the OSD level, not the PG level, and are handled when =
ops
> > come in before they reach the PG.) Allowing read requests against a=
 PG
> > to complete even when we aren't taking writes on a per-PG level wou=
ld
> > take some doing.
> > Also: it would be weird from several different levels. We'd need to
> > keep track of client streams because we wouldn't want to let throug=
h a
> > read that is ordered after a write. How would we handle the memory
> > pressure implied by that? While I can imagine it being useful for s=
ome
> > stuff like RGW reads, in general making data available for read but
> > not write is a pretty complicated thing to explain to users =E2=80=94=
 how do
> > we expose that in a useful way?
> > -Greg
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
