From: Sage Weil <sweil@redhat.com>
Subject: Re: ceph-mgr is in master
Date: Tue, 4 Oct 2016 13:25:08 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610041324580.19850@piezo.us.to>
References: <CALe9h7ebyOdYcy1hjJ1pje28fuVro68o=_q=WscRuNX2dLebjw@mail.gmail.com> <CAJ4mKGb4BLwOs1sqmB=mD-_BUzUDrc0wL4NZ8wotp++kdkE9mQ@mail.gmail.com> <b9e30685-d37d-f019-79cc-dbe5c77b71b8@redhat.com>
 <CAJ4mKGYJptXbrL54FZp=YLsH51STk=F9Fw5ztq32xboX-jvaAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59394 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753565AbcJDNZL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Oct 2016 09:25:11 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C92DC05ACA3
        for <ceph-devel@vger.kernel.org>; Tue,  4 Oct 2016 13:25:11 +0000 (UTC)
In-Reply-To: <CAJ4mKGYJptXbrL54FZp=YLsH51STk=F9Fw5ztq32xboX-jvaAQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Dan Mick <dmick@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, 3 Oct 2016, Gregory Farnum wrote:
> On Mon, Oct 3, 2016 at 8:16 PM, Dan Mick <dmick@redhat.com> wrote:
> > On 10/03/2016 10:45 AM, Gregory Farnum wrote:
> >
> >> 3) It uses "ceph tell" syntax. I thought we were moving away from
> >> top-level "tell" commands and towards making them part of the
> >> sub-command (eg "ceph osd tell", "ceph mgr tell"); is this a
> >> deliberate new lease on life for that? Unintended? Something I just
> >> made up?
> >
> > Actually it's the other way around; 'osd tell', for example, says:
> >
> > "osd tell" is deprecated; try "tell osd.<id> <command> [options...]"
> > instead (id can be "*")
> 
> o_0. Thanks Dan.
> 
> In other news we've also acquired some valgrind errors in the
> MgrMonitor; not sure how serious they are but it's getting flagged in
> the tests. http://tracker.ceph.com/issues/17492

https://github.com/ceph/ceph/pull/11308


