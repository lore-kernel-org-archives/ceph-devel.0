From: =?iso-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Subject: AW: radosgw- bind user to pool
Date: Fri, 14 Jun 2013 17:02:21 +0000
Message-ID: <5EFBD28BA42C604BB012164C72CA560450CBBEE8@SMBXKO3.cgm.ag>
References: <5EFBD28BA42C604BB012164C72CA560450CBBE16@SMBXKO3.cgm.ag>
 <CAC-hyiFxX+d-DtWEJROZett7dW4ShGyFuwsM26PX_Drtpjxamg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smxko3.compugroup.com ([193.47.161.188]:56287 "EHLO
	SMXKO3.compugroup.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab3FNRC3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 13:02:29 -0400
In-Reply-To: <CAC-hyiFxX+d-DtWEJROZett7dW4ShGyFuwsM26PX_Drtpjxamg@mail.gmail.com>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hello,

thank you very much, I would like it very much.

Regards

Philipp

-----Urspr=FCngliche Nachricht-----
Von: yehudasa@gmail.com [mailto:yehudasa@gmail.com] Im Auftrag von Yehu=
da Sadeh
Gesendet: Freitag, 14. Juni 2013 17:23
An: J=E4ger, Philipp
Cc: ceph-devel@vger.kernel.org
Betreff: Re: radosgw- bind user to pool

On Fri, Jun 14, 2013 at 6:59 AM, J=E4ger, Philipp <Philipp.Jaeger@cgm.c=
om> wrote:
> Hello,
>
> We have several projects, which needs to save data to a rados object =
store via radosgw.
>
> Is it possible to bind a rgw user to a specific pool?

No, not at the moment. You can pre-create buckets for the users while c=
ontrolling the bucket placement settings, but that's probably not what =
you're looking for.

>
> Perhaps it is also possible to bind a whole rgw to a specific pool? W=
e have set up 2 rgws, but when I add a certain pool in rgw1, it's synch=
ronized in the other one/ rgw2 . It's the same with the user database. =
So is it possible to separate it? We thought about 1RGW per project, bu=
t because of the sync, it's not possible I think?

Currently, the only way to do it right now is to create separate zones =
and point each gateway at a different zone. However, you'll have to cre=
ate a completely separate set of users, and I'm having trouble recommen=
ding actually doing that as it contradicts the direction we're going (d=
ifferent regions that share users). We can make the list of available p=
ools configurable, so that you could control it on a per-gateway basis.=
 That's a pretty straight forward change. I opened issue #5344 for that=
=2E

>
> When you add more than one pool to the radosgw, in which pool will da=
ta be written? Is it random?
>

It's being selected randomly from the available data pools.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
