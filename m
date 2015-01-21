From: "Blinick, Stephen L" <stephen.l.blinick@intel.com>
Subject: Memstore issue on v0.91
Date: Wed, 21 Jan 2015 07:48:34 +0000
Message-ID: <3649A15A2562B54294DE14BCE5AC79120AB3CD9F@FMSMSX106.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40802 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbbAUHsg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jan 2015 02:48:36 -0500
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Moved to 0.91 yesterday and ran into some issues, with a Memstore OSD o=
f default size.  After a few hundred K OPS client gets a FULL message a=
nd the avail space looks like:

[root@cephtestnode0 bmpa]# rados df
pool name=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0KB=A0 =A0 =A0 objects=A0 =A0=
 =A0 =A0clones=A0 =A0 =A0degraded=A0 =A0 =A0unfound=A0 =A0 =A0 =A0 =A0 =
=A0rd=A0 =A0 =A0 =A0 rd KB=A0 =A0 =A0 =A0 =A0 =A0wr=A0 =A0 =A0 =A0 wr K=
B
rbd=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0 =A0=
 =A0 0=A0 =A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0=
 =A0 0=A0 =A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0=
 =A0 =A0 0=A0 =A0 =A0 =A0 =A0 =A0 0
testmemstore=A0 =A0 =A0 =A0 =A01505052=A0 =A0 =A0 =A0376263=A0 =A0 =A0 =
=A0 =A0 =A0 0=A0 =A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =
=A0 =A0 =A0 0=A0 =A0 =A0 =A0 =A0 =A0 0=A0 =A0 =A0 =A0376263=A0 =A0 =A0 =
1505052
=A0 total used=A0 =A0 =A0 =A0 =A01494247=A0 =A0 =A0 =A0376263
=A0 total avail=A0 =A018014398508987737
=A0 total space=A0 =A0 =A0 =A0 1000000

I was looking at pull request #2836 and found a case where there could =
be an unsigned int underflow in MemStore.cc:statfs:

   st->f_bfree =3D st->f_bavail =3D MAX((st->f_blocks - used_bytes / st=
->f_bsize), 0);

But that wasn't the final issue.. I put some asserts where used_bytes c=
ould underflow as well and didn't catch anything.  I will keep digging =
but wanted to find out if anyone else was seeing the issue as well.

Thanks,

Stephen


=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
