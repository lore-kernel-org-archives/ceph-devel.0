From: Jeff Mitchell <jeffrey.mitchell@gmail.com>
Subject: Re: questions on networks and hardware
Date: Tue, 22 Jan 2013 09:58:04 -0500
Message-ID: <50FEA8FC.1040400@gmail.com>
References: <EFFE82E1-B74B-4DAB-8801-5311FA903618@jnielsen.net> <50FC2682.3020601@widodh.nl> <86F63F32-4C61-4F12-9EB0-925AD4FF1864@jnielsen.net> <50FE921D.2050204@widodh.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:55493 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248Ab3AVPFg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 10:05:36 -0500
Received: by mail-vc0-f176.google.com with SMTP id fy27so2277995vcb.7
        for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 07:05:34 -0800 (PST)
In-Reply-To: <50FE921D.2050204@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@widodh.nl>
Cc: John Nielsen <lists@jnielsen.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Wido den Hollander wrote:
> One thing is still having multiple Varnish caches and object banning. I
> proposed something for this some time ago, some "hook" in RGW you could
> use to inform a upstream cache to "purge" something from it's cache.

Hopefully not Varnish-specific; something like the Last-Modified header 
would be good.

Also there are tricks you can do with queries; see for instance 
http://forum.nginx.org/read.php?2,1047,1052

--Jeff
