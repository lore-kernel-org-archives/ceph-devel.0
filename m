From: Martin Mailand <martin@tuxadero.com>
Subject: Re: osd crash during resync
Date: Tue, 24 Jan 2012 22:22:16 +0100
Message-ID: <4F1F2108.10400@tuxadero.com>
References: <4F1EFCFA.3060607@tuxadero.com> <CAF3hT9CMxL6eQMgNebdMifZ9CgcVGHNPhqV30Auh+on9HBKefQ@mail.gmail.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:57260 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756653Ab2AXVWV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jan 2012 16:22:21 -0500
In-Reply-To: <CAF3hT9CMxL6eQMgNebdMifZ9CgcVGHNPhqV30Auh+on9HBKefQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Hi Greg,
ok, do you guys still need the core files, or could I delete them?

-martin

Am 24.01.2012 22:13, schrieb Gregory Farnum:
> On Tue, Jan 24, 2012 at 10:48 AM, Martin Mailand<martin@tuxadero.com>  wrote:
>> Hi,
>> today I tried the btrfs patch mentioned on the btrfs ml. Therefore I
>> rebooted osd.0 with a new kernel and created a new btrfs on the osd.0, than
>> I took the osd.0 into the cluster. During the the resync of osd.0 osd.2 and
>> osd.3 crashed.
>> I am not sure, if the crashes happened because I played with osd.0, or if
>> they are bugs.
>
> These are OSD-level issues not caused by btrfs, so your new kernel
> definitely didn't do it. It's probably fallout from the backfill
> changes that got merged in last week. I created new bugs to track
> them: http://tracker.newdream.net/issues/1982 (1983, 1984). Sam and
> Josh are going wild on some other issues that we've turned up and
> these have been added to the queue as soon as somebody qualified can
> get to them. :)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
