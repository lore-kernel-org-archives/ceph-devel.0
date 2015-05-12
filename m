From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Merging PRs on the command line
Date: Tue, 12 May 2015 17:00:46 -0500
Message-ID: <5552780E.2000801@redhat.com>
References: <55527771.6060401@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42424 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964783AbbELWAt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 12 May 2015 18:00:49 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 85925B592E
	for <ceph-devel@vger.kernel.org>; Tue, 12 May 2015 22:00:49 +0000 (UTC)
In-Reply-To: <55527771.6060401@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/12/2015 04:58 PM, Ken Dreyer wrote:
> Hi Loic,
>
> I was reading over some of the HOWTO docs in the wiki, and saw the steps
> here:
>
> http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_populate_the_integration_branch
>
> It looks like you're using curl to get the title of the PR, populating
> the commit message, etc.
>
> I've found that GitHub's "hub" utility is really great for simplifying
> this. I typically merge PRs in GitHub by running the following in my
> local clone:
>
>    git checkout master
>    git pull
>    hub merge https://github.com/ceph/ceph/pull/4658
>    git commit --amend (to add my "Reviewed-by" line to the merge commit)
>    git push
>
> The hub utility uses GitHub's APIs to automatically add a
> non-fast-forward commit with a "regular" commit message that looks
> more-or-less identical to the one that I'd get if I clicked the "Merge"
> button in the web UI.
>
> The thing that sold me on this is that all the merge commits are
> authored by "kdreyer@redhat.com" instead of my personal email address. I
> found that when I clicked the "Merge" button in GitHub's web UI, the
> merge commits were authored by my primary email address for my
> "ktdreyer" GitHub UID, which isn't really what I want for Ceph.

I've been using hub for cbt PRs as well ala:

http://blog.spreedly.com/2014/06/24/merge-pull-request-considered-harmful/#.VVJ3zn_qpt4

It's absolutely heavenly.

Mark
