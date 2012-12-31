From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: Improving responsiveness of KVM guests on Ceph storage
Date: Mon, 31 Dec 2012 15:15:24 +0300
Message-ID: <CABYiri9izEyRJxufqcJd1ecMOuEUZc4wZKFO3V+QYqLeVg_tBw@mail.gmail.com>
References: <50E0745D.8050306@mermaidconsulting.dk> <CABYiri9A4LxEgjrGHRVfn_WSLR9_ztHKN_+GJBh7KButwa68JA@mail.gmail.com>
 <50E0CA52.9020909@mermaidconsulting.dk> <CABYiri8OFSpNMuHuNAzTLwkzG3kqE9bt1f=Lz8TO0dDZ18ivTQ@mail.gmail.com>
 <50E16FCB.7050604@mermaidconsulting.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:63705 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab2LaMPp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 31 Dec 2012 07:15:45 -0500
Received: by mail-oa0-f49.google.com with SMTP id l10so11516587oag.22
        for <ceph-devel@vger.kernel.org>; Mon, 31 Dec 2012 04:15:44 -0800 (PST)
In-Reply-To: <50E16FCB.7050604@mermaidconsulting.dk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?Q?Jens_Kristian_S=C3=B8gaard?= <jens@mermaidconsulting.dk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Dec 31, 2012 at 2:58 PM, Jens Kristian S=C3=B8gaard
<jens@mermaidconsulting.dk> wrote:
> Hi Andrey,
>
>
>> As I understood right, you have md device holding both journal and
>> filestore? What type of raid you have here?
>
>
> Yes, same md device holding both journal and filestore. It is a raid5=
=2E

Ahem, of course you need to reassemble it to something faster :)
>
>
>> Of course you`ll need a
>> separate device (for experimental purposes, fast disk may be enough)
>> for the journal
>
>
> Is there a way to tell if the journal is the bottleneck without actua=
lly
> adding such an extra device?
>
In theory, yes - but your setup already dying under high amount of
write seeks, so it may be not necessary. Also I don`t see a right way
to measure a bottleneck when disk device used for both filestore and
journal - in case of separated ones, you may measure maximum values
using fio and compare to calculated ones from /proc/diskstats,
``all-in-one'' case seems obviously hard to measure, even if you able
to log writes to journal file and filestore files separately without
significant overhead.

>
>> filestore partition, you may also change it to simple RAID0, or even
>> separate disks, and create one osd over every disk(you should see to
>
>
> I have only 3 OSDs with 4 disks each. I was afraid that it would be t=
oo
> brittle as a RAID0, and if I created seperate OSDs for each disk, it =
would
> stall the file system due to recovery if a server crashes.

No, it isn`t too bad in most cases. Recovery process is not affecting
operations to the rbd storage except small performance degradation, so
you may split your raid setup to the lightweight R0. It depends, on
plain SATA controller software R0 under one OSD will do better work
than >2 separate OSDs having one disk each, on cache-backed controller
separate OSDs is more preferably until controller is not able to align
writes due to overall write bandwidth.

>
>
>> What size of cache_size/max_dirty you have inside ceph.conf
>
>
> I haven't set them explicitly, so I imagine the cache_size is 32 MB a=
nd the
> max_dirty is 24 MB.
>
>
>> and which
>>
>> qemu version you use?
>
>
> Using the default 0.15 version in Fedora 16.
>
>
>> tasks increasing cache may help OS to align writes more smoothly. Al=
so
>> you don`t need to set rbd_cache explicitly in the disk config using
>> qemu 1.2 and younger releases, for older ones
>> http://lists.gnu.org/archive/html/qemu-devel/2012-05/msg02500.html
>> should be applied.
>
>
> I read somewhere that I needed to enable it specifically for older qe=
mu-kvm
> versions, which I did like this:
>
>   format=3Drbd,file=3Drbd:data/image1:rbd_cache=3D1,if=3Dvirtio
>
> However now I read in the docs for qemu-rbd that it needs to be set l=
ike
> this:
>
>   format=3Draw,file=3Drbd:data/squeeze:rbd_cache=3Dtrue,cache=3Dwrite=
back
>
> I'm not sure if 1 and true are interpreted the same way?
>
> I'll try using "true" and see if I get any noticable changes in behav=
iour.
>
> The link you sent me seems to indicate that I need to compile my own =
version
> of qemu-kvm to be able to test this?
>

No, there is no significant changes since 0.15 to the current version
and your options will work just fine. So there may be general
recommendations to remove redundancy from your disk backend and then
move out journal to separate disk or ssd.

>
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
