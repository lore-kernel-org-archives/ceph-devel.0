From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: how to run ceph on top of other local file system
Date: Mon, 17 Oct 2011 10:31:08 -0700
Message-ID: <CAF3hT9BwDAnUewrfTeZSWMuJSDHZW765jKF2sgQ2jNa32cLgxw@mail.gmail.com>
References: <CAB7xdikWPdZ4RaLRvqpMhUdkOS6=99ggdx3iBidBkbWy3k5vOg@mail.gmail.com>
	<CAORUGqBnqHOJp_wy3QOi=2LUy3Tbi+6PoaA4sTgUeSPqzDCZyw@mail.gmail.com>
	<CAB7xdim9QmtLWSVTrPoZofrwY=0PQEzsxtcBjA=pgS-GzLgzAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58401 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab1JQRbI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2011 13:31:08 -0400
Received: by yxp4 with SMTP id 4so4166693yxp.5
        for <ceph-devel@vger.kernel.org>; Mon, 17 Oct 2011 10:31:08 -0700 (PDT)
In-Reply-To: <CAB7xdim9QmtLWSVTrPoZofrwY=0PQEzsxtcBjA=pgS-GzLgzAw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Oct 17, 2011 at 10:20 AM, sheng qiu <herbert1984106@gmail.com> wrote:
> if my local file system does not support extended attributes, can i
> use it?
Unfortunately not. Ceph requires xattr support; it uses xattrs for
internal bookkeeping as well as for its own xattr support.

Most filesystems do support xattrs these days, though; you probably
just need to specify it as a mount option. :)
-Greg
