From: Alyona Kiselyova <akiselyova@mirantis.com>
Subject: Re: data-at-rest compression
Date: Fri, 13 Nov 2015 14:20:11 +0300
Message-ID: <CAONhiy67Yd-7h6Ew9W+X3n3u6198A5Q58xZYRZ62-divm-78bA@mail.gmail.com>
References: <5642115E.407@mirantis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:33720 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956AbbKMLUM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Nov 2015 06:20:12 -0500
Received: by obbww6 with SMTP id ww6so71050925obb.0
        for <ceph-devel@vger.kernel.org>; Fri, 13 Nov 2015 03:20:11 -0800 (PST)
In-Reply-To: <5642115E.407@mirantis.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Igor Fedotov <ifedotov@mirantis.com>, Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi,
I was working on pluggable compression interface in this work
(https://github.com/ceph/ceph/pull/6361). In Igor's pull request was
suggested to reuse  common plugin infrastructure from unmerged
wip-plugin branch. Now I'm working on adaptation of it, and as I see,
I need only this two commits from it
(https://github.com/ceph/ceph/commit/294bef3d12ec04d9febf1f850184be7653a4322cand
https://github.com/ceph/ceph/commit/18ad8df1094db52c839dc6b2dc689fc882230acb).
Sage, is it possible to make standalone pull request with them, or I
must just to cherry pick them in my branch?
Thanks for answer.
-------------------------------
Best regards,
Alyona Kiseleva


On Tue, Nov 10, 2015 at 6:46 PM, Igor Fedotov <ifedotov@mirantis.com> wrote:
> Hi All,
>
> a while ago we had some conversations here about adding compression support
> for EC pools.
> Here is corresponding pull request implementing this feature:
>
> https://github.com/ceph/ceph/pull/6524/commits
>
> Appropriate blueprint is at:
> http://tracker.ceph.com/projects/ceph/wiki/Rados_-_at-rest_compression
>
> All comments and reviews are highly appreciated.
>
> Thanks,
> Igor.
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
