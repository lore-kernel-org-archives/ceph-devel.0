From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: ceph-disk improvements
Date: Thu, 7 Apr 2016 11:26:27 +0200
Message-ID: <20160407092627.GE26235@suse.de>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
 <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56312 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbcDGJ03 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Apr 2016 05:26:29 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id C5C96ABC7
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 09:26:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2016-04-02T07:54:05, Wido den Hollander <wido@42on.com> wrote:

>=20
> > Op 1 april 2016 om 17:36 schreef Sage Weil <sweil@redhat.com>:
> >=20
> >=20
> > Hi all,
> >=20
> > There are a couple of looming features for ceph-disk:
> >=20
> > 1- Support for additional devices when using BlueStore.  There can =
be up=20
> > to three: the main device, a WAL/journal device (small, ~128MB, ide=
ally=20
> > NVRAM), and a fast metadata device (as big as you have available; w=
ill be=20
> > used for internal metadata).
> >=20
> > 2- Support for setting up dm-cache, bcache, and/or FlashCache under=
neath=20
> > filestore or bluestore.
> >=20
>=20
> Keep in mind that you can't create a partition on a bcache device. So=
 when using
> bcache, the journal has to be filebased and not a partition.

Is there a point to running the journal on bcache? I see a point for
bcache for the (potentially on HDD) actual data store - but the
WAL/journal, would that not be directly on NVMe/PM/SSD (at the very
least)? Without an intervening cache?


Regards,
    Lars

--=20
Architect SDS, Distinguished Engineer
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton,=
 HRB 21284 (AG N=FCrnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wil=
de

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
