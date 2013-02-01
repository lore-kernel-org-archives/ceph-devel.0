From: Gregory Farnum <greg@inktank.com>
Subject: Re: Maintenance mode
Date: Thu, 31 Jan 2013 23:48:42 -0800
Message-ID: <16B6063F84B648D2BC7A4B01D365C070@inktank.com>
References: <CAEqYNSaOVFQyYaN=e0JeBBvj7r3hnjc3f=gtw3_HQsSsxJBLFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:34761 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab3BAHss convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Feb 2013 02:48:48 -0500
Received: by mail-pb0-f42.google.com with SMTP id wz17so2051435pbc.1
        for <ceph-devel@vger.kernel.org>; Thu, 31 Jan 2013 23:48:48 -0800 (PST)
In-Reply-To: <CAEqYNSaOVFQyYaN=e0JeBBvj7r3hnjc3f=gtw3_HQsSsxJBLFw@mail.gmail.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?utf-8?Q?Alexis_G=C3=9CNST_HORN?= <alexis.gunsthorn@outscale.com>, John Wilkins <john.wilkins@inktank.com>
Cc: ceph-devel@vger.kernel.org

Try "ceph osd set noout" beforehand and then "ceph osd unset noout". Th=
at will prevent any OSDs from getting removed from the mapping, so no d=
ata will be rebalanced. I don't think there's a way to prevent OSDs fro=
m getting zapped on an individual basis, though. =20
This is described briefly in the docs at http://ceph.com/docs/master/ra=
dos/operations/troubleshooting-osd/?highlight=3Dnoout, though it could =
probably be a bit more clear.
-Greg


On Thursday, January 31, 2013 at 11:40 PM, Alexis G=C3=9CNST HORN wrote=
:

> Hello to all,
> =20
> Here is my setup :
> =20
> - 2 racks
> - osd1 .. osd6 in rack1
> - osd7 .. osd12 in rack2
> - replica =3D 2
> - CRUSH map set to put replicas accross racks
> =20
> My question :
> Let's imagine that one day, I need to unplug one of the racks (let's
> say, rack1). No problem because an other copy of my objects will be i=
n
> the other rack. But, if i do it, Ceph will start to rebalance data
> accross OSDs.
> =20
> So, is there a way to put nodes in "Maintenance mode", in order to pu=
t
> Ceph in "degraded" mode, but avoiding any remaping.
> =20
> The idea is to have a command like :
> =20
> $ ceph osd set maintenance=3Don osd.1
> $ ceph osd set maintenance=3Don osd.2
> $ ceph osd set maintenance=3Don osd.3
> $ ceph osd set maintenance=3Don osd.4
> $ ceph osd set maintenance=3Don osd.5
> $ ceph osd set maintenance=3Don osd.6
> =20
> So Ceph knows that 6 osds are down, goes into degraded mode, but
> without remapping data.
> Then, once maintenance finished, i'll only have to do the opposite :
> =20
> $ ceph osd set maintenance=3Doff osd.1
> $ ceph osd set maintenance=3Doff osd.2
> $ ceph osd set maintenance=3Doff osd.3
> $ ceph osd set maintenance=3Doff osd.4
> $ ceph osd set maintenance=3Doff osd.5
> $ ceph osd set maintenance=3Doff osd.6
> =20
> What do you think ?
> I know that there is a way in Ceph doc to do so with reweight, but
> it's a little bit complex...
> =20
> What do you think ?
> Thanks,
> =20
> Alexis
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org (mailto:majordomo@=
vger.kernel.org)
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
