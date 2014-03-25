From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 14:18:36 +0100
Message-ID: <1395753516.2823.37.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
	 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
	 <53316D18.7040103@ieee.org>
	 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
	 <53317BC2.9010700@ieee.org>
	 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:35863 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752070AbaCYNSl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 09:18:41 -0400
In-Reply-To: <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Alex Elder <elder@ieee.org>, Ceph Development <ceph-devel@vger.kernel.org>



Le mardi 25 mars 2014 =C3=A0 14:57 +0200, Ilya Dryomov a =C3=A9crit :
> On Tue, Mar 25, 2014 at 2:51 PM, Alex Elder <elder@ieee.org> wrote:
> > On 03/25/2014 07:34 AM, Ilya Dryomov wrote:
> >>> On 03/25/2014 04:04 AM, Ilya Dryomov wrote:
> >>>> On Tue, Mar 25, 2014 at 10:39 AM, Olivier Bonvalet <ceph.list@da=
evel.fr> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> what can/should I do to help fix that problem ?
> >>>>>
> >>>>> for now, RBD kernel client hang on :
> >>>>>         Assertion failure in rbd_img_obj_callback() at line 213=
1:
> >>>>>            rbd_assert(which >=3D img_request->next_completion);
> >>>
> >>> If you can build your own kernel as Ilya says I'd like to
> >>> see the values of which and img_request->next_completion
> >>> here.
> >>
> >> Looks like which was 1, which means that next_completion had to be=
 2 or
> >> greater.  I miss solaris crash dumps ...
> >>
> >> On a different note, why are we asserting next_completion outside =
of
> >> a spinlock which is supposed to protect next_completion?
> >
> > That's a very good point (which could be easily remedied by moving
> > the assertion down a couple lines).  The image object request (#1)
> > in this case will have been marked done at this point; it's possibl=
e
> > that request #2 (or later) was concurrently getting handled by the
> > for_each_obj_request_from() loop below in that same function, but
> > may not have updated next_completion yet.
> >
> > So that *could* explain the tripped assertion.  The assertion
> > should be moved in any case, it's a bug.
> >
> > That being said, it doesn't explain the other assertion:
> >         rbd_assert(img_request !=3D NULL);
> > So there's at least one other thing going on.
>=20
> Yeah, exactly my thoughts.
>=20
> Thanks,
>=20
>                 Ilya

So, a (partial) fix can be this patch ?

--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -2123,6 +2123,7 @@ static void rbd_img_obj_callback(struct rbd_obj_r=
equest *obj_request)
        rbd_assert(obj_request_img_data_test(obj_request));
        img_request =3D obj_request->img_request;
=20
+       spin_lock_irq(&img_request->completion_lock);
        dout("%s: img %p obj %p\n", __func__, img_request, obj_request)=
;
        rbd_assert(img_request !=3D NULL);
        rbd_assert(img_request->obj_request_count > 0);
@@ -2130,7 +2131,6 @@ static void rbd_img_obj_callback(struct rbd_obj_r=
equest *obj_request)
        rbd_assert(which < img_request->obj_request_count);
        rbd_assert(which >=3D img_request->next_completion);
=20
-       spin_lock_irq(&img_request->completion_lock);
        if (which !=3D img_request->next_completion)
                goto out;
=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
