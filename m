From: Ramesh Chander <Ramesh.Chander@sandisk.com>
Subject: RE: Lib snappy error
Date: Tue, 28 Jun 2016 03:13:19 +0000
Message-ID: <CY1PR0201MB1820DCF2B3AE57A5FC8B114C85220@CY1PR0201MB1820.namprd02.prod.outlook.com>
References: <CY1PR0201MB1820A490B5063DCFF9AC971085220@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <BL2PR02MB2115EEEF96F291F50C8B1127F4220@BL2PR02MB2115.namprd02.prod.outlook.com>
 <CY1PR0201MB1820CCFEF6847E640D56808885220@CY1PR0201MB1820.namprd02.prod.outlook.com>
 <BL2PR02MB211592B5E83AC82B46F34A50F4220@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0081.outbound.protection.outlook.com ([157.56.110.81]:11155
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751882AbcF1DNX convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jun 2016 23:13:23 -0400
In-Reply-To: <BL2PR02MB211592B5E83AC82B46F34A50F4220@BL2PR02MB2115.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "Sage Weil (sweil@redhat.com)" <sweil@redhat.com>

Ok,

That makes sense.

Thanks :)

> -----Original Message-----
> From: Somnath Roy
> Sent: Tuesday, June 28, 2016 8:42 AM
> To: Ramesh Chander; ceph-devel@vger.kernel.org
> Cc: Sage Weil (sweil@redhat.com)
> Subject: RE: Lib snappy error
>
> 'Make install' will put all the libraries in the path  (--prefix) you opted for
> during autogen (default /usr). You should do that in your dev env also just in
> case you have different version present.
>
> -----Original Message-----
> From: Ramesh Chander
> Sent: Monday, June 27, 2016 8:08 PM
> To: Somnath Roy; ceph-devel@vger.kernel.org
> Cc: Sage Weil (sweil@redhat.com)
> Subject: RE: Lib snappy error
>
> No I did't, is that mandatory even for dev environments?
>
> Looks like path is hardcoded in any script.
>
>
> > -----Original Message-----
> > From: Somnath Roy
> > Sent: Tuesday, June 28, 2016 8:35 AM
> > To: Ramesh Chander; ceph-devel@vger.kernel.org
> > Cc: Sage Weil (sweil@redhat.com)
> > Subject: RE: Lib snappy error
> >
> > Did you do 'make install' ?
> >
> >
> > -----Original Message-----
> > From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> > owner@vger.kernel.org] On Behalf Of Ramesh Chander
> > Sent: Monday, June 27, 2016 7:56 PM
> > To: ceph-devel@vger.kernel.org
> > Cc: Sage Weil (sweil@redhat.com)
> > Subject: RE: Lib snappy error
> >
> > Creating sym link at  /usr/lib/ceph/compressor/libceph_snappy.so from
> > .libs/libceph_snappy.so.2.0.0 works for me
> >
> > Not sure what is the right way though.
> >
> > -Ramesh
> >
> > > -----Original Message-----
> > > From: Ramesh Chander
> > > Sent: Tuesday, June 28, 2016 8:07 AM
> > > To: ceph-devel@vger.kernel.org
> > > Cc: Sage Weil (sweil@redhat.com)
> > > Subject: Lib snappy error
> > >
> > > Hi All,
> > >
> > > I am getting this error whatever I do:
> > >
> > > [New Thread 0x7ffff1d70700 (LWP 14659)]
> > > 2016-06-28 08:00:02.395492 7ffff2d72700 -1
> > > bdev(store_test_temp_dir/block) _aio_thread got (4) Interrupted
> > > system call
> > > 2016-06-28 08:00:02.395755 7ffff7fda6c0 -1 load failed
> > > dlopen(/usr/lib/ceph/compressor/libceph_snappy.so):
> > > /usr/lib/ceph/compressor/libceph_snappy.so: cannot open shared
> > > object
> > > file: No such file or directory
> > > 2016-06-28 08:00:02.395766 7ffff7fda6c0 -1 create cannot load
> > > compressor of type snappy
> > > 2016-06-28 08:00:02.395769 7ffff7fda6c0 -1
> > > bluestore(store_test_temp_dir) _set_compression unable to initialize
> > > snappy compressor
> > >
> > > I did full make. Did clean and make again but still it fails everytime.
> > >
> > > I see in the path that it is looking for
> > > /usr/lib/ceph/compressor/libceph_snappy.so even though I am not
> > > installing ceph and using Vstart.
> > >
> > > Any idea what is wrong here?
> > >
> > > -Ramesh
> > PLEASE NOTE: The information contained in this electronic mail message
> > is intended only for the use of the designated recipient(s) named
> > above. If the reader of this message is not the intended recipient,
> > you are hereby notified that you have received this message in error
> > and that any review, dissemination, distribution, or copying of this
> > message is strictly prohibited. If you have received this
> > communication in error, please notify the sender by telephone or
> > e-mail (as shown above) immediately and destroy any and all copies of
> > this message in your possession (whether hard copies or electronically
> stored copies).
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> > in the body of a message to majordomo@vger.kernel.org More
> majordomo
> > info at http://vger.kernel.org/majordomo-info.html
PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
