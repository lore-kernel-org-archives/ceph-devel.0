From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: ceph_test_librbd_fsx fails with thrasher
Date: Mon, 12 Jan 2015 08:59:05 -0800
Message-ID: <54B3FD59.6070808@inktank.com>
References: <54B3D9B0.2050906@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:37028 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbbALQ7K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Jan 2015 11:59:10 -0500
Received: by mail-pa0-f49.google.com with SMTP id eu11so32976246pac.8
        for <ceph-devel@vger.kernel.org>; Mon, 12 Jan 2015 08:59:09 -0800 (PST)
In-Reply-To: <54B3D9B0.2050906@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 01/12/2015 06:26 AM, Loic Dachary wrote:
> Hi Josh,
>
> While looking at errors from a giant (plus backports) run of the RBD suite, I stumbled upon:
>
>     http://tracker.ceph.com/issues/10513
>
> and the error is unclear (at least to me ;-). Would you have an idea ? For information the backports included are all the pull requests mentionned at http://tracker.ceph.com/issues/10501.

Thanks for organizing these Loic!

There's no trace of the actual error in the teuthology or ceph client
logs. Looking at the syslogs, this and several other failures from that
run were from running out of memory. This happened with and without
caching, so I suspect these tests may simply need more memory in their
current configuration, since osds are sharing it too, and they use much
more with thrashing.

Josh
