From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: format 2TB rbd device is too slow
Date: Fri, 28 Aug 2015 12:22:34 +0300
Message-ID: <CAOi1vP9Cx6VcZv7JJEjsT-jHpyB8RgRV7jDr2Xs4KLJMHr7v6Q@mail.gmail.com>
References: <CABAwU-ahZz48B2VHfeyqssBv778fKoVeD5Z3x2=Xgcf42VxTbQ@mail.gmail.com>
	<CACJqLyY0FrJDbi4VDzBa3aUBGu30A9soxbRbiiNpAL_Mttna+w@mail.gmail.com>
	<CAOi1vP__WA0+Q1xfRwcvNfs6_7T3OeA7Wdsw58taZt1arNR+bg@mail.gmail.com>
	<CABAwU-YnEw2mzpF-EwMoWLrTmDdSt+XPQ0dgawigkbH7rGMtuw@mail.gmail.com>
	<6AA21C22F0A5DA478922644AD2EC308C1D1A5038@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:34092 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbbH1JWg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Aug 2015 05:22:36 -0400
Received: by laba3 with SMTP id a3so28626525lab.1
        for <ceph-devel@vger.kernel.org>; Fri, 28 Aug 2015 02:22:34 -0700 (PDT)
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C1D1A5038@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>
Cc: huang jun <hjwsm1989@gmail.com>, Haomai Wang <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Aug 28, 2015 at 10:36 AM, Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
> Hi Ilya,
>    We can change sector size from 512 to 4096. This can reduce the count of write.
> I did a simple test: for 900G, mkfs.xfs -f
> For default: 1m10s
> Physical sector size = 4096:  0m10s.
>
> But if change sector size, we need rbd meta record this.

What exactly do you mean by changing the sector size?  xfs sector size
or physical block size of the rbd device?  If the latter, meaning
mkfs.xfs -s size 4096, I fail to see how it can result in the above
numbers.  If the former, you have to patch the kernel and I fail to see
how it can result in such an improvement too.  I probably didn't have
enough coffee, please elaborate.

Thanks,

                Ilya
