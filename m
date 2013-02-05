From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Trigger to create PGs ?
Date: Mon, 04 Feb 2013 16:43:33 -0800
Message-ID: <511055B5.6080903@inktank.com>
References: <20130204.145038.210467743.yasu@soe.ucsc.edu> <20130204.152624.157931698.yasu@soe.ucsc.edu> <511049F5.609@inktank.com> <20130204.162211.130587088.yasu@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:48495 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431Ab3BEAnh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 19:43:37 -0500
Received: by mail-ob0-f170.google.com with SMTP id wc20so7071069obb.1
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 16:43:37 -0800 (PST)
In-Reply-To: <20130204.162211.130587088.yasu@soe.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

I see now that there are a bunch of PGs in creating state; sorry for 
missing that.

I think you might try "ceph pg send_pg_creates" to kick the cluster in 
the head and get it to create those PGs.

On 02/04/2013 04:22 PM, Yasuhiro Ohara wrote:
>
> Dan,
>
> In fact it's been more than a week since it is in the status.
> ceph -w can show us the other progress (like backfilling on the
> down/up osds), but has not shown any progress on the 'creating'.
>
> regards,
> Yasu
>
> From: Dan Mick <dan.mick@inktank.com>
> Subject: Re: Trigger to create PGs ?
> Date: Mon, 04 Feb 2013 15:53:25 -0800
> Message-ID: <511049F5.609@inktank.com>
>
>>
>>
>> On 02/04/2013 03:26 PM, Yasuhiro Ohara wrote:
>>> 3264 pgs: 1088 creating, 2176 active+clean
>>
>> This means, I believe, that the cluster has healed 2176 of 3264 PGs,
>> and is working on the remaining 1088.  You can use 'ceph -w' to
>> observe the progress, but I think your cluster is backfilling the
>> newly-configured OSDs as it should be.
