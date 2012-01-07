From: huang jun <hjwsm1989@gmail.com>
Subject: Re: questions about radosgw
Date: Sat, 7 Jan 2012 15:19:01 +0800
Message-ID: <CABAwU-Zbp_fYnb=m1J2s=krp2BgQ_NU5P0g219ba7_PCLALp+g@mail.gmail.com>
References: <CABAwU-ZVOzWBH1ethSuCFmNODC9bN3QPO7DMj3Y8EwP5tM3xjA@mail.gmail.com>
	<4F05AE63.8080302@widodh.nl>
	<CABAwU-Y-h+1Yez49wsYzNnDF_=KLdMQg6osY1XHi2NHTSZDRhw@mail.gmail.com>
	<CAC-hyiGn1f9BxsN4R-Pi7Q1_hExrL_UOea9N1friHwgRGD97QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:54221 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750996Ab2AGHTC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Jan 2012 02:19:02 -0500
Received: by obcwo16 with SMTP id wo16so2669629obc.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2012 23:19:01 -0800 (PST)
In-Reply-To: <CAC-hyiGn1f9BxsN4R-Pi7Q1_hExrL_UOea9N1friHwgRGD97QA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

2012/1/7 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> On Fri, Jan 6, 2012 at 7:10 PM, huang jun <hjwsm1989@gmail.com> wrote:
>> I have an idea, why not use radosgw+fs to balance the workload?
>> but i can not successfully deploy it.
>> I really want to know whether radosgw+fs works?
>> If so, how about the performance between radosgw+fs and radosgw+rados?
>>
>
> At this point radosgw cannot use arbitrary file system as a backend.
> This requires a restructuring of the code, though we do have that in
> mind. The current 'fs' backend for radosgw is obsolete and wouldn't
> work anyway as the internal interfaces evolved quite a bit since it
> had been written, mainly to take advantage of rados capabilities that
> a regular filesystem cannot provide.
> The plan is to create a new devel library (similar to librados and
> librbd) that will provide a filesystem-like api. Having radosgw using
> this library (instead of the current internal access library) will
> help enabling a fs backend. But, as I said, there's still some work
> ahead of us.
>
> Yehuda
hi, thanks for you reply
so the workload balance will be a hidden trouble using radosgw?do you
have any ideas to promote this?
and if we put an object in atmotic way: put it to a temp object and
after the write finished , send a clone op, does this have any effect
on IO thourghput?




-- 
huangjun
ChuYunHanZhi WuHan Network Storage System Ltd
WuHan GuangGu Road
