From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: how to free space from rados bench comman?
Date: Thu, 24 May 2012 11:05:57 -0700
Message-ID: <4FBE7885.6080200@inktank.com>
References: <4FBDDCAE.7040709@profihost.ag> <4FBDE314.7030305@widodh.nl> <4FBDE57F.9010409@profihost.ag> <4FBDEFB0.3030700@widodh.nl> <4FBDF691.3070601@profihost.ag> <986F41761DD1467EA38C8C853CFE8160@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:52976 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933804Ab2EXSGE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 14:06:04 -0400
Received: by weyu7 with SMTP id u7so39263wey.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 11:06:03 -0700 (PDT)
In-Reply-To: <986F41761DD1467EA38C8C853CFE8160@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Greg Farnum <greg@inktank.com>
Cc: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>, Wido den Hollander <wido@widodh.nl>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 05/24/2012 10:55 AM, Greg Farnum wrote:
> On Thursday, May 24, 2012 at 1:51 AM, Stefan Priebe - Profihost AG wrote:
>> Am 24.05.2012 10:22, schrieb Wido den Hollander:
>>> On 24-05-12 09:38, Stefan Priebe - Profihost AG wrote:
>>>>
>>>> ~# rados -p data ls|wc -l
>>>> 46631
>>>
>>>
>>>
>>> That is weird, I thought the bench tool cleaned up it's "mess".
>>>
>>> Imho it should cleanup after it's done, but there might be a reason why
>>> it's not. Did you abort the benchmark or did you let it do the whole run?
>>
>>
>> No it doesn't BUG?
> It doesn't because you might want to leave around the data for read benchmarking (or so that your cluster is full of data).
> There should probably be an option to clean up bench data, though! I've created a bug: http://tracker.newdream.net/issues/2477

Why not have the read benchmark write data itself, and then benchmark
reading? Then both read and write benchmarks can clean up after
themselves.

It's a bit odd to have the read benchmark depend on you running a write
benchmark first.

Josh
