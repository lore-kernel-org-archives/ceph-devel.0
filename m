From: Mike Christie <mchristi@redhat.com>
Subject: Re: [RFC PATCH 0/5] rbd_tcm cluster COMPARE AND WRITE
Date: Wed, 29 Jul 2015 04:31:41 -0500
Message-ID: <55B89D7D.1080704@redhat.com>
References: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750860AbbG2Jbm (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 05:31:42 -0400
In-Reply-To: <1438132552-14673-1-git-send-email-ddiss@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: ceph-devel@vger.kernel.org

On 07/28/2015 08:15 PM, David Disseldorp wrote:
> Hi Mike,
> 
> This RFC patch-set expands on your recently proposed cluster API changes
> to add rbd_tcm COMPARE AND WRITE support.
> 
> Rather than offloading the entire COMPARE AND WRITE operation to the
> cluster back-end, these changes extend on the existing local semaphore
> usage, to additionally take an RBD COMPARE AND WRITE device lock. RBD
> device lock acquisition is handled via a newly added rbd_tcm workqueue.
> 
> I'd appreciate feedback on the overall direction of these changes.
> 

I will take a look at them. I just posted my patches too :)

I originally did not want to use cluster locking because I did not want
to have to grab a cluster lock every time we execute the command. I
tried to take advantage that we know which OSD the compare and write is
going to go to, so we can just send the op to it and it can do locking
on the OSD side.

