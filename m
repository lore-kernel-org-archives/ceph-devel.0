From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: libvirt: Removing RBD volumes with snapshots, auto purge or not?
Date: Tue, 20 Aug 2013 14:12:35 -0700
Message-ID: <5213DBC3.1080009@inktank.com>
References: <52138CEF.8010109@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:50522 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab3HTVOc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Aug 2013 17:14:32 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so869714pbb.34
        for <ceph-devel@vger.kernel.org>; Tue, 20 Aug 2013 14:14:32 -0700 (PDT)
In-Reply-To: <52138CEF.8010109@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/20/2013 08:36 AM, Wido den Hollander wrote:
> Hi,
>
> The current [0] libvirt storage pool code simply calls "rbd_remove"
> without anything else.
>
> As far as I know rbd_remove will fail if the image still has snapshots,
> you have to remove those snapshots first before you can remove the image.
>
> The problem is that libvirt's storage pools do not support listing
> snapshots, so we can't integrate that.

libvirt's storage pools don't have any concept of snapshots, which is
the real problem. Ideally they would have functions to at least create,
list and delete snapshots (and probably rollback and create a volume 
from a snapshot too).

> Libvirt however has a flag you can pass down to tell you want the device
> to be zeroed.
>
> The normal procedure is that the device is filled with zeros before
> actually removing it.
>
> I was thinking about "abusing" this flag to use it as a snap purge for RBD.
>
> So a regular volume removal will call only rbd_remove, but when the flag
> VIR_STORAGE_VOL_DELETE_ZEROED is passed it will purge all snapshots
> prior to calling rbd_remove.

I don't think we should reinterpret the flag like that. A new flag
for that purpose could work, but since libvirt storage pools don't
manage snapshots at all right now I'd rather CloudStack delete the
snapshots via librbd, since it's the service creating them in this case.
You could see what the libvirt devs think about a new flag though.

> Another way would be to always purge snapshots, but I'm afraid that
> could make somebody very unhappy at some point.

I agree this would be too unsafe for a default. It seems that's what
the LVM storage pool does now, maybe because it doesn't expect
snapshots to be used.

> Currently "virsh" doesn't support flags, but that could be fixed in a
> different patch.

No backend actually uses the flags yet either.

Josh
