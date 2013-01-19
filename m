From: Wenhao Xu <xuwenhao2008@gmail.com>
Subject: Re: Understanding Ceph
Date: Sun, 20 Jan 2013 01:15:52 +0800
Message-ID: <CAN7K+5vamUuEywLP5Y633SyTaNyD7rSB+3mHK2aaCoOJvudGOg@mail.gmail.com>
References: <CAPrNTukzeSN8ZfO_Mhtx9LkHqe0M3tUxJuQG=gwwJD4w+-OGEg@mail.gmail.com>
 <50FAC92C.8030709@bmrb.wisc.edu> <50FACEF7.4070805@ledeuns.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f179.google.com ([209.85.210.179]:55228 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab3ASRQQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 19 Jan 2013 12:16:16 -0500
Received: by mail-ia0-f179.google.com with SMTP id x24so2039913iak.24
        for <ceph-devel@vger.kernel.org>; Sat, 19 Jan 2013 09:16:13 -0800 (PST)
In-Reply-To: <50FACEF7.4070805@ledeuns.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Denis Fondras <ceph@ledeuns.net>
Cc: ceph-devel@vger.kernel.org

oops, it seems not a good news to CentOS users. For kvm's rbd
image/volume use case, is it well supported? Or will Inktank consider
supporting CentOS in the near future?

Ceph-Fs seems not an urgent requirement. But the rbd and object store
are the core requirement for cloud service providers who are running
CentOS. If not, I think sheepdog should be a good alternative for
volume backend. And users can keep using swift as the object store on
CentOS.


On Sun, Jan 20, 2013 at 12:51 AM, Denis Fondras <ceph@ledeuns.net> wrote:
>
> Hello,
>
>
>>
>> I was unable to get ceph to run on centos 6.3 following the "5 minute
>
>
> Same here... I was only able to build the ceph-fuse client.
>
> Denis
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html




--
~_~
