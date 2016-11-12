From: Dan Mick <dmick@redhat.com>
Subject: Re: How do I add a note to the Ceph release notes?
Date: Fri, 11 Nov 2016 18:00:43 -0800
Message-ID: <b933ff90-5c80-772d-2d9c-17f8df00e35b@redhat.com>
References: <539332276.1908.1478854023888@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47698 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936530AbcKLCAp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 11 Nov 2016 21:00:45 -0500
In-Reply-To: <539332276.1908.1478854023888@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 11/11/2016 12:47 AM, Wido den Hollander wrote:
> Hi,
> 
> With the merge of PR #11665 [0] the Monitors will no longer allow pools to be removed by default
> 
> Users explicitly need to set mon_allow_pool_delete to true in their ceph.conf before they can remove pools.
> 
> I would like to add this to the release notes of Kraken, but where do I add this? I found a script which generates the release notes from Git.
> 
> I thought there would be a tracker issue, but couldn't find that one either.
> 
> Hints?
> 
> Wido
> 
> [0]: https://github.com/ceph/ceph/pull/11665

Add to PendingReleaseNotes


-- 
Dan Mick
Red Hat, Inc.
Ceph docs: http://ceph.com/docs
