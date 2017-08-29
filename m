From: Mustafa Muhammad <mustafa1024m@gmail.com>
Subject: Re: High memory usage kills OSD while peering
Date: Tue, 29 Aug 2017 22:34:21 +0300
Message-ID: <CAFehDbAN9M5_rc_Rrg5gYdDoez+bbuy-QADzAHHctTiNwmi9-Q@mail.gmail.com>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com>
 <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com>
 <15fa2de0-27ad-cc51-6a6c-f306b9f330d2@gmail.com> <CAFehDbCzt=Ezffz+D7QQNM4PaPaDTJqU+dm1AhjmNHjw1W1FcA@mail.gmail.com>
 <alpine.DEB.2.11.1708222230080.17029@piezo.novalocal> <cf976b97-5173-cf89-010f-a3d492944304@gmail.com>
 <alpine.DEB.2.11.1708231343470.20435@piezo.novalocal> <e79cb096-bb5c-5e1c-5e03-5ca8b324b9e2@gmail.com>
 <alpine.DEB.2.11.1708240351220.20435@piezo.novalocal> <12a4771a-dab2-3e98-c925-119b09c2d2d0@gmail.com>
 <alpine.DEB.2.11.1708252243080.20435@piezo.novalocal> <18fbddea-9b94-bc9c-46d5-08076b591d13@gmail.com>
 <alpine.DEB.2.11.1708252306140.20435@piezo.novalocal> <d335345b-7c66-ee22-096d-31f792070397@gmail.com>
 <73dc0755-4699-8d61-d5fc-a39e629c582a@gmail.com> <alpine.DEB.2.11.1708270157360.20435@piezo.novalocal>
 <CAFehDbAVBmxAhUtOCUx72ZQHkUTmRf4uA87J4qJvuxj+sn7E+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34147 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751359AbdH2TeW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Aug 2017 15:34:22 -0400
Received: by mail-vk0-f49.google.com with SMTP id s199so12351132vke.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Aug 2017 12:34:22 -0700 (PDT)
In-Reply-To: <CAFehDbAVBmxAhUtOCUx72ZQHkUTmRf4uA87J4qJvuxj+sn7E+w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Linux Chips <linux.chips@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

I reported this issue, if you can take a look:

http://tracker.ceph.com/issues/21173

Regards
Mustafa

On Tue, Aug 29, 2017 at 10:44 AM, Mustafa Muhammad
<mustafa1024m@gmail.com> wrote:
> Hi all,
> Not sure if I should open a new thread, but this is the same cluster,
> so this should provide a little background.
> Now the cluster is up and recovering, but we are hitting a bug that is
> crashing the OSD
>
>      0> 2017-08-29 10:00:51.699557 7fae66139700 -1
> /home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/12.1.4/rpm/el7/BUILD/ceph-12.1.4/src/osd/ECUtil.cc:
> In function 'int ECUtil::decode(const ECUtil::stripe_info_t&,
> ceph::ErasureCodeInterfaceRef&, std::map<int, ceph::buffer::list>&,
> std::map<int, ceph::buffer::list*>&)' thread 7fae66139700 time
> 2017-08-29 10:00:51.688625
> /home/jenkins-build/build/workspace/ceph-build/ARCH/x86_64/AVAILABLE_ARCH/x86_64/AVAILABLE_DIST/centos7/DIST/centos7/MACHINE_SIZE/huge/release/12.1.4/rpm/el7/BUILD/ceph-12.1.4/src/osd/ECUtil.cc:
> 59: FAILED assert(i->second.length() == total_data_size)
>
> Probably http://tracker.ceph.com/issues/14009
>
> Some shards are problematic, smaller sizes (definitely a problem) or
> last part of them is all zeros (not sure if this is padding or
> problem).
>
> Now we have set noup, marked OSDs with corrupt chunks down, and let
> the recovery proceed, but this is happening in lots of PGs and is very
> slow.
> Is there anything we can do to fix this faster, we tried removing the
> corrupted chunk? and got this crash (I grep the thread in which Abort
> happened):
>
>    -77> 2017-08-28 15:11:40.030178 7f90cd519700  0 osd.377 pg_epoch:
> 1102631 pg[143.1b0s0( v 1098703'309813 (960110'306653,1098703'309813]
> local-lis/les=1102586/1102609 n=63499 ec=470378/470378 lis/c
> 1102586/960364 les/c/f 1102609/960364/1061015 1102545/1102586/1102586)
> [377,77,248,635,642,111,182,234,531,307,29,648]/[377,77,248,198,529,111,182,234,548,307,29,174]
> r=0 lpr=1102586 pi=[960339,1102586)/44 rops=1
> bft=531(8),635(3),642(4),648(11) crt=1098703'309813 lcod 0'0 mlcod 0'0
> active+remapped+backfilling] failed_push
> 143:0d9ce204:::default.63296332.1__shadow_2033460653.2~dpBlpEu3nMuFDe6ikBFMso5ivuBb7oj.1_93:head
> from shard 548(8), reps on  unfound? 0
>     -2> 2017-08-28 15:11:40.130722 7f90cd519700 -1 osd.377 pg_epoch:
> 1102631 pg[143.1b0s0( v 1098703'309813 (960110'306653,1098703'309813]
> local-lis/les=1102586/1102609 n=63499 ec=470378/470378 lis/c
> 1102586/960364 les/c/f 1102609/960364/1061015 1102545/1102586/1102586)
> [377,77,248,635,642,111,182,234,531,307,29,648]/[377,77,248,198,529,111,182,234,548,307,29,174]
> r=0 lpr=1102586 pi=[960339,1102586)/44
> bft=531(8),635(3),642(4),648(11) crt=1098703'309813 lcod 0'0 mlcod 0'0
> active+remapped+backfilling] recover_replicas: object
> 143:0d9ce204:::default.63296332.1__shadow_2033460653.2~dpBlpEu3nMuFDe6ikBFMso5ivuBb7oj.1_93:head
> last_backfill 143:0d9ce1c5:::default.63296332.1__shadow_26882237.2~mGGm_A45xKldAdADFC13qizbUiC0Yrw.1_158:head
>     -1> 2017-08-28 15:11:40.130802 7f90cd519700 -1 osd.377 pg_epoch:
> 1102631 pg[143.1b0s0( v 1098703'309813 (960110'306653,1098703'309813]
> local-lis/les=1102586/1102609 n=63499 ec=470378/470378 lis/c
> 1102586/960364 les/c/f 1102609/960364/1061015 1102545/1102586/1102586)
> [377,77,248,635,642,111,182,234,531,307,29,648]/[377,77,248,198,529,111,182,234,548,307,29,174]
> r=0 lpr=1102586 pi=[960339,1102586)/44
> bft=531(8),635(3),642(4),648(11) crt=1098703'309813 lcod 0'0 mlcod 0'0
> active+remapped+backfilling] recover_replicas: object added to missing
> set for backfill, but is not in recovering, error!
>      0> 2017-08-28 15:11:40.134768 7f90cd519700 -1 *** Caught signal
> (Aborted) **
> in thread 7f90cd519700 thread_name:tp_osd_tp
>
> What we can do to fix this?
> Will enabling fast_read on the pool benefit us or it is client only?
> Any ideas?
>
> Regards
> Mustafa
