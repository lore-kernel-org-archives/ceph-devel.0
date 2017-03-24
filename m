From: Mao Cheng <chengmao2010@gmail.com>
Subject: Re: CephFS: How to figure out which files are affected after a disaster
Date: Fri, 24 Mar 2017 17:01:08 +0800
Message-ID: <CAGiyNfA_BrXRTTJ9no=b3jdQoYTBk0fkwMRFx_ge1JGzSrye-A@mail.gmail.com>
References: <CY4PR10MB1591F37261F24E1D6F510E97E43E0@CY4PR10MB1591.namprd10.prod.outlook.com>
 <CY4PR10MB159194A6062F5ABA74AA3E9CE43E0@CY4PR10MB1591.namprd10.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35004 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751477AbdCXJBJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Mar 2017 05:01:09 -0400
Received: by mail-io0-f172.google.com with SMTP id z13so12949709iof.2
        for <ceph-devel@vger.kernel.org>; Fri, 24 Mar 2017 02:01:09 -0700 (PDT)
In-Reply-To: <CY4PR10MB159194A6062F5ABA74AA3E9CE43E0@CY4PR10MB1591.namprd10.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

cephfs-data-scan can help you.

2017-03-24 13:35 GMT+08:00 Wang, Zhiye <Zhiye.Wang@arcserve.com>:
> Dear all,
>
> I store only one replica (pool size = 1) for my data. And I lose one OSD in my cluster. Is there a way to figure out which files (in CephFS) are actually affected?
>
> "pool size = 1" is just an example for simple. I can also say "pool size = 2, but lose 2 OSD", or "pool size = 3, but lose 3 OSD".
>
>
>
> Thanks
> Zhiye
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
