From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: workload balance
Date: Thu, 30 Jun 2011 11:04:21 -0700
Message-ID: <4E0CBAA5.50804@dreamhost.com>
References: <BANLkTikHkttLd6vMeZxVm4FNeGJ+-E9uTg@mail.gmail.com>	<4E08F0E5.4080501@dreamhost.com> <BANLkTi=rSvuawL_VqVYZqpif=GEj+iivmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:54719 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab1F3SEV convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2011 14:04:21 -0400
In-Reply-To: <BANLkTi=rSvuawL_VqVYZqpif=GEj+iivmQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 06/27/2011 05:25 PM, huang jun wrote:
> thanks=A3=ACJosh
> By default=A3=ACwe set two replicas for each PG,so if we use ceph
> as back-end storage of a website, you know, some files will be freque=
ntly read,
> if then of thousands clients do this, some osd's workload will be ver=
y high.
> so in this circumstance, how to balance the whole  cluster's workload=
?

If the files don't change often, they can be cached by the clients. If
there really is one object that is being updated and read frequently,
there's not much you can do currently. To reduce the load on the primar=
y
OSD, we could add a flag to the MDS to tell clients to read from
replicas based on the usage.

Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
