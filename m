From: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Subject: Re: Trigger to create PGs ?
Date: Mon, 04 Feb 2013 16:22:11 -0800 (PST)
Message-ID: <20130204.162211.130587088.yasu@soe.ucsc.edu>
References: <20130204.145038.210467743.yasu@soe.ucsc.edu>
	<20130204.152624.157931698.yasu@soe.ucsc.edu>
	<511049F5.609@inktank.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:43433 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab3BEAWS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 19:22:18 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2830250dak.2
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 16:22:17 -0800 (PST)
In-Reply-To: <511049F5.609@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dan.mick@inktank.com
Cc: ceph-devel@vger.kernel.org


Dan,

In fact it's been more than a week since it is in the status.
ceph -w can show us the other progress (like backfilling on the
down/up osds), but has not shown any progress on the 'creating'.

regards,
Yasu

From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Trigger to create PGs ?
Date: Mon, 04 Feb 2013 15:53:25 -0800
Message-ID: <511049F5.609@inktank.com>

> 
> 
> On 02/04/2013 03:26 PM, Yasuhiro Ohara wrote:
>> 3264 pgs: 1088 creating, 2176 active+clean
> 
> This means, I believe, that the cluster has healed 2176 of 3264 PGs,
> and is working on the remaining 1088.  You can use 'ceph -w' to
> observe the progress, but I think your cluster is backfilling the
> newly-configured OSDs as it should be.
