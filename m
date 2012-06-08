From: Florian Haas <florian@hastexo.com>
Subject: Re: Ceph/OpenStack integration on Ubuntu precise: horribly broken, or
 am I doing something wrong?
Date: Fri, 8 Jun 2012 18:04:50 +0200
Message-ID: <CAPUexz-JPMPQpyRCuWp4jXq2ozHGFo-HtpjvQQ=yb9nhFEm+cg@mail.gmail.com>
References: <CAPUexz846keC+6KvFeethXV4xzpke3n_YKU0_oh-YfTCVR1ozw@mail.gmail.com>
	<4FD21ECC.7040906@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:63172 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab2FHQEu convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 12:04:50 -0400
Received: by qcro28 with SMTP id o28so918838qcr.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 09:04:50 -0700 (PDT)
In-Reply-To: <4FD21ECC.7040906@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org, Openstack <openstack@lists.launchpad.net>

On Fri, Jun 8, 2012 at 5:48 PM, Josh Durgin <josh.durgin@inktank.com> w=
rote:
> Hi Florian,
>
> There's an Ubuntu bug already:
>
> https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/981130
>
> librgw was not complete, and wasn't actually used by radosgw, so it w=
as
> dropped. The Ubuntu package just needs to be updated to remove the
> dependency and rgw.py, like upstream did.

Thanks Josh -- could an Ubuntu person weigh on on this? This has me
wondering whether this is going to be fixed in precise.

Changed in ceph (Ubuntu):
milestone:	 ubuntu-12.04.1 =E2=86=92 quantal-alpha-1

=2E.. is what the bug report says.

Cheers,
=46lorian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
