From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 0/5] target/rbd: distributed lun reset support
Date: Tue, 05 May 2015 23:56:22 -0500
Message-ID: <55499EF6.3080906@redhat.com>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51257 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252AbbEFE4X (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 6 May 2015 00:56:23 -0400
In-Reply-To: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

On 05/05/2015 04:56 AM, mchristi@redhat.com wrote:
> The following patches allow drivers like libceph/rbd to distribute
> execution of scsi task management functions across multiple nodes
> (still working on issues with distributed PRs).
> 
> In this patchset, I added a new type of callout/module for these
> cluster aware modules. The idea is that something like drbd could maybe do
> something optimized for them, or nbd could, or you could use dlm
> plus some file system, or do something cluster FS specific. For rbd
> we are making rados/libceph calls.
> 
> I am mostly looking for feedback on the hooks/callouts approach. I was
> not sure if we wanted to maybe instead do somethign like add new callouts
> to the request_queue (request_queue->reset_q) or block_device or
> add some new block layer REQ_TYPEs (REQ_TYPE_DEVICE_RESET or
> REQ_TYPE_PGR_REGISTER, etc). In this patchset I just added new
> callouts that modules can implement, because I thought this was most
> similar to how we do fabric modules and so it was a ok fit.
> 

Oh shoot. Sorry. Forgot to cc the lio list on the first set of ceph/rbd
patches which this patchset is built on. They are here:

http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/24553
