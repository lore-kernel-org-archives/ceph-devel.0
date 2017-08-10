From: Sage Weil <sweil@redhat.com>
Subject: Re: final luminous blockers
Date: Thu, 10 Aug 2017 15:01:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1708101501290.20435@piezo.novalocal>
References: <alpine.DEB.2.11.1708081556210.20435@piezo.novalocal> <CA+aFP1CWMrnk=k0UY-CmEMXUVHOYgznbm9izeHxmTu0BrfCZyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751982AbdHJPBr (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 10 Aug 2017 11:01:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FEF111C0F5
        for <ceph-devel@vger.kernel.org>; Thu, 10 Aug 2017 15:01:47 +0000 (UTC)
In-Reply-To: <CA+aFP1CWMrnk=k0UY-CmEMXUVHOYgznbm9izeHxmTu0BrfCZyw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

The final RADOS blocker is resolved so I think we're good for a release 
today!

sage


On Wed, 9 Aug 2017, Jason Dillaman wrote:

> RBD should be good-to-go for 12.2.0.
> 
> On Tue, Aug 8, 2017 at 11:58 AM, Sage Weil <sweil@redhat.com> wrote:
> > I'm hoping we get get 12.2.0 out the door tomorrow.  On the rados side,
> > there is just one blocker:
> >
> >         http://tracker.ceph.com/issues/20925
> >
> > which I'm testing a fix for now.  There is also the rocskdb build issue
> > that makes things break for folks with really old CPUs, but I don't think
> > it needs to block the initial release.
> >
> > I'm waiting for the latest round of upgrade tests to run as well but I
> > think everything is resolved there.
> >
> > Jason, Matt, Patrick: how are rbd, rgw, and cephfs looking?
> >
> > Everyone else: any other blockers?
> >
> > Thanks!
> > sage
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
