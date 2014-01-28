From: Filippos Giannakos <philipgian@grnet.gr>
Subject: Re: RADOS + deep scrubbing performance issues in production
 environment
Date: Tue, 28 Jan 2014 20:13:25 +0200
Message-ID: <20140128181325.GD11532@philipgian-mac>
References: <20140127151321.GD26390@philipgian-mac>
 <CAFMfnwp4u-O8m3gZko35y5t3r05kAgt9zUWOew_pmHSJjmLPmA@mail.gmail.com>
 <alpine.DEB.2.00.1401271045160.2149@cobra.newdream.net>
 <52E74E96.8070202@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:29373 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755205AbaA1SN3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 28 Jan 2014 13:13:29 -0500
Content-Disposition: inline
In-Reply-To: <52E74E96.8070202@cloudapt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Dawson <mike.dawson@cloudapt.com>
Cc: Sage Weil <sage@inktank.com>, Kyle Bader <kyle.bader@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, synnefo-devel@googlegroups.com

On Tue, Jan 28, 2014 at 01:30:46AM -0500, Mike Dawson wrote:
> 
> On 1/27/2014 1:45 PM, Sage Weil wrote:
> >There is also
> >
> >  ceph osd set noscrub
> >
> >and then later
> >
> >  ceph osd unset noscrub
> >
> In my experience scrub isn't nearly as much of a problem as
> deep-scrub. On a IOPS constrained cluster with writes approaching
> the available aggregate spindle performance minus replication
> penalty and possibly co-located osd journal penalty, scrub may run
> without any disruption. But deep-scrub tends to make iowait on the
> spindles get ugly.
> 
> To disable/enable deep-scrub use:
> 
> ceph osd set nodeep-scrub
> ceph osd unset nodeep-scrub
>

Yes, deep-scrubbing is much worse than scrubbing, but I think fully disabling it
is not a good option. But having days of degraded performance isn't either.
That's why I am bringing up the problem and seeking for a solid solution
regarding the matter.

Kind Regards,
-- 
Filippos
<philipgian@grnet.gr>
