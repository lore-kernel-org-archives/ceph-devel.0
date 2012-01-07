From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: questions about radosgw
Date: Fri, 6 Jan 2012 22:59:16 -0800
Message-ID: <CAC-hyiGn1f9BxsN4R-Pi7Q1_hExrL_UOea9N1friHwgRGD97QA@mail.gmail.com>
References: <CABAwU-ZVOzWBH1ethSuCFmNODC9bN3QPO7DMj3Y8EwP5tM3xjA@mail.gmail.com>
	<4F05AE63.8080302@widodh.nl>
	<CABAwU-Y-h+1Yez49wsYzNnDF_=KLdMQg6osY1XHi2NHTSZDRhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49976 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114Ab2AGG7R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 7 Jan 2012 01:59:17 -0500
Received: by ghbg21 with SMTP id g21so1019190ghb.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jan 2012 22:59:16 -0800 (PST)
In-Reply-To: <CABAwU-Y-h+1Yez49wsYzNnDF_=KLdMQg6osY1XHi2NHTSZDRhw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: huang jun <hjwsm1989@gmail.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

On Fri, Jan 6, 2012 at 7:10 PM, huang jun <hjwsm1989@gmail.com> wrote:
> I have an idea, why not use radosgw+fs to balance the workload?
> but i can not successfully deploy it.
> I really want to know whether radosgw+fs works?
> If so, how about the performance between radosgw+fs and radosgw+rados?
>

At this point radosgw cannot use arbitrary file system as a backend.
This requires a restructuring of the code, though we do have that in
mind. The current 'fs' backend for radosgw is obsolete and wouldn't
work anyway as the internal interfaces evolved quite a bit since it
had been written, mainly to take advantage of rados capabilities that
a regular filesystem cannot provide.
The plan is to create a new devel library (similar to librados and
librbd) that will provide a filesystem-like api. Having radosgw using
this library (instead of the current internal access library) will
help enabling a fs backend. But, as I said, there's still some work
ahead of us.

Yehuda
