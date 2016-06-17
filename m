From: Haomai Wang <haomai@xsky.com>
Subject: Re: considering AsyncMessenger variant over RDS (RDMA and/or TCP)
Date: Fri, 17 Jun 2016 10:49:14 +0800
Message-ID: <CACJqLyYEQBYGnVMC+7ba_Vp-cP2daDZL=YQyoQBkPCjCOWm9Tw@mail.gmail.com>
References: <DB5PR05MB160730A88C01615EC3ED3B98A9560@DB5PR05MB1607.eurprd05.prod.outlook.com>
 <CACJqLyYpc+tQw55x=cKPfzx4xRNC3fm3-i9pjkasr=Fipqz_sw@mail.gmail.com> <DB5PR05MB1607BC316B76C1ED41220676A9560@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0132.outbound.protection.outlook.com ([104.47.126.132]:57915
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754466AbcFQCt1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Jun 2016 22:49:27 -0400
Received: by mail-yw0-f172.google.com with SMTP id z186so60631740ywd.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2016 19:49:22 -0700 (PDT)
In-Reply-To: <DB5PR05MB1607BC316B76C1ED41220676A9560@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 16, 2016 at 8:30 PM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
> Hi Haomai,
>
> I didn't understand which RDMA API the other guy is using.  Is it rdma_cm, Accelio, other?

ibverbs/rdma_cm

>
> Also, is there an estimation when will it be possible to download and use it from your branch (even before it is formally merged into Ceph)?
>
> In this thread I asked about *RDS* over RDMA http://linux.die.net/man/7/rds since RDS API is very close to TCP socket API.  Do you think this is needed in addition to your work?

I don't know the status of RDS and which open source project is using RDS?

>
> TIA,
>  Avner
>
> -----Original Message-----
> From: Haomai Wang [mailto:haomai@xsky.com]
> Sent: Thursday, June 16, 2016 15:07
> To: Avner Ben Hanoch <avnerb@mellanox.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: considering AsyncMessenger variant over RDS (RDMA and/or TCP)
>
> On Thu, Jun 16, 2016 at 7:31 PM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
>> Hi all,
>>
>> I am at a preliminary phase of considering writing of an additional optional Messenger based on RDS - Reliable Datagram Sockets technology .
>>
>> You may learn about RDS here:
>>     http://linux.die.net/man/7/rds
>>     https://www.kernel.org/doc/Documentation/networking/rds.txt
>>
>> https://oss.oracle.com/pipermail/rds-devel/2007-November/000228.html
>>
>> Since, RDS supports socket API, it should be relatively simple to create AsyncMessenger variant that is based on RDS sockets instead of TCP sockets (though, RDS is datagram oriented and not stream oriented).
>>
>> Questions:
>>     1. Do you know if somebody is already working on this subject?
>
> Exactly, since I have abstracted the asyncmessenger backend framework.
> I implement the dpdk backend. Then another guy is working on native rdma backend. Because a lot of async messenger changes is pending on merge queue one by one, we need some time to wait for this framework more clear.
>
>>     2. Do you have any comments for me?
>>
>> TIA,
>>   Avner
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
