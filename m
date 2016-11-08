From: Sage Weil <sage@newdream.net>
Subject: Re: New Jewel cluster has firefly tunables by default
Date: Tue, 8 Nov 2016 14:30:02 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611081428510.29278@piezo.us.to>
References: <56283c4e-47f3-2fe8-5f14-d8b363e91426@corp.ovh.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55004 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751111AbcKHOaF (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 09:30:05 -0500
In-Reply-To: <56283c4e-47f3-2fe8-5f14-d8b363e91426@corp.ovh.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tomasz Kuzemko <tomasz.kuzemko@corp.ovh.com>
Cc: ceph-devel@vger.kernel.org

On Tue, 8 Nov 2016, Tomasz Kuzemko wrote:
> Hi,
> I noticed that when a fresh Jewel cluster is deployed, by default it has
> "firefly" tunables set. Is there some reason not to set "optimal" by
> default or is this a bug?

We usually lag by one or two stable releases so that older clients can 
connect.  In particular, the kernel clients tend to lag as most users 
are using distro kernels (and the kernel doesn't always get the support 
immediately).

sage
