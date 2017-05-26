From: Alfredo Deza <adeza@redhat.com>
Subject: Re: [Ceph-ansible] EXT: Re: EXT: Re: osd-directory scenario is used
 by us
Date: Fri, 26 May 2017 16:14:08 -0400
Message-ID: <CAC-Np1zEG734656oQJZUeAcGho84WVNhu5H0hUOa3r=9-3Q3wQ@mail.gmail.com>
References: <C7677170-0BA7-4310-B25B-CC3006517D2D@walmart.com>
 <CA+HUO7L=6Tk8rRAQyzNgcCf5_jiJg9UaHAqkoNQs0A5HgSbb6A@mail.gmail.com> <DM3P100MB01557A2F09BED8A1C5250BC290E20@DM3P100MB0155.NAMP100.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36795 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937454AbdEZUOK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 26 May 2017 16:14:10 -0400
Received: by mail-wm0-f49.google.com with SMTP id 7so3110979wmo.1
        for <ceph-devel@vger.kernel.org>; Fri, 26 May 2017 13:14:09 -0700 (PDT)
In-Reply-To: <DM3P100MB01557A2F09BED8A1C5250BC290E20@DM3P100MB0155.NAMP100.PROD.OUTLOOK.COM>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Anton Thaker <Anton.Thaker@walmart.com>
Cc: Sebastien Han <shan@redhat.com>, Warren Wang - ISD <Warren.Wang@walmart.com>, "ceph-ansible@lists.ceph.com" <ceph-ansible@lists.ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users-bounces@lists.ceph.com>

On Fri, May 12, 2017 at 5:56 PM, Anton Thaker <Anton.Thaker@walmart.com> wrote:
> I should have chimed in here earlier, but I think adding support for this would be potentially beneficial for lots of use cases (not just our current big-data workload).
> We've tested this type of setup with bcache and lvmcache (dmcache), with both block and object workloads, and decided to settle on lvmcache due to better support and tooling and slightly better performance.  Ideally, support would be added for a generic raw block device so that ceph-disk and ceph-ansible does not try to create partitions and just uses the entire device.  This then can be used with LVM, bcache, Intel CAS, <insert-your-favorite-caching-tech-here>...

You are right in that ceph-disk will insist in partitioning (and
labeling) things, so it will not work with lvm or anything similar to
a logical volume. Our current idea is to go ahead and support devices
as-is, but this is a bit more complicated (as you may be aware)
because systemd is tied to ceph-disk and they all rely on udev.

Would it be possible to know how did you handled the mounting of these
volumes? Was it editing fstab directly or some other way?

>
> The way we would use it with lvmcache would be, run our own Ansible role beforehand to prepare the physical disks with our lvmcache PVs, VG, LVs and hidden cached LVs, and then have ceph-ansible run something like this:
>
> ceph-disk prepare <vg/lv-data> <vg/lv-journal>
>
> where "vg/lv-data" is a cached device that has some small NVMe cache storage backed by a large spinning disk, and "vg/lv-journal" where the entire LV is on the NVMe device.

This is the path I want to go with and trying to gather information
before we go ahead implementing. My main concern is how to deal with
mounting while keeping systemd support. Knowing a bit more of your
setup will help
validate my ideas/concerns

>
> We currently do this with the "osd directory" ceph-ansible scenario where our lvm Ansible role slices up the disks, creates a bunch of logical volumes, and formats and mounts XFS (prior to running ceph-ansible).  The down side is of course that we're forced to use file-based journals.  Even with the overhead of file-based journals the performance improvements vs. just normal NVMe journals is significant for our workloads.  The caching layer is smart enough to promote the journals into the faster storage tier, and deep scrubs do not get promoted because of the large, sequential IO requests that are automatically detected.
>
> I don't know if there might be potential support issues with making this generic, so at the very least it would be great if support for just LVM was added.  I can share my Ansible role for building out the lvmcache devices if anyone is interested or if it helps to understand our setup.

That would be incredibly helpful!

>
> Thanks for the interest in our use case!
> Anton Thaker
> Walmart ✻
>
>
>
> From: Ceph-ansible <ceph-ansible-bounces@lists.ceph.com> on behalf of Sebastien Han <shan@redhat.com>
> Sent: Friday, May 12, 2017 10:32 AM
> To: Warren Wang - ISD
> Cc: ceph-ansible@lists.ceph.com; ceph-devel; ceph-users
> Subject: EXT: Re: [Ceph-ansible] EXT: Re: EXT: Re: osd-directory scenario is used by us
>
> So if we were to support LVM device as an OSD that would be enough for
> you? (support in ceph-disk).
>
> On Mon, May 8, 2017 at 5:57 AM, Warren Wang - ISD
> <Warren.Wang@walmart.com> wrote:
>> You might find additional responses in ceph-users. Added.
>>
>> A little extra background here. If Ceph directly supported LVM devices as OSDs, we probably wouldn’t have to do what we’re doing now.  We don’t know of a way to be able to use LVM cache device as an OSD without this type of config. This is primarily to support  big data workloads that use object storage as the only backing storage. So the type of IO that we see is highly irregular, compared to most object storage workloads. Shameless plug, my big data colleagues will be presenting on this topic next week at the OpenStack  summit.
>>
>>  https://www.openstack.org/summit/boston-2017/summit-schedule/events/18432/introducing-swifta-a-performant-hadoop-file-system-driver-for-openstack-swift
>>
>> Sebastien, even with Bluestore, we’re expecting to use LVM cached devices for the bulk of object storage, with a dedicated NVMe/SSD partition for RocksDB. I don’t know if that matters at all with regards to the OSD directory discussion. We really haven’t  done anything other than a basic Bluestore test on systems where we had not setup LVM cache devices.
>>
>> Warren Wang
>> Walmart ✻
>>
>> On 5/3/17, 6:17 PM, "Ceph-ansible on behalf of Gregory Meno" <ceph-ansible-bounces@lists.ceph.com on behalf of gmeno@redhat.com> wrote:
>>
>>     Haven't seen any comments in a week. I'm going to cross-post this to ceph-devel
>>
>>     Dear ceph-devel in an effort to simplify ceph-ansible I removed the
>>     code that sets up directory backed OSDs. We found our that it was
>>     being used in the following way.
>>
>>     I would like to hear thoughts about this approach pro and con.
>>
>>     cheers,
>>     G
>>
>>     On Tue, Apr 25, 2017 at 2:12 PM, Michael Gugino
>>     <Michael.Gugino@walmart.com> wrote:
>>     > All,
>>     >
>>     >   Thank you for the responses and consideration.  What we are doing is
>>     > creating lvm volumes, mounting them, and using the mounts as directories
>>     > for ceph-ansible.  Our primary concern is the use of lvmcache.  We’re
>>     > using faster drives for the cache and slower drives for the backing
>>     > volumes.
>>     >
>>     >   We try to keep as few local patches as practical, and our initial
>>     > rollout of lvmcache + ceph-ansible steered us towards osd_directory
>>     > scenario.  Currently, ceph-ansible does not allow use to use lvm in the
>>     > way that we desire, but we are looking into submitting a PR to go that
>>     > direction (at some point).
>>     >
>>     >   As far as using the stable branches, I’m not entirely sure what our
>>     > strategy going forward will be.  Currently we are maintaining ceph-ansible
>>     > branches based on ceph releases, not ceph-ansible releases.
>>     >
>>     >
>>     > Michael Gugino
>>     > Cloud Powered
>>     > (540) 846-0304 Mobile
>>     >
>>     > Walmart ✻
>>     > Saving people money so they can live better.
>>     >
>>     >
>>     >
>>     >
>>     >
>>     > On 4/25/17, 4:51 PM, "Sebastien Han" <shan@redhat.com> wrote:
>>     >
>>     >>One other argument to remove the osd directory scenario is BlueStore.
>>     >>Luminous is around the corner and we strongly hope it'll be the
>>     >>default object store.
>>     >>
>>     >>On Tue, Apr 25, 2017 at 7:40 PM, Gregory Meno <gmeno@redhat.com> wrote:
>>     >>> Michael,
>>     >>>
>>     >>> I am naturally interested in the specifics of your use-case and would
>>     >>> love to hear more about it.
>>     >>> I think the desire to remove this scenario from the stable-2.2 release
>>     >>> is low considering what you just shared.
>>     >>> Would it be fair to ask that sharing your setup be the justification
>>     >>> for restoring this functionality?
>>     >>> Are you using the stable released bits already? I recommend doing so.
>>     >>>
>>     >>> +Seb +Alfredo
>>     >>>
>>     >>> cheers,
>>     >>> Gregory
>>     >>>
>>     >>> On Tue, Apr 25, 2017 at 10:08 AM, Michael Gugino
>>     >>> <Michael.Gugino@walmart.com> wrote:
>>     >>>> Ceph-ansible community,
>>     >>>>
>>     >>>>   I see that recently osd-directory scenario was removed from
>>     >>>>deployment
>>     >>>> options.  We use this option in production, I will be submitting a
>>     >>>>patch
>>     >>>> and a small fix to re-add that scenario.  We believe our use-case is
>>     >>>> non-trivial, and we are hoping to share our setup with the community in
>>     >>>> the near future once we get approval.
>>     >>>>
>>     >>>> Thank you
>>     >>>>
>>     >>>>
>>     >>>> Michael Gugino
>>     >>>> Cloud Powered
>>     >>>> (540) 846-0304 Mobile
>>     >>>>
>>     >>>> Walmart ✻
>>     >>>> Saving people money so they can live better.
>>     >>>>
>>     >>>>
>>     >>>>
>>     >>>>
>>     >>>>
>>     >>>> On 4/18/17, 3:41 PM, "Ceph-ansible on behalf of Sebastien Han"
>>     >>>> <ceph-ansible-bounces@lists.ceph.com on behalf of shan@redhat.com>
>>     >>>>wrote:
>>     >>>>
>>     >>>>>Hi everyone,
>>     >>>>>
>>     >>>>>We are close from releasing the new ceph-ansible stable release.
>>     >>>>>We are currently in a heavy QA phase where we are pushing new tags in
>>     >>>>>the format of v2.2.x.
>>     >>>>>The latest tag already points to stable-2.2 branch.
>>     >>>>>
>>     >>>>>Stay tuned, stable-2.2 is just around the corner.
>>     >>>>>Thanks!
>>     >>>>>
>>     >>>>>--
>>     >>>>>Cheers
>>     >>>>>
>>     >>>>>––––––
>>     >>>>>Sébastien Han
>>     >>>>>Principal Software Engineer, Storage Architect
>>     >>>>>
>>     >>>>>"Always give 100%. Unless you're giving blood."
>>     >>>>>
>>     >>>>>Mail: seb@redhat.com
>>     >>>>>Address: 11 bis, rue Roquépine - 75008 Paris
>>     >>>>>_______________________________________________
>>     >>>>>Ceph-ansible mailing list
>>     >>>>>Ceph-ansible@lists.ceph.com
>>     >>>>>http://lists.ceph.com/listinfo.cgi/ceph-ansible-ceph.com
>>     >>>>
>>     >>>> _______________________________________________
>>     >>>> Ceph-ansible mailing list
>>     >>>> Ceph-ansible@lists.ceph.com
>>     >>>> http://lists.ceph.com/listinfo.cgi/ceph-ansible-ceph.com
>>     >>
>>     >>
>>     >>
>>     >>--
>>     >>Cheers
>>     >>
>>     >>––––––
>>     >>Sébastien Han
>>     >>Principal Software Engineer, Storage Architect
>>     >>
>>     >>"Always give 100%. Unless you're giving blood."
>>     >>
>>     >>Mail: seb@redhat.com
>>     >>Address: 11 bis, rue Roquépine - 75008 Paris
>>     >
>>     _______________________________________________
>>     Ceph-ansible mailing list
>>     Ceph-ansible@lists.ceph.com
>>     http://lists.ceph.com/listinfo.cgi/ceph-ansible-ceph.com
>
>
> Ceph-ansible Info Page
> lists.ceph.com
> To see the collection of prior postings to the list, visit the Ceph-ansible Archives. Using Ceph-ansible: To post a message to all the list members ...
>
>>
>>
>
>
>
> --
> Cheers
>
> ––––––
> Sébastien Han
> Principal Software Engineer, Storage Architect
>
> "Always give 100%. Unless you're giving blood."
>
> Mail: seb@redhat.com
> Address: 11 bis, rue Roquépine - 75008 Paris
> _______________________________________________
> Ceph-ansible mailing list
> Ceph-ansible@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-ansible-ceph.com
>
>
> Ceph-ansible Info Page
> lists.ceph.com
> To see the collection of prior postings to the list, visit the Ceph-ansible Archives. Using Ceph-ansible: To post a message to all the list members ...
>
>
> _______________________________________________
> Ceph-ansible mailing list
> Ceph-ansible@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-ansible-ceph.com
