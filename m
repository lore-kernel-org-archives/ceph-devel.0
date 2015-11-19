From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>
Subject: Re: Regarding op_t, local_t
Date: Thu, 19 Nov 2015 09:59:40 +0800
Message-ID: <CANE=7sW+-4XB9iqduiVL9RSwWYfj6fn2xSUp2+WJcVMyMRPxbA@mail.gmail.com>
References: <CO1PR02MB208676EEBEE4B862DDDF769F41B0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f52.google.com ([209.85.218.52]:33780 "EHLO
	mail-oi0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932721AbbKSB7l (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Nov 2015 20:59:41 -0500
Received: by oixx65 with SMTP id x65so36773017oix.0
        for <ceph-devel@vger.kernel.org>; Wed, 18 Nov 2015 17:59:40 -0800 (PST)
In-Reply-To: <CO1PR02MB208676EEBEE4B862DDDF769F41B0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Good catch. I think it does make sense.

2015-11-19 9:54 GMT+08:00 Somnath Roy <Somnath.Roy@sandisk.com>:
> Hi Sage,
> I saw we are now having single transaction in submit_transaction. But,
> in the replication path we are still having two transaction, can't we merge it to one there ?
>
> Thanks & Regards
> Somnath
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Regards,
xinze
