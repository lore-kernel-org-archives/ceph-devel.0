From: Dan Mick <dan.mick@inktank.com>
Subject: Re: bug in rbd rename command?
Date: Fri, 19 Apr 2013 13:26:43 -0700
Message-ID: <5171A883.2040006@inktank.com>
References: <5170F217.9020105@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:63538 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517Ab3DSU0s (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 16:26:48 -0400
Received: by mail-pd0-f176.google.com with SMTP id r11so2404423pdi.35
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 13:26:47 -0700 (PDT)
In-Reply-To: <5170F217.9020105@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

It's arguable, but we wanted to treat source and destination pools 
separately in general.

Note that you can also specify images as POOLNAME/a and POOLNAME/b.

On 04/19/2013 12:28 AM, Stefan Priebe - Profihost AG wrote:
> Hi,
>
> if i issue rbd -p POOLNAME ... rename a b
>
> It uses the POOL for a but not for b.
>
> Output is then:
> rbd: mv/rename across pools not supported
> source pool: vmstorssd1 dest pool: rbd
>
> Shouldn't it use the pool provided by -p for both?
>
> Stefan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
