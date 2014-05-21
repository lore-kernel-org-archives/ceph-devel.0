From: Wido den Hollander <wido@42on.com>
Subject: Re: Feedback: default FS pools and newfs behavior
Date: Wed, 21 May 2014 21:21:03 +0200
Message-ID: <537CFC9F.4000009@42on.com>
References: <CAGd4Wr21kmRhJz=uXw4EgLY_UK2NoLMj3e7qKmN3+=ukHa8FdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:36659 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752713AbaEUTVG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 May 2014 15:21:06 -0400
In-Reply-To: <CAGd4Wr21kmRhJz=uXw4EgLY_UK2NoLMj3e7qKmN3+=ukHa8FdQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 05/21/2014 05:32 PM, John Spray wrote:
> In response to #8010[1], I'm looking at making it possible to
> explicitly disable CephFS, so that the (often unused) filesystem pools
> don't hang around if they're unwanted.
>
> The administrative behavior would change such that:
>   * To enable the filesystem it is necessary to create two pools and
> use "ceph newfs <metadata> <data>"
>   * There's a new "ceph rmfs" command to disable the filesystem and
> allow removing its pools
>   * Initially, the filesystem is disabled and the 'data' and 'metadata'
> pools are not created by default
>
> There's an initial cut of this on a branch:
> https://github.com/ceph/ceph/commits/wip-nullfs
>
> Questions:
>   * Are there strong opinions about whether the CephFS pools should
> exist by default?  I think it makes life simpler if they don't,
> avoiding "what the heck is the 'data' pool?" type questions from
> newcomers.

+1

We simpler the clusters are, the better imho. A lot of users don't 
require CephFS, so don't enable what ain't used.

>   * Is it too unfriendly to require users to explicitly create pools
> before running newfs, or do we need to auto-create pools when they run
> newfs?  Auto-creating some pools from newfs is a bit awkward
> internally because it requires modifying both OSD and MDS maps in one
> command.
>
> Cheers,
> John
>
> 1. http://tracker.ceph.com/issues/8010
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
