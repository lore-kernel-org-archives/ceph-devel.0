From: Wido den Hollander <wido@42on.com>
Subject: Re: Bucket name restrictions in RGW
Date: Fri, 12 Jun 2015 20:44:05 +0200
Message-ID: <557B2875.1090505@42on.com>
References: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:46341 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755681AbbFLSoI (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Jun 2015 14:44:08 -0400
In-Reply-To: <CAPRac-aj5YrKXrxxd_YTM-VJcNmS8j1zw_BToSwSdmd5nhv9cQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Harshal Gupta <harshal.gupta001@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 06/12/2015 05:28 PM, Harshal Gupta wrote:
> Hi,
> I was looking into the bucket creation and found out that we are able
> to create buckets with names which are not DNS compliant. One such
> example is names ending with a non-alphanumeric character. There are
> other rules which make bucket name restrictions in RGW more lenient
> than what is recommended for DNS compliant names as well.
> 
> In case we plan to support website hosting in future on RGW, we will
> need to make bucket names DNS compliant. Keeping that in mind, I am
> thinking about modifying the bucket name rules and applying more
> restrictions to make them more towards DNS compliant.
> 
> Please share your opinion about this.
> 

I'm in favor. I would even like more strict bucket names, eg a setting
where you can force all names to lowercase or refuse names with
uppercase in it. This sometimes gives conflicts with DNS names when
using lower and uppercase mixed.

> Thanks,
> Harshal Gupta
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
