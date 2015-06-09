From: Zack Cerza <zack@redhat.com>
Subject: Re: provisioning teuthology targets with OpenStack
Date: Tue, 9 Jun 2015 12:25:45 -0400 (EDT)
Message-ID: <837976248.11945956.1433867145523.JavaMail.zimbra@redhat.com>
References: <557479B4.9060207@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:51952 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844AbbFIQ0u convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Jun 2015 12:26:50 -0400
In-Reply-To: <557479B4.9060207@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic!

I'm really happy to hear you have the time and motivation to work on th=
is! It's something I've wanted to get to for a while, but other things =
keep getting in the way.

I'd suggest looking at teuthology.provision.Downburst to investigate ma=
ybe pulling some of its functionality into a base class that a potentia=
l OpenStack subclass could also benefit from. I'd love to see us using =
a common interface for all of our provisioning. If that seems like a lo=
t of work, I'd be willing to be the one to create the base class and wo=
rk with you to make sure its API was useful for OpenStack as well.

Thanks,
Zack

----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Zack Cerza" <zcerza@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Sunday, June 7, 2015 11:04:52 AM
> Subject: provisioning teuthology targets with OpenStack
>=20
> Hi Zack,
>=20
> I'm motivated by my recent experience with hacking teuthology and con=
tainers
> :-) I'd like to give
>=20
> http://tracker.ceph.com/issues/6502 "provision targets using a cloud =
API"
>=20
> a shot with OpenStack in mind (because I know nothing of EC2 really).=
 The
> idea is to make it relatively easy for someone with access to an Open=
Stack
> tenant to using instead of downburst. Not only would that simplify th=
e
> development process for people without access to the lab, it would al=
so
> allow the addition of more horsepower to the lab. What do you think ?
>=20
> Cheers
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
