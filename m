From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Improving responsiveness of KVM guests on Ceph storage
Date: Mon, 31 Dec 2012 11:19:10 +0300
Message-ID: <CABYiri8OFSpNMuHuNAzTLwkzG3kqE9bt1f=Lz8TO0dDZ18ivTQ@mail.gmail.com>
References: <50E0745D.8050306@mermaidconsulting.dk> <CABYiri9A4LxEgjrGHRVfn_WSLR9_ztHKN_+GJBh7KButwa68JA@mail.gmail.com>
 <50E0CA52.9020909@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:52602 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab2LaITg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Dec 2012 03:19:36 -0500
Received: by mail-oa0-f41.google.com with SMTP id k14so11656293oag.0
        for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 00:19:33 -0800 (PST)
In-Reply-To: <50E0CA52.9020909@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Jens_Kristian_S=C3=B8gaard?= <jens@mermaidconsulting.dk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Dec 31, 2012 at 3:12 AM, Jens Kristian S=C3=B8gaard
<jens@mermaidconsulting.dk> wrote:
> Hi Andrey,
>
> Thanks for your reply!
>
>
>> You may try do play with SCHED_RT, I have found it hard to use for
>> myself, but you can achieve your goal by adding small RT slices via
>> ``cpu'' cgroup to vcpu/emulator threads, it dramatically increases
>> overall VM` responsibility.
>
>
> I'm not quite sure I understand your suggestion.
>
> Do you mean that you set the process priority to real-time on each qe=
mu-kvm
> process, and then use cgroups cpu.rt_runtime_us / cpu.rt_period_us to
> restrict the amount of CPU time those processes can receive?
>
> I'm not sure how that would apply here, as I have only one qemu-kvm p=
rocess
> and it is not non-responsive because of the lack of allocated CPU tim=
e
> slices - but rather because some I/Os take a long time to complete, a=
nd
> other I/Os apparently have to wait for those to complete.
>
Yep, I meant the same. Of course it`ll not help with only one VM, RT
may help in more concurrent cases :)
>
>> threads. Of course, some Ceph tuning like writeback cache and large
>> journal may help you too, I`m speaking primarily of VM` performance =
by
>
>
> I have been considering the journal as something where I could improv=
e
> performance by tweaking the setup. I have set aside 10 GB of space fo=
r the
> journal, but I'm not sure if this is too little - or if the size real=
ly
> doesn't matter that much when it is on the same mdraid as the data it=
self.
>
> Is there a tool that can tell me how much of my journal space that is
> actually actively being used?
>
> I.e. I'm looking for something that could tell me, if increasing the =
size of
> the journal or placing it on a seperate (SSD) disk could solve my pro=
blem.

As I understood right, you have md device holding both journal and
filestore? What type of raid you have here? Of course you`ll need a
separate device (for experimental purposes, fast disk may be enough)
for the journal, and if you set any type of redundant storage under
filestore partition, you may also change it to simple RAID0, or even
separate disks, and create one osd over every disk(you should see to
the journal device` throughput which must be equal to sum of speeds of
all filestore devices, so for commodity-type SSD it sums to two
100MB/s disks, for example). I have ``pure'' disk setup in my dev
environment built on quite old desktop-class machines and one rsync
process may hang VM for short time, despite of using dedicated SATA
disk for journal.
>
> How do I change the size of the writeback cache when using qemu-kvm l=
ike I
> do?
>
> Does setting rbd cache size in ceph.conf have any effect on qemu-kvm,=
 where
> the drive is defined as:
>
>   format=3Drbd,file=3Drbd:data/image1:rbd_cache=3D1,if=3Dvirtio
>
What size of cache_size/max_dirty you have inside ceph.conf and which
qemu version you use? Default values good enough to prevent pushing
I/O spikes down to the physical storage, but for long I/O-intensive
tasks increasing cache may help OS to align writes more smoothly. Also
you don`t need to set rbd_cache explicitly in the disk config using
qemu 1.2 and younger releases, for older ones
http://lists.gnu.org/archive/html/qemu-devel/2012-05/msg02500.html
should be applied.

>
> --
> Jens Kristian S=C3=B8gaard, Mermaid Consulting ApS,
> jens@mermaidconsulting.dk,
> http://www.mermaidconsulting.com/
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
