From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH 0/5] wip-tunables3
Date: Thu, 27 Mar 2014 16:39:40 -0700
Message-ID: <5334B6BC.6090202@inktank.com>
References: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:37326 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755279AbaC0XmZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 19:42:25 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so4155230pbc.16
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 16:42:25 -0700 (PDT)
In-Reply-To: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 03/19/2014 09:09 AM, Ilya Dryomov wrote:
> Hello,
>
> This series updates the kernel implementation of CRUSH with a couple of
> fixes and a new chooseleaf_vary_r tunable (all ported from ceph.git).
> TUNABLES3 feature bit is shared with PRIMARY_AFFINITY, which will also
> be posted in a couple of days in order to get everything into 3.15.
>
> Thanks,
>
>                  Ilya
>
>
> Ilya Dryomov (5):
>    crush: fix off-by-one errors in total_tries refactor
>    crush: allow crush rules to set (re)tries counts to 0
>    crush: add chooseleaf_vary_r tunable
>    crush: add SET_CHOOSELEAF_VARY_R step
>    crush: support chooseleaf_vary_r tunable (tunables3) by default
>
>   include/linux/ceph/ceph_features.h |   10 ++++-
>   include/linux/crush/crush.h        |    7 +++
>   net/ceph/crush/mapper.c            |   85 ++++++++++++++++++++++++------------
>   3 files changed, 74 insertions(+), 28 deletions(-)
>

These all look good.

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>
