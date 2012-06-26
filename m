From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: FS / Kernel question choosing the correct kernel version
Date: Tue, 26 Jun 2012 18:43:55 +0200
Message-ID: <4FE9E6CB.8080803@profihost.ag>
References: <4FE60A65.2030800@profihost.ag> <Pine.LNX.4.64.1206251506070.22491@cobra.newdream.net> <4FE97BE8.6010603@profihost.ag> <4FE9E006.6030404@profihost.ag> <4FE9E360.8050807@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:58799 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758426Ab2FZQn7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jun 2012 12:43:59 -0400
In-Reply-To: <4FE9E360.8050807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "hch@infradead.org >> Christoph Hellwig" <hch@infradead.org>

Am 26.06.2012 18:29, schrieb Mark Nelson:
> On 06/26/2012 11:15 AM, Stefan Priebe wrote:
> Hi Stefan,
>
> If you can, it would be really interesting to see the blktrace results
> during these tests for both xfs and btrfs.  blktrace is in the ubuntu
> repositories and can be run quite easily from the command line during
> your test.

Sure any special parameters? I have 4 SSDs per OSD Server.

Or just blktrace -o file?

Stefan
