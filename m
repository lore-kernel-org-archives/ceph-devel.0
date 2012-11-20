From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: libcephfs create file with layout and replication
Date: Mon, 19 Nov 2012 18:48:37 -0800
Message-ID: <CAPrxi5-Y9Y=rjCOEPvo8SoR_oy5eyzZm2LBHcrB2orm5FP6z5Q@mail.gmail.com>
References: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com>
	<alpine.DEB.2.00.1211171520280.31628@cobra.newdream.net>
	<CAPrxi58Ro5i9HP1Yryvg+hzgm=LOeo+Zp4NhBp-OJgWjpbg9xg@mail.gmail.com>
	<alpine.DEB.2.00.1211171614550.31628@cobra.newdream.net>
	<CAPrxi59thxE6rOj1BSkhpkU3sVOmBM38Rd=QakBAdQQBR=vawA@mail.gmail.com>
	<CAPrxi5_xpas2uiTtP0bpueVmfPn1YhoHMqFuNJBGCV2suSgV-g@mail.gmail.com>
	<CAPYLRzi7R_4CkEAYCdGjLA9Atmyf+Gce+MbQtdS_=16M-0OtsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:50072 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab2KTCsi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 21:48:38 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so95319vbb.19
        for <ceph-devel@vger.kernel.org>; Mon, 19 Nov 2012 18:48:37 -0800 (PST)
In-Reply-To: <CAPYLRzi7R_4CkEAYCdGjLA9Atmyf+Gce+MbQtdS_=16M-0OtsQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 19, 2012 at 5:04 PM, Gregory Farnum <greg@inktank.com> wrote:
>
> Just glanced over this, and I'm curious:
> 1) Why symlink another reference to your file_layout.h?

I followed the same pattern as page.h in librados, but may have
misunderstood its use. When libcephfs.h is installed, it includes

  #include "file_layout.h"

and we assume the user has -Iprefix/cephfs/.

but in the build tree, include/cephfs isn't an includes path used,
hence the symlink.

> 2) There's already a ceph_file_layout struct which is used "widely"
> (MDS, kernel, userspace client). It also has an accompanying function
> that does basic validity checks.

I avoided ceph_file_layout because I was under the impression that all
of the __le64 stuff in it was very much Linux-specific. I had run into
a lot of this hacking on an OSX port.

> FYI, there's an "unused" __le32 in the open struct (used to be for
> preferred PG). We should be able to steal that away without too much
> pain or massaging! :)

Nice. Do you think I should revert back to using ceph_file_layout?

Thanks,
Noah
