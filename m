From: Martin Wilderoth <martin.wilderoth@linserv.se>
Subject: Re: HEALTH_WARNING
Date: Sat, 2 Apr 2011 20:23:58 +0200 (CEST)
Message-ID: <145352050.13442.1301768638863.JavaMail.root@mail.linserv.se>
References: <AANLkTimwMj6zprkW0u8brSn2dCVw6CUnrGPRa=H4HXti@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 194-17-14-101.customer.telia.com ([194.17.14.101]:39914 "EHLO
	mail.linserv.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610Ab1DBSap (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 2 Apr 2011 14:30:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.linserv.se (Postfix) with ESMTP id 662261204E1
	for <ceph-devel@vger.kernel.org>; Sat,  2 Apr 2011 20:23:59 +0200 (CEST)
Received: from mail.linserv.se ([127.0.0.1])
	by localhost (mail.linserv.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zgaFK7TqiMrO for <ceph-devel@vger.kernel.org>;
	Sat,  2 Apr 2011 20:23:58 +0200 (CEST)
Received: from mail.linserv.se (mail.linserv.se [194.17.14.101])
	by mail.linserv.se (Postfix) with ESMTP id E4047120034
	for <ceph-devel@vger.kernel.org>; Sat,  2 Apr 2011 20:23:58 +0200 (CEST)
In-Reply-To: <AANLkTimwMj6zprkW0u8brSn2dCVw6CUnrGPRa=H4HXti@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I'm running 0.25.2 from the debian repository squeeze. so it's the latest i think

> The only way I know to recover is to create a new filesystem in the cluster :-) 
> But it's bad fot the data :-) 
> 
> When i get problems with one osd it seems as if they are crashing one by one. 
> And i dont know how to get them up again whitout deleting all the data. 
> 

Which version of ceph are you running? We had similar problem before. 
I would like to know if recent fixes for osd recovery (>= v0.25.1) 
have already resolved this problem. 

Thanks, 
Henry 
