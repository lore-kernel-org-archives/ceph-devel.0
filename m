From: Sage Weil <sweil@redhat.com>
Subject: Re: jewel punch list
Date: Tue, 19 Apr 2016 14:56:07 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604191455340.16393@cpach.fuggernut.com>
References: <alpine.DEB.2.11.1604181448220.4803@cpach.fuggernut.com> <CAJ4mKGYU=53qMvQgCMRk2i3bak3ZxXDrDLk-ZvZ_VeNbV-J-Kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932667AbcDSS4H (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Apr 2016 14:56:07 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 807CF7822E
	for <ceph-devel@vger.kernel.org>; Tue, 19 Apr 2016 18:56:06 +0000 (UTC)
In-Reply-To: <CAJ4mKGYU=53qMvQgCMRk2i3bak3ZxXDrDLk-ZvZ_VeNbV-J-Kg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, dillaman@redhat.com
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I just got a verbal ack from Sam and Yehuda.  Jason?

sage


On Mon, 18 Apr 2016, Gregory Farnum wrote:

> Ack.
> 
> On Mon, Apr 18, 2016 at 12:57 PM, Sage Weil <sweil@redhat.com> wrote:
> > I think we're in good shape.  Assuming the qa/workunit bit is fixed (let's
> > do a rados run as soon as master builds), are we good for the 10.2.0
> > release?  There is still the rgw leak, so please merge the parts that are
> > safe and we'll backport any follow-on fixes.
> >
> > There is also one selinux issue (http://tracker.ceph.com/issues/15524)
> > that we need to take care of before this goes out.  Yuri, are there other
> > outstanding issues that we haven't addressed yet?
> >
> > Those items aside, can the leads and QA please ACK for a release?
> >
> > Thanks!
> > sage
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
