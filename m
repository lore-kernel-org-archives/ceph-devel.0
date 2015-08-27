From: Joshua Schmid <jschmid@suse.de>
Subject: Re: Proposal: data-at-rest encryption
Date: Thu, 27 Aug 2015 10:46:30 +0200
Message-ID: <55DECE66.5000505@suse.de>
References: <55DAE0F7.1070905@suse.de>
 <alpine.DEB.2.00.1508261744370.13116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43339 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750802AbbH0IoF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Aug 2015 04:44:05 -0400
In-Reply-To: <alpine.DEB.2.00.1508261744370.13116@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org



On 08/27/2015 02:49 AM, Sage Weil wrote:
> Hi Joshua!
>=20

Hi Sage,


> Overall the ceph-disk changes look pretty good, and it looks like And=
rew=20
> and David have both reviewed.  My only real concern/request is that t=
he=20
> key server be as pluggable as possible.  You're using ftps here, but =
we'd=20
> also like to allow deo[1], or even the mon config-key service.

Thank for having a look!
I think this should do:

https://github.com/jschmid1/ceph/commit/7dd64c70bcb8d986568d6f379a6fbf9=
a0e40a441

Service of choice can now be set in the ceph.conf and will be handled
separately. This is currently only for unlocking/mapping but will be
extended for locking/new if this solution is acceptable.


>=20
> With the original mon proposal, we also wanted an additional layer of=
=20
> security (beyond simply access to the storage network) by=20
> storing some key-fetching-key on the disk.

Like deo does it? (From the deo README)

"""
Second, we will add a new random key to the pre-existing LUKS encrypted
disk and then encrypt it using Deo in a known location.
"""


  It looks like the ftps
> access is unauthenticated... is that right?  I would assume (I'm not =
hte=20
> expert!) that most key management systems require some credentials to=
=20
> store/fetch keys?

Its totally unauthenticated, thats right. It'd be possible to require
USER/PASS for ftp.
>=20
> sage
>=20

--=20
=46reundliche Gr=FC=DFe - Kind regards,
Joshua Schmid
Trainee - Storage
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 N=FCrnberg
-----------------------------------------------------------------------=
---------------------------------------------
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard,
Jennifer Guild, Dilip Upmanyu, Graham Norton, HRB 21284 (AG N=FCrnberg)
-----------------------------------------------------------------------=
---------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
