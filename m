From: Tommi Virtanen <tv@inktank.com>
Subject: Re: High-availability testing of ceph
Date: Tue, 31 Jul 2012 11:12:50 -0700
Message-ID: <CADvuQRE-=0_8PLsRD+0y92OiMRSJd9_an0hVTyOjFq70hBJP5g@mail.gmail.com>
References: <60E83269D669544E8069A09CB69135EA011444@GDC-CLDMBX-P02.whq.wistron>
 <5017735D.3060206@inktank.com> <60E83269D669544E8069A09CB69135EA011D31@GDC-CLDMBX-P02.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:41969 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085Ab2GaSNM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 14:13:12 -0400
Received: by vbbff1 with SMTP id ff1so6065709vbb.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 11:13:11 -0700 (PDT)
In-Reply-To: <60E83269D669544E8069A09CB69135EA011D31@GDC-CLDMBX-P02.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: josh.durgin@inktank.com, ceph-devel@vger.kernel.org, Chris_YT_Huang@wiwynn.com, Victor_CY_Chang@wiwynn.com

On Tue, Jul 31, 2012 at 12:31 AM,  <Eric_YH_Chen@wiwynn.com> wrote:
> If the performance of rbd device is n MB/s under replica=2,
> then that means the total io throughputs on hard disk is over 3 * n MB/s.
> Because I think the total number of copies is 3 in original.
>
> So, it seems not correct now, the total number of copies is only 2.
> The total io through puts on disk should be 2 * n MB/s. Right?

Yes, each replica needs to independently write the data to disk. On
top of that, there are journal writes, and filesystems have overhead
too. If you create a 1 GB object in a pool replicated 3 times, you
should expect about 3*1 GB writes in total to your osd data disks, and
at least 3*1 GB writes in total to your osd journal disks.

In normal use, you have many servers, and use CRUSH rules to ensure
the different replicas are not stored on the same server.
