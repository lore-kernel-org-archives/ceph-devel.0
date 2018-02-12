From: Marat A Akhmetianov <vmm@solarcom.ch>
Subject: Supporting CEPH with VMware
Date: Mon, 12 Feb 2018 09:18:35 +0300
Message-ID: <20180212091834.A111.48078FD1@solarcom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.solarcom.ch ([46.28.201.70]:38228 "EHLO mail.solarcom.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750783AbeBLGfd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Feb 2018 01:35:33 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi.

I recently asked VMware Support if they officially support CEPH as a Storage. They told us no, but we can ask CEPH team if you are supporting CEPH with VMware solutions. 

So, I have several questions:
1) Does CEPH officially support VMware?
2) What use cases for CEPH as a Storage are the best for VMware: NFS or iSCSI? 	
3) Does CEPH with iSCSI work with VMware ESXi 6.0 and VMFS5 or only with ESXi 6.5 and VMFS6 (I found the link here that CEPH only supports ESXi 6.5 http://docs.ceph.com/docs/master/rbd/iscsi-target-cli/)?
4) Does iSCSI use case has the problem with 'Abort Task' loop that can cause targets to be restarted and some VMs crashing (here is the link http://lists.ceph.com/pipermail/ceph-users-ceph.com/2016-October/013610.html)?

Thank you.
-- 
Marat A Akhmetianov <vmm@solarcom.ch>
Solar Communications GmbH

