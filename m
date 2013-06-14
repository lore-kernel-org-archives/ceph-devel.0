From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw- bind user to pool
Date: Fri, 14 Jun 2013 08:22:34 -0700
Message-ID: <CAC-hyiFxX+d-DtWEJROZett7dW4ShGyFuwsM26PX_Drtpjxamg@mail.gmail.com>
References: <5EFBD28BA42C604BB012164C72CA560450CBBE16@SMBXKO3.cgm.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:53520 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367Ab3FNPWg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 11:22:36 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so653021lab.14
        for <ceph-devel@vger.kernel.org>; Fri, 14 Jun 2013 08:22:34 -0700 (PDT)
In-Reply-To: <5EFBD28BA42C604BB012164C72CA560450CBBE16@SMBXKO3.cgm.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?J=E4ger=2C_Philipp?= <Philipp.Jaeger@cgm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jun 14, 2013 at 6:59 AM, J=E4ger, Philipp <Philipp.Jaeger@cgm.c=
om> wrote:
> Hello,
>
> We have several projects, which needs to save data to a rados object =
store via radosgw.
>
> Is it possible to bind a rgw user to a specific pool?

No, not at the moment. You can pre-create buckets for the users while
controlling the bucket placement settings, but that's probably not
what you're looking for.

>
> Perhaps it is also possible to bind a whole rgw to a specific pool? W=
e have set up 2 rgws, but when I add a certain pool in rgw1, it's synch=
ronized in the other one/ rgw2 . It's the same with the user database. =
So is it possible to separate it? We thought about 1RGW per project, bu=
t because of the sync, it's not possible I think?

Currently, the only way to do it right now is to create separate zones
and point each gateway at a different zone. However, you'll have to
create a completely separate set of users, and I'm having trouble
recommending actually doing that as it contradicts the direction we're
going (different regions that share users). We can make the list of
available pools configurable, so that you could control it on a
per-gateway basis. That's a pretty straight forward change. I opened
issue #5344 for that.

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
