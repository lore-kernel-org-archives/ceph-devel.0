From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: Higher OSD disk util due to RBD snapshots from Dumpling to Firefly
Date: Thu, 01 Jan 2015 10:30:45 +0100
Message-ID: <54A513C5.6040407@profihost.ag>
References: <54A42280.60607@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:38954 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbbAAJfo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jan 2015 04:35:44 -0500
In-Reply-To: <54A42280.60607@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>, ceph-devel <ceph-devel@vger.kernel.org>

hi,

Am 31.12.2014 um 17:21 schrieb Wido den Hollander:
> Hi,
>
> Last week I upgraded a 250 OSD cluster from Dumpling 0.67.10 to Firefly
> 0.80.7 and after the upgrade there was a severe performance drop on the
> cluster.
>
> It started raining slow requests after the upgrade and most of them
> included a 'snapc' in the request.
>
> That lead me to investigate the RBD snapshots and I found that a rogue
> process had created ~1800 snapshots spread out over 200 volumes.
>
> One image even had 181 snapshots!
>
> As the snapshots weren't used I removed them all and after the snapshots
> were removed the performance of the cluster came back to normal level again.
>
> I'm wondering what changed between Dumpling and Firefly which caused
> this? I saw OSDs spiking to 100% disk util constantly under Firefly
> where this didn't happen with Dumpling.
>
> Did something change in the way OSDs handle RBD snapshots which causes
> them to create more disk I/O?

I saw the same and addionally a slowdown in librbd too, that's why i'm 
still on dumpling and won't upgrade until hammer.

Stefan
