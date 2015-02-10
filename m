From: Mark Nelson <mnelson@redhat.com>
Subject: Re: speed decrease since firefly,giant,hammer the 2nd try
Date: Tue, 10 Feb 2015 15:38:07 -0600
Message-ID: <54DA7A3F.6070009@redhat.com>
References: <54DA541E.9000608@profihost.ag> <54DA578F.3000900@redhat.com> <54DA5853.3070504@profihost.ag> <54DA5E9F.3060305@redhat.com> <54DA6904.6000305@profihost.ag> <54DA6BB9.7000306@redhat.com> <54DA7404.4060201@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51553 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753822AbbBJViY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 10 Feb 2015 16:38:24 -0500
In-Reply-To: <54DA7404.4060201@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/10/2015 03:11 PM, Stefan Priebe wrote:
>
> mhm i installed librbd1-dbg and librados2-dbg - but the output still
> looks useless to me. Should i upload it somewhere?

Meh, if it's all just symbols it's probably not that helpful.

I've summarized your results here:

1 concurrent 4k write (libaio, direct=1, iodepth=1)

		IOPS		Latency
		wb on	wb off	wb on	wb off
dumpling	10870	536	~100us	~2ms
firefly		10350	525	~100us	~2ms

So in single op tests dumpling and firefly are far closer.  Now let's 
see each of these cases with iodepth=32 (still 1 thread for now).

Mark

>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
