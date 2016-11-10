From: Sage Weil <sage@newdream.net>
Subject: Re: status of spdk
Date: Thu, 10 Nov 2016 22:59:03 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611102248410.29579@piezo.us.to>
References: <CADRKj5R+kwpr+_D+bx48gw_BHzX0jcQG-52C_kiLuTeqeEV+Qw@mail.gmail.com>         <alpine.DEB.2.11.1611082334390.32512@piezo.us.to>         <CADRKj5T0=J1QuMjgDKr9WMME-bT6_DoY7UjnQdYUBUJ3YiJU1A@mail.gmail.com>         <41F4566A-4573-4CB9-81F4-1688ED2534C1@alibaba-inc.com>
         <CAAL-TMeZpUok4QWUXuC5G-VLqJYxKcJdFPu6rdWLG5f+kWxohw@mail.gmail.com>         <034AAD465C6CBE4F96D9FB98573A79A602670AB7@FMSMSX108.amr.corp.intel.com>         <alpine.DEB.2.11.1611092054550.29278@piezo.us.to>        
 <82115773F5CCE44DA5B6CE8B3878B6F0294DA2DC@fmsmsx115.amr.corp.intel.com> <1478817550.80333.50.camel@intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1929840019-1478818746=:29579"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47285 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756077AbcKJW7I (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Nov 2016 17:59:08 -0500
In-Reply-To: <1478817550.80333.50.camel@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Walker, Benjamin" <benjamin.walker@intel.com>
Cc: "Gohad, Tushar" <tushar.gohad@intel.com>, "Moreno, Orlando" <orlando.moreno@intel.com>, "haomaiwang@gmail.com" <haomaiwang@gmail.com>, "archer.wudong@gmail.com" <archer.wudong@gmail.com>, "ifedotov@mirantis.com" <ifedotov@mirantis.com>, "james.liu@alibaba-inc.com" <james.liu@alibaba-inc.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "yehuda@redhat.com" <yehuda@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1929840019-1478818746=:29579
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi-

Thanks, Ben-- this is super helpful!

On Thu, 10 Nov 2016, Walker, Benjamin wrote:
> > > 2- sharing a tiny portion of the NVMe device for the osd_data (usually a few
> > > MB of metadata that gets mounted at /var/lib/ceph/osd/$cluster-$id).  
> > > Not sure this will be feasible or not.
> > 
> > Unfortunately, this is not feasible without some form of partitioning support
> > in SPDK (namespace/GPT or in form of a new LVM-like layer on top of SPDK bdev)
> > - the latter is under development at the moment.
> 
> We are currently developing both a persistent block allocator and a very
> lightweight, minimally featured filesystem (no directories, no permissions, no
> times). The original target for these are as the backing store of RocksDB, but
> they can be easily expanded to store other data. It isn't necessarily our
> primary aim to incorporate this into Ceph, but it clearly fits into the Ceph
> internals very well. We haven't provided a timeline on open sourcing this, but
> we're actively writing the code now.

This may not actually be that helpful.  It's basically what BlueFS is 
already doing (it's a rocksdb::Env that implements minimal "file system" 
and shares the device with teh rest of BlueStore).

What this point is really about is more operational than anything.  
Currently disks (HDDs or SSDs) can be easily swapped between machines 
because they have GPT partition labels and udev rules to run 'ceph-disk 
trigger' on them.  That basically mounts the tagged partition to a 
temporary location, figures out which OSD it is, bind mounts it to the 
appropriate /var/lib/ceph/osd/* directory, and then starts up the process.  
With BlueStore there are just a handful of metadata/bootstrap files here 
to get the OSD started:

-rw-r--r-- 1 sage sage           2 Nov  9 11:40 bluefs
-rw-r--r-- 1 sage sage          37 Nov  9 11:40 ceph_fsid
-rw-r--r-- 1 sage sage          37 Nov  9 11:40 fsid
-rw------- 1 sage sage          56 Nov  9 11:40 keyring
-rw-r--r-- 1 sage sage           8 Nov  9 11:40 kv_backend
-rw-r--r-- 1 sage sage          21 Nov  9 11:40 magic
-rw-r--r-- 1 sage sage           4 Nov  9 11:40 mkfs_done
-rw-r--r-- 1 sage sage           6 Nov  9 11:40 ready
-rw-r--r-- 1 sage sage          10 Nov  9 11:40 type
-rw-r--r-- 1 sage sage           2 Nov  9 11:40 whoami

plus a symlink for block, block.db, and block.wal to the other partitions 
or devices with the actual block data.

With SPDK, we can't carve out a partition or label it, a certainly can't 
mount it, so we'll need to rethink the bootstrapping process.  Fortunatley 
that can be wrapped up reasonably neatly in the 'ceph-disk activate' 
function, but eventually we'll need to decide how to storage/manage this 
metadata about the device.

Or just forget about easy hot swapping and stick these files on the 
hosts root partition.

> > The limitation that Orlando identified is, not being able to launch multiple
> > SPDK-based OSDs on a node today.  Igor and Orlando's PR (16966) is to add a
> > config option to limit the number of hugepages assigned to an OSD via an EAL
> > switch.  The other limitation today is being able to specify the CPU mask
> > assigned to each OSD which would require config addition.
> > 
> 
> To clarify, DPDK requires a process to declare the amount of memory (hugepages)
> and which CPU cores the process will use up front. If you want to run multiple
> DPDK-based processes on the same system, you just have to make sure there are
> enough hugepages and that the cores you specify don't overlap. That PR is just
> making it so you can configure these values. I just wanted to clarify that there
> isn't any deeper technical problem with running multiple DPDK processes on the
> same system - you all probably knew that but it's best to be clear. 
> 
> Also, DPDK uses hugepages because it's the only good way to get "pinned" memory
> in userspace that userspace drivers can DMA into and out of. That's because the
> kernel doesn't page out or move around hugepages (hugepages also happen to be
> more efficient TLB-wise given that the data buffers are often large transfers).
> There is some work on vfio-pci in the kernel that may provide a better solution
> in the long term, but I'm not totally up to speed on that. Because data must
> reside in hugepages currently, all buffers sent to the SPDK backend for
> BlueStore are copied from wherever they are into a buffer from a pool allocated
> out of hugepages. It would be better if all data buffers were originally
> allocated from hugepage memory, but that's a bigger change to Ceph of course.
> Note that incoming packets from DPDK will also reside in hugepages upon DMA from
> the NIC, which would be convenient except that almost all NVMe devices today
> don't support fully flexible scatter-gather specification of buffers and you end
> up forced to copy simply to satisfy the alignment requirements of the DMA
> engine. Some day though!

Yeah, we definitely want to get there eventually.  When Ceph sends data 
over the wire it is preceded by a header that includes an alignment 
so that (with TCP currently) we read data off the socket into 
properly aligned memory.  That way we can eventually do O_DIRECT writes 
with it.  If it's possible to direct what memory the DPDK data comes into 
we can hopefully do something similar here...  The rest of Ceph's 
bufferlist library should be flexible enough to enable zero-copy.

> Sorry to be so long-winded, but I'm happy to help with SPDK.

That's great to hear--this was very helpful for me!

Thanks-
sage




> 
> Thanks,
> Ben
> 
> > Tushar 
> > 
> > 
> > > 
> > > 
> > > -----Original Message-----
> > > From: ceph-devel-owner@vger.kernel.org 
> > > [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Dong Wu
> > > Sent: Tuesday, November 8, 2016 7:45 PM
> > > To: LIU, Fei <james.liu@alibaba-inc.com>
> > > Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>; Sage Weil 
> > > <sweil@redhat.com>; Wang, Haomai <haomaiwang@gmail.com>; ceph-devel 
> > > <ceph-devel@vger.kernel.org>
> > > Subject: Re: status of spdk
> > > 
> > > Hi, Yehuda and Haomai,
> > >     DPDK backend may have the same problem. I had tried to use haomai's  PR:
> > > https://github.com/ceph/ceph/pull/10748 to test dpdk backend, but failed to
> > > start multiple OSDs on the host with only one network card, alse i read
> > > about the dpdk multi-process support:
> > > http://dpdk.org/doc/guides/prog_guide/multi_proc_support.html, but did not
> > > find any config  to set multi-process support. Anything wrong or multi-
> > > process support not been implemented?
> > > 
> > > 2016-11-09 8:21 GMT+08:00 LIU, Fei <james.liu@alibaba-inc.com>:
> > > > 
> > > > Hi Yehuda and Haomai,
> > > >    The issue of drives driven by SPDK is not able to be shared by multiple
> > > > OSDs as kernel NVMe drive since SPDK as a process so far can not be shared
> > > > across multiple processes like OSDs, right?
> > > > 
> > > >    Regards,
> > > >    James
> > > > 
> > > > 
> > > > 
> > > > On 11/8/16, 4:06 PM, "Yehuda Sadeh-Weinraub" <ceph-devel-owner@vger.kernel
> > > > .org on behalf of yehuda@redhat.com> wrote:
> > > > 
> > > >     On Tue, Nov 8, 2016 at 3:40 PM, Sage Weil <sweil@redhat.com> wrote:
> > > >     > On Tue, 8 Nov 2016, Yehuda Sadeh-Weinraub wrote:
> > > >     >> I just started looking at spdk, and have a few comments and
> > > > questions.
> > > >     >>
> > > >     >> First, it's not clear to me how we should handle build. At the
> > > > moment
> > > >     >> the spdk code resides as a submodule in the ceph tree, but it
> > > > depends
> > > >     >> on dpdk, which currently needs to be downloaded separately. We can
> > > > add
> > > >     >> it as a submodule (upstream is here: git://dpdk.org/dpdk). That
> > > > been
> > > >     >> said, getting it to build was a bit tricky and I think it might be
> > > >     >> broken with cmake. In order to get it working I resorted to
> > > > building a
> > > >     >> system library and use that.
> > > >     >
> > > >     > Note that this PR is about to merge
> > > >     >
> > > >     >         https://github.com/ceph/ceph/pull/10748
> > > >     >
> > > >     > which adds the DPDK submodule, so hopefully this issue will go away
> > > > when
> > > >     > that merged or with a follow-on cleanup.
> > > >     >
> > > >     >> The way to currently configure an osd to use bluestore with spdk is
> > > > by
> > > >     >> creating a symbolic link that replaces the bluestore 'block' device
> > > > to
> > > >     >> point to a file that has a name that is prefixed with 'spdk:'.
> > > >     >> Originally I assumed that the suffix would be the nvme device id,
> > > > but
> > > >     >> it seems that it's not really needed, however, the file itself
> > > > needs
> > > >     >> to contain the device id (see
> > > >     >> https://github.com/yehudasa/ceph/tree/wip-yehuda-spdk for a couple
> > > > of
> > > >     >> minor fixes).
> > > >     >
> > > >     > Open a PR for those?
> > > > 
> > > >     Sure
> > > > 
> > > >     >
> > > >     >> As I understand it, in order to support multiple osds on the same
> > > > NVMe
> > > >     >> device we have a few options. We can leverage NVMe namespaces, but
> > > >     >> that's not supported on all devices. We can configure bluestore to
> > > >     >> only use part of the device (device sharding? not sure if it
> > > > supports
> > > >     >> it). I think it's best if we could keep bluestore out of the loop
> > > >     >> there and have the NVMe driver abstract multiple partitions of the
> > > >     >> NVMe device. The idea is to be able to define multiple partitions
> > > > on
> > > >     >> the device (e.g., each partition will be defined by the offset,
> > > > size,
> > > >     >> and namespace), and have the osd set to use a specific partition.
> > > >     >> We'll probably need a special tool to manage it, and potentially
> > > > keep
> > > >     >> the partition table information on the device itself. The tool
> > > > could
> > > >     >> also manage the creation of the block link. We should probably
> > > > rethink
> > > >     >> how the link is structure and what it points at.
> > > >     >
> > > >     > I agree that bluestore shouldn't get involved.
> > > >     >
> > > >     > Is the NVMe namespaces meant to support multiple processes sharing
> > > > the
> > > >     > same hardware device?
> > > > 
> > > >     More of a partitioning solution, but yes (as far as I undestand).
> > > > 
> > > >     >
> > > >     > Also, if you do that, is it possible to give one of the namespaces
> > > > to the
> > > >     > kernel?  That might solve the bootstrapping problem we 
> > > > currently have
> > > > 
> > > >     Theoretically, but not right now (or ever?). See here:
> > > > 
> > > >     https://lists.01.org/pipermail/spdk/2016-July/000073.html
> > > > 
> > > >     > where we have nowhere to put the $osd_data filesystem with the
> > > > device
> > > >     > metadata.  (This is admittedly not necessarily a blocking
> > > > issue.  Putting
> > > >     > those dirs on / wouldn't be the end of the world; it just means
> > > > cards
> > > >     > can't be easily moved between boxes.)
> > > >     >
> > > > 
> > > >     Maybe we can use bluestore for these too ;) that been said, there
> > > >     might be some kind of a loopback solution that could work, but not
> > > >     sure if it won't create major bottlenecks that we'd want to avoid.
> > > > 
> > > >     Yehuda
> > > >     --
> > > >     To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > > > in
> > > >     the body of a message to majordomo@vger.kernel.org
> > > >     More majordomo info at  
> > > > http://vger.kernel.org/majordomo-info.html
> > > > 
> > > > 
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > > > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > > > info at  http://vger.kernel.org/majordomo-info.html
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > > info at  http://vger.kernel.org/majordomo-info.html
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe ceph-devel" 
> > > in the body of a message to majordomo@vger.kernel.org More majordomo 
> > > info at  http://vger.kernel.org/majordomo-info.html
> > > 
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> > body of a message to majordomo@vger.kernel.org More majordomo info at  http://
> > vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> N?????r??y??????X??ǧv???)޺{.n?????z?]z????ay?ʇڙ??j??f???h??????w??????j:+v???w????????????zZ+???????j"????i
--8323329-1929840019-1478818746=:29579--
