From: Sage Weil <sweil@redhat.com>
Subject: Re: v0.80.2?
Date: Fri, 11 Jul 2014 13:44:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407111259580.3932@cobra.newdream.net>
References: <alpine.DEB.2.00.1407101629490.16614@cobra.newdream.net> <CAF6-1L6bYp9EUidFnKZDwh1Qsf6wRrRpyL4gm7nP7aHS+VHEng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47085 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbaGKUos (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jul 2014 16:44:48 -0400
In-Reply-To: <CAF6-1L6bYp9EUidFnKZDwh1Qsf6wRrRpyL4gm7nP7aHS+VHEng@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 11 Jul 2014, Sylvain Munaut wrote:
> Hi,
> 
> > We built v0.80.2 yesterday and pushed it out to the repos, but quickly
> > discovered a regression in radosgw that preventing reading objects written
> > with earlier versions.  We pulled the packages, fixed the bug, and are
> > rerunning tests to confirm the fix and ensure there aren't other
> > upgrade-related issues.  We expect to have a v0.80.3 ready tomorrow or
> > Monday.
> 
> 
> I see that you reverted 5fd8b0d1639c67e355f0fc0d7e6d7036618d87a1. in
> 0.80.2. But without this patch, I can't initiate multipart upload ...
> I reported this in http://tracker.ceph.com/issues/8517  My fix was a
> bit different but should be equivalent to the one that was merged in.
> 
> Who reported the issue with this patch ?

We merged two batches of firefly backports.  After the first batch, 
s3-tests was passing cleanly.  With the second batch, which included that 
commit, the multipart upload test broke.  I definitely want to get the fix 
in, but we can't delay 0.80.2 any longer given the other fixes in there.

Ideally the thing to do here is run s3-tests on your end and confirm that 
the tests are failing with the patch and figure out why.  Or, if it passes 
for you, we can figure out what is different between your environment and 
QA.  And then, ideally, we can extend s3-tests to reproduce the failure 
that you are seeing with the patch reverted so that we can confirm it is 
fixed (and stays fixed).

Yehuda isn't back until next week, but Josh and I are also around on IRC 
etc to help out.

Thanks!
sage

