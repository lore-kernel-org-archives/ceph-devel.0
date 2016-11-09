From: "Moreno, Orlando" <orlando.moreno@intel.com>
Subject: RE: status of spdk
Date: Wed, 9 Nov 2016 20:53:09 +0000
Message-ID: <034AAD465C6CBE4F96D9FB98573A79A602670AB7@FMSMSX108.amr.corp.intel.com>
References: <CADRKj5R+kwpr+_D+bx48gw_BHzX0jcQG-52C_kiLuTeqeEV+Qw@mail.gmail.com>
 <alpine.DEB.2.11.1611082334390.32512@piezo.us.to>
 <CADRKj5T0=J1QuMjgDKr9WMME-bT6_DoY7UjnQdYUBUJ3YiJU1A@mail.gmail.com>
 <41F4566A-4573-4CB9-81F4-1688ED2534C1@alibaba-inc.com>
 <CAAL-TMeZpUok4QWUXuC5G-VLqJYxKcJdFPu6rdWLG5f+kWxohw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:36594 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752167AbcKIUxR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 9 Nov 2016 15:53:17 -0500
In-Reply-To: <CAAL-TMeZpUok4QWUXuC5G-VLqJYxKcJdFPu6rdWLG5f+kWxohw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dong Wu <archer.wudong@gmail.com>, "LIU, Fei" <james.liu@alibaba-inc.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Sage Weil <sweil@redhat.com>, "Wang, Haomai" <haomaiwang@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, "'ifedotov@mirantis.com'" <ifedotov@mirantis.com>

Hi all,

Multiple DPDK/SPDK instances on a single host does not work because the current implementation in Ceph does not support it. This issue is tracked here: http://tracker.ceph.com/issues/16966 There is multi-process support in DPDK, but you must configure the EAL correctly for it to work. I have been working on a patch, https://github.com/ommoreno/ceph/tree/wip-16966, that allows the user to configure multiple BlueStore OSDs backed by SPDK. Though this patch works, I think it needs a few additions to actually make it performant.

This is just to get the 1 OSD process per NVMe case working. A multi-OSD per NVMe solution will probably require more work as described in this thread.

Thanks,
Orlando


-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Dong Wu
Sent: Tuesday, November 8, 2016 7:45 PM
To: LIU, Fei <james.liu@alibaba-inc.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>; Sage Weil <sweil@redhat.com>; Wang, Haomai <haomaiwang@gmail.com>; ceph-devel <ceph-devel@vger.kernel.org>
Subject: Re: status of spdk

Hi, Yehuda and Haomai,
    DPDK backend may have the same problem. I had tried to use haomai's  PR: https://github.com/ceph/ceph/pull/10748 to test dpdk backend, but failed to start multiple OSDs on the host with only one network card, alse i read about the dpdk multi-process support:
http://dpdk.org/doc/guides/prog_guide/multi_proc_support.html, but did not find any config  to set multi-process support. Anything wrong or multi-process support not been implemented?

2016-11-09 8:21 GMT+08:00 LIU, Fei <james.liu@alibaba-inc.com>:
> Hi Yehuda and Haomai,
>    The issue of drives driven by SPDK is not able to be shared by multiple OSDs as kernel NVMe drive since SPDK as a process so far can not be shared across multiple processes like OSDs, right?
>
>    Regards,
>    James
>
>
>
> On 11/8/16, 4:06 PM, "Yehuda Sadeh-Weinraub" <ceph-devel-owner@vger.kernel.org on behalf of yehuda@redhat.com> wrote:
>
>     On Tue, Nov 8, 2016 at 3:40 PM, Sage Weil <sweil@redhat.com> wrote:
>     > On Tue, 8 Nov 2016, Yehuda Sadeh-Weinraub wrote:
>     >> I just started looking at spdk, and have a few comments and questions.
>     >>
>     >> First, it's not clear to me how we should handle build. At the moment
>     >> the spdk code resides as a submodule in the ceph tree, but it depends
>     >> on dpdk, which currently needs to be downloaded separately. We can add
>     >> it as a submodule (upstream is here: git://dpdk.org/dpdk). That been
>     >> said, getting it to build was a bit tricky and I think it might be
>     >> broken with cmake. In order to get it working I resorted to building a
>     >> system library and use that.
>     >
>     > Note that this PR is about to merge
>     >
>     >         https://github.com/ceph/ceph/pull/10748
>     >
>     > which adds the DPDK submodule, so hopefully this issue will go away when
>     > that merged or with a follow-on cleanup.
>     >
>     >> The way to currently configure an osd to use bluestore with spdk is by
>     >> creating a symbolic link that replaces the bluestore 'block' device to
>     >> point to a file that has a name that is prefixed with 'spdk:'.
>     >> Originally I assumed that the suffix would be the nvme device id, but
>     >> it seems that it's not really needed, however, the file itself needs
>     >> to contain the device id (see
>     >> https://github.com/yehudasa/ceph/tree/wip-yehuda-spdk for a couple of
>     >> minor fixes).
>     >
>     > Open a PR for those?
>
>     Sure
>
>     >
>     >> As I understand it, in order to support multiple osds on the same NVMe
>     >> device we have a few options. We can leverage NVMe namespaces, but
>     >> that's not supported on all devices. We can configure bluestore to
>     >> only use part of the device (device sharding? not sure if it supports
>     >> it). I think it's best if we could keep bluestore out of the loop
>     >> there and have the NVMe driver abstract multiple partitions of the
>     >> NVMe device. The idea is to be able to define multiple partitions on
>     >> the device (e.g., each partition will be defined by the offset, size,
>     >> and namespace), and have the osd set to use a specific partition.
>     >> We'll probably need a special tool to manage it, and potentially keep
>     >> the partition table information on the device itself. The tool could
>     >> also manage the creation of the block link. We should probably rethink
>     >> how the link is structure and what it points at.
>     >
>     > I agree that bluestore shouldn't get involved.
>     >
>     > Is the NVMe namespaces meant to support multiple processes sharing the
>     > same hardware device?
>
>     More of a partitioning solution, but yes (as far as I undestand).
>
>     >
>     > Also, if you do that, is it possible to give one of the namespaces to the
>     > kernel?  That might solve the bootstrapping problem we currently 
> have
>
>     Theoretically, but not right now (or ever?). See here:
>
>     https://lists.01.org/pipermail/spdk/2016-July/000073.html
>
>     > where we have nowhere to put the $osd_data filesystem with the device
>     > metadata.  (This is admittedly not necessarily a blocking issue.  Putting
>     > those dirs on / wouldn't be the end of the world; it just means cards
>     > can't be easily moved between boxes.)
>     >
>
>     Maybe we can use bluestore for these too ;) that been said, there
>     might be some kind of a loopback solution that could work, but not
>     sure if it won't create major bottlenecks that we'd want to avoid.
>
>     Yehuda
>     --
>     To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>     the body of a message to majordomo@vger.kernel.org
>     More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> in the body of a message to majordomo@vger.kernel.org More majordomo 
> info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
