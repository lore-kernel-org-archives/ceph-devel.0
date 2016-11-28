From: "Igor.Podoski@ts.fujitsu.com" <Igor.Podoski@ts.fujitsu.com>
Subject: RE: "exe" ceph-mds processes
Date: Mon, 28 Nov 2016 11:29:40 +0000
Message-ID: <432789e85f484dfca805b29e8c82d929@R01UKEXCASM222.r01.fujitsu.local>
References: <CALe9h7fort-NWax8LUXMB1gGycvUXNundNzdbzVaypcpQWEC6w@mail.gmail.com>
 <alpine.DEB.2.11.1611261433390.28496@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail1.bemta6.messagelabs.com ([193.109.254.106]:11020 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753751AbcK1LhW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 28 Nov 2016 06:37:22 -0500
In-Reply-To: <alpine.DEB.2.11.1611261433390.28496@piezo.us.to>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>

> > I guess we could:
> >  * Switch the logic to try resolving argv[0] and only use
> > proc/self/exe if we can't find argv[0]?
> >  * Create a link to /proc/self/exe named ceph-mds, and exec that?
> 
> We could also check if argv[0] is 'exe' and, if so, rewrite it so that the ps
> output shows ceph-mds...

For ps/pgrep/pkill it'll work, but 'top' reports process name differently and you'll see 'exe' there. I think this is because 'ps' is looking on command line and 'top' on something else in procfs. You need to run also prctl(PR_SET_NAME, argv[0]) shortly after process starts. This could be a race condition, when system will be under big load, for a moment process name would change from 'ceph-mds' to 'exe' and then back to 'ceph-mds', pid will remain the same but some third party monitoring software could be confused (depends how they check the process name).

I'm not sure, but I think you could pass argv again here, then respawn will short to:
execv("/proc/self/exe", argv);

And process name will be kept, since first start will set argv[0] and passing argv to execv + prctl will propagate it.

> http://stackoverflow.com/questions/23398952/changing-linux-ps-output-
> by-changing-argv0
> 
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
