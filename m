From: Wido den Hollander <wido@42on.com>
Subject: Re: [PATCH] libceph: Complete stuck requests to OSD with EIO
Date: Thu, 9 Feb 2017 17:11:32 +0100 (CET)
Message-ID: <553533223.9594.1486656692332@ox.pcextreme.nl>
References: <4e080919-2df5-1b75-3c8a-3ae95eb8f08d@synesis.ru>
 <CAOi1vP-7hcHAaVcqvLAcu9vL4ohQW4u9XoGdg-d5AuaX7E19Dw@mail.gmail.com>
 <cfa74b42-b6d6-e658-9095-8e1cddf008fc@synesis.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.139]:48417 "EHLO
        smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751030AbdBIQLn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Feb 2017 11:11:43 -0500
In-Reply-To: <cfa74b42-b6d6-e658-9095-8e1cddf008fc@synesis.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Artur Molchanov <artur.molchanov@synesis.ru>, Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>


> Op 9 februari 2017 om 16:51 schreef Artur Molchanov <artur.molchanov@synesis.ru>:
> 
> 
> Hi Ilya,
> 
> Currently we're working on moving our product to kubernetes / ceph stack. We're 
> actively tuning ceph configuration and ceph cluster often need to be redeployed. 
> We have to warm reboot all machines with mounted RBDs as a result. This patch 
> allows us to remap and remount RBDs without time consuming reboot.
> 

I understand the usecase. You don't always want to block, sometimes you want to timeout after some time.

Wido

> On 02/09/2017 05:27 PM, Ilya Dryomov wrote:
> > What is the use case?  What do you expect this timeout to be in your
> > environment?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
