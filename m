From: Sage Weil <sage@newdream.net>
Subject: Re: data-at-rest compression
Date: Fri, 13 Nov 2015 05:18:25 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511130518160.7964@cobra.newdream.net>
References: <5642115E.407@mirantis.com> <CAONhiy67Yd-7h6Ew9W+X3n3u6198A5Q58xZYRZ62-divm-78bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40810 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754352AbbKMNS0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Nov 2015 08:18:26 -0500
In-Reply-To: <CAONhiy67Yd-7h6Ew9W+X3n3u6198A5Q58xZYRZ62-divm-78bA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alyona Kiselyova <akiselyova@mirantis.com>
Cc: Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 13 Nov 2015, Alyona Kiselyova wrote:
> Hi,
> I was working on pluggable compression interface in this work
> (https://github.com/ceph/ceph/pull/6361). In Igor's pull request was
> suggested to reuse  common plugin infrastructure from unmerged
> wip-plugin branch. Now I'm working on adaptation of it, and as I see,
> I need only this two commits from it
> (https://github.com/ceph/ceph/commit/294bef3d12ec04d9febf1f850184be7653a4322cand
> https://github.com/ceph/ceph/commit/18ad8df1094db52c839dc6b2dc689fc882230acb).
> Sage, is it possible to make standalone pull request with them, or I
> must just to cherry pick them in my branch?

Let's do a separate PR.

Thanks!
sage


> Thanks for answer.
> -------------------------------
> Best regards,
> Alyona Kiseleva
> 
> 
> On Tue, Nov 10, 2015 at 6:46 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> > Hi All,
> >
> > a while ago we had some conversations here about adding compression support
> > for EC pools.
> > Here is corresponding pull request implementing this feature:
> >
> > https://github.com/ceph/ceph/pull/6524/commits
> >
> > Appropriate blueprint is at:
> > http://tracker.ceph.com/projects/ceph/wiki/Rados_-_at-rest_compression
> >
> > All comments and reviews are highly appreciated.
> >
> > Thanks,
> > Igor.
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
