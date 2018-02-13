From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [RFC PATCH] Samba RADOS service registration
Date: Mon, 12 Feb 2018 20:46:17 -0500
Message-ID: <CA+aFP1Aqc3Ty7ZrukrN3GAW=SLEz1QdUn2Q0X7cpwTqsKyyujw@mail.gmail.com>
References: <20180213022540.5f9686b7@suse.de>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:38942 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933102AbeBMBqS (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 20:46:18 -0500
Received: by mail-yw0-f169.google.com with SMTP id v196so11317084ywc.6
        for <ceph-devel@vger.kernel.org>; Mon, 12 Feb 2018 17:46:18 -0800 (PST)
In-Reply-To: <20180213022540.5f9686b7@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samba Technical <samba-technical@lists.samba.org>

On Mon, Feb 12, 2018 at 8:25 PM, David Disseldorp <ddiss@suse.de> wrote:
> Hi,
>
> I've been working on having Samba's smbd daemon register itself with the
> Ceph Cluster via rados_service_register(), and would appreciate some
> input on what to include in the instance and metadata descriptors.
>
> The attached patch implements basic Samba service registration
> functionality, but only uses a $hostname:smbd string for the instance
> and doesn't add any extra metadata (see [1] as a sample service dump).

Just as a heads up, after making tcmu-runner and rbd-mirror daemon
both register as service daemons, I found that using a hostname wasn't
the best technique since you really need to ensure a unique name or
else the last registered service daemon will clobber the previously
registered daemon. Since the initial implementation, I now include the
global instance id from RADOS in the service name to guarantee
uniqueness (especially since the hostname is already automatically
included in the metadata).

> I'd like to (at the very least) pack the CephFS backed share names and
> paths into the service registration. For this, I'm leaning towards
> adding the share name as an instance suffix (i.e.
> $hostname:smbd:$share), with a separate registration for each share.
> Each share could then include the CephFS path as instance specific
> metadata. That still leaves me with a few questions:
> - does it make sense to only register shares which are backed by CephFS?
>   + consider a server with local and CephFS shares, or worse still,
>     shared printers
>   + what about a Samba service without any shares?
> - I'd be using a single RADOS cluster connection to register all
>   shares. Can these services can be deregistered individually in case of
>   share removal, or are separate cluster connections required?

Currently you can only register a single service per (mgr) connection.
When I added the hooks to tcmu-runner and rbd-mirror daemons, I just
used the service status [1] to populate any data that would be
dynamically changing.

>   + a rados_service_deregister() hook would be useful
>
> Cheers, David
>
> 1. Sample Samba smbd service dump with shares ignored
>
>> ceph service dump
> {
>     "epoch": 2,
>     "modified": "2018-02-13 01:53:09.263133",
>     "services": {
>         "samba": {
>             "daemons": {
>                 "summary": "",
>                 "rapido1:smbd": {
>                     "start_epoch": 2,
>                     "start_stamp": "2018-02-13 01:53:08.112102",
>                     "gid": 4131,
>                     "addr": "192.168.124.104:0/1984347853",
>                     "metadata": {
>                         "arch": "x86_64",
>                         "ceph_version": "ceph version 12.2.1-387-g313479ab90 (313479ab90915289fa4905822d1f4825d1bf1e7c) luminous (stable)",
>                         "cpu": "QEMU Virtual CPU version 2.5+",
>                         "distro": "dracut",
>                         "distro_description": "openSUSE Leap 42.3 dracut-044-29.1 (Initramfs)",
>                         "distro_version": "044-29.1",
>                         "hostname": "rapido1",
>                         "kernel_description": "#21 SMP Tue Feb 13 01:05:27 CET 2018",
>                         "kernel_version": "4.4.115+",
>                         "mem_swap_kb": "0",
>                         "mem_total_kb": "1022828",
>                         "os": "Linux"
>                     }
>                 }
>             }
>         }
>     }
> }
>

[1] https://github.com/ceph/ceph/blob/master/src/tools/rbd_mirror/ServiceDaemon.cc#L241

-- 
Jason
