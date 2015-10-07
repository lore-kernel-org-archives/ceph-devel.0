From: Wido den Hollander <wido@42on.com>
Subject: Re: radosgw with openstack auth v3
Date: Wed, 7 Oct 2015 14:03:01 +0200
Message-ID: <561509F5.1090908@42on.com>
References: <CACx0BdPJsOO39XGZPFr_TXk4+xSsw5_yU6fG2Ahw_B2cBNkttA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:39506 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbbJGMDH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Oct 2015 08:03:07 -0400
In-Reply-To: <CACx0BdPJsOO39XGZPFr_TXk4+xSsw5_yU6fG2Ahw_B2cBNkttA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Periquito <periquito@gmail.com>, ceph-devel@vger.kernel.org

On 10/06/2015 11:03 AM, Luis Periquito wrote:
> Hi,
> 
> I was trying to get radosgw to authenticate using API v3, as I thought
> it would be relatively straightforward, but my C++ is not up to
> standard.
> 
> That and the time it takes to compile and make the radosgw binary is
> way too long. Is there a way to just compile radosgw so I can make the
> tests quickly?
> 

You need to compile Ceph first, afterwards you can run this in the src
directory:

$ cd src
$ make radosgw

> I can share all the progress I made, and share some thoughts. I also
> have a complete setup that I can use to test the solution.
> 
> Is there anyone currently looking into this?
> 
> thanks,
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
