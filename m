From: Sage Weil <sage@newdream.net>
Subject: Re: Docs falling out of sync with code
Date: Wed, 21 Sep 2016 22:29:53 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609212228270.1040@piezo.us.to>
References: <52e4b5e2-2db7-1437-8fd3-ab7b7e8ec879@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:52037 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933101AbcIUW35 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 18:29:57 -0400
In-Reply-To: <52e4b5e2-2db7-1437-8fd3-ab7b7e8ec879@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 21 Sep 2016, Dan Mick wrote:
> The upstream docs at http://ceph.com/docs can tend to become out of
> date.  We don't have much process to track things that need doc work.
> 
> As a start, I propose we add a "docs needed" flag to tracker.ceph.com so
> that we can at least search things that add or change features through a
> tracker issue, and a "docs needed" label to github, so we can track it
> on PRs as well.
> 
> Thoughts?  We can make this happen pretty quickly, and of course it's no
> perfect lock, but at least it may start contributors and reviewers
> thinking about the issue.

We can make a 'needs-docs' tag for PRs in github.  If they don't block the 
merge, then we can still search for them in open or closed prs, and make a 
point of removing the tag once the docs are eventually updated.

For the tracker, maybe a category for each project instead of a 
separate tracker?  Not sure..

sage
