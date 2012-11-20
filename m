From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: libcephfs create file with layout and replication
Date: Tue, 20 Nov 2012 13:59:21 -0800
Message-ID: <CAPrxi58VeC2PK8S7BvN2cxx6t-ooE4EicWoEWJAOK_Lun2v=vg@mail.gmail.com>
References: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com>
	<alpine.DEB.2.00.1211171520280.31628@cobra.newdream.net>
	<CAPrxi58Ro5i9HP1Yryvg+hzgm=LOeo+Zp4NhBp-OJgWjpbg9xg@mail.gmail.com>
	<alpine.DEB.2.00.1211171614550.31628@cobra.newdream.net>
	<CAPrxi59thxE6rOj1BSkhpkU3sVOmBM38Rd=QakBAdQQBR=vawA@mail.gmail.com>
	<CAPrxi5_xpas2uiTtP0bpueVmfPn1YhoHMqFuNJBGCV2suSgV-g@mail.gmail.com>
	<CAPYLRzi7R_4CkEAYCdGjLA9Atmyf+Gce+MbQtdS_=16M-0OtsQ@mail.gmail.com>
	<CAPrxi5-Y9Y=rjCOEPvo8SoR_oy5eyzZm2LBHcrB2orm5FP6z5Q@mail.gmail.com>
	<alpine.DEB.2.00.1211191927530.1082@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f179.google.com ([209.85.160.179]:50710 "EHLO
	mail-gh0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798Ab2KTV7V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 16:59:21 -0500
Received: by mail-gh0-f179.google.com with SMTP id r14so1264314ghr.10
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 13:59:21 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211191927530.1082@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 19, 2012 at 7:28 PM, Sage Weil <sage@inktank.com> wrote:
>
> We could avoid the whole issue by passing 4 arguments to the function...

I pushed a new patch that takes each of the 4 new arguments.

  wip-client-open-layout

Thanks,
-Noah
