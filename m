From: David Disseldorp <ddiss@suse.de>
Subject: Re: [systemd-devel] [PATCH] rules: block - add dm devices to
 whitelist
Date: Mon, 10 Jul 2017 13:18:22 +0200
Message-ID: <20170710131822.7c612d7c@suse.de>
References: <20170705110145.20172-1-ddiss@suse.de>
        <20170710083838.GE5995@gardel-login>
        <20170710113703.13ca760d@suse.de>
        <20170710095303.GA6261@gardel-login>
        <df472d6a-b453-aca8-1143-be8ad62b0ce1@redhat.com>
        <7e499437-f48c-e630-f277-78b1b0db93a6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753819AbdGJLS3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 10 Jul 2017 07:18:29 -0400
In-Reply-To: <7e499437-f48c-e630-f277-78b1b0db93a6@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Peter Rajnoha <prajnoha@redhat.com>
Cc: ceph-devel@vger.kernel.org, systemd-devel@lists.freedesktop.org

On Mon, 10 Jul 2017 12:47:24 +0200, Peter Rajnoha wrote:

> On 07/10/2017 12:14 PM, Peter Rajnoha wrote:
...
> > Yes, please, any rules for symlinks which should be created under
> > /dev/disk for DM devices (including all its subsystems like LVM,
> > mpath...) should go into 13-dm-disk.rules that is part of LVM/DM source
> > tree:
> > 
> > https://sourceware.org/git/?p=lvm2.git;a=blob;f=udev/13-dm-disk.rules.in
> > 
> > Now, when we create a partition over a DM device, there's a new mapping
> > created on top for each partition (either by calling kpartx manually or
> > by having it created by partitioning tool directly if it supports that).
> > So in this case, it's not the kernel directly who creates the
> > partitions, but they're simply another DM devices created on top of the
> > underlying DM device to represent these partitions. But I think that
> > doesn't matter - we should still create those symlinks for people to
> > still have a possibility to reference the device by its part uuid - I'll
> > fix 13-dm-disk.rules to include this.
> >   
> 
> Fixed here:
> 
> https://sourceware.org/git/?p=lvm2.git;a=commit;h=c48149cf80c6582c2369bc7f8a33d794021d9dae

Looks good and works for me - thanks Peter.

Cheers, David
