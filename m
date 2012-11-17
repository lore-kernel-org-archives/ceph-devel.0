From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: libcephfs create file with layout and replication
Date: Sat, 17 Nov 2012 15:58:56 -0800
Message-ID: <CAPrxi58Ro5i9HP1Yryvg+hzgm=LOeo+Zp4NhBp-OJgWjpbg9xg@mail.gmail.com>
References: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com>
	<alpine.DEB.2.00.1211171520280.31628@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44210 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361Ab2KQX65 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Nov 2012 18:58:57 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so4042016vbb.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Nov 2012 15:58:56 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211171520280.31628@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sat, Nov 17, 2012 at 3:23 PM, Sage Weil <sage@inktank.com> wrote:
> On Sat, 17 Nov 2012, Noah Watkins wrote:
>
> FWIW, the striping parameters are object size, stripe unit, stripe count,
> and data pool.

In ceph_mds_request_args.open I see the all the striping parameters
except data pool, and I don't see any places that the file_replication
parameter is being used. Should a pg_pool field be added?

-Noah
