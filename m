From: Tommi Virtanen <tv@inktank.com>
Subject: Re: How to write data to rbd pool.
Date: Mon, 1 Oct 2012 09:27:42 -0700
Message-ID: <CADvuQRE9paXEHD+bEa_Xjbh9Ex5Dt9+E4R+WjYq=3JY=VPCrOg@mail.gmail.com>
References: <loom.20121001T173732-275@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:38100 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab2JAQ2D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 12:28:03 -0400
Received: by qchd3 with SMTP id d3so3815338qch.19
        for <ceph-devel@vger.kernel.org>; Mon, 01 Oct 2012 09:28:02 -0700 (PDT)
In-Reply-To: <loom.20121001T173732-275@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, Oct 1, 2012 at 8:38 AM, ramu eppa <ramu.freesystems@gmail.com> wrote:
> Hi all,
>
>    I want write data or text file to rbd pool.Please help me.

You can create objects in RADOS pools with "rados put". See
http://ceph.com/docs/master/man/8/rados/ for the documentation.

The rbd pool usually contains only rbd images, though. An object
created from an arbitrary file won't work as an rbd image. For rbd
images, you want e.g. "rbd import":
http://ceph.com/docs/master/man/8/rbd/
