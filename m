From: Casey Bodley <cbodley@redhat.com>
Subject: Re: queue_transaction interface + unique_ptr + performance
Date: Thu, 3 Dec 2015 14:09:15 -0500 (EST)
Message-ID: <1575682875.28391996.1449169755619.JavaMail.zimbra@redhat.com>
References: <CO1PR02MB2082647268152AF8A71E84FF40D0@CO1PR02MB208.namprd02.prod.outlook.com> <alpine.DEB.2.00.1512030349200.19170@cobra.newdream.net> <CO1PR02MB2087E3AF3553B6269FBC10DF40D0@CO1PR02MB208.namprd02.prod.outlook.com> <20151203172508.GB13420@ultraspiritum.redhat.com> <CO1PR02MB208C446A80363743FC5D341F40D0@CO1PR02MB208.namprd02.prod.outlook.com> <CAN=+7FU1z9w=dDZ8+qbvKu-_ucYEU8K0eKS99Pd6Ku=A=t2gWg@mail.gmail.com> <CO1PR02MB208B0C5A0B6995CC4EE87F5F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:59765 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbbLCTJT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 14:09:19 -0500
In-Reply-To: <CO1PR02MB208B0C5A0B6995CC4EE87F5F40D0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Samuel Just <sjust@redhat.com>, "Adam C. Emerson" <aemerson@redhat.com>, Sage Weil <sage@newdream.net>, "Samuel Just (sam.just@inktank.com)" <sam.just@inktank.com>, ceph-devel@vger.kernel.org

After more discussion with Adam, it seems that making the Transaction
object itself a movable type could alleviate all of these concerns abou=
t
heap allocations, ownership, and lifetime.

The queue_transactions() interface could take a container of Transactio=
ns,
rather than pointers to Transactions, and the ObjectStore would move th=
em
out of the container into whatever representation it prefers.

Casey

----- Original Message -----
> Yes, if we can do that, that will be far more easier..I will double c=
heck
> that if apply_transaction is been used from any of the performance se=
nsitive
> path and do the changes accordingly..Thanks..
>=20
> -----Original Message-----
> From: Samuel Just [mailto:sjust@redhat.com]
> Sent: Thursday, December 03, 2015 9:51 AM
> To: Somnath Roy
> Cc: Adam C. Emerson; Sage Weil; Samuel Just (sam.just@inktank.com);
> ceph-devel@vger.kernel.org
> Subject: Re: queue_transaction interface + unique_ptr + performance
>=20
> As far as I know, there are no current users which want to use the
> Transaction later.  You could also change apply_transaction to copy t=
he
> Transaction into a unique_ptr since I don't think it's used in any
> performance sensitive code paths.
> -Sam
>=20
> On Thu, Dec 3, 2015 at 9:48 AM, Somnath Roy <Somnath.Roy@sandisk.com>=
 wrote:
> > Yes, that we can do..But, in that case aren't we restricting user i=
f they
> > want to do something with this Transaction object later. I didn't g=
o
> > through each and every part of the code yet (which is huge) that ar=
e using
> > these interfaces to understand if it is using Transaction object
> > afterwards.
> >
> > Thanks & Regards
> > Somnath
> > -----Original Message-----
> > From: Adam C. Emerson [mailto:aemerson@redhat.com]
> > Sent: Thursday, December 03, 2015 9:25 AM
> > To: Somnath Roy
> > Cc: Sage Weil; Samuel Just (sam.just@inktank.com);
> > ceph-devel@vger.kernel.org
> > Subject: Re: queue_transaction interface + unique_ptr + performance
> >
> > On 03/12/2015, Somnath Roy wrote:
> >> Yes, I posted the new result after adding -O2 in the compiler flag=
 and it
> >> shows almost no overhead with unique_ptr.
> >> I will add the test of adding to list overhead and start implement=
ing the
> >> new interface.
> >> But, regarding my other point of changing all the objecstore inter=
faces
> >> (my first mail on this mail chain in case you have missed) taking
> >> Transaction, any thought of that ?
> >> Should we reconsider having two queue_transaction interface ?
> >
> > As I understand it, the concern with switching to unique_ptr was th=
at the
> > callee would move from the reference without this being known to th=
e
> > caller.
> >
> > Would it make sense to pass as an RValue reference (i.e. Transactio=
nRef&&)?
> > That way the compiler should demand that the callers explicitly use
> > std::move on the reference they're holding, documenting at the site=
 of the
> > call that they're willing to give up ownership.
> >
> >
> > --
> > Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, =
US
> > IRC: Aemerson@{RedHat, OFTC, Freenode}
> > 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BF=
B9
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
