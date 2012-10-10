From: James Horner <james.horner@precedent.co.uk>
Subject: Re: Client Location
Date: Wed, 10 Oct 2012 10:16:04 +0100 (BST)
Message-ID: <653431320.70.1349860564219.JavaMail.root@corellia.pncl.co.uk>
References: <CAPYLRzgznZaZ+xVsY1Er2sYKbF7hfpfewGDPygiHQDSmxDPu6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from corellia.pncl.co.uk ([195.224.14.166]:45690 "EHLO
	corellia.pncl.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291Ab2JJJQ0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Oct 2012 05:16:26 -0400
In-Reply-To: <CAPYLRzgznZaZ+xVsY1Er2sYKbF7hfpfewGDPygiHQDSmxDPu6Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: James Horner <james.horner@precedent.co.uk>, ceph-devel@vger.kernel.org, Mark Kampe <mark.kampe@inktank.com>

Hi There

The basic setup Im trying to get is a backend to a Hypervisor cluster, =
so that auto-failover and live migration works. The mail thing is that =
we have a number of datacenters with a gigabit interconnect that is not=
 always 100% reliable. In the event of a failure we want all the virtua=
l machines to fail over to the remaining datacenters, so we need all th=
e data in each location.
The other issue is that within each datacenter we can use link aggregat=
ion to increase the bandwidth between hypervisors and the ceph cluster =
but between the datacenters we only have the gigabit so it become essen=
tial to have the hyperviors looking at the storage in the same datacent=
er.
Another consideration is that the virtual machines might get migrated b=
etween datacenters without any failure, and the main problem I see with=
 Mark suggests is that in this mode the migrated VM would still be conn=
ecting to the OSD's in the remote datacenter.

Tbh Im fairly new to ceph and I know im asking for everything and the k=
itchen sink! Any thoughts would be very helpful though.

Thanks
James

----- Original Message -----
=46rom: "Gregory Farnum" <greg@inktank.com>
To: "Mark Kampe" <mark.kampe@inktank.com>
Cc: "James Horner" <james.horner@precedent.co.uk>, ceph-devel@vger.kern=
el.org
Sent: Tuesday, October 9, 2012 5:48:37 PM
Subject: Re: Client Location

On Tue, Oct 9, 2012 at 9:43 AM, Mark Kampe <mark.kampe@inktank.com> wro=
te:
> I'm not a real engineer, so please forgive me if I misunderstand,
> but can't you create a separate rule for each data center (choosing
> first a local copy, and then remote copies), which should ensure
> that the primary is always local.  Each data center would then
> use a different pool, associated with the appropriate location-
> sensitive rule.
>
> Does this approach get you the desired locality preference?

This sounds right to me =E2=80=94 I think maybe there's a misunderstand=
ing
about how CRUSH works. What precisely are you after, James?
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
