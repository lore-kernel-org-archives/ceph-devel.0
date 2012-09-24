From: Gregory Farnum <greg@inktank.com>
Subject: Re: Initial Setup - Chef hangs at "in New OSD"
Date: Mon, 24 Sep 2012 09:52:47 -0700
Message-ID: <CAPYLRzhu+7BqBCc5WpkWpNDx0wv=FsT_BVp+-RGsB6ntpJV52Q@mail.gmail.com>
References: <S1755227Ab2IXIkt/20120924084049Z+524@vger.kernel.org>
	<506032AF.9040909@b1-systems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:50199 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756694Ab2IXQwu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Sep 2012 12:52:50 -0400
Received: by ieak13 with SMTP id k13so11434341iea.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Sep 2012 09:52:47 -0700 (PDT)
In-Reply-To: <506032AF.9040909@b1-systems.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Tilman Beitter <beitter@b1-systems.de>
Cc: ceph-devel@vger.kernel.org

Hmmm...this is probably an issue with SUSECloud setup rather than Ceph
itself (and we don't know how SUSECloud works). But it looks like it's
hanging while running "ceph osd tree", which means it's likely a
problem somewhere in connecting or getting an answer from the
monitors.
1) See if you have all your monitors running.
2) See if you can run "ceph -s -k <path/to/admin/keyring>" on one of
your monitors and get a response.
3) See if you can run "ceph -s <path/to/ndoe/keyring>" on the host
that is stuck.
4) See what's output from "ceph osd tree" on the monitor node.

On Mon, Sep 24, 2012 at 3:15 AM, Tilman Beitter <beitter@b1-systems.de> wrote:
> Hi all,
>
> I am trying to do a test-setup with SUSE Cloud and Ceph. Ceph get's
> installed via chef-client on the nodes. As I do not have enough disks in
> my test environment I created two partitions for ceph. So, ceph uses
> /dev/sda3 and /dev/sda4.
>
> While installing it stops here:
>
> [Mon, 24 Sep 2012 08:01:52 +0000] INFO: execute[Adding the secret
> AQCp3FxQ+OWiBhAApsrBRhRBZcn2qhSHjQcM8A== for client.admin into
> /etc/ceph/client.admin.keyring] ran successfully
> [Mon, 24 Sep 2012 08:01:52 +0000] INFO: Processing execute[make xfs
> filesystem on /dev/sda3] action run (ceph::osd line 36)
> [Mon, 24 Sep 2012 08:01:52 +0000] INFO: Processing
> directory[/var/lib/ceph/osd/ceph-2] action create (ceph::osd line 46)
> [Mon, 24 Sep 2012 08:01:52 +0000] INFO: Processing
> mount[/var/lib/ceph/osd/ceph-2] action enable (ceph::osd line 54)
> [Mon, 24 Sep 2012 08:01:52 +0000] INFO: Processing
> mount[/var/lib/ceph/osd/ceph-2] action mount (ceph::osd line 54)
> [Mon, 24 Sep 2012 08:01:52 +0000] INFO: Processing ceph_osd[Initializing
> new osd on /dev/sda3 ] action initialize (ceph::osd line 62)
> [Mon, 24 Sep 2012 08:01:52 +0000] INFO: in New OSD
>
> Mounts:
>
> /dev/sda3 on /var/lib/ceph/osd/ceph-2 type xfs (rw,noatime)
>
> Processes:
>
>  3319 ?        Ssl    0:02 /usr/bin/ceph-mon -i d00-14-5e-6d-08-a4-ceph
> --pid-file /var/run/ceph/mon.d00-14-5e-6d-08-a4-ceph.pid -c
> /etc/ceph/ceph.conf
> 18521 ?        S      0:00 sh -c ceph osd tree | grep -q osd.2
> 18522 ?        Sl     0:01 ceph osd tree
>
>
> Are there problems with the use of partitions or do I have another
> problem / misconfig?
>
> Thanks in advance
>
> Til
>
>
