From: Sage Weil <sweil@redhat.com>
Subject: Re: status of spdk
Date: Tue, 8 Nov 2016 23:40:01 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611082334390.32512@piezo.us.to>
References: <CADRKj5R+kwpr+_D+bx48gw_BHzX0jcQG-52C_kiLuTeqeEV+Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751111AbcKHXkE (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 8 Nov 2016 18:40:04 -0500
In-Reply-To: <CADRKj5R+kwpr+_D+bx48gw_BHzX0jcQG-52C_kiLuTeqeEV+Qw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: "Wang, Haomai" <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 8 Nov 2016, Yehuda Sadeh-Weinraub wrote:
> I just started looking at spdk, and have a few comments and questions.
> 
> First, it's not clear to me how we should handle build. At the moment
> the spdk code resides as a submodule in the ceph tree, but it depends
> on dpdk, which currently needs to be downloaded separately. We can add
> it as a submodule (upstream is here: git://dpdk.org/dpdk). That been
> said, getting it to build was a bit tricky and I think it might be
> broken with cmake. In order to get it working I resorted to building a
> system library and use that.

Note that this PR is about to merge

	https://github.com/ceph/ceph/pull/10748

which adds the DPDK submodule, so hopefully this issue will go away when 
that merged or with a follow-on cleanup.

> The way to currently configure an osd to use bluestore with spdk is by
> creating a symbolic link that replaces the bluestore 'block' device to
> point to a file that has a name that is prefixed with 'spdk:'.
> Originally I assumed that the suffix would be the nvme device id, but
> it seems that it's not really needed, however, the file itself needs
> to contain the device id (see
> https://github.com/yehudasa/ceph/tree/wip-yehuda-spdk for a couple of
> minor fixes).

Open a PR for those?

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

I agree that bluestore shouldn't get involved.

Is the NVMe namespaces meant to support multiple processes sharing the 
same hardware device?

Also, if you do that, is it possible to give one of the namespaces to the 
kernel?  That might solve the bootstrapping problem we currently have 
where we have nowhere to put the $osd_data filesystem with the device 
metadata.  (This is admittedly not necessarily a blocking issue.  Putting 
those dirs on / wouldn't be the end of the world; it just means cards 
can't be easily moved between boxes.)

sage
