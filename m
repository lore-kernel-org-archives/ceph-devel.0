From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: systemd status
Date: Wed, 29 Jul 2015 09:09:24 -0400
Message-ID: <CAGbviv+2=8CaZWFO4NA9yiBB=DRcFYdTV7jyLFLaS3G6chLdCA@mail.gmail.com>
References: <alpine.DEB.2.00.1507281202370.22099@cobra.newdream.net>
	<CACkq2mr0aU+X_KDKGeQFy=sdtmRyy7CSR5tKHxYGyUFAA6kfEQ@mail.gmail.com>
	<mpad83$pu4$1@ger.gmane.org>
	<alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33468 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751351AbbG2NJY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jul 2015 09:09:24 -0400
Received: by igbpg9 with SMTP id pg9so166187300igb.0
        for <ceph-devel@vger.kernel.org>; Wed, 29 Jul 2015 06:09:24 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1507290550250.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Alex Elsayed <eternaleye@gmail.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jul 29, 2015 at 8:55 AM, Sage Weil <sage@newdream.net> wrote:
> On Wed, 29 Jul 2015, Alex Elsayed wrote:
>> Travis Rhoden wrote:
>>

[...]

>> >> - udev's attempt to trigger ceph-disk isn't working for me.  the osd
>> >> service gets started but the mount isn't present and it fails to start.
>> >> I'm a systemd noob and haven't sorted out how to get udev to log
>> >> something
>> >> meaningful to debug it.  Perhaps we should merge in the udev +
>> >> systemd revamp patches here too...
>>
>> Personally, my opinion is that ceph-disk is doing too many things at once,
>> and thus fits very poorly into the systemd architecture...
>>
>> I mean, it tries to partition, format, mount, introspect the filesystem
>> inside, and move the mount, depending on what the initial state was.
>
> There is a series from David Disseldorp[1] that fixes much of this, by
> doing most of these steps in short-lived systemd tasks (instead of a
> complicated slow ceph-disk invocation directly from udev, which breaks
> udev).


Good stuff...

Is anyone working on something similar for upstart based systems?


>
>> Now, part of the issue is that the final mountpoint depends on data inside
>> the filesystem - OSD id, etc. To me, that seems... mildly absurd at least.
>>
>> If the _mountpoint_ was only dependent on the partuuid, and the ceph OSD
>> self-identified from the contents of the path it's passed, that would
>> simplify things immensely IMO when it comes to systemd integration because
>> the mount logic wouldn't need any hokey double-mounting, and could likely
>> use the systemd mount machinery much more easily - thus avoiding race issues
>> like the above.
>
> Hmm.  Well, we could name the mount point with the uuid and symlink the
> osd id to that.  We could also do something sneaky like embed the osd id
> in the least significant bits of the uuid, but that throws away a lot of
> entropy and doesn't capture the cluster name (which also needs to be known
> before mount).
>
> If the mounting and binding to the final location is done in a systemd job
> identified by the uuid, it seems like systemd would effectively handle the
> mutual exclusion and avoid races?
>
> sage
