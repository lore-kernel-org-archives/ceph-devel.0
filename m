From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Internal Qemu snapshots with RBD and libvirt
Date: Fri, 19 Jul 2013 15:30:38 -0700
Message-ID: <51E9BE0E.7020609@inktank.com>
References: <51E807DD.5050805@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gh0-f182.google.com ([209.85.160.182]:52428 "EHLO
	mail-gh0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab3GSWbu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Jul 2013 18:31:50 -0400
Received: by mail-gh0-f182.google.com with SMTP id z15so1464554ghb.41
        for <ceph-devel@vger.kernel.org>; Fri, 19 Jul 2013 15:31:50 -0700 (PDT)
In-Reply-To: <51E807DD.5050805@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 07/18/2013 08:21 AM, Wido den Hollander wrote:
> Hi,
>
> I'm working on the RBD integration for CloudStack 4.2 and now I got to
> the point snapshotting.
>
> The "problem" is that CloudStack uses libvirt for snapshotting
> Instances, but Qemu/libvirt also tries to store the memory contents of
> the domain to assure the snapshot is consistent.
>
> So the way libvirt tries to do it is not possible with RBD right now,
> since there is no way to store the internal memory.
>
> I was thinking about using the Java librbd bindings to create the
> snapshot, but that will not be consistent thus not 100% safe, so I'd
> rather avoid that.
>
> How is this done in OpenStack? Or are you facing similar issues?

OpenStack doesn't store the memory contents of a domain. For volume
snapshots, it requires that the volume is detached, so there can be
no inconsistency, and the actual snapshot handling is done by the volume
driver in cinder, so libvirt is not involved at all. It just uses the
rbd command (or now the python bindings).

> P.S.: I'm testing with libvirt 1.0.6 from the Ubuntu Cloud Team archive
> with packages for OpenStack Havana.
>

