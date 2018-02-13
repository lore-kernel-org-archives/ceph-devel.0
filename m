From: John Spray <jspray@redhat.com>
Subject: Re: [RFC PATCH] Samba RADOS service registration
Date: Tue, 13 Feb 2018 11:07:44 +0000
Message-ID: <CALe9h7dPuDOtY06RPXJ2u5wkT=j8S6D1PkwgfByuQ8y3cuP9Fg@mail.gmail.com>
References: <20180213022540.5f9686b7@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:54419 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934079AbeBMLIG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 06:08:06 -0500
Received: by mail-wm0-f52.google.com with SMTP id i186so15212445wmi.4
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 03:08:06 -0800 (PST)
In-Reply-To: <20180213022540.5f9686b7@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Samba Technical <samba-technical@lists.samba.org>

On Tue, Feb 13, 2018 at 1:25 AM, David Disseldorp <ddiss@suse.de> wrote:
> Hi,
>
> I've been working on having Samba's smbd daemon register itself with the
> Ceph Cluster via rados_service_register(), and would appreciate some
> input on what to include in the instance and metadata descriptors.
>
> The attached patch implements basic Samba service registration
> functionality, but only uses a $hostname:smbd string for the instance
> and doesn't add any extra metadata (see [1] as a sample service dump).

Very cool!

> I'd like to (at the very least) pack the CephFS backed share names and
> paths into the service registration.

Echoing back the share configuration probably isn't a good use of this
interface -- the idea is for service daemons to register just enough
information about themselves to report on their existence, location
and health.

In the case of nfs-ganesha, we're moving toward having the option of
consuming its share configuration from a central place like a RADOS
object, rather than from a local text config file -- in that model, a
UI can go look at the configuration directly rather than having the
daemon report it back.  This is kind of a Ceph-ized version of the way
a lot of new projects are storing their configuration in etcd.

John



For this, I'm leaning towards
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
