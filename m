From: Haomai Wang <haomai@xsky.com>
Subject: Re: considering AsyncMessenger variant over RDS (RDMA and/or TCP)
Date: Thu, 16 Jun 2016 20:07:28 +0800
Message-ID: <CACJqLyYpc+tQw55x=cKPfzx4xRNC3fm3-i9pjkasr=Fipqz_sw@mail.gmail.com>
References: <DB5PR05MB160730A88C01615EC3ED3B98A9560@DB5PR05MB1607.eurprd05.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sg2apc01on0096.outbound.protection.outlook.com ([104.47.125.96]:26016
	"EHLO APC01-SG2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753846AbcFPMHp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Jun 2016 08:07:45 -0400
Received: by mail-yw0-f182.google.com with SMTP id z186so40637929ywd.2
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2016 05:07:40 -0700 (PDT)
In-Reply-To: <DB5PR05MB160730A88C01615EC3ED3B98A9560@DB5PR05MB1607.eurprd05.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Avner Ben Hanoch <avnerb@mellanox.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, Jun 16, 2016 at 7:31 PM, Avner Ben Hanoch <avnerb@mellanox.com> wrote:
> Hi all,
>
> I am at a preliminary phase of considering writing of an additional optional Messenger based on RDS - Reliable Datagram Sockets technology .
>
> You may learn about RDS here:
>     http://linux.die.net/man/7/rds
>     https://www.kernel.org/doc/Documentation/networking/rds.txt
>     https://oss.oracle.com/pipermail/rds-devel/2007-November/000228.html
>
> Since, RDS supports socket API, it should be relatively simple to create AsyncMessenger variant that is based on RDS sockets instead of TCP sockets (though, RDS is datagram oriented and not stream oriented).
>
> Questions:
>     1. Do you know if somebody is already working on this subject?

Exactly, since I have abstracted the asyncmessenger backend framework.
I implement the dpdk backend. Then another guy is working on native
rdma backend. Because a lot of async messenger changes is pending on
merge queue one by one, we need some time to wait for this framework
more clear.

>     2. Do you have any comments for me?
>
> TIA,
>   Avner
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
