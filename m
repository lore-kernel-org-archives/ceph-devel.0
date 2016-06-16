From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: Dramatic performance drop at certain number of objects in pool
Date: Thu, 16 Jun 2016 22:48:05 +1000
Message-ID: <CA+z5Dsz=e1N9RxRoF5Wao8Dogf_S1UstNZaCJ=oj-efj83HBig@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34388 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753824AbcFPMsZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Jun 2016 08:48:25 -0400
Received: by mail-vk0-f49.google.com with SMTP id t129so71547928vka.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Jun 2016 05:48:25 -0700 (PDT)
In-Reply-To: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wade Holler <wade.holler@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Wade,

What IO are you seeing on the OSD devices when this happens (see e.g.
iostat), are there short periods of high read IOPS where (almost) no
writes occur? What does your memory usage look like (including slab)?

Cheers,

On 16 June 2016 at 22:14, Wade Holler <wade.holler@gmail.com> wrote:
> Hi All,
>
> I have a repeatable condition when the object count in a pool gets to
> 320-330 million the object write time dramatically and almost
> instantly increases as much as 10X, exhibited by fs_apply_latency
> going from 10ms to 100s of ms.
>
> Can someone point me in a direction / have an explanation ?
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



-- 
Cheers,
~Blairo
