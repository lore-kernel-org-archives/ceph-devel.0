From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 0/30] mds: lookup-by-ino & fixes
Date: Mon, 27 May 2013 10:56:31 +0800
Message-ID: <51A2CB5F.4080706@intel.com>
References: <1369296418-14871-1-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1305231118510.32642@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12977 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756021Ab3E0C4n (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 26 May 2013 22:56:43 -0400
In-Reply-To: <alpine.DEB.2.00.1305231118510.32642@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, greg@inktank.com, sam.lang@inktank.com

On 05/24/2013 02:22 AM, Sage Weil wrote:
> On Thu, 23 May 2013, Yan, Zheng wrote:
>> From: "Yan, Zheng" <zheng.z.yan@intel.com>
>>
>> Patch 1~21 are random fixes for MDS cluster. Patch 22~28 rework
>> the backtrace handling. Patch 29 introduces lookup-by-ino helper.
>> Path 30 uses the lookup-by-ino helper to fix issue #4850.
>>
>> This patch series are also in:
>>   git://github.com/ukernel/ceph.git wip-mds
>=20
> Awesome!  I pushed this to wip-mds in ceph.git for now.  Note that=20
> gitbuilders are picking up a failure due to the encoding changes.  Fo=
r the=20
> types and messages that change, can you mark them in the=20
> ceph-object-corpus.git tree?  Look for the forward_incompat/ dirs and=
=20
> follow that example.

I ran scripts in src/test/encoding/, but still couldn't figure out what=
 was
wrong. (I use Fedora, autobuild-ceph doesn't support it)

>=20
> I reviewed up until the backtrace patch before I ran out of time (cat=
ching=20
> a plane).  If you can address the comments we can get at least that=20
> much merged.  I'll defer to Greg for now on the backtrace changes, th=
ough,=20
> as he is more familiar with that original code.
>=20
> Can't wait to get the lookup-by-ino into tree... I think the ganesha =
guys=20
> will be happy about that too.  Do you have any stress tests for that?=
 =20
> There is a wip-cephfs branch (incomplete and not quite ready yet, but=
=2E.)=20
> branch that adds a handle-based API to libcephfs.  Soon we should bui=
ld=20
> some tests for the ino lookup based on that (or something similar) so=
 we=20
> can hammer the mds cluster under various load/stress conditions.
>=20
Last Friday=EF=BC=8CI modified open_remote_dentry(), made it to use the=
 lookup-by-ino
function. I ran fsstress for the whole weekend, the lookup-by-ino funct=
ion works
well so far.

Regards
Yan, Zheng
=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
