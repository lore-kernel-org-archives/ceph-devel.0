From: Olivier Bonvalet <ceph.list@daevel.fr>
Subject: Re: Issue #5876 : assertion failure in rbd_img_obj_callback()
Date: Tue, 25 Mar 2014 15:01:50 +0100
Message-ID: <1395756110.2823.40.camel@localhost>
References: <1395736765.2823.29.camel@localhost>
		 <CALFYKtCUR6Swm5yxBP_7y42QVjj=v+XCtag7FmJ61AvoFjUmRA@mail.gmail.com>
		 <53316D18.7040103@ieee.org>
		 <CALFYKtCU4G7pebWV=icEdvL3Lf0aoUWbtxOYk7S2rV5G_UeynA@mail.gmail.com>
		 <53317BC2.9010700@ieee.org>
		 <CALFYKtDKDVRke9PvF3zX1ujHJ+5gTO+yJRrQLj0saZu+Ca8k-w@mail.gmail.com>
	 <1395753516.2823.37.camel@localhost> <533184AF.9050101@ieee.org>
	 <5331853D.40408@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from licorne.daevel.fr ([178.32.94.222]:36472 "EHLO
	licorne.daevel.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360AbaCYOB4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Mar 2014 10:01:56 -0400
In-Reply-To: <5331853D.40408@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ilya Dryomov <ilya.dryomov@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>


Le mardi 25 mars 2014 =C3=A0 08:31 -0500, Alex Elder a =C3=A9crit :
> ...
> >> So, a (partial) fix can be this patch ?
> >>
> >=20
> >=20
> > Yes, roughly.  I'd do the following instead.  It would be great
> > to learn whether it eliminates the one form of assertion failure
> > you were seeing.
> >=20
> > 					-Alex
> >
>=20
>=20
> Strike that, my last patch was dead wrong.  Sorry.  Try this:
>=20
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -2128,11 +2128,11 @@ static void rbd_img_obj_callback(struct
>  	rbd_assert(img_request->obj_request_count > 0);
>  	rbd_assert(which !=3D BAD_WHICH);
>  	rbd_assert(which < img_request->obj_request_count);
> -	rbd_assert(which >=3D img_request->next_completion);
>=20
>  	spin_lock_irq(&img_request->completion_lock);
> -	if (which !=3D img_request->next_completion)
> +	if (which > img_request->next_completion)
>  		goto out;
> +	rbd_assert(which =3D=3D img_request->next_completion);
>=20
>  	for_each_obj_request_from(img_request, obj_request) {
>  		rbd_assert(more);
>=20

Thanks !

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
