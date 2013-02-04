From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Trigger to create PGs ?
Date: Mon, 04 Feb 2013 15:53:25 -0800
Message-ID: <511049F5.609@inktank.com>
References: <20130204.145038.210467743.yasu@soe.ucsc.edu> <20130204.152624.157931698.yasu@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:47466 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754356Ab3BDXx3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 18:53:29 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so1617211pab.8
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 15:53:29 -0800 (PST)
In-Reply-To: <20130204.152624.157931698.yasu@soe.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Cc: ceph-devel@vger.kernel.org



On 02/04/2013 03:26 PM, Yasuhiro Ohara wrote:
> 3264 pgs: 1088 creating, 2176 active+clean

This means, I believe, that the cluster has healed 2176 of 3264 PGs, and 
is working on the remaining 1088.  You can use 'ceph -w' to observe the 
progress, but I think your cluster is backfilling the newly-configured 
OSDs as it should be.
