From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Infiniband 40GB
Date: Sun, 03 Jun 2012 07:56:13 -0500
Message-ID: <4FCB5EED.30909@inktank.com>
References: <4FCB1C0A.4050504@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35345 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958Ab2FCM4P (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Jun 2012 08:56:15 -0400
Received: by obbtb18 with SMTP id tb18so5693494obb.19
        for <ceph-devel@vger.kernel.org>; Sun, 03 Jun 2012 05:56:15 -0700 (PDT)
In-Reply-To: <4FCB1C0A.4050504@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 6/3/12 3:10 AM, Stefan Priebe wrote:
> Hi List,
>
> has anybody already tried CEPH over Infiniband 40GB?
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html

Hi Stefan,

A couple of folks have done DDR IB.  For now you are limited to ipoib 
though.  If you have the hardware available I'd be really curious what 
kind of throughput/latencies you see.

Mark
