From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: libcephfs create file with layout and replication
Date: Sun, 18 Nov 2012 12:05:45 -0800
Message-ID: <CAPrxi5_xpas2uiTtP0bpueVmfPn1YhoHMqFuNJBGCV2suSgV-g@mail.gmail.com>
References: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com>
	<alpine.DEB.2.00.1211171520280.31628@cobra.newdream.net>
	<CAPrxi58Ro5i9HP1Yryvg+hzgm=LOeo+Zp4NhBp-OJgWjpbg9xg@mail.gmail.com>
	<alpine.DEB.2.00.1211171614550.31628@cobra.newdream.net>
	<CAPrxi59thxE6rOj1BSkhpkU3sVOmBM38Rd=QakBAdQQBR=vawA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:35589 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab2KRUFq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 18 Nov 2012 15:05:46 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so516895vcm.19
        for <ceph-devel@vger.kernel.org>; Sun, 18 Nov 2012 12:05:45 -0800 (PST)
In-Reply-To: <CAPrxi59thxE6rOj1BSkhpkU3sVOmBM38Rd=QakBAdQQBR=vawA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Wanna have a look at a first pass on this patch?

   wip-client-open-layout

Thanks,
Noah

On Sat, Nov 17, 2012 at 5:20 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> On Sat, Nov 17, 2012 at 4:15 PM, Sage Weil <sage@inktank.com> wrote:
>>
>> We ignore that for the purposes of getting the libcephfs API correct,
>> though...
>
> Ok, make sense. Thanks.
>
> Noah
