From: Sage Weil <sweil@redhat.com>
Subject: Re: Replacing Pending Backports with Backports in the Ceph bug queue
 - no subprojects
Date: Tue, 1 Sep 2015 14:47:08 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509011446520.13116@cobra.newdream.net>
References: <55E6178B.8050501@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44690 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbbIAVrK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 1 Sep 2015 17:47:10 -0400
In-Reply-To: <55E6178B.8050501@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Samuel Just <sjust@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 1 Sep 2015, Loic Dachary wrote:
> Hi Sam,
> 
> I modified the http://tracker.ceph.com/projects/ceph/issues?query_id=47 
> "Bug queue - no subprojects" to not display the "Pending Backports" and 
> include the "Backport" tracker instead. Now that there is a separate 
> Backport tracker, the backporting activity that used to be logged in 
> "Pending Backports" issues is now logged in the matching "Backport" 
> issue(s) and that seemed more appropriate.
> 
> If you think this is not a good idea let me know and I'll revert.

This is so much better... thanks!

sage
