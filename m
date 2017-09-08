From: Bassam Tabbara <bassam@tabbara.com>
Subject: Re: [Ceph-maintainers] Ceph release cadence
Date: Fri, 8 Sep 2017 09:38:11 -0700
Message-ID: <11CE55BC-95D2-41DD-9445-2127E48CC995@tabbara.com>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
 <20170907113913.wutbtiy2pavl5mfc@suse.com>
 <alpine.DEB.2.11.1709081601550.16664@piezo.novalocal>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35397 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753132AbdIHQiN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Sep 2017 12:38:13 -0400
Received: by mail-pg0-f49.google.com with SMTP id 188so5680860pgb.2
        for <ceph-devel@vger.kernel.org>; Fri, 08 Sep 2017 09:38:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1709081601550.16664@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Lars Marowsky-Bree <lmb@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, ceph-users@ceph.com

A big +1 to Lars proposal.

Having the train run on time (3 months) has many benefits. Take a look =
at the Kuberenetes release cycle for reference =
(https://github.com/kubernetes/community/wiki/Life-of-a-Kubernetes-Release=
) and its one of the highest velocity projects and they do stateful, =
breaking and protocol upgrades too.

> These make the upgrade testing a huge concern and burden for the=20
> Ceph development community.
>=20

Sage, do you think an investment in more automation around upgrade =
testing would help this? Limiting the horizon to a ~1 year could help =
too.

> - test upgrades between all of them within a 2 year horizon, instead=20=

>   of just the last major one
>=20

If you limit the upgrade horizon to 2 previous versions, a customer on =
n-3 could upgrade to n-2 and then to n. Also I think by declaring the =
policy most admins will start upgrading more frequently.

My 2 cents.

