From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: status of spdk
Date: Tue, 8 Nov 2016 15:31:44 -0800
Message-ID: <CADRKj5R+kwpr+_D+bx48gw_BHzX0jcQG-52C_kiLuTeqeEV+Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:34078 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbcKHXbr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 18:31:47 -0500
Received: by mail-ua0-f180.google.com with SMTP id 51so160610900uai.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 15:31:47 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Haomai" <haomaiwang@gmail.com>, "Weil, Sage" <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I just started looking at spdk, and have a few comments and questions.

First, it's not clear to me how we should handle build. At the moment
the spdk code resides as a submodule in the ceph tree, but it depends
on dpdk, which currently needs to be downloaded separately. We can add
it as a submodule (upstream is here: git://dpdk.org/dpdk). That been
said, getting it to build was a bit tricky and I think it might be
broken with cmake. In order to get it working I resorted to building a
system library and use that.

The way to currently configure an osd to use bluestore with spdk is by
creating a symbolic link that replaces the bluestore 'block' device to
point to a file that has a name that is prefixed with 'spdk:'.
Originally I assumed that the suffix would be the nvme device id, but
it seems that it's not really needed, however, the file itself needs
to contain the device id (see
https://github.com/yehudasa/ceph/tree/wip-yehuda-spdk for a couple of
minor fixes).

As I understand it, in order to support multiple osds on the same NVMe
device we have a few options. We can leverage NVMe namespaces, but
that's not supported on all devices. We can configure bluestore to
only use part of the device (device sharding? not sure if it supports
it). I think it's best if we could keep bluestore out of the loop
there and have the NVMe driver abstract multiple partitions of the
NVMe device. The idea is to be able to define multiple partitions on
the device (e.g., each partition will be defined by the offset, size,
and namespace), and have the osd set to use a specific partition.
We'll probably need a special tool to manage it, and potentially keep
the partition table information on the device itself. The tool could
also manage the creation of the block link. We should probably rethink
how the link is structure and what it points at.

Any thoughts?

Yehuda
