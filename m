From: Matt Conner <matt.conner@keepertech.com>
Subject: Kernel RBD hang on OSD Failure
Date: Mon, 7 Dec 2015 15:56:25 -0500
Message-ID: <CAKeiORSsNQ-LOWQ0heLZQkekN_mwYQ81XSXfdJe-R1eP1Osz1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:36862 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932744AbbLGU40 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Dec 2015 15:56:26 -0500
Received: by obcse5 with SMTP id se5so119808610obc.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Dec 2015 12:56:25 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

We have a Ceph cluster in which we have been having issues with RBD
clients hanging when an OSD failure occurs. We are using a NAS gateway
server which maps RBD images to filesystems and serves the filesystems
out via NFS. The gateway server has close to 180 NFS clients and
almost every time even 1 OSD goes down during heavy load, the NFS
exports lock up and the clients are unable to access the NAS share via
NFS. When the OSD fails, Ceph recovers without issue, but the gateway
kernel RBD module appears to get stuck waiting on the now failed OSD.
Note that this works correctly when under lighter loads.

From what we have been able to determine, the NFS server daemon hangs
waiting for I/O from the OSD that went out and never recovers.
Similarly, attempting to access files from the exported FS locally on
the gateway server will result in a similar hang. We also noticed that
Ceph health details will continue to report blocked I/O on the now
down OSD until either the OSD is recovered or the gateway server is
rebooted.  Based on a few kernel logs from NFS and PVS, we were able
to trace the problem to the RBD kernel module.

Unfortunately, the only way we have been able to recover our gateway
is by hard rebooting the server.

Has anyone else encountered this issue and/or have a possible solution?
Are there suggestions for getting more detailed debugging information
from the RBD kernel module?


Few notes on our setup:
We are using Kernel RBD on a gateway server that exports filesystems via NFS
The exported filesystems are XFS on LVMs which are each composed of 16
striped images (NFS->LVM->XFS->PVS->RBD)
There are currently 176 mapped RBD images on the server (11
filesystems, 16 mapped RBD images per FS)
Gateway Kernel: 3.18.6
Ceph version: 0.80.9
Note - We've tried using different kernels all the way up to 4.3.0 but
the problem persists.

Thanks,
Matt Conner
Keeper Technology
