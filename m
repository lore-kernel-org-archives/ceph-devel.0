From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-commit] [ceph/ceph] e6a154: osx: compile on OSX
Date: Sun, 9 Dec 2012 10:05:43 -0800
Message-ID: <4685D39E3A8A4352B08C753D91FC4A5A@inktank.com>
References: <50c4cd4dabe04_4126fc8af02216d@sh2.rs.github.com.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58509 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab2LISFr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Dec 2012 13:05:47 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so1508323pad.19
        for <ceph-devel@vger.kernel.org>; Sun, 09 Dec 2012 10:05:46 -0800 (PST)
In-Reply-To: <50c4cd4dabe04_4126fc8af02216d@sh2.rs.github.com.mail>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Watkins Noah <noah.watkins@inktank.com>
Cc: ceph-devel@vger.kernel.org

Oooh, very nice! Do you have a list of the dependencies that you actually needed to install?

Apart from breaking this up into smaller patches, we'll also want to reformat some of it. Rather than sticking an #if APPLE on top of every spin lock, we should have utility functions that do this for us. ;)

Also, we should be able to find libatomic_ops for OS X (its parent project works under OS X), and we can use that to construct a spin lock if we think it'll be useful. I'm not too sure how effective its muteness are at spinlock-y workloads.
-Greg


On Sunday, December 9, 2012 at 9:41 AM, GitHub wrote:

> Branch: refs/heads/wip-osx
> Home: https://github.com/ceph/ceph
> Commit: e6a1544d42737b1aacf12210c0818200bb6d29aa
> https://github.com/ceph/ceph/commit/e6a1544d42737b1aacf12210c0818200bb6d29aa
> Author: Noah Watkins <nwatkins@martini.local>
> Date: 2012-12-09 (Sun, 09 Dec 2012)
> 
> Changed paths:
> M autogen.sh (http://autogen.sh)
> M configure.ac (http://configure.ac)
> A m4/ax_c_var_func.m4
> A m4/ax_cxx_static_cast.m4
> M src/Makefile.am (http://Makefile.am)
> M src/client/Client.cc (http://Client.cc)
> M src/client/fuse_ll.cc (http://fuse_ll.cc)
> M src/client/ioctl.h
> M src/common/OutputDataSocket.cc (http://OutputDataSocket.cc)
> M src/common/admin_socket.cc (http://admin_socket.cc)
> M src/common/blkdev.cc (http://blkdev.cc)
> M src/common/ceph_context.cc (http://ceph_context.cc)
> M src/common/ceph_context.h
> M src/common/code_environment.cc (http://code_environment.cc)
> A src/common/cpipe.c
> A src/common/cpipe.h
> M src/common/ipaddr.cc (http://ipaddr.cc)
> M src/common/lockdep.cc (http://lockdep.cc)
> R src/common/pipe.c
> R src/common/pipe.h
> M src/common/sctp_crc32.c
> M src/common/sync_filesystem.h
> M src/common/xattr.c
> M src/crush/crush.h
> M src/crush/hash.h
> M src/include/assert.h
> M src/include/atomic.h
> M src/include/buffer.h
> M src/include/byteorder.h
> M src/include/cephfs/libcephfs.h
> M src/include/compat.h
> M src/include/inttypes.h
> M src/include/linux_fiemap.h
> M src/include/msgr.h
> M src/include/types.h
> M src/leveldb
> M src/log/Log.cc (http://Log.cc)
> M src/log/Log.h
> M src/mon/LogMonitor.cc (http://LogMonitor.cc)
> M src/msg/Pipe.cc (http://Pipe.cc)
> M src/msg/SimpleMessenger.cc (http://SimpleMessenger.cc)
> M src/msg/SimpleMessenger.h
> M src/os/FileJournal.cc (http://FileJournal.cc)
> M src/os/FileStore.cc (http://FileStore.cc)
> M src/osd/OSD.cc (http://OSD.cc)
> M src/rados.cc (http://rados.cc)
> M src/test/system/cross_process_sem.cc (http://cross_process_sem.cc)
> M src/test/system/systest_runnable.cc (http://systest_runnable.cc)
> M src/tools/ceph.cc (http://ceph.cc)
> M src/tools/common.cc (http://common.cc)
> 
> Log Message:
> -----------
> osx: compile on OSX
> 
> This patch allows the full tree to build on OSX, but currently there are
> a lot of segfaults, inconsistent uses of DARWIN/__APPLE__ defines, and
> some of the semantic changes are likely wrong. We'll need to split this
> up into a much longer patch series, and can probably start with the
> minimal change set needed to make fuse work.
> 
> Use homebrew installed in its default location (/usr/local/) to install
> dependencies, and configure with --without-libatomic-ops --with-libaio.
> 
> _______________________________________________
> Ceph-commit mailing list
> Ceph-commit@lists.ceph.newdream.net (mailto:Ceph-commit@lists.ceph.newdream.net)
> http://lists.ceph.newdream.net/listinfo.cgi/ceph-commit-ceph.newdream.net



