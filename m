From: Bassam Tabbara <bassam@tabbara.com>
Subject: Re: CSI (container storage interface)
Date: Wed, 10 Jan 2018 14:29:39 -0800
Message-ID: <B03A147C-24FA-415D-9C74-A3821725AEEE@tabbara.com>
References: <alpine.DEB.2.11.1801101842180.17779@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:45487 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752146AbeAJW3l (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jan 2018 17:29:41 -0500
Received: by mail-pg0-f42.google.com with SMTP id c194so806094pga.12
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jan 2018 14:29:41 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801101842180.17779@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Steve LeonTang <Steve.LeonTang@Quantum.com>

Excellent! Excited to see this work starting.

Could we please get a blueprint/design on ceph-csi written down and =
reviewed?

There are a lot of different topics to consider here around secret =
management, user-mode vs. kernel, etc. that might be better sorted in a =
design doc vs. in PR reviews.

(cc=E2=80=99ing steve that offered to help)

> On Jan 10, 2018, at 10:45 AM, Sage Weil <sweil@redhat.com> wrote:
>=20
> Development has kicked off on a CSI driver for Ceph (RBD initially; =
CephFS=20
> will follow).  See
>=20
> 	https://github.com/ceph/ceph-csi
> 	https://github.com/ceph/ceph-csi/pulls
>=20
> CSI is a generic provisioning (and attachment) interface for container=20=

> orchestration platforms, including Kubernetes and Mesos.
>=20
> 	https://github.com/container-storage-interface/spec
>=20
> In the kubernetes context, this will /eventually/ replace the in-tree =
RBD=20
> and CephFS volume drivers, as well as Rook's flex volume plugin.
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

