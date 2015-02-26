From: =?gb2312?B?0c/V/Q==?= <zyan@redhat.com>
Subject: Re: ceph-fuse remount issues
Date: Thu, 26 Feb 2015 16:28:46 +0800
Message-ID: <C2032CA0-61E4-430E-938F-C40D51BF8DDA@redhat.com>
References: <54E66259.9040501@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39106 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752401AbbBZI3A convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Feb 2015 03:29:00 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1Q8T0n9010947
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <ceph-devel@vger.kernel.org>; Thu, 26 Feb 2015 03:29:00 -0500
In-Reply-To: <54E66259.9040501@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: ceph-devel@vger.kernel.org, Gregory Farnum <gfarnum@redhat.com>


> =D4=DA 2015=C4=EA2=D4=C220=C8=D5=A3=AC06:23=A3=ACJohn Spray <john.spr=
ay@redhat.com> =D0=B4=B5=C0=A3=BA
>=20
>=20
> Background: a while ago, we found (#10277) that existing cache expira=
tion mechanism wasn't working with latest kernels.  We used to invalida=
te the top level dentries, which caused fuse to invalidate everything, =
but an implementation detail in fuse caused it to start ignoring our re=
peated invalidate calls, so this doesn't work any more.  To persuade fu=
se to dirty its entire metadata cache, Zheng added in a system() call t=
o "mount -o remount" after we expire things from our client side cache.

Change of d_invalidate() implementation breaks our old cache expiration=
 mechanism. When invalidating a denty, d_invalidate() also walks the de=
ntry subtree and try pruning any unused descendant dentries. Our old ca=
che expiration mechanism replies on this
to prune unused dentries. We invalidate the top level dentries, d_inval=
idate() try pruning unused dentries underneath these top level dentries=
=2E Prior to 3.18 kernel, d_invalidate() can fail if the dentry is used=
 by some one. Implementation of d_invalidate() change
in 3.18 kernel,  d_invalidate() always successes and unhash the dentry =
even if it=A1=AFs still in use. This behavior changes make us not be ab=
le to use d_invalidate() at will. One known bad consequence is getcwd()=
 system call return -EINVAL after process=A1=AF working directory gets =
invalidated.

The cephfs kernel client has no such issue because it maintains its own=
 per-session cap list. When it receives cache pressure message from MDS=
, it can iterate the list and prune unused caps.

>=20
> However, this was a bit of a hack and has created problems:
> * You can't call mount -o remount unless you're root, so we are less =
flexible than we used to be (#10542)
> * While the remount is happening, unmounts sporadically fail and the =
fuse process can become unresponsive to SIGKILL (#10916)
>=20
> The first issue was maybe an acceptable compromise, but the second is=
sue is just painful, and it seems like we might not have seen the last =
of the knock on effects -- upstream maintainers certainly aren't expect=
ing filesystems to remount themselves quite so frequently.
>=20
> We probably have an opportunity to get something upstream in fuse to =
support a direct call to trigger the invalidation we want, if we can wo=
rk out what that should look like.  Thoughts?
>=20
> John

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
