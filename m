From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: Kernel RBD hang on OSD Failure
Date: Tue, 8 Dec 2015 11:59:57 +0100
Message-ID: <CAOi1vP-ZvpDTQ1ej0Um2hJSG-LpquTMZAY8e3P2BtpSkNnL4Hw@mail.gmail.com>
References: <CAKeiORSsNQ-LOWQ0heLZQkekN_mwYQ81XSXfdJe-R1eP1Osz1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33792 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932537AbbLHK77 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Dec 2015 05:59:59 -0500
Received: by wmvv187 with SMTP id v187so208034373wmv.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Dec 2015 02:59:57 -0800 (PST)
In-Reply-To: <CAKeiORSsNQ-LOWQ0heLZQkekN_mwYQ81XSXfdJe-R1eP1Osz1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Conner <matt.conner@keepertech.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Dec 7, 2015 at 9:56 PM, Matt Conner <matt.conner@keepertech.com> wrote:
> Hi,
>
> We have a Ceph cluster in which we have been having issues with RBD
> clients hanging when an OSD failure occurs. We are using a NAS gateway
> server which maps RBD images to filesystems and serves the filesystems
> out via NFS. The gateway server has close to 180 NFS clients and
> almost every time even 1 OSD goes down during heavy load, the NFS
> exports lock up and the clients are unable to access the NAS share via
> NFS. When the OSD fails, Ceph recovers without issue, but the gateway
> kernel RBD module appears to get stuck waiting on the now failed OSD.
> Note that this works correctly when under lighter loads.
>
> From what we have been able to determine, the NFS server daemon hangs
> waiting for I/O from the OSD that went out and never recovers.
> Similarly, attempting to access files from the exported FS locally on
> the gateway server will result in a similar hang. We also noticed that
> Ceph health details will continue to report blocked I/O on the now
> down OSD until either the OSD is recovered or the gateway server is
> rebooted.  Based on a few kernel logs from NFS and PVS, we were able
> to trace the problem to the RBD kernel module.
>
> Unfortunately, the only way we have been able to recover our gateway
> is by hard rebooting the server.
>
> Has anyone else encountered this issue and/or have a possible solution?
> Are there suggestions for getting more detailed debugging information
> from the RBD kernel module?

Dumping osdc, osdmap and ceph status when it gets stuck would be
a start:

# cat /sys/kernel/debug/ceph/*/osdmap
# cat /sys/kernel/debug/ceph/*/osdc
$ ceph status

Thanks,

                Ilya
