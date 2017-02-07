From: Sage Weil <sage@newdream.net>
Subject: Re: Fwd: Disable Load balancing in ceph during repair
Date: Tue, 7 Feb 2017 14:52:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702071451470.3654@piezo.novalocal>
References: <CAA8xDw1g2-__B5riz9KXLJvGMtvP_Ykg9_rs_CrhAsFcwf-ymw@mail.gmail.com> <CAA8xDw3W8ujm3XZ=MxzPkDkx0OGmPRyLq5rZ+srQtDd-MHRvFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47930 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753888AbdBGOwq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Feb 2017 09:52:46 -0500
In-Reply-To: <CAA8xDw3W8ujm3XZ=MxzPkDkx0OGmPRyLq5rZ+srQtDd-MHRvFQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Elita Lobo <loboelita@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com, ceph-community@ceph.com

On Tue, 7 Feb 2017, Elita Lobo wrote:
> Hi,
> 
> Is there a way to disable load balancing in ceph (in multiple pg case)
> whenever an osd goes down?
> Or can we atleast add a delay before load balancing happens?
> 
> 
> I am trying to compute the no of erasures in each pg by using the
> command "ceph pg dump" before and after an osd goes down. The
> positions of some of the osds get changed due to load balancing.
> Hence I am unable to get the correct no of erasures due to load
> balancing happening.
> 
> Would be grateful if any of the ceph developers could help me figure
> out a way to find the no of erasures in each pg.

The simplest thing to do is simply

 ceph osd set noout

which will prevent the rebalancing indefinitely.  You can also adjust the 
'mon osd down out interval' setting on the mon (default 10m IIRC) to be 
something longer.

sage
