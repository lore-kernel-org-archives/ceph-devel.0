From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: contraining crush placement possibilities
Date: Fri, 7 Mar 2014 11:30:43 +0100
Message-ID: <CABZ+qqkYw2CznTS5ters9LMaX7zPMQ8LxvB8e0rfGuz_3BYXZA@mail.gmail.com>
References: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:28471 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbaCGKbZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Mar 2014 05:31:25 -0500
Received: by mail-lb0-f171.google.com with SMTP id w7so2681271lbi.30
        for <ceph-devel@vger.kernel.org>; Fri, 07 Mar 2014 02:31:23 -0800
 (PST)
In-Reply-To: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 6, 2014 at 9:30 PM, Sage Weil <sage@inktank.com> wrote:
> Sheldon just
> pointed out a talk from ATC that discusses the basic problem:
>
>         https://www.usenix.org/conference/atc13/technical-sessions/presentation/cidon
>
> The situation with CRUSH is slightly better, I think, because the number
> of peers for a given OSD in a large cluster is bounded (pg_num /
> num_osds), but I think we may still be able improve things.


I'm surprised they didn't cite Ceph -- aren't copysets ~= placement groups?
Cheers, Dan

-- Dan van der Ster || Data & Storage Services || CERN IT Department --
