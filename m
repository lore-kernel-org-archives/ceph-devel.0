From: srimugunthan dhandapani <srimugunthan.dhandapani@gmail.com>
Subject: Re: Filesystems for ceph
Date: Thu, 28 Jul 2011 13:05:32 +0530
Message-ID: <CAMjNe_fxSP+tjLsOtu30NRza=SfFkOGQZ8M3ypCr1maUa2O2Jw@mail.gmail.com>
References: <CAO47_-8nD4XLgBP9+nDxasO548ZXcTzMm3M+P=ewdQR3EwoqUw@mail.gmail.com>
	<Pine.LNX.4.64.1107272136110.29447@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:52633 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab1G1Hfd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jul 2011 03:35:33 -0400
Received: by wwe5 with SMTP id 5so2179297wwe.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2011 00:35:32 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1107272136110.29447@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Christian Brunner <chb@muc.de>, ceph-devel@vger.kernel.org

On Thu, Jul 28, 2011 at 10:09 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 27 Jul 2011, Christian Brunner wrote:
>> We are having quite some problems with the underlying filesystem for
>> the cosd's and I would like to hear about other experiences. Here is
>> what we have gone through so far:
>>
>> btrfs with 2.6.38:
>>
>> - good performance
>> - frequently hitting of various BUG_ON conditions
>>
>> btrfs with 2.6.39:
>>
>> - big performance problems after a few days uptime
>> - occasionally hitting BUG_ON conditions
>>
>> btrfs with 3.0:
>>
>> - big performance problems after a few days uptime
>> - occasionally hitting a deadlock in the btrfs filesystem (cosd is i=
n D-state)
>
> You might try 3.0 + the latest stuff Chris just sent to Linus (at lea=
st
> for the D-state problem). =A0I'm eager to see whether the latencytop =
info
> you sent is helpful for the rest.
>
> FWIW we're running 2.6.38+ at the moment. =A0We get some warnings wit=
h the
> orphan code (fixed in .39), but it's otherwise been reasonably stable=
=2E

I thought that ext3/4 and btrfs are the only recommended underlying
filesystem for ceph. I didnt know we can use xfs.
With Glusterfs, theoretically, we can use any filesystem with extended
attributes support as backend filesystem. Is that the same case with
ceph too?
Though it may not be optimal, theoretically can i use a "filesystem X"
with extended attributes support for ceph?
thanks,
Mugunthan
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
