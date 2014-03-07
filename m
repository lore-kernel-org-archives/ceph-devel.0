From: Dan van der Ster <daniel.vanderster@cern.ch>
Subject: Re: contraining crush placement possibilities
Date: Fri, 7 Mar 2014 09:45:11 +0100
Message-ID: <CABZ+qqmke=_BW9DBoU=ygwDy8a9WOupkDU8bwF69o88V2+eQQA@mail.gmail.com>
References: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:35500 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbaCGIpy (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 7 Mar 2014 03:45:54 -0500
Received: by mail-la0-f41.google.com with SMTP id gl10so2580708lab.14
        for <ceph-devel@vger.kernel.org>; Fri, 07 Mar 2014 00:45:51 -0800
 (PST)
In-Reply-To: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Mar 6, 2014 at 9:30 PM, Sage Weil <sage@inktank.com> wrote:
> If anyone has some clear intuition here, would love to hear it.  If there
> is anything we can do to improve things we definitely want to do it!


The thing is, if you constrain the number of OSD combinations, it just
amplifies the damage in case you do lose all replicas of a PG. So the
total expected data loss per year should stay the same, though the
probability of an incident decreases.
Cheers, Dan

-- Dan van der Ster || Data & Storage Services || CERN IT Department --
