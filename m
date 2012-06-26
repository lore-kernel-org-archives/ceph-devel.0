From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 11:59:49 -0500
Message-ID: <4FE9EA85.9030809@inktank.com>
References: <4FE60A65.2030800@profihost.ag> <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net> <4FE97BE8.6010603@profihost.ag> <4FE9E006.6030404@profihost.ag> <4FE9E360.8050807@inktank.com> <4FE9E6CB.8080803@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f51.google.com ([209.85.213.51]:40807 "EHLO
	mail-yw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758348Ab2FZRAG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 13:00:06 -0400
Received: by yhnn12 with SMTP id n12so176823yhn.10
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jun 2012 10:00:06 -0700 (PDT)
In-Reply-To: <4FE9E6CB.8080803@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "hch@infradead.org >> Christoph Hellwig" <hch@infradead.org>

On 06/26/2012 11:43 AM, Stefan Priebe wrote:
> Am 26.06.2012 18:29, schrieb Mark Nelson:
>> On 06/26/2012 11:15 AM, Stefan Priebe wrote:
>> Hi Stefan,
>>
>> If you can, it would be really interesting to see the blktrace results
>> during these tests for both xfs and btrfs. blktrace is in the ubuntu
>> repositories and can be run quite easily from the command line during
>> your test.
>
> Sure any special parameters? I have 4 SSDs per OSD Server.
>
> Or just blktrace -o file?
>
> Stefan

For each device you run it on you'll get one file per core.  There may 
be some performance impact if you run blktrace on every device per node. 
  If your data is well distributed, even a trace for one OSD (per test) 
would be interesting.

so blktrace -o <outfile prefix> -d <device> where device is your first 
OSD or something.  If you can do it for both btrfs and xfs and maybe run 
each test for a couple of minutes that might be enough.

Mark
