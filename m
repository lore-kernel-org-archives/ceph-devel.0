From: Sage Weil <sweil@redhat.com>
Subject: Re: Idea for optimize an OSD rebuild
Date: Thu, 30 Mar 2017 13:26:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703301326100.10776@piezo.novalocal>
References: <CAL2-6bJLntQ3MzYffw3_tFQXjizErDLDY5RoBG5-DyZUoCAhnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58640 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933331AbdC3N0W (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 30 Mar 2017 09:26:22 -0400
In-Reply-To: <CAL2-6bJLntQ3MzYffw3_tFQXjizErDLDY5RoBG5-DyZUoCAhnQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vincent Godin <vince.mlist@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 30 Mar 2017, Vincent Godin wrote:
> When you replace a failed osd, it has to recover all of its pgs and so
> it is pretty busy. Is it possible to tell this OSD to not become
> primary for any of its already synchronized pgs till every pgs (of the
> OSD) have recovered ? It should accelerate the rebuild process because
> this OSD won't have to serve client's read requests but just sync the
> writes request from the OSDs owning the primary pgs and recover. Is
> there something wrong with this idea ?

This is a great idea, and it's on the list of things ceph-mgr should be 
doing to balance load across the cluster.  I've added a card for this
at

        https://trello.com/b/ugTc2QFH/ceph-backlog

("mgr: primary-affinity away from busy osds").

sage
