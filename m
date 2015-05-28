From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: selinux scanning all OSD objects
Date: Thu, 28 May 2015 12:11:01 -0400 (EDT)
Message-ID: <289406985.6125316.1432829461820.JavaMail.zimbra@redhat.com>
References: <CABZ+qq=-rGfsk4MJo-PWm2-9PzxxfocpH=b1CRMW1aUsF=vqbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:51800 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556AbbE1QLD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 12:11:03 -0400
In-Reply-To: <CABZ+qq=-rGfsk4MJo-PWm2-9PzxxfocpH=b1CRMW1aUsF=vqbQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: ceph-devel@vger.kernel.org

Hi Dan,

Thanks for the pointer. I've added Milan Broz as a watcher to that tick=
et, since Milan's working on SELinux integration with Ceph.

- Ken

----- Original Message -----
> From: "Dan van der Ster" <dan@vanderster.com>
> To: "Ken Dreyer" <kdreyer@redhat.com>
> Cc: ceph-devel@vger.kernel.org
> Sent: Thursday, May 28, 2015 6:30:31 AM
> Subject: selinux scanning all OSD objects
>=20
> Hi Ken,
>=20
> I had forgotten about this issue:
>=20
> =C2=A0 http://tracker.ceph.com/issues/9927
>=20
> (as you see, it's similar to the updatedb indexing issue you recently
> inquired about)
>=20
> I didn't check, but I suspect this still affects major version
> upgrades also in RHEL7. Do you think this should also be sent
> upstream?
>=20
> Cheers, Dan
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
