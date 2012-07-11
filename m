From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 07/16] rbd: dynamically allocate object prefix
Date: Wed, 11 Jul 2012 14:17:59 -0500
Message-ID: <4FFDD167.6010602@inktank.com>
References: <4FFD847C.7070205@inktank.com> <4FFD8750.7010407@inktank.com> <4FFDD014.9090208@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f52.google.com ([209.85.213.52]:50050 "EHLO
	mail-yw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191Ab2GKTSA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Jul 2012 15:18:00 -0400
Received: by yhpp61 with SMTP id p61so1856808yhp.11
        for <ceph-devel@vger.kernel.org>; Wed, 11 Jul 2012 12:18:00 -0700 (PDT)
In-Reply-To: <4FFDD014.9090208@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 07/11/2012 02:12 PM, Josh Durgin wrote:
>>   /*
>> @@ -1711,15 +1721,17 @@ static int __rbd_refresh_header(struct
>> rbd_device *rbd_dev)
>>              if head moves */
>>           follow_seq = 1;
>>
>> -    kfree(rbd_dev->header.snapc);
>> -    kfree(rbd_dev->header.snap_names);
>> +    kfree(rbd_dev->header.object_prefix);
> 
> Object prefix isn't going to change, so it doesn't need to be reset
> here. Otherwise looks good.


In that case I will verify that and warn if they do differ.	-Alex
