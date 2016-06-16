From: Wido den Hollander <wido@42on.com>
Subject: Re: Dramatic performance drop at certain number of objects in pool
Date: Thu, 16 Jun 2016 15:38:19 +0200 (CEST)
Message-ID: <1450235390.2134.1466084299677@ox.pcextreme.nl>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:51804 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbcFPNiX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2016 09:38:23 -0400
In-Reply-To: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wade Holler <wade.holler@gmail.com>, ceph-devel@vger.kernel.org


> Op 16 juni 2016 om 14:14 schreef Wade Holler <wade.holler@gmail.com>:
> 
> 
> Hi All,
> 
> I have a repeatable condition when the object count in a pool gets to
> 320-330 million the object write time dramatically and almost
> instantly increases as much as 10X, exhibited by fs_apply_latency
> going from 10ms to 100s of ms.
> 

My first guess is the filestore splitting and the amount of files per directory.

You have 3*16=48 OSDs, is that correct? With roughly 100 PGs per OSD you have let's say 4800 PGs in total?

That means you have ~66k objects per PG.

> Can someone point me in a direction / have an explanation ?

If you take a look at one of the OSDs, are there a huge amount of files in a single directory? Look inside the 'current' directory on that OSDs.

Wido

> 
> I can add a new pool and it performs normally.
> 
> Config is generally
> 3 Nodes 24 physical core each, 768GB Ram each, 16 OSD / node , all SSD
> with NVME for journals. Centos 7.2, XFS
> 
> Jewell is the release; inserting objects with librados via some Python
> test code.
> 
> Best Regards
> Wade
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
