From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Jewel build for CentOS 6
Date: Mon, 13 Jun 2016 09:39:17 -0600
Message-ID: <CALqRxCx2DxYhxCiiB-x-2isqi0Fd8R5u=ChT+6Z_r_pima4h8Q@mail.gmail.com>
References: <CAK=B8ybVb0=Z7FM1LOPA-Dp1kGZjPn3nBbDg1hf+SkC50ir+Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36182 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423867AbcFMPjX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jun 2016 11:39:23 -0400
Received: by mail-vk0-f44.google.com with SMTP id u64so72564734vkf.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jun 2016 08:39:23 -0700 (PDT)
In-Reply-To: <CAK=B8ybVb0=Z7FM1LOPA-Dp1kGZjPn3nBbDg1hf+SkC50ir+Lw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Muminul Islam Russell <misla011@fiu.edu>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

You really should upgrade to CentOS 7, particularly with such a
fast-moving project as Ceph :) The time required to stabilize a 10.2.1
build on el6 probably outweighs the time required to migrate OS
versions.

That said, if you really want to get el6 builds working, you'll
probably want to patch out SELinux support, disable debug package
generation in the RPM, and use a newer GCC.

- Ken


On Tue, Jun 7, 2016 at 6:13 PM, Muminul Islam Russell <misla011@fiu.edu> wrote:
> Hello Cephers,
>
> I was trying to build Jewel for Centos 6 for personal purpose. I fixed
> couple of things and at the end I got the following error. Please let
> me know if anyone have any idea how to fix this issue.
>
> -------
> writing... rbd-mirror.8 { } rbdmap.8 { } ceph-detect-init.8 { }
> ceph-rest-api.8 { } osdmaptool.8 { } ceph-rbdnamer.8 { }
> ceph-create-keys.8 { } ceph-disk.8 { } cephfs.8 { } ceph.8 { }
> monmaptool.8 { } ceph-deploy.8 { } ceph-debugpack.8 { }
> ceph-dencoder.8 { } rbd-nbd.8 { } mount.ceph.8 { } radosgw-admin.8 { }
> ceph-fuse.8 { } ceph-authtool.8 { } ceph-run.8 { } librados-config.8 {
> } ceph-clsinfo.8 { } ceph-post-file.8 { } ceph-mds.8 { } ceph-osd.8 {
> } ceph-syn.8 { } crushtool.8 { } rbd-fuse.8 { } radosgw.8 { }
> ceph-conf.8 { } ceph-mon.8 { } rados.8 { } rbd-replay-many.8 { }
> rbd-replay-prep.8 { } rbd.8 { } rbd-replay.8 { }
> build succeeded.
> make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-10.2.1/man'
> Making all in doc
> make[1]: Entering directory `/root/rpmbuild/BUILD/ceph-10.2.1/doc'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-10.2.1/doc'
> Making all in systemd
> make[1]: Entering directory `/root/rpmbuild/BUILD/ceph-10.2.1/systemd'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-10.2.1/systemd'
> Making all in selinux
> make[1]: Entering directory `/root/rpmbuild/BUILD/ceph-10.2.1/selinux'
> make -j1 -f /usr/share/selinux/devel/Makefile ceph.pp
> make[2]: Entering directory `/root/rpmbuild/BUILD/ceph-10.2.1/selinux'
> make[2]: warning: -jN forced in submake: disabling jobserver mode.
> Compiling targeted ceph module
> /usr/bin/checkmodule:  loading policy configuration from tmp/ceph.tmp
> ceph.te":109:ERROR 'syntax error' at token 'fsadm_manage_pid' on line 15485:
>
> fsadm_manage_pid(ceph_t)
> /usr/bin/checkmodule:  error(s) encountered while parsing configuration
> make[2]: *** [tmp/ceph.mod] Error 1
> make[2]: Leaving directory `/root/rpmbuild/BUILD/ceph-10.2.1/selinux'
> make[1]: *** [ceph.pp] Error 2
> make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-10.2.1/selinux'
> make: *** [all-recursive] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.pInRWe (%build
>
> --
> Russell
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
