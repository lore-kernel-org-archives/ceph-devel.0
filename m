From: Wido den Hollander <wido@42on.com>
Subject: Re: Questions on some minor issues when upgrading from 0.48 to 0.56
Date: Thu, 14 Feb 2013 08:18:07 +0100
Message-ID: <511C8FAF.1080102@42on.com>
References: <1360783561.14929.YahooMailNeo@web162602.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:41156 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755857Ab3BNHSL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Feb 2013 02:18:11 -0500
In-Reply-To: <1360783561.14929.YahooMailNeo@web162602.mail.bf1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Daniel Hoang <daniel_m_hoang@yahoo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On 02/13/2013 08:26 PM, Daniel Hoang wrote:
>
>
> Hi All,
>
> Just in case these issues have not been reported yet, I am on ubuntu 12.04, upgrade librados2/librados-dev from 0.48 to 0.56, and I notice the following issues:
>
> 1. librados2 / librados-dev still reports minor version as 48
>
> Should minor version changed to 56?

No. From what I understand the librados version is only bumped when the 
API actually changes.

This indicates that the API is still the same as 0.48

>
> 2. In 0.48, rados_pool_list(cluster, NULL, 0) can be used like a buffer size query, and it would return the buffer size required for the pool list buffer string. In 0.56, this call now returns error -22 instead, and I have to pass in a tmp_buf[32] and len = 32 in order for the call to return successfully. I check the current rados_pool_list API, and it does not mention anything about buffer and len should not be NULL, 0.
>
> May be this was a bug in 0.48, that we should not pass in NULL, 0 ?
>

Take a look at this commit: 
https://github.com/ceph/ceph/commit/a677f47926b9640c53fbd00c94d6eb7a590a94fc

I ran into this with phprados as well: 
https://github.com/ceph/phprados/commit/ee8b87fe93f87f92a7c3fa197a33b3d2de2fc4b6

Wido

> Thanks for your help,
> DanielH
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
