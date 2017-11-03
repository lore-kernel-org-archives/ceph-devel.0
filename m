From: Bassam Tabbara <bassam@tabbara.com>
Subject: Re: [ceph-users] announcing ceph-helm (ceph on kubernetes
 orchestration)
Date: Fri, 3 Nov 2017 14:10:39 -0700
Message-ID: <2BFAAC76-F81E-47A4-A234-BCD319D2ECD8@tabbara.com>
References: <alpine.DEB.2.11.1710251848140.22592@piezo.us.to>
 <CAOugy1vGkPDf7w_+ZMKpA7R2r-MV71=3KnaQ2V6WTaLg5fmTyA@mail.gmail.com>
 <alpine.DEB.2.11.1710251928080.22592@piezo.us.to>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:44605 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752384AbdKCVKl (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Nov 2017 17:10:41 -0400
Received: by mail-pf0-f180.google.com with SMTP id x7so3071136pfa.1
        for <ceph-devel@vger.kernel.org>; Fri, 03 Nov 2017 14:10:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1710251928080.22592@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Hans van den Bogert <hansbogert@gmail.com>, ceph-devel@vger.kernel.org, ceph-users@ceph.com

(sorry for the late response, just catching up on ceph-users)

> Probably the main difference is that ceph-helm aims to run Ceph as =
part of=20
> the container infrastructure.  The containers are privileged so they =
can=20
> interact with hardware where needed (e.g., lvm for dm-crypt) and the=20=

> cluster runs on the host network.  We use kubernetes some =
orchestration:=20
> kube is a bit of a headache for mons and osds but will be very helpful =
for=20
> scheduling everything else: mgrs, rgw, rgw-nfs, iscsi, mds, ganesha,=20=

> samba, rbd-mirror, etc.
>=20
> Rook, as I understand it at least (the rook folks on the list can =
speak up=20
> here), aims to run Ceph more as a tenant of kubernetes.  The cluster =
runs=20
> in the container network space, and the aim is to be able to deploy =
ceph=20
> more like an unprivileged application on e.g., a public cloud =
providing=20
> kubernetes as the cloud api.
>=20

Yes Rook=E2=80=99s goal is to run wherever Kubernetes runs without =
making changes at the host level. Eventually we plan to remove the need =
to run some of the containers privileged, and automatically work with =
different kernel versions and heterogeneous environments. It's fair to =
think of Rook as an application of Kubernetes. As a result you could run =
it on AWS, Google, bare-metal or wherever.

> The other difference is around rook-operator, which is the thing that =
lets=20
> you declare what you want (ceph clusters, pools, etc) via kubectl and =
goes=20
> off and creates the cluster(s) and tells it/them what to do.  It makes =
the=20
> storage look like it is tightly integrated with and part of kubernetes =
but=20
> means that kubectl becomes the interface for ceph cluster management. =20=


Rook extends Kubernetes to understand storage concepts like Pool, Object =
Store, FileSystems. Our goal is for storage to be integrated deeply into =
Kuberentes. That said, you can easily launch the Rook toolbox and use =
the ceph tools at any point. I don=E2=80=99t think the goal is for Rook =
to replace the ceph tools, but instead to offer a Kuberentes-native =
alternative to them.

> Some of that seems useful to me (still developing opinions here!) and=20=

> perhaps isn't so different than the declarations in your chart's=20
> values.yaml but I'm unsure about the wisdom of going too far down the =
road=20
> of administering ceph via yaml.
>=20
> Anyway, I'm still pretty new to kubernetes-land and very interested in=20=

> hearing what people are interested in or looking for here!

Would be great to find ways to get these two projects closer.=20

Bassam

