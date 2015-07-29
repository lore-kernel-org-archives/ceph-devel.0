From: David Disseldorp <ddiss@suse.de>
Subject: Re: [RFC PATCH 0/5] rbd_tcm cluster COMPARE AND WRITE
Date: Wed, 29 Jul 2015 12:04:26 +0200
Message-ID: <20150729120426.4f1c3792@g21.suse.de>
References: <1438132552-14673-1-git-send-email-ddiss@suse.de>
	<55B89D7D.1080704@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36695 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819AbbG2KE2 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 29 Jul 2015 06:04:28 -0400
In-Reply-To: <55B89D7D.1080704@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Christie <mchristi@redhat.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 29 Jul 2015 04:31:41 -0500, Mike Christie wrote:

> On 07/28/2015 08:15 PM, David Disseldorp wrote:
> > Hi Mike,
> > 
> > This RFC patch-set expands on your recently proposed cluster API changes
> > to add rbd_tcm COMPARE AND WRITE support.
> > 
> > Rather than offloading the entire COMPARE AND WRITE operation to the
> > cluster back-end, these changes extend on the existing local semaphore
> > usage, to additionally take an RBD COMPARE AND WRITE device lock. RBD
> > device lock acquisition is handled via a newly added rbd_tcm workqueue.
> > 
> > I'd appreciate feedback on the overall direction of these changes.
> > 
> 
> I will take a look at them. I just posted my patches too :)

Thanks for posting your new patch-set.

> I originally did not want to use cluster locking because I did not want
> to have to grab a cluster lock every time we execute the command. I
> tried to take advantage that we know which OSD the compare and write is
> going to go to, so we can just send the op to it and it can do locking
> on the OSD side.

Offloading the entire read/compare/write operation to the OSD is *much*
nicer. Consider my RFC patch-set revoked :)

Cheers, David
