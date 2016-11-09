From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: status of spdk
Date: Wed, 9 Nov 2016 12:45:44 +0800
Message-ID: <CACJqLyb-yUBJvOz50xDy187hczso6ynPx03Bq8HB-cEs+QrQCA@mail.gmail.com>
References: <CADRKj5R+kwpr+_D+bx48gw_BHzX0jcQG-52C_kiLuTeqeEV+Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:34336 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbcKIEpq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 23:45:46 -0500
Received: by mail-vk0-f46.google.com with SMTP id x186so166954866vkd.1
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 20:45:45 -0800 (PST)
In-Reply-To: <CADRKj5R+kwpr+_D+bx48gw_BHzX0jcQG-52C_kiLuTeqeEV+Qw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: "Weil, Sage" <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Nov 9, 2016 at 7:31 AM, Yehuda Sadeh-Weinraub <yehuda@redhat.com> wrote:
> I just started looking at spdk, and have a few comments and questions.
>
> First, it's not clear to me how we should handle build. At the moment
> the spdk code resides as a submodule in the ceph tree, but it depends
> on dpdk, which currently needs to be downloaded separately. We can add
> it as a submodule (upstream is here: git://dpdk.org/dpdk). That been
> said, getting it to build was a bit tricky and I think it might be
> broken with cmake. In order to get it working I resorted to building a
> system library and use that.

yes, because we expect dpdk submodule will merge soon. we left this aside..

now the eaisest way is yum install dpdk-devel to complete the build
instead of git clone dpdk repo separated.

>
> The way to currently configure an osd to use bluestore with spdk is by
> creating a symbolic link that replaces the bluestore 'block' device to
> point to a file that has a name that is prefixed with 'spdk:'.
> Originally I assumed that the suffix would be the nvme device id, but
> it seems that it's not really needed, however, the file itself needs
> to contain the device id (see
> https://github.com/yehudasa/ceph/tree/wip-yehuda-spdk for a couple of
> minor fixes).

hmm, I commented in config_opt.h.
// If you want to use spdk driver, you need to specify NVMe serial number here
// with "spdk:" prefix.
// Users can use 'lspci -vvv -d 8086:0953 | grep "Device Serial Number"' to
// get the serial number of Intel(R) Fultondale NVMe controllers.
// Example:
// bluestore_block_path = spdk:55cd2e404bd73932

we don't need to create symbolic link by hand, it could be done in
bluestore codes.

>
> As I understand it, in order to support multiple osds on the same NVMe
> device we have a few options. We can leverage NVMe namespaces, but
> that's not supported on all devices. We can configure bluestore to
> only use part of the device (device sharding? not sure if it supports
> it). I think it's best if we could keep bluestore out of the loop
> there and have the NVMe driver abstract multiple partitions of the
> NVMe device. The idea is to be able to define multiple partitions on
> the device (e.g., each partition will be defined by the offset, size,
> and namespace), and have the osd set to use a specific partition.
> We'll probably need a special tool to manage it, and potentially keep
> the partition table information on the device itself. The tool could
> also manage the creation of the block link. We should probably rethink
> how the link is structure and what it points at.

I discussed multi namespace with intel, spdk will embedded multi
namespace management.
But before ceph-osd single process can support multi OSD instance, I
think we need to do offset/length in application side.

Besides these problems, the most important thing is getting ride of
spdk dependence on dpdk. before multi-osd within single process
feature is done, we can't bear the multi polling threads occur 100%
cpu times.

>
> Any thoughts?
>
> Yehuda



-- 
Best Regards,

Wheat
