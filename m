From: Yuri Weinstein <yweinste@redhat.com>
Subject: Re: dumpling & giant backports update
Date: Mon, 02 Feb 2015 15:13:15 -0800
Message-ID: <54D0048B.6050904@redhat.com>
References: <54D003B7.3090509@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38235 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbbBBXOU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 2 Feb 2015 18:14:20 -0500
In-Reply-To: <54D003B7.3090509@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Yuri Weinstein <yuri.weinstein@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Loic,

Thanks for the updates!

YuriW


On 2/2/15 3:09 PM, Loic Dachary wrote:
> Hi Yuri,
>
> There is one remaining issue in the dumpling backports (the details are here http://tracker.ceph.com/issues/10560).
>
> The giant integration branch has been updated today with all the pending pull requests (rgw in particular) and the rbd, rados and rgw suites scheduled (the details are here http://tracker.ceph.com/issues/10501). I'll analyze the result as soon as one of them finishes. The previous run was good and I'm hopeful the additional backports won't create unexpected difficulties.
>
> Cheers
>
> P.S. I moved the branches inventory to a wiki updatable via git to save the tedious copy / paste. There are here now : http://workbench.dachary.org/ceph/ceph-backports/wikis/pages
>

