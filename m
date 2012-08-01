From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: How to write a backend for sdfs to talk directly to rados.
Date: Wed, 1 Aug 2012 08:21:32 -0700
Message-ID: <CAC-hyiEAU_1Q0Tfd-=CcAqkB04=Lm3DfX+SG2BfCA_qQH+WRew@mail.gmail.com>
References: <loom.20120801T090829-546@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44917 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755502Ab2HAPVe (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Aug 2012 11:21:34 -0400
Received: by bkwj10 with SMTP id j10so3835134bkw.19
        for <ceph-devel@vger.kernel.org>; Wed, 01 Aug 2012 08:21:32 -0700 (PDT)
In-Reply-To: <loom.20120801T090829-546@post.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ramu <ramu.freesystems@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Wed, Aug 1, 2012 at 12:09 AM, ramu <ramu.freesystems@gmail.com> wrote:
> Hi,
>
> How to write a backend for sdfs to talk directly to rados (java-rados).
> Please help me to write bakend for sdfs talk directly to rados.
>

I'm not too familiar with sdfs, but browsing through some online
material it seems that it already has plugin for Amazon S3. Why not
just using it with the rados gateway as a start? While hooking
directly to rados is probably possible, it really depends on the sdfs
requirements, whether it's going to be easy or not. Specifically I can
think of an issue like the atomic read/write of large objects that you
don't get out of the box with rados, but the radosgw solves and hides
the details.


Yehuda
