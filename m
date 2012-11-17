From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: libcephfs create file with layout and replication
Date: Sat, 17 Nov 2012 12:13:56 -0800
Message-ID: <CAPrxi5-eQ=unNbUMO5b_dJpFERySAuWD9GXratMEo9XGPpkrkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:59353 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752125Ab2KQUN5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Nov 2012 15:13:57 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so3960332vbb.19
        for <ceph-devel@vger.kernel.org>; Sat, 17 Nov 2012 12:13:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>

The Hadoop VFS layer assumes that block size and replication can be
set on a per-file basis, which is important to users for file
layout/workload optimizations.

The libcephfs interface doesn't make this entirely easy. Here is one
approach, but it isn't thread safe as the default values are global
variables in the client.

  orig_obj_size = ceph_get_default_object_size() //save
  set_default_object_size(new size)
  open(path, O_CREAT)
  set_default_object_size(new size) //reset

Something more convenient might be:

  ceph_open_layout(path, flags, mode, layout, replication)

where layout and replication are used with O_CREAT | O_EXCL, or and
interface for setting these values explicitly on newly created files:

  ceph_open(path, O_CREAT|O_EXCL)
  ceph_set_layout(path, layout, replication)

where ceph_set_layout would succeed ostensibly on zero-length files.

Any thoughts on how to handle this?

Thanks,
Noah
