From: Wido den Hollander <wido@42on.com>
Subject: Re: Ceph-client branch for Ubuntu 14.04.1 LTS (3.13.0-x kernels)
Date: Mon, 05 Jan 2015 12:15:18 +0100
Message-ID: <54AA7246.9070303@42on.com>
References: <9E914F5BD7F48A4782456CEB550A42280A758A6D@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:43775 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753253AbbAELO7 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 5 Jan 2015 06:14:59 -0500
In-Reply-To: <9E914F5BD7F48A4782456CEB550A42280A758A6D@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 05-01-15 11:53, Chaitanya Huilgol wrote:
> Hi All,
>
> The stock ceph-client modules with Ubuntu 14.04 LTS are quite dated and we are seeing crashes and soft-lockup issues which have been fixed in the current ceph-client code base.
> What would be recommended ceph-client branch compatible with the Ubuntu 14.04 (3.13.0-x) kernels so that we can get as many fixes as possible?
>

I recommend you take a look here: 
http://kernel.ubuntu.com/~kernel-ppa/mainline/

That should give you some new kernels.

Wido

> Regards,
> Chaitanya
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
