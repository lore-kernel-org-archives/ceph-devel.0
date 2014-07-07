From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Cache tier READ_FORWARD transition
Date: Mon, 07 Jul 2014 14:38:58 -0500
Message-ID: <53BAF752.3080005@inktank.com>
References: <53BACB03.5010603@redhat.com> <alpine.DEB.2.00.1407070934120.23451@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:62519 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbaGGTi7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 15:38:59 -0400
Received: by mail-ie0-f172.google.com with SMTP id rd18so4082033iec.3
        for <ceph-devel@vger.kernel.org>; Mon, 07 Jul 2014 12:38:58 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407070934120.23451@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Luis Pabon <lpabon@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/07/2014 02:29 PM, Sage Weil wrote:
> On Mon, 7 Jul 2014, Luis Pabon wrote:
>> Hi all,
>>      I am working on OSDMonitor.cc:5325 and wanted to confirm the following
>> read_forward cache tier transition:
>>
>>      readforward -> forward || writeback || (any && num_objects_dirty == 0)
>>      forward -> writeback || readforward || (any && num_objects_dirty == 0)
>>      writeback -> readforward || forward
>>
>> Is this the correct cache tier state transition?
>
> That looks right to me.
>
> By the way, I had a thought after we spoke that we probably want something
> that is somewhere inbetween the current writeback behavior (promote on
> first read) and the read_forward behavior (never promote on read).  I
> suspect a good all-around policy is something like promote on second read?
> This should probably be rolled into the writeback mode as a tunable...

That would be a good start I think.  What about some kind of scheme that 
also favours promoting small objects over larger ones?  It could be as 
simple as increasing the number of reads necessary to do a promotion 
based on the object size.

ie something like:

<= 64k object = 1 read
<= 512k object = 2 read
else 3 read

That would make the behaviour for default RBD object sizes always 3 
read, but could keep big objects out of the cache tier for RGW.

Mark

>
> sage
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

