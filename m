From: Sage Weil <sweil@redhat.com>
Subject: Re: branches! infernalis vs master, RIP next
Date: Wed, 30 Sep 2015 05:56:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509300556090.21582@cobra.newdream.net>
References: <alpine.DEB.2.00.1509291310470.4617@cobra.newdream.net> <CAL-2WbHHD5_Y07viKp+sjWbTSpgsJn7uysas7dQR=T70VsraRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59770 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932774AbbI3M4t (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 30 Sep 2015 08:56:49 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id AB3A2C0B1B27
	for <ceph-devel@vger.kernel.org>; Wed, 30 Sep 2015 12:56:47 +0000 (UTC)
In-Reply-To: <CAL-2WbHHD5_Y07viKp+sjWbTSpgsJn7uysas7dQR=T70VsraRQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Gryniewicz <dang@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 30 Sep 2015, Daniel Gryniewicz wrote:
> On Tue, Sep 29, 2015 at 5:12 PM, Sage Weil <sweil@redhat.com> wrote:
> >
> >  1- Target any pull request with a bug fix that should go into infernalis
> > at the infernalis branch.
> 
> 
> So, currently, anything targeted at both infernalis and master should
> have a pull request for infernalis only?  Or for both?

Only infernalis.  We will regularly merge infernalis back into 
master up until the final/initial release (9.2.0).

sage
