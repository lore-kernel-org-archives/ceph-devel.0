From: Wido den Hollander <wido@42on.com>
Subject: Re: [radosgw] absolute uri
Date: Thu, 27 Aug 2015 11:34:49 +0200
Message-ID: <55DED9B9.7060200@42on.com>
References: <CAPHxCcTAA4sPXmbCxkMo8gFH_=d5AW8BvzVgGuGVJpZ5+N1CKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:43183 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751401AbbH0Jex (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Aug 2015 05:34:53 -0400
In-Reply-To: <CAPHxCcTAA4sPXmbCxkMo8gFH_=d5AW8BvzVgGuGVJpZ5+N1CKA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lorieri <lorieri@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/27/2015 06:36 AM, Lorieri wrote:
> Hi,
> 
> I'm debugging a golang aws client and I've noticed it makes absolute
> uri requests on amazon.
> http://www.w3.org/Protocols/rfc2616/rfc2616-sec5.html#sec5.1.2
> 
> it would be great if radosgw implement it.
> 

I think only the Golang client is the one that does it. I've never seen
any other client do it.

Even the AWS SDK or Python Boto don't do this, so shouldn't the Golang
AWS client be fixed?

> cheers,
> -lorieri
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
