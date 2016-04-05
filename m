From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: Very slow write speed in CephFS+ Fuse +Namespace
Date: Tue, 5 Apr 2016 22:13:41 +0800
Message-ID: <CAAM7YAkJpb3soEgn1AAMD=g5uYwQ-XV97aQLBxkXtpyKfr=eEQ@mail.gmail.com>
References: <CAEYCsV+c-nNoJrMZbYbiBqhQ7L0qu94=VV23YyATEEEqwQLEgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35394 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759216AbcDEONn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 10:13:43 -0400
Received: by mail-wm0-f49.google.com with SMTP id 191so26102303wmq.0
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2016 07:13:42 -0700 (PDT)
In-Reply-To: <CAEYCsV+c-nNoJrMZbYbiBqhQ7L0qu94=VV23YyATEEEqwQLEgw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Sage Weil <sage@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Apr 4, 2016 at 11:04 PM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> Hi,
>
>     I am trying the rados namespace feature on CephFS over 10.1.0, it
> works well when I was using the admin keyring. But when I trying to
> lock user "cephFS.tenantA" to /tenantA, the writing speed is extremely
> slow.
>
> [Direct]
> root@slc5b03c-1gtn:/mnt# dd if=/dev/zero of=./test_big_file of=direct
> bs=1M count=20
> 5+0 records in
> 5+0 records out
> 5242880 bytes (5.2 MB) copied, 30.2971 s, 173 kB/s
>
> [Buffer]
> root@slc5b03c-1gtn:/mnt# dd if=/dev/zero of=./test_big_file_2 bs=1M count=20
> 20+0 records in
> 20+0 records out
> 20971520 bytes (21 MB) copied, 5.68805 s, 3.7 MB/s
>
>
>     cephFS.tenantA was created by:
> root@slc5b03c-2ucb:/mnt# ceph auth get-or-create client.cephFS.tenantA
> mon 'allow r' mds 'allow rw path=/tenantA' osd 'allow rw pool=mds_data
> namespace=tenantA'
> [client.cephFS.tenantA]
> key = AQAgeAJXhe7aORAAqx46SfsOqeZQue5XoBV8cQ==
>
>      the layout of /tenantA is:
> root@slc5b03c-2ucb:/mnt# getfattr -n ceph.dir.layout ./tenantA
> # file: tenantA
> ceph.dir.layout="stripe_unit=4194304 stripe_count=1
> object_size=4194304 pool=mds_data pool_namespace=tenantA"
>
>
>      then try to mount via ceph-fuse like:
> root@slc5b03c-1gtn:~# ceph-fuse --id cephFS.tenantA --cluster
> slc07_ceph_02 --client_mountpoint /tenantA /mnt
> ceph-fuse[94654]: starting ceph client
> 2016-04-04 07:42:28.096671 7f65000e2e80 -1 init, newargv =
> 0x7f650a680f60 newargc=11
> ceph-fuse[94654]: starting fuse
>
>    Note that, the writing speed with admin keyring looks good
> root@slc5b03c-2ucb:/mnt/tenantA# dd if=/dev/zero of=./try oflag=direct
> bs=1M count=20
> 20+0 records in
> 20+0 records out
> 20971520 bytes (21 MB) copied, 0.432546 s, 48.5 MB/s
>
>    And the layout works fine
> root@slc5b03c-1gtn:/mnt# rados ls --pool mds_data --namespace tenantA
> --id cephFS.tenantA --conf /etc/ceph/slc07_ceph_02.conf
> 10000000009.00000000
> 100000003f3.00000001
> 100000003f4.00000000
> 100000003f4.00000002
> 100000003f3.00000000
> 100000003f4.00000003
> 100000003f4.00000004
> 100000003f4.00000001
>
>
>    Is that something bugly in ceph-fuse?
>
> root@slc5b03c-1gtn:~# dpkg -l | grep fuse
> ii  ceph-fuse                              10.1.0-1trusty
>      amd64        FUSE-based client for the Ceph distributed file
> system
> ii  fuse                                   2.9.2-4ubuntu4.14.04.1
>      amd64        Filesystem in Userspace
> ii  libfuse2:amd64                         2.9.2-4ubuntu4.14.04.1
>      amd64        Filesystem in Userspace (library)
>

I just tried v10.1.0 and current master (10.1.0-490-gcf5d277), but
didn't see this behavior.  Please check again. If you still see this
behavior, please set debug objecter = 10 debug ms = 10, do some
direct-IO write and send the log to us.

Thanks
Yan, Zheng

>
> -Xiaoxi
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
