From: Gregory Farnum <greg@inktank.com>
Subject: Re: XioMessenger (RDMA) Status Update
Date: Tue, 13 May 2014 15:54:48 -0700
Message-ID: <CAPYLRzhHbSwv+FLFdf6buTa+M+0uhmGZHQtpyNQzfpSPz66biw@mail.gmail.com>
References: <1143714307.164.1400015257404.JavaMail.root@thunderbeast.private.linuxbox.com>
	<624098295.166.1400015293897.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:61998 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaEMWyy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 May 2014 18:54:54 -0400
Received: by mail-qg0-f48.google.com with SMTP id i50so1506116qgf.7
        for <ceph-devel@vger.kernel.org>; Tue, 13 May 2014 15:54:53 -0700 (PDT)
In-Reply-To: <624098295.166.1400015293897.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Tue, May 13, 2014 at 2:08 PM, Matt W. Benjamin <matt@cohortfs.com> wrote:
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

Can you talk about what structural changes you've made since the last
branch? :) Is there support for mark_down or some of the other things
we've discussed?
-Greg
