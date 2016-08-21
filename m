From: Sage Weil <sweil@redhat.com>
Subject: RE: BlueStore metadata write overhead
Date: Sun, 21 Aug 2016 23:37:09 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608212334440.14754@piezo.us.to>
References: <BL2PR02MB2115119EAA0F68B837D71C6CF4150@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608191358510.10673@piezo.us.to> <BL2PR02MB2115CA2313338720CA844CA3F4160@BL2PR02MB2115.namprd02.prod.outlook.com> <alpine.DEB.2.11.1608191706420.14754@piezo.us.to>
 <BL2PR02MB21152923FED03DCD09A0637DF4170@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-478541516-1471822631=:14754"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36554 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753285AbcHUXhM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 21 Aug 2016 19:37:12 -0400
In-Reply-To: <BL2PR02MB21152923FED03DCD09A0637DF4170@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-478541516-1471822631=:14754
Content-Type: TEXT/PLAIN; charset=koi8-r
Content-Transfer-Encoding: 8BIT

I updated the branch and I think it is correct now.

For the shared device, we only want to add the 'free' space (according to 
bluefs) to the total.  (Ohterwise, it's counted as used by 
bluestore because the space is allocated to bluefs.)

If there is an additional (unshared) device (BDEV_DB) that is dedicated to 
bluefs, we add both the total and free amounts in.

We ignore the bluefs wal device (if any).

Thanks!
sage


On Sat, 20 Aug 2016, Somnath Roy wrote:
> Sage,
> I applied your patch but it seems bluefs->get_usage() has some bug and that's why it is messing up the calculation. Here is the explanation :
> 
> This is just after creating cluster, no image.
> 
> root@emsnode5:~/ceph-master/src# ceph df
> 2016-08-19 16:53:54.558617 7fddda4d1700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> 2016-08-19 16:53:54.562438 7fddda4d1700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> GLOBAL:
>     SIZE     AVAIL     RAW USED     %RAW USED
>     115T      111T        4371G          3.68
> POOLS:
>     NAME     ID     USED     %USED     MAX AVAIL     OBJECTS
>     rbd      0         0         0        57151G           0
> 
> And here is my drive partition:
> 
> sdi           8:128  0     7T  0 disk
> †€sdi1        8:129  0    10G  0 part /var/lib/ceph/osd/ceph-15
> †€sdi2        8:130  0   304G  0 part ----> block.db
> †€sdi3        8:131  0    10G  0 part  -----> block.wal
> „€sdi4        8:132  0   6.7T  0 part
> 
> So, total RAW size it should be showing ~ 112 TB (6.7TB X 16 (16 osds) + 304G X 16 (block.db) + 10G * 16 (block.wal) ). But, it is showing ~115TB.
> I did some debugging and found out that bluefs->get_usage() is returning 3 vector entries instead of 2.  One entry of size 293345419264 is getting added probably db.slow (?) even if no such device present.
> 
> Secondly, we are showing entire db devices as used from the beginning , that is probably ok since user won't be able to use that anyway. But, it would be good if we can somehow see the amount of db actually used in some statistics.
> 
> Now, here is the 'ceph df' output after I have written 4k RW (without filling up my 40TB  image) for 2 hours.
> 
> root@stormeap-1:~/fio_rbd/fio/examples/plot# ceph df
> 2016-08-19 16:13:50.843564 7fc0bc71a700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> 2016-08-19 16:13:50.846647 7fc0bc71a700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> 2016-08-19 16:13:50.848156 7fc0bc71a700 -1 WARNING: the following dangerous and experimental features are enabled: bluestore,rocksdb
> GLOBAL:
>     SIZE     AVAIL     RAW USED     %RAW USED
>     115T      110T        5809G          4.90
> POOLS:
>     NAME              ID     USED       %USED     MAX AVAIL     OBJECTS
>     recovery_test     1      37007G     62.37        56338G     10000003
> 
> "RAW USED" is correctly showing the amount of data written to the cluster but see the POOLS statistics , it is really confusing. Since it is touching all the objects , the amount of used % it is showing ~37 TB while only 1.4 TB is written.
> I saw pool data is not gathered from store->statfs() but from each op probably ? Is there a bug ?
> 
> Thanks & Regards
> Somnath
> 
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com] 
> Sent: Friday, August 19, 2016 10:08 AM
> To: Somnath Roy
> Cc: ceph-devel@vger.kernel.org
> Subject: RE: BlueStore metadata write overhead
> 
> Broken united wifi conspired to keep me from pushing this earlier:
> 
> 	https://github.com/ceph/ceph/pull/10795
> 
> This should resolve it I think?  It does include the wal space in the total, which is probably not right, but that should be a rounding error.
> 
> sage
> 
> On Fri, 19 Aug 2016, Somnath Roy wrote:
> 
> > Yes, seems something wrong..Here is the 'ceph df' on a freshly created cluster with no data.
> > 
> > root@stormeap-1:~/fio_rbd/fio/examples# ceph df
> > 2016-08-19 09:47:45.714539 7f7fd3ed9700 -1 WARNING: the following 
> > dangerous and experimental features are enabled: bluestore,rocksdb
> > 2016-08-19 09:47:45.717589 7f7fd3ed9700 -1 WARNING: the following 
> > dangerous and experimental features are enabled: bluestore,rocksdb
> > 2016-08-19 09:47:45.718583 7f7fd3ed9700 -1 WARNING: the following 
> > dangerous and experimental features are enabled: bluestore,rocksdb
> > GLOBAL:
> >     SIZE     AVAIL       RAW USED     %RAW USED
> >     106T     100536G        8742G          8.00
> > POOLS:
> >     NAME              ID     USED     %USED     MAX AVAIL     OBJECTS
> >     recovery_test     1        16         0        50268G           3
> > 
> > It is saying 8TB RAW used , I will take a look.
> > 
> > Thanks & Regards
> > Somnath
> > 
> > -----Original Message-----
> > From: Sage Weil [mailto:sweil@redhat.com]
> > Sent: Friday, August 19, 2016 7:00 AM
> > To: Somnath Roy
> > Cc: ceph-devel@vger.kernel.org
> > Subject: Re: BlueStore metadata write overhead
> > 
> > On Thu, 18 Aug 2016, Somnath Roy wrote:
> > > Sage, Here is some estimate probably how much extra (space wise) we 
> > > are writing with Bluestore. Considering Rocksdb has not much space 
> > > amp for level style compaction , these are mostly the metadata 
> > > Bluestore is writing.
> > >
> > > BlueStore:
> > > ----------------
> > > root@stormeap-1:~/fio_rbd/fio/examples# ceph df
> > > 2016-08-17 11:00:57.936952 7f5c39a2b700 -1 WARNING: the following 
> > > dangerous and experimental features are enabled: bluestore,rocksdb
> > > 2016-08-17 11:00:57.939969 7f5c39a2b700 -1 WARNING: the following 
> > > dangerous and experimental features are enabled: bluestore,rocksdb
> > > 2016-08-17 11:00:57.941269 7f5c39a2b700 -1 WARNING: the following 
> > > dangerous and experimental features are enabled: bluestore,rocksdb
> > > GLOBAL:
> > >     SIZE     AVAIL      RAW USED     %RAW USED
> > >     106T     22411G       86867G         79.49
> > > POOLS:
> > >     NAME              ID     USED       %USED     MAX AVAIL     OBJECTS
> > >     recovery_test     1      39062G     71.49         6290G     10000003
> > >
> > >
> > > So, if we trust the statfs implementation of Bluestore , it is  writing ~8743 GB more.  Total data  = image size of 39062 GB * replication 2 = ~78124 GB. So, ~11.19% more.
> > > BTW, this is after 1MB image preconditioning only, filling with 4K blocksize will be adding more metadata.
> > >
> > > Filestore:
> > > -----------
> > > GLOBAL:
> > >     SIZE     AVAIL      RAW USED     %RAW USED
> > >     109T     34443G       78147G         69.41
> > > POOLS:
> > >     NAME              ID     USED       %USED     MAX AVAIL     OBJECTS
> > >     recovery_test     2      39062G     69.39        12930G     10000003
> > >
> > > So, in the similar setup , filestore is writing only ~23GB extra and 
> > > i.e ~0.029%
> > 
> > This seems like a lot for bluestore.  The statfs output from bluestore should show how much of the space is bluefs vs bluestore.
> > 
> > Hmm, my guess is that bluestore is counting all of the space that it has given to bluefs as used, even though bluefs isn't using it.  Probably just need to make BlueStore::statfs() call BlueFs::statfs() and correct for the bluefs unused space...
> > 
> > sage
> > PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
> > 
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
--8323329-478541516-1471822631=:14754--
