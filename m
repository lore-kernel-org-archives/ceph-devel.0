From: Sage Weil <sweil@redhat.com>
Subject: Re: new naming convention for building repos and binaries from
 branches
Date: Thu, 6 Oct 2016 16:34:39 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610061633440.19850@piezo.us.to>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com> <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com> <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964928AbcJFQer (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 12:34:47 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B723C05ACA5
        for <ceph-devel@vger.kernel.org>; Thu,  6 Oct 2016 16:34:42 +0000 (UTC)
In-Reply-To: <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andrew Schoen <aschoen@redhat.com>
Cc: John Spray <jspray@redhat.com>, Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 6 Oct 2016, Andrew Schoen wrote:
> >> We could keep the implicit convention for `wip-*` or maybe something similar?
> >
> > Building everything that starts with wip-* sounds fine to me.  But
> > isn't that usually everything that we push to the ceph/ceph
> > repository?  What is is that we're trying to avoid building?
> >
> > John
> 
> I think the idea is that we only want to build branches that we plan
> to run tests against. As we add more flavors, distros and
> architectures to build for the workload increases exponentially. The
> system is designed to scale, but let's not build things we don't
> really need.

I think we need a "do not build" prefix and a "build this asap" prefix. 
Maybe nobuild-* and asap-*?

sage
