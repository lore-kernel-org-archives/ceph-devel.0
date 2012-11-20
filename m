From: Gregory Farnum <greg@inktank.com>
Subject: Re: libcephfs create file with layout and replication
Date: Mon, 19 Nov 2012 17:04:53 -0800
Message-ID: <CAPYLRzi7R_4CkEAYCdGjLA9Atmyf+Gce+MbQtdS_=16M-0OtsQ@mail.gmail.com>
References: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com>
	<alpine.DEB.2.00.1211171520280.31628@cobra.newdream.net>
	<CAPrxi58Ro5i9HP1Yryvg+hzgm=LOeo+Zp4NhBp-OJgWjpbg9xg@mail.gmail.com>
	<alpine.DEB.2.00.1211171614550.31628@cobra.newdream.net>
	<CAPrxi59thxE6rOj1BSkhpkU3sVOmBM38Rd=QakBAdQQBR=vawA@mail.gmail.com>
	<CAPrxi5_xpas2uiTtP0bpueVmfPn1YhoHMqFuNJBGCV2suSgV-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:54390 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753486Ab2KTBEx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 20:04:53 -0500
Received: by mail-ia0-f174.google.com with SMTP id y25so3851846iay.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 17:04:53 -0800 (PST)
In-Reply-To: <CAPrxi5_xpas2uiTtP0bpueVmfPn1YhoHMqFuNJBGCV2suSgV-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Sun, Nov 18, 2012 at 12:05 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
> Wanna have a look at a first pass on this patch?
>
>    wip-client-open-layout
>
> Thanks,
> Noah

Just glanced over this, and I'm curious:
1) Why symlink another reference to your file_layout.h?
2) There's already a ceph_file_layout struct which is used "widely"
(MDS, kernel, userspace client). It also has an accompanying function
that does basic validity checks.


> On Sat, Nov 17, 2012 at 5:20 PM, Noah Watkins <jayhawk@cs.ucsc.edu> wrote:
>> On Sat, Nov 17, 2012 at 4:15 PM, Sage Weil <sage@inktank.com> wrote:
>>>
>>> We ignore that for the purposes of getting the libcephfs API correct,
>>> though...
>>
>> Ok, make sense. Thanks.
>>
>> Noah

FYI, there's an "unused" __le32 in the open struct (used to be for
preferred PG). We should be able to steal that away without too much
pain or massaging! :)
-Greg
