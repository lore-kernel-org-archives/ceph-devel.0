From: srimugunthan dhandapani <srimugunthan.dhandapani@gmail.com>
Subject: Re: workload balance
Date: Sun, 17 Jul 2011 16:01:57 +0530
Message-ID: <CAMjNe_fkt1Mw489F_=dxGCqoxZes1ASZu5hGBJtiCgOMNYoeNg@mail.gmail.com>
References: <BANLkTikHkttLd6vMeZxVm4FNeGJ+-E9uTg@mail.gmail.com>
	<4E08F0E5.4080501@dreamhost.com>
	<BANLkTi=rSvuawL_VqVYZqpif=GEj+iivmQ@mail.gmail.com>
	<4E0CBAA5.50804@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:42524 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755731Ab1GQKb6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 17 Jul 2011 06:31:58 -0400
Received: by wyg8 with SMTP id 8so1565364wyg.19
        for <ceph-devel@vger.kernel.org>; Sun, 17 Jul 2011 03:31:57 -0700 (PDT)
In-Reply-To: <4E0CBAA5.50804@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

2011/6/30 Josh Durgin <josh.durgin@dreamhost.com>
>
> On 06/27/2011 05:25 PM, huang jun wrote:
> > thanks=A3=ACJosh
> > By default=A3=ACwe set two replicas for each PG,so if we use ceph
> > as back-end storage of a website, you know, some files will be freq=
uently read,
> > if then of thousands clients do this, some osd's workload will be v=
ery high.
> > so in this circumstance, how to balance the whole  cluster's worklo=
ad?
>
> If the files don't change often, they can be cached by the clients. I=
f
> there really is one object that is being updated and read frequently,
> there's not much you can do currently. To reduce the load on the prim=
ary
> OSD, we could add a flag to the MDS to tell clients to read from
> replicas based on the usage.


If a particular file is updated heavily, if we can change the inode
number of the heavily updated file, then the objects will be remapped
to new locations and can result in balancing.
Will that be a good solution to implement?

>
> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
