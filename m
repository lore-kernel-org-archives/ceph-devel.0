From: Ken Dreyer <kdreyer@redhat.com>
Subject: handling qemu-guest logs in ceph-ansible
Date: Mon, 1 Aug 2016 13:25:47 -0600
Message-ID: <CALqRxCzk4-u842fq5xBW2SrdYSY+9wD=zLEDtUrAgNZ-L4pggA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:35795 "EHLO
	mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903AbcHATbg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2016 15:31:36 -0400
Received: by mail-ua0-f181.google.com with SMTP id l32so113597749ual.2
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2016 12:31:25 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

With the new unprivileged user support in Jewel, I'm seeing some
issues with logging and file permissions.

ceph-ansible always configures client logging on every cluster node, like so:

  [client]
  log file = /var/log/ceph/qemu-guest-$pid.log

As a result, every single client command (eg "ceph health") will
create a new root-owned "qemu-guest-$pid" log file (which leads to
issues with logrotate failing to rotate the root-owned files in the
diretory...)

It's clear we need to remove that bit from the ceph.conf files that
ceph-ansible writes, but I'm wondering what it *should* be?

Is there a more granular way to configure Ceph so that we only log
qemu/librbd interactions to qemu-guest-$pid, rather than all client
logs?

- Ken
