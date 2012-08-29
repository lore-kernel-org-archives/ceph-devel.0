From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Integration work
Date: Wed, 29 Aug 2012 10:20:27 +0200
Message-ID: <CAF6-1L6QKQbgPZvXYMQw+0_vaLrP0cr_P0_nZs56Lh+A2B9k8Q@mail.gmail.com>
References: <503D0A00.2080905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:47580 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146Ab2H2IU2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 04:20:28 -0400
Received: by vbbff1 with SMTP id ff1so297665vbb.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 01:20:28 -0700 (PDT)
In-Reply-To: <503D0A00.2080905@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ross Turk <ross@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> How about Xen?

I vote for this :)

Using RBD storage for Xen VM images / disks is IMHO a very nice fit,
the same way people do with QEMU. This should even allow live
migration of VM.

Currently we have to rely on the RBD kernel driver which has some
downsides (no caching / need recent kernel to get latest ceph
patches). There also seem to be some weird interactions between RBD
and Xen that lead to significant performance hits that are not present
when using only RBD or only Xen.

One possibility would be to develop a blktap driver for xen to provide
block device backend in userspace using librbd rather than kernel mode
rbd.

Cheers,

    Sylvain
