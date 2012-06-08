From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: mds dump
Date: Fri, 08 Jun 2012 15:55:42 -0400 (EDT)
Message-ID: <8b0e86a9-4b6c-4897-8ebd-3c894ff8e024@mail.linserv.se>
References: <96F588468D534E32AFF4784464C393E7@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 195-67-7-55.customer.telia.com ([195.67.7.55]:40323 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933436Ab2FHTz4 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 15:55:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 398B4DA033
	for <ceph-devel@vger.kernel.org>; Fri,  8 Jun 2012 15:55:43 -0400 (EDT)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d6bcKjHtL70s for <ceph-devel@vger.kernel.org>;
	Fri,  8 Jun 2012 15:55:42 -0400 (EDT)
Received: from mail.linserv.se (mail.linserv.se [195.67.7.55])
	by mail.linserv.se (Postfix) with ESMTP id 9BF4FDA031
	for <ceph-devel@vger.kernel.org>; Fri,  8 Jun 2012 15:55:42 -0400 (EDT)
In-Reply-To: <96F588468D534E32AFF4784464C393E7@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello

Thanks it worked perfectly :-)

Regards Martin
=20
> On Friday, June 8, 2012 at 12:31 PM, Tommi Virtanen wrote:=20
> > On Fri, Jun 8, 2012 at 12:22 PM, Martin Wilderoth=20
> > <martin.wilderoth@linserv.se (mailto:martin.wilderoth@linserv.se)> =
wrote:=20
> > > I have removed the data and metadata pool. Do I need to create th=
em again, or=20
> > > will they be created automaticly.=20
> > > Maybe I need the undocumented way of creating the mds map ?. I wo=
uld like to=20
> > > get an empty cephfs to play with again.=20
> >=20
> >=20
> >=20
> > Just create them again with rados mkpool, that gets you back to squ=
are one.=20
> Actually, this doesn't =E2=80=94 the MDS uses pool IDs for its access=
, not pool names, so you need to do a bit more (Sage > > illustrated th=
e simplest route for handling that).=20
> -Greg=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
