From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: XioMessenger (RDMA) Status Update
Date: Tue, 13 May 2014 16:10:09 -0500
Message-ID: <53728A31.1090805@inktank.com>
References: <624098295.166.1400015293897.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:42973 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaEMVJz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 17:09:55 -0400
Received: by mail-ig0-f172.google.com with SMTP id uy17so5746513igb.17
        for <ceph-devel@vger.kernel.org>; Tue, 13 May 2014 14:09:55 -0700 (PDT)
In-Reply-To: <624098295.166.1400015293897.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>, ceph-devel <ceph-devel@vger.kernel.org>
Cc: Gregory Farnum <greg@inktank.com>, Sage Weil <sage@inktank.com>

On 05/13/2014 04:08 PM, Matt W. Benjamin wrote:
> Hi Ceph Devs,
>
> I've pushed two Ceph+Accelio branches, xio-firefly and xio-firefly-cmake to our
> public ceph repository https://github.com/linuxbox2/linuxbox-ceph.git .
>
> These branches are pulled up to the HEAD of ceph/firefly, and also have improvements
> to XioMessenger which allow:
>
> 1. operation of (at least) a minimal Ceph Mon and OSD cluster over Xio messaging alone
> 2. initial support for Accelio in the MDS server and Client/libcephfs (not formally tested)
>
> There are some new config options:
>
> (global addr) "rdma local" sets a local rdma interface address
> (global bool) "cluster rdma" selects Accelio for intra-cluster communication
> (global bool) "client rdma" selecs Accelio for libcephfs communications
>
> These changes haven't been strenuously tested, we'll expect to have additional information
> and likely new, simple rados bench results against this code in the next several days,
> at latest.

Excellent new Matt.  Can't wait to see your results! :D

>
> Thanks,
>
> Matt
>

