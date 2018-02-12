From: Mike Christie <mchristi@redhat.com>
Subject: Re: Supporting CEPH with VMware
Date: Mon, 12 Feb 2018 12:27:30 -0600
Message-ID: <5A81DC92.3090307@redhat.com>
References: <20180212091834.A111.48078FD1@solarcom.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752003AbeBLS1b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:27:31 -0500
In-Reply-To: <20180212091834.A111.48078FD1@solarcom.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marat A Akhmetianov <vmm@solarcom.ch>, ceph-devel@vger.kernel.org

On 02/12/2018 12:18 AM, Marat A Akhmetianov wrote:
> Hi.
> 
> I recently asked VMware Support if they officially support CEPH as a Storage. They told us no, but we can ask CEPH team if you are supporting CEPH with VMware solutions. 
> 
> So, I have several questions:
> 1) Does CEPH officially support VMware?

It does for iscsi, but there are limitations.

1. We do not yet support distributed PGRs, so the common setup of using
windows clustering in vmware VMs, is not supported.

2. There is a issue with vsphere HA when sharing a LUN between multiple
VMs and one loses their primary connection, but other VMs using the LUN
do not:

https://github.com/open-iscsi/tcmu-runner/issues/341

Setup instructions are here:

http://docs.ceph.com/docs/master/rbd/iscsi-initiator-esx/

> 2) What use cases for CEPH as a Storage are the best for VMware: NFS or iSCSI? 	

For iscsi, it is currently non initiator side HA type of workloads due
to the issues mentioned in #1.

> 3) Does CEPH with iSCSI work with VMware ESXi 6.0 and VMFS5 or only with ESXi 6.5 and VMFS6 (I found the link here that CEPH only supports ESXi 6.5 http://docs.ceph.com/docs/master/rbd/iscsi-target-cli/)?

Like the doc says 6.5 and vmfs 6.


> 4) Does iSCSI use case has the problem with 'Abort Task' loop that can cause targets to be restarted and some VMs crashing (here is the link http://lists.ceph.com/pipermail/ceph-users-ceph.com/2016-October/013610.html)?
> 

With ESXi 6.5 and vmfs 6 and using the config options described in the docs
http://docs.ceph.com/docs/master/rbd/iscsi-requirements/
http://docs.ceph.com/docs/master/rbd/iscsi-initiator-esx/
and using gwcli then we have not seen it.

However, we are hitting the CAW/ATS as heartbeat related hang mentioned
on the target-devel list a while back:
https://www.spinics.net/lists/target-devel/msg12071.html

tcmu-runner issue for the same issue
https://github.com/open-iscsi/tcmu-runner/issues/315.

Internally, when using the ceph offloaded ATS/CAW feature or using the
esx side VMFS3/UseATSForHBOnVMFS5 workaround we have not seen the issue.
However, all the needed pieces for the offload feature are only in ceph
v13 and up, and our QE team has not completed testing the offload
feature with vmware yet.
