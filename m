From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: Publishing hammer v0.94.6
Date: Fri, 29 Jan 2016 09:10:23 -0800
Message-ID: <56AB9CFF.4000305@redhat.com>
References: <56AAFAB2.9010103@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45835 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844AbcA2RKV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 29 Jan 2016 12:10:21 -0500
In-Reply-To: <56AAFAB2.9010103@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 01/28/2016 09:37 PM, Loic Dachary wrote:
> Hi Sage,
>
> Now that the test infrastructure is back, we could try to publish v0.94.6. These are the issues it fixes: http://tracker.ceph.com/versions/505. And these are the backports that are in flight and would not be in v0.94.6 if we decide to cut the release today: http://tracker.ceph.com/projects/ceph/issues?query_id=78
>
> What do you think ?

There are some in-review rbd fixes I'd like to include. Scheduling a
test run with those now.

Josh

