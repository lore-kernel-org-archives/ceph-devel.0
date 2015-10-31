From: Ning Yao <zay11022@gmail.com>
Subject: Re: why we use two ObjectStore::Transaction in ReplicatedBackend::submit_transaction?
Date: Sun, 1 Nov 2015 01:06:41 +0800
Message-ID: <CALZt5jxECz=Rf-UxBeXxWNu+CuE-9pDvFg9698VC=FupOpFOrQ@mail.gmail.com>
References: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com>
	<alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net>
	<CALZt5jwEocBc2uqvec11ynWVWu=M=pG5wZSw_quFBVoaCgZcZQ@mail.gmail.com>
	<CO1PR02MB208AE0D8B1C669E5E48DC93F42E0@CO1PR02MB208.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37694 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895AbbJaRNx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 31 Oct 2015 13:13:53 -0400
Received: by wmff134 with SMTP id f134so32004366wmf.0
        for <ceph-devel@vger.kernel.org>; Sat, 31 Oct 2015 10:13:52 -0700 (PDT)
In-Reply-To: <CO1PR02MB208AE0D8B1C669E5E48DC93F42E0@CO1PR02MB208.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: Sage Weil <sage@newdream.net>, =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> BTW, latest code base is already separating out 2 transaction. No more append call.
Yeah, Got it. But still extra memory allocation in local_t like op_bl.
we may use the previous op_bl in op_t in most cases.
