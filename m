From: Tommi Virtanen <tv@inktank.com>
Subject: Re: How to write data to rbd pool.
Date: Tue, 2 Oct 2012 09:33:38 -0700
Message-ID: <CADvuQRHPZOwANKdX8THLkGqes-hxWN9grXJyce8uvfu=+SrTEQ@mail.gmail.com>
References: <loom.20121001T173732-275@post.gmane.org> <CADvuQRE9paXEHD+bEa_Xjbh9Ex5Dt9+E4R+WjYq=3JY=VPCrOg@mail.gmail.com>
 <loom.20121002T151242-374@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:49195 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab2JBQd7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 12:33:59 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so721126qad.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 09:33:59 -0700 (PDT)
In-Reply-To: <loom.20121002T151242-374@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu eppa <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 2, 2012 at 6:13 AM, ramu eppa <ramu.freesystems@gmail.com> wrote:
>   How to know the rbd volume path.

Umm. What is an rbd volume path? If you "rbd map" it, the block device
will be called /dev/rbd/<poolname>/<imagename> -- maybe that's what
you were looking for?
