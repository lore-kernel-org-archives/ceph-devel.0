From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: fio read and randread  cpu usage results for qemu and host machine
Date: Thu, 23 Oct 2014 08:07:29 -0500
Message-ID: <5448FD91.7010709@redhat.com>
References: <b0e1d9f1-224e-4711-99f4-9421f29d21e3@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:42364 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755566AbaJWNHb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Oct 2014 09:07:31 -0400
Received: by mail-ig0-f173.google.com with SMTP id h18so2784590igc.12
        for <ceph-devel@vger.kernel.org>; Thu, 23 Oct 2014 06:07:30 -0700 (PDT)
In-Reply-To: <b0e1d9f1-224e-4711-99f4-9421f29d21e3@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, Ceph Devel <ceph-devel@vger.kernel.org>

On 10/23/2014 07:30 AM, Alexandre DERUMIER wrote:
> Hi,
>
> I have done fio tests on multiple qemu setups and host machine,
> to see if librbd use more cpu than krbd
> and also find the best qemu optimisations.
>
> Fio test was done with blocksize=4K , read and randread with num_jobs=32.
>
>
>
>
>
> 1) First, I have done more tests with qemu optimisation, like iothread (dataplane) for virtio-blk disk,
> and num_queue=8 for virtio-scsi disks.
>
> for virtio iothread:
> --------------------
> It's working only with qemu + krbd, and for sequential reads.
> And It's seem that qemu aggregate reads in bigger ceph reads. (I see 4x more iops on fio than on ceph, with same bandwith)
>
>
> for virtio-scsi num_queue = 8:
> -------------------------------
> works with krbd and librbd
>
>   -for random read : I jump from 7000 to 12000iops
>   -for sequential, qemu aggreate reads in bigger ceph reads. (Same, I see 4xmore iops on fio than on ceph, with same bandwith).
>
>
> So it seem to be useful for some specific workloads.
>
>
>
> 2 ) Now, about cpu usage, it's seem than librbd use really more cpu than krbd,
>
> on host, librbd use 4x more cpu than krbd
> on qemu, librbd use 2x more cpu than krbd
>
>
> So, what could explain so much difference between both ?

Hi Alexandre, do you have access to perf?  Especially on newer 
kernels/distributions where you can use dwarf symbols, perf can give you 
a lot of information about what is using CPU where.  vtune is also a 
nice option if you ave a license.

>
>
> Regards,
>
> Alexandre
>
>
>
> fio iops seq read summary results
> ----------------------------------
> qemu virtio iothread krbd vs qemu virtio iothread librbd : 27000 iops vs 15000 ipos
> qemu virtio krbd vs qemu virtio librbd                   : 19000 iops vs 15000 iops
> qemu virtio-scsi krbd vs qemu virtio librbd              : 50000 iops vs 48000 iops
> host krbd vs host librbd                                :  36000 iops vs 25000 iops
>
>
>
> fio iops randread summary results
> ------------------------------
> qemu virtio iothread krbd vs qemu virtio iothread librbd : 15000 iops vs 14000 iops
> qemu virtio krbd vs qemu virtio librbd                   : 14000 iops vs 15000 iops
> qemu virtio-scsi krbd vs qemu virtio librbd              : 7500  iops vs 12000 iops
> host krbd vs host librbd                                 : 38000 iops vs 25000 iops
>
>
> cpu usage ratio  summary
> ------------------------
> qemu virtio krbd vs qemu virtio librbd : 2x more cpu usage for librbd
> qemu virtio-scsi krbd vs qemu virtio-scsi librbd : 2x more cpu usage for librbd
> host krbd vs host librbd : 4x more cpu usage for fio-rbd
>
>
>
>
>
>
> RESULTS
> -------
>
> host + fio - krbd
> -------------------
> read
> -----
> fio iops : 142.9MB/Ss , 36000 iops
> ceph : 134 MB/s rd, 34319 op/s
>
> fio : 70,4%  kworker : 93,9% cpu = 164% cpu
>
> 100%cpu : 21000iops
>
> randread
> --------
> fio: 151MB/S,38000 iops
> ceph :148 MB/s rd, 37932 op/s
>
> fio : 80%cpu kwoker : 110,3%cpu  = 180% cpu
>
> 100%cpu : 21000 iops
>
>
>
>
> host + fio-rbdengin :
> ---------------------
> randread (cpu bound)
> --------------------
> fio iops : 25000 ops
> ceph iops : 99636 kB/s rd, 24909 op/s
>
> fio : 460%cpu
>
> 100%cpu : 5415iops
>
> read (cpu bound)
> -----------------
> fio iops : 25000 ops
> ceph ios : 94212 kB/s rd, 23553 op/s
>
> fio : 480%cpu
>
> 100%cpu : 5323iops
>
>
>
>
>
> qemu + krbd  + virtio + iothread
> ---------------------------------
> read
> ----
> fio :107MB/S : 27000 iops  >>>SEEM THAT QEMU AGGREGATE READS ops
> ceph : 93942 kB/s rd, 12430 op/s
>
> kvm: 130% cpu - kworker : 41,2% = 171,2% cpu
>
> 100%cpu ratio : 7260iops
>
> randread
> --------
> fio : 60MBS - 15000 iops
> ceph :  54400 kB/s rd, 13600 op/s
>
> kvm: 95,0% cpu  - kworker : 42,1 % cpu = 137,1%cpu
>
> 100%cpu ratio : 9919 iops
>
>
>
>
>
> qemu + krbd  + virtio
> ----------------------
> read
> -----
> fio : 70mbs/ , 19000iops
> ceph:75705 kB/s rd, 18926 op/s
> kvm : 164% cpu - kworker : 48,5% cpu = 212,5%cpu
>
> 100%cpu ratio : 8906 iops
>
> randread
> --------
> fio : 54mbs/ , 14000iops
> ceph : 54800 kB/s rd, 13700 op/s
> kvm: 103% cpu - kworker 41,2% cpu = 144,2%cpu
>
> 100%cpu ratio : 9513 iops
>
>
>
> qemu + krbd  + virtio-scsi (num_queue 8)
> --------------------------------------
> read:
> ----
> fio : 200MB / 50000 iops  >>>SEEM THAT QEMU AGGREGATE READS ops
> ceph : 205 MB/s rd, 7648 op/s
>
> kvm: 145% kworker : 46,5% = 191,5%cpu
>
> 100%cpu ratio : 3993 iops
>
> randread:
> ----------
> fio : 30MB/S / 7500 iops
> ceph : 29318 kB/s rd, 7329 op/s
> kvm : 150%  kworker : 21,4% cpu = 171,4% cpu
>
> 100%cpu ratio : 4275 iops
>
>
>
>
> qemu + librbd + virtio + iothread
> ----------------------------------
> read
> ----
> fio : 60MBS/s , 15000iops
> ceph: 56199 kB/s rd, 14052 op/s
>
> kvm: 300% cpu
>
> 100%cpu : 4666iops
>
>
> randread
> ---------
> fio : 56MBS/s, 14000iops
> ceph : 55916 kB/s rd, 13979 op/s
>
> kvm: 300% cpu
>
> 100%cpu : 4659 iops
>
>
>
> qemu + librbd +  virtio
> -------------------------
> read
> -----
> fio : 60MBS/s, 15000iops
> ceph : 63021 kB/s rd, 15755 op/s
>
> kvm: 300% cpu
>
> 100%cpu : 5233 iops
>
> randread
> --------
> fio : 60MBS/s, 15000iops
> ceph : 55916 kB/s rd, 13979 op/s
>
> kvm : 300%cpu
>
> 100%cpu : 4659 iops
>
>
> qemu + librbd + virtio-scsi (num_queue 8)
> ----------------------------------------
> read
> ----
> fio : 256 MB/S , 48000iops  >>>SEEM THAT QEMU AGGREGATE READS ops
> ceph : 244 MB/s rd, 12002 op/s
>
> kvm : 300% cpu
>
> 100%cpu : 4000 iops
>
> randread
> --------
> fio: 12000iops
> ceph iops :  47511 kB/s rd, 11877 op/s
>
> kvm: 300% cpu
>
> 100%cpu: 3959 iops
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

