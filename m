From: Gregory Farnum <gregf@hq.newdream.net>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Mon, 29 Nov 2010 09:07:49 -0800
Message-ID: <AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
References: <1291001135.1872.106.camel@cephhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49993 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab0K2RHv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Nov 2010 12:07:51 -0500
Received: by ewy5 with SMTP id 5so2100663ewy.19
        for <ceph-devel@vger.kernel.org>; Mon, 29 Nov 2010 09:07:50 -0800 (PST)
In-Reply-To: <1291001135.1872.106.camel@cephhost>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: cpwu@tnsoft.com.cn
Cc: sage@newdream.net, yehuda@hq.newdream.net, colinm@hq.newdream.net, ceph-devel@vger.kernel.org, mllv <mllv@tnsoft.com.cn>

On Sun, Nov 28, 2010 at 7:25 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
>
> Hi ,
>
> I've recently been using FFSB and iozone to do performance test with Ceph
> v0.23 on my platform.
> the attachment file are FFSB configuration file and ceph.conf.
So you're not using OSD journals in either test configuration? You're
going to get pretty terrible write results without a journal.
The reads are clearly slower than they should be and you could
probably get better results by adjusting the caching behaviors. We
haven't done too much work on optimizing read behavior.

Could you run "ceph osd tell * bench", then run "ceph -w", and report
the results? (That'll just run local benchmarking on the OSD to report
the approximate write speed it's capable of.)
You can also run "rados -p data bench 60 write", and then "rados -p
data bench 0 seq" to get a simpler (better understood) performance
test.
With this data as a baseline we can start looking at what might be
causing trouble.
-Greg
