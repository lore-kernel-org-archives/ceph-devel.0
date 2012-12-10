From: =?UTF-8?Q?Alexandre_Maumen=C3=A9?= <alexandre@maumene.org>
Subject: Few questions about Ceph
Date: Mon, 10 Dec 2012 20:17:26 +0100
Message-ID: <CAGBmBz-CWSZM_QB9k+MG71VZzLV94VG7xhBaemPZqfqj1F2L4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:65450 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2LJTR6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Dec 2012 14:17:58 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so5413173iay.5
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 11:17:58 -0800 (PST)
Received: by mail-ie0-f173.google.com with SMTP id e13so13168728iej.18
        for <ceph-devel@vger.kernel.org>; Mon, 10 Dec 2012 11:17:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello all,

I have a few questions about Ceph:

1) Is it possible to run a cluster with "some" lantecy between monitor
nodes? Latency will be 30ms at worst.

2) When using RBD what are the best practices for a direct mount using
XFS filesystem? And for a qemu/kvm devices? I'm thinking about
writeback, rbd_cache, ...

3) About the CRUSH map, how can I separate 2 pools on different OSD?
I'd like to setup a cluster with different disks (like SATA/SAS) and I
want to be able to specify on which disks (or OSD) my data are going
to be write.

Thanks in advance for any answer.

Regards,
