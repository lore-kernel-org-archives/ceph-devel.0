From: Venky Shankar <vshankar@redhat.com>
Subject: Re: [ceph-users] RBD: Failed to map rbd device with data pool
 enabled.
Date: Thu, 8 Dec 2016 18:45:02 +0530
Message-ID: <20161208131502.GB6969@h3ckers-pride>
References: <DM5PR02MB249101F060B725F16473BAB195850@DM5PR02MB2491.namprd02.prod.outlook.com>
 <f2efc180.AEQAGsrUIYIAAAAAAAAAAF3gdyMAADNJBWwAAAAAAACRXwBYSAYU@mailjet.com>
 <DM5PR02MB2491F5659FF8AFF1133DFF9095850@DM5PR02MB2491.namprd02.prod.outlook.com>
 <86fc6036.AEQAGti255EAAAAAAAAAAF3gdyMAADNJBWwAAAAAAACRXwBYSRbC@mailjet.com>
 <DM5PR02MB24919A47E0D7DAF7235418C295840@DM5PR02MB2491.namprd02.prod.outlook.com>
 <20161208103444.GA6969@h3ckers-pride>
 <DM5PR02MB2491703DC8FBA057093F7C0195840@DM5PR02MB2491.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:33184 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbcLHNPJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Dec 2016 08:15:09 -0500
Received: by mail-pg0-f45.google.com with SMTP id 3so174193729pgd.0
        for <ceph-devel@vger.kernel.org>; Thu, 08 Dec 2016 05:15:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <DM5PR02MB2491703DC8FBA057093F7C0195840@DM5PR02MB2491.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Aravind Ramesh <Aravind.Ramesh@sandisk.com>
Cc: nick@fisk.me.uk, ceph-devel@vger.kernel.org, Samuel Just <sjust@redhat.com>

On 16-12-08 11:53:56, Aravind Ramesh wrote:
> Hi
> 
> I did a make install in my ceph build and also did make install on the fio and ensured the latest binaries were installed. Now, fio is failing with below errors for the rbd device with EC pool as data pool. I have shared the "rbd ls" and my rbd.fio conf file details below. Let me know if you think there is any configuration issues here.

[Adding Sam + moving to devel]

I tried and got the same error

  2016-12-08 15:59:56.456702 7f4129ffb700 20 librbd::AioObjectRequest: send_write 0x7f411404b1f0 rbd_data.0.102f2ae8944a.00000000000000d7 3969024~4096 object exist 1 write_full 0
  2016-12-08 15:59:56.456703 7f4129ffb700 20 librbd::AioObjectRequest: send_write 0x7f411404b1f0 rbd_data.0.102f2ae8944a.00000000000000d7 3969024~4096 object exist 1
  2016-12-08 15:59:56.474369 7f412a7fc700 20 librbd::AioObjectRequest: write 0x7f41140260f0 rbd_data.0.102f2ae8944a.0000000000000078 1355776~4096 should_complete: r = -95
  2016-12-08 15:59:56.474376 7f412a7fc700 20 librbd::AioObjectRequest: WRITE_FLAT
  2016-12-08 15:59:56.474378 7f412a7fc700 20 librbd::AioObjectRequest: complete 0x7f41140260f0

Looks like its coming from the OSDs (object: rbd_data.0.102f2ae8944a.0000000000000078)

      https://paste.fedoraproject.org/501724/12025271/
      
> 
> ems@rack9-ems-5:~/ec-rbd/master/ceph/build$ ./bin/rbd ls
> 2016-12-08 17:14:39.663643 7f487017dec0 -1 WARNING: the following dangerous and experimental features are enabled: *
> rbd_12			<<== normal rbd device
> rbdimg_1		<<== rbd device with EC pool as data pool 
> 
> ems@rack9-ems-5:~/ec-rbd/master/ceph/build$
> ems@rack9-ems-5:~/ec-rbd/master/ceph/build$ cat rbd.fio
> ######################################################################
> # Example test for the RBD engine.
> #
> # Runs a 4k random write test against a RBD via librbd
> #
> # NOTE: Make sure you have either a RBD named 'fio_test' or change
> #       the rbdname parameter.
> ######################################################################
> [global]
> #logging
> #write_iops_log=write_iops_log
> #write_bw_log=write_bw_log
> #write_lat_log=write_lat_log
> ioengine=rbd
> clientname=admin
> pool=rbd
> rbdname=rbdimg_1
> #rbdname=fio_test
> rw=randwrite
> bs=4k
> 
> [rbd_iodepth32]
> iodepth=32
> ems@rack9-ems-5:~/ec-rbd/master/ceph/build$
> ems@rack9-ems-5:~/ec-rbd/master/ceph/build$ ./fio ./rbd.fio
> rbd_iodepth32: (g=0): rw=randwrite, bs=4K-4K/4K-4K/4K-4K, ioengine=rbd, iodepth=32
> fio-2.15-21-g4871
> Starting 1 process
> rbd engine: RBD version: 0.1.11
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=64757760, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=408551424, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=905359360, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=980332544, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=388386816, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=431546368, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=863858688, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=421429248, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=600182784, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=794877952, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=902078464, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=338862080, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=739086336, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=455880704, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=504672256, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=71749632, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=863690752, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=848175104, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=905744384, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=78327808, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=997011456, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=379588608, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=472981504, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=699166720, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=665198592, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=265089024, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=1060147200, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=4313088, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=1067864064, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=918290432, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=279457792, buflen=4096
> fio: io_u error on file rbd_iodepth32.0.0: Unknown error -95: write offset=271794176, buflen=4096
> fio: pid=23094, err=-95/file:io_u.c:1712, func=io_u error, error=Unknown error -95
> Jobs: 1 (f=0)
> rbd_iodepth32: (groupid=0, jobs=1): err=-95 (file:io_u.c:1712, func=io_u error, error=Unknown error -95): pid=23094: Thu Dec  8 17:12:34 2016
>   cpu          : usr=7.32%, sys=29.88%, ctx=96, majf=0, minf=72
>   IO depths    : 1=3.1%, 2=6.2%, 4=12.5%, 8=25.0%, 16=50.0%, 32=3.1%, >=64=0.0%
>      submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>      complete  : 0=2.9%, 4=94.3%, 8=0.0%, 16=0.0%, 32=2.9%, 64=0.0%, >=64=0.0%
>      issued    : total=r=0/w=32/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
>      latency   : target=0, window=0, percentile=100.00%, depth=32
> Run status group 0 (all jobs):
> 
> Disk stats (read/write):
>   sda: ios=0/37, merge=0/43, ticks=0/800, in_queue=856, util=94.87%
> ems@rack9-ems-5:~/ec-rbd/master/ceph/build$
> 
> 
> -----Original Message-----
> From: Venky Shankar [mailto:vshankar@redhat.com] 
> Sent: Thursday, December 08, 2016 4:05 PM
> To: Aravind Ramesh <Aravind.Ramesh@sandisk.com>
> Cc: nick@fisk.me.uk; ceph-users@lists.ceph.com
> Subject: Re: [ceph-users] RBD: Failed to map rbd device with data pool enabled.
> 
> On 16-12-08 09:32:02, Aravind Ramesh wrote:
> > You can specify the -data-pool option while creating the rbd image.
> > Example:
> > rbd create rbdimg_EC1 --size 1024 --pool replicated_pool1 --data-pool 
> > ecpool Once the image is created, you can add the image name(rdbimg_EC1) and the replicated pool name(replicated_pool1) in the fio config file and set ioengine=rbd. Fio is supposed to do I/O on this new image, but I am seeing that it is failing for such devices. For normal replicated pool rbd-images it is working as expected.
> 
> What errors do you see with an EC data pool? try with "debug rbd = 20" to get verbose logs.
> 
> > 
> > Aravind
> > 
> > From: Nick Fisk [mailto:nick@fisk.me.uk]
> > Sent: Thursday, December 08, 2016 1:46 PM
> > To: Aravind Ramesh <Aravind.Ramesh@sandisk.com>; nick@fisk.me.uk; 
> > ceph-users@lists.ceph.com
> > Subject: RE: [ceph-users] RBD: Failed to map rbd device with data pool enabled.
> > 
> > Fio has a direct RBD engine which uses librbd. I've just had a quick look at the code and I can't see an option in the latest fio to specify datapool, but I'm not sure if librbd handles this all behind the scenes. Might be worth a try.
> > 
> > From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf 
> > Of Aravind Ramesh
> > Sent: 07 December 2016 19:47
> > To: nick@fisk.me.uk<mailto:nick@fisk.me.uk>; 
> > ceph-users@lists.ceph.com<mailto:ceph-users@lists.ceph.com>
> > Subject: Re: [ceph-users] RBD: Failed to map rbd device with data pool enabled.
> > 
> > Thanks Nick,
> > 
> > I have not tried using rbd-nbd, I will give it a try. Rbd mapping is failing for the image which was created with -data-pool <ec-pool> option, so I can't run fio or any IO on it.
> > 
> > Aravind
> > 
> > From: Nick Fisk [mailto:nick@fisk.me.uk]
> > Sent: Wednesday, December 07, 2016 6:23 PM
> > To: Aravind Ramesh 
> > <Aravind.Ramesh@sandisk.com<mailto:Aravind.Ramesh@sandisk.com>>; 
> > ceph-users@lists.ceph.com<mailto:ceph-users@lists.ceph.com>
> > Subject: RE: RBD: Failed to map rbd device with data pool enabled.
> > 
> > Hi Aravind,
> > 
> > I've also seen this merge on Monday and tried to create a RBD on an ecpool and also failed. Although I ended up with all my OSD's crashing and refusing to restart. I'm going to rebuild the cluster and try again.
> > 
> > Have you tried using the rbd-nbd driver or benchmarking directly with fio for the time being so you don't have to disable the image features?
> > 
> > From: ceph-users [mailto:ceph-users-bounces@lists.ceph.com] On Behalf 
> > Of Aravind Ramesh
> > Sent: 07 December 2016 11:07
> > To: ceph-users@lists.ceph.com<mailto:ceph-users@lists.ceph.com>
> > Subject: [ceph-users] RBD: Failed to map rbd device with data pool enabled.
> > 
> > Hi,
> > 
> > I am seeing this failure when I try to map a rbd device with -data-pool set to a EC Pool. This is a newly merged feature, I am not sure if it is expected to work yet or I need to do something more.
> > Same issue is seen while mapping a rbd image from replicated pool but after disabling the new features, I was able to map it and create a filesystem on it, but rbd devices created with the option -data-pool <ec pool), I am not able to disable the features also.
> > =============================
> > ems@rack9-ems-5:~/ec-rbd/master/ceph/build$ ./bin/rbd create 
> > rbdimg_EC1 --size 1024 --pool rep_pool --data-pool aravecpool32 
> > ems@rack9-ems-5:~/ec-rbd/master/ceph/build$
> > 
> > ems@rack9-ems-5:~/ec-rbd/master/ceph/build$ rbd ls
> > rbdimg_EC1
> > ems@rack9-ems-5:~/ec-rbd/master/ceph/build$
> > 
> > ems@rack9-ems-5:~/ec-rbd/master/ceph/build$ sudo rbd map rbdimg_EC1
> > rbd: sysfs write failed
> > rbd: map failed: (6) No such device or address 
> > ems@rack9-ems-5:~/ec-rbd/master/ceph/build$
> > 
> > ems@rack9-ems-5:~/ec-rbd/master/ceph/build$ rbd feature disable 
> > rbdimg_EC1 exclusive-lock deep-flatten fast-diff object-map
> > 2016-12-07 16:19:42.710095 7f6594ff9700 -1 
> > librbd::image::RefreshRequest: Image uses unsupported features: 128
> > 2016-12-07 16:19:42.710185 7f6587fff700 -1 librbd::image::OpenRequest: 
> > failed to refresh image: (38) Function not implemented
> > 2016-12-07 16:19:42.785027 7f6587fff700 -1 librbd::ImageState: failed 
> > to open image: (38) Function not implemented
> > rbd: error opening image rbdimg_EC1: (38) Function not implemented 
> > ems@rack9-ems-5:~/ ==================================
> > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> > 
> > 
> > 
> > 
> 
> 
> 
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users@lists.ceph.com
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
