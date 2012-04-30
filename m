From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: set_layout
Date: Mon, 30 Apr 2012 10:43:09 -0700
Message-ID: <CAORUGqAF6+PjvqC60jV1Z6XVvve5T9cex0=qrQHkNrNyz-VUxw@mail.gmail.com>
References: <loom.20120427T181902-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:49125 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab2D3Rna (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Apr 2012 13:43:30 -0400
Received: by vcqp1 with SMTP id p1so2210461vcq.19
        for <ceph-devel@vger.kernel.org>; Mon, 30 Apr 2012 10:43:29 -0700 (PDT)
In-Reply-To: <loom.20120427T181902-693@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xinren <tntinfo@hotmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, Apr 27, 2012 at 10:25, xinren <tntinfo@hotmail.com> wrote:
> All,
>
> I try to use cephfs to set up
> various parameters, such as
>
> cephfs /cephdir set_layout -s 8388608 -c 1 -u 8388608 -o 1
>
> In this case, the "preferred osd" will be 1. I then copy files to /cephdir. I
> found that stripe_unit is 8MByte. However, files are copies to different OSDs (I
> have 4 OSDs). Is there any way that I copy a file to a designate OSD? Thanks in
> advance.

The "local PGs" feature used by -o is deprecated and removed
(depending on the release).

Experience with the feature showed that it did not behave well, and we
currently consider trying to manually manage data allocations to osds
a bad idea.

If you want to manage how your data is located and replicated, you are
better off using pools with custom crushmap rules. This allows for
placement policies that are still flexible enough to handle osd
failures and balancing.
