From: Allen Samuels <Allen.Samuels@sandisk.com>
Subject: Re: bluestore blobs
Date: Fri, 26 Aug 2016 18:16:13 +0000
Message-ID: <418D3D8F-DE12-4666-BF1F-A49A5ABC5533@sandisk.com>
References: <alpine.DEB.2.11.1608261747440.24244@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bl2nam02on0082.outbound.protection.outlook.com ([104.47.38.82]:6026
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753308AbcHZSQQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 26 Aug 2016 14:16:16 -0400
In-Reply-To: <alpine.DEB.2.11.1608261747440.24244@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I like the simplicity of this approach a lot. When the system isn't fragmen=
ted, this should work excellently. However when it is fragmented, this fall=
s back to the current situation. Nevertheless in a heavily fragmented envir=
onment the onode size might be the least important problem to solve, so I a=
gree this is the approach we should take.

Sent from my iPhone. Please excuse all typos and autocorrect

> On Aug 26, 2016, at 1:52 PM, Sage Weil <sweil@redhat.com> wrote:
>=20
> Hi Allen,
>=20
> The "blobs must be confined to a extent map shard" rule is still somewhat=
=20
> unsatisfying to me.  There's another easy possibility, though: we=20
> allow blobs to span extent map shards, and when they do, we stuff them=20
> directly in the onode.  The number of such blobs will always be small=20
> (no more than the number of extent map shards), so I don't think size is =
a=20
> concern.  And we'll always already have them loaded up when we bring any=
=20
> particular shard in, so we don't need to worry about any additional=20
> complexity around paging them in.  And we avoid the slightly annoying cut=
=20
> points on compressed extents when they cross such boundaries.
>=20
> This also avoids some of the tuning practicalities that were annoying me=
=20
> (does a global config option control where the enforced cut points are? =
=20
> what happens if that changes on an existing store?)
>=20
> sage
