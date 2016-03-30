From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Adding compression/checksum support for bluestore.
Date: Wed, 30 Mar 2016 16:03:37 -0700
Message-ID: <CAJ4mKGaoSiyX8bHA22G00y=PbQUDs1j0BnrMj=o2rTycD9uAqQ@mail.gmail.com>
References: <CY1PR0201MB18975EBCBB7EC1291E57CBCCE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1603301806380.22014@cpach.fuggernut.com>
	<CY1PR0201MB189760F1BB3EB67EF216B71DE8980@CY1PR0201MB1897.namprd02.prod.outlook.com>
	<alpine.DEB.2.11.1603301856470.22014@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35530 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbcC3XDi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Mar 2016 19:03:38 -0400
Received: by mail-vk0-f49.google.com with SMTP id e6so81525024vkh.2
        for <ceph-devel@vger.kernel.org>; Wed, 30 Mar 2016 16:03:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1603301856470.22014@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Allen Samuels <Allen.Samuels@sandisk.com>, Igor Fedotov <ifedotov@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Mar 30, 2016 at 3:57 PM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 30 Mar 2016, Allen Samuels wrote:
>> One thing to also factor in is that if you increase the span of a
>> checksum, you degrade the quality of the checksum. So if you go with
>> 128K chunks of data you'll likely want to increase the checksum itself
>> from something beyond a CRC-32. Maybe somebody out there has a good way
>> of describing this quanitatively.
>
> Good point.  FWIW, I think we should default to xxhash over crc32c:
>
>         https://github.com/Cyan4973/xxHash
>
> Note that there is a 64-bit version that's faster on 64-bit procs.

Random googling (...and StackOverflow) lead me to
https://users.ece.cmu.edu/~koopman/roses/dsn04/koopman04_crc_poly_embedded.pdf,
which only extends up to 2KB (with a crc16, which makes me think crc32
can go a long way) but for anybody who actually reads it can probably
be extended to larger block sizes without much difficulty.
-Greg
