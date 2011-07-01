From: huang jun <hjwsm1989@gmail.com>
Subject: Re: workload balance
Date: Fri, 1 Jul 2011 08:13:08 +0800
Message-ID: <BANLkTikV9pv0V0QQ+md94MHy7SYioneP-A@mail.gmail.com>
References: <BANLkTikHkttLd6vMeZxVm4FNeGJ+-E9uTg@mail.gmail.com>
	<4E08F0E5.4080501@dreamhost.com>
	<BANLkTi=rSvuawL_VqVYZqpif=GEj+iivmQ@mail.gmail.com>
	<4E0CBAA5.50804@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34060 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab1GAANK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2011 20:13:10 -0400
Received: by wyg8 with SMTP id 8so1882045wyg.19
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jun 2011 17:13:08 -0700 (PDT)
In-Reply-To: <4E0CBAA5.50804@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

thank you Josh
Currently,we can reduce the primary workload by distributing read
requests to replicas,
but once a object becomes a extremly hot point, this stratey does not
make much difference, so can we bring Tiered Storage into ceph, just
like to use HSM or ILM? In this way, client can got data more
effeciently.

best regards!

=D4=DA 2011=C4=EA7=D4=C21=C8=D5 =C9=CF=CE=E72:04=A3=ACJosh Durgin <josh=
=2Edurgin@dreamhost.com> =D0=B4=B5=C0=A3=BA
> On 06/27/2011 05:25 PM, huang jun wrote:
>> thanks=A3=ACJosh
>> By default=A3=ACwe set two replicas for each PG,so if we use ceph
>> as back-end storage of a website, you know, some files will be frequ=
ently read,
>> if then of thousands clients do this, some osd's workload will be ve=
ry high.
>> so in this circumstance, how to balance the whole  cluster's workloa=
d?
>
> If the files don't change often, they can be cached by the clients. I=
f
> there really is one object that is being updated and read frequently,
> there's not much you can do currently. To reduce the load on the prim=
ary
> OSD, we could add a flag to the MDS to tell clients to read from
> replicas based on the usage.
>
> Josh
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
