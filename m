From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Performance results on inline data support
Date: Mon, 30 Sep 2013 07:39:37 -0500
Message-ID: <52497109.8030206@inktank.com>
References: <5249377C.8030003@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:57398 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab3I3Mjf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Sep 2013 08:39:35 -0400
Received: by mail-ie0-f175.google.com with SMTP id e14so10141489iej.34
        for <ceph-devel@vger.kernel.org>; Mon, 30 Sep 2013 05:39:35 -0700 (PDT)
In-Reply-To: <5249377C.8030003@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On 09/30/2013 03:34 AM, Li Wang wrote:
> Hi,
>    We did a performance test on inline data support, the Ceph cluster is
> composed of 1 MDS, 1 MON, 6 OSD on a HPC cluster. The program is simple,
> there are 1000 - 3000 files with each being 1KB. The program repeated
> the following processes on each file: open(), read(), close(). The total
> time is measured with/without inline data support. The results are as
> follows (seconds),
>
> #files  without    with
> 1000    17.3674      8.7186
> 2000    35.4848      17.7646
> 3000    53.2164      26.4374

Excellent job!  Looks like this could make a big difference for certain 
workloads.  How much data can it store before it switches away from 
inlining the data?

>
> Cheers,
> Li Wang
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

