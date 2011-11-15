From: Christian Brunner <chb@muc.de>
Subject: Re: ceph and ext4
Date: Tue, 15 Nov 2011 09:29:28 +0100
Message-ID: <CAO47_-9nfO32nwOAQMVdqw6iWGWK+FWb+MD=WeOz_vr4YrrKmw@mail.gmail.com>
References: <4EC10664.1080501@tuxadero.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63100 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753329Ab1KOI33 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Nov 2011 03:29:29 -0500
Received: by vws1 with SMTP id 1so6016350vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 15 Nov 2011 00:29:28 -0800 (PST)
In-Reply-To: <4EC10664.1080501@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: ceph-devel@vger.kernel.org

2011/11/14 Martin Mailand <martin@tuxadero.com>:
> Hi Christian,
> I am not sure if you noticed, but your ext4 bug is fixed in mainline. I am
> running a ceph cluster with 40+ vms for over a week by now, without any
> problems. An fsck.ext4 shows the ext4 is clean.
> The performance of ext4 is much better than btrfs, no rise in the load of
> the osd's.

Yes, I've seen the patch Eric submited. (In fact this was a result of
the call we had opened with RedHat).

I'd love to have a working filesystem for ceph, but the xattr issue
with ext4 really scares me. That's why I'm still wrestling with btrfs.

On the first day after I rebooted the OSDs btrfs performance is really
great. We can get up to 700 MB/s (over 10 Gigabit-Ethernet) inside a
virtual machine, I haven't reached this with ext4.

Regards,
Christian
