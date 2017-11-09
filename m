From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [ceph-users] who is using nfs-ganesha and cephfs?
Date: Thu, 09 Nov 2017 09:28:51 -0500
Message-ID: <1510237731.30919.7.camel@redhat.com>
References: <5A0428EF020000B70026338D@gwmail.emea.novell.com>
         <5A0438CC02000042001EBE2A@gwmail.emea.novell.com>
         <5A04567302000042001EBEAB@gwmail.emea.novell.com>
         <5A04567302000042001EBEAB@gwmail.emea.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:54525 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753751AbdKIO2z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Nov 2017 09:28:55 -0500
Received: by mail-qt0-f179.google.com with SMTP id c36so1645822qtc.11
        for <ceph-devel@vger.kernel.org>; Thu, 09 Nov 2017 06:28:54 -0800 (PST)
In-Reply-To: <5A04567302000042001EBEAB@gwmail.emea.novell.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Supriti Singh <Supriti.Singh@suse.com>, sweil@redhat.com, Lars Marowsky-Bree <lmb@suse.com>
Cc: ceph-devel@vger.kernel.org, ceph-users@ceph.com

Ouch... yeah the rotten performance is sad but not really surprising.

We add a lot of extra hops and data copies by going through ganesha.
Ganesha also uses the userland client libs and those are organized
around the BCCL (Big Ceph Client Lock).

I think the only way we'll get decent performance over the long haul is
get ganesha out of the data path. A flexfiles pnfs layout is something
of a natural fit on top of cephfs, and I imagine that would get us a lot
closer to the cephfs read/write numbers.

-- Jeff

On Thu, 2017-11-09 at 13:21 +0000, Supriti Singh wrote:
> The email was not delivered to ceph-devel@vger.kernel.org. So, re-sending it. 
> 
> Few more things regarding the hardware and clients used in our benchmarking setup:
> - The cephfs benchmark were done using kernel cephfs client. 
> - NFS-Ganesha was mounted using nfs version 4. 
> - Single nfs-ganesha server was used. 
> 
> Ceph and Client setup:
> - Each client node has 16 cores and 16 GB RAM.
> - MDS and Ganesha server is running on the same node. 
> - Network interconnect between client and ceph nodes is 40Gbit/s. 
> - Ceph on 8 nodes: (each node has 24 cores/128 GB RAM). 
>   - 5 OSD nodes
>   - 3 MON/MDS nodes
>   - 6 OSD daemons per node - Blustore - SSD/NVME journal 
> 
> 
> ------
> Supriti Singh SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
> HRB 21284 (AG Nürnberg)
>  
> 
> 
> 
> > > > Supriti Singh 11/09/17 12:15 PM >>>
> 
> Hi Sage,
> 
> As Lars mentioned, at SUSE, we use ganesha 2.5.2/luminous. We did a preliminary performance comparison of cephfs client
> and nfs-ganesha client. I have attached the results. The results are aggregate bandwidth over 10 clients.
> 
> 1. Test Setup:
> We use fio to read/write to a single 5GB file per thread for 300 seconds. A single job (represented in x-axis) is of
> type {number_of_worker_thread}rw_{block_size}_{op}, where, 
> number_of_worker_threads: 1, 4, 8, 16
> Block size: 4K,64K,1M,4M,8M
> op: rw 
> 
>  
> 2. NFS-Ganesha configuration:
> Parameters set (other than default):
> 1. Graceless = True
> 2. MaxRPCSendBufferSize/MaxRPCRecvBufferSize is set to max value.
> 
> 3. Observations:
> -  For single thread (on each client) and 4k block size, the b/w is around 45% of cephfs 
> - As number of threads increases, the performance drops. It could be related to nfs-ganesha parameter
> "Dispatch_Max_Reqs_Xprt", which defaults to 512. Note, this parameter is important only for v2.5. 
> - We did run with both nfs-ganesha mdcache enabled/disabled. But there were no significant improvements with caching.
> Not sure but it could be related to this issue: https://github.com/nfs-ganesha/nfs-ganesha/issues/223
>   
> The results are still preliminary, and I guess with proper tuning of nfs-ganesha parameters, it could be better.
> 
> Thanks,
> Supriti 
> 
> ------
> Supriti Singh SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
> HRB 21284 (AG Nürnberg)
>  
> 
> 
> 
> > > > Lars Marowsky-Bree <lmb@suse.com> 11/09/17 11:07 AM >>>
> 
> On 2017-11-08T21:41:41, Sage Weil <sweil@redhat.com> wrote:
> 
> > Who is running nfs-ganesha's FSAL to export CephFS?  What has your 
> > experience been?
> > 
> > (We are working on building proper testing and support for this into 
> > Mimic, but the ganesha FSAL has been around for years.)
> 
> We use it currently, and it works, but let's not discuss the performance
> ;-)
> 
> How else do you want to build this into Mimic?
> 
> Regards,
>     Lars
> 
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

-- 
Jeff Layton <jlayton@redhat.com>
