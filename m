From: Casey Bodley <cbodley@redhat.com>
Subject: Re: About Fio backend with ObjectStore API
Date: Fri, 11 Sep 2015 10:35:30 -0400 (EDT)
Message-ID: <653443615.15587496.1441982130977.JavaMail.zimbra@redhat.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B31A8D8@SSIEXCH-MB3.ssi.samsung.com> <CACJqLyY9t_t7omJfb9vknwqBQ2V7csfLPqU-jvUtvDj2fhuyPw@mail.gmail.com> <99767EA2E27DD44DB4E9F9B9ACA458C03BD79F00@SSIEXCH-MB3.ssi.samsung.com> <596210169.12342351.1441302227895.JavaMail.zimbra@redhat.com> <99767EA2E27DD44DB4E9F9B9ACA458C03BD7A59A@SSIEXCH-MB3.ssi.samsung.com> <CACJqLybm+1qWHHB+mnNe8QkVyn1nfjuOYD99uz7ztX-Nb-YtiA@mail.gmail.com> <99767EA2E27DD44DB4E9F9B9ACA458C03BD7D259@SSIEXCH-MB3.ssi.samsung.com> <1169204779.15582423.1441981694437.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:35534 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbbIKOfd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Sep 2015 10:35:33 -0400
In-Reply-To: <1169204779.15582423.1441981694437.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, ceph-devel@vger.kernel.org

I forgot to mention for the list, you can find the latest version of the fio-objectstore branch at https://github.com/cbodley/ceph/commits/fio-objectstore.

Casey

----- Original Message -----
From: "Casey Bodley" <cbodley@redhat.com>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: "Haomai Wang" <haomaiwang@gmail.com>, ceph-devel@vger.kernel.org
Sent: Friday, September 11, 2015 10:28:14 AM
Subject: Re: About Fio backend with ObjectStore API

Hi James,

That's great that you were able to get fio-objectstore running! Thanks to you and Haomai for all the help with testing.

In terms of performance, it's possible that we're not handling the completions optimally. When profiling with MemStore I remember seeing a significant amount of cpu time spent in polling with fio_ceph_os_getevents().

The issue with reads is more of a design issue than a bug. Because the test starts with a mkfs(), there are no objects to read from initially. You would just have to add a write job to run before the read job, to make sure that the objects are initialized. Or perhaps the mkfs() step could be an optional part of the configuration.

Casey

----- Original Message -----
From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
To: "Haomai Wang" <haomaiwang@gmail.com>, "Casey Bodley" <cbodley@redhat.com>
Cc: ceph-devel@vger.kernel.org
Sent: Thursday, September 10, 2015 8:08:04 PM
Subject: RE: About Fio backend with ObjectStore API

Hi Casey and Haomai,

  We finally made the fio-objectstore works in our end . Here is fio data against filestore with Samsung 850 Pro. It is sequential write and the performance is very poor which is expected though. 

    Run status group 0 (all jobs):
  WRITE: io=524288KB, aggrb=9467KB/s, minb=9467KB/s, maxb=9467KB/s, mint=55378msec, maxt=55378msec
    
  But anyway, it works even though still some bugs to fix like read and filesytem issues. thanks a lot for your great work.

  Regards,
  James

  jamesliu@jamesliu-OptiPlex-7010:~/WorkSpace/ceph_casey/src$ sudo ./fio/fio ./test/objectstore.fio 
filestore: (g=0): rw=write, bs=128K-128K/128K-128K/128K-128K, ioengine=cephobjectstore, iodepth=1
fio-2.2.9-56-g736a
Starting 1 process
test1
filestore: Laying out IO file(s) (1 file(s) / 512MB)
2015-09-10 16:55:40.614494 7f19d34d1840  1 filestore(/home/jamesliu/fio_ceph) mkfs in /home/jamesliu/fio_ceph
2015-09-10 16:55:40.614924 7f19d34d1840  1 filestore(/home/jamesliu/fio_ceph) mkfs generated fsid 5508d58e-dbfc-48a5-9f9c-c639af4fe73a
2015-09-10 16:55:40.630326 7f19d34d1840  1 filestore(/home/jamesliu/fio_ceph) write_version_stamp 4
2015-09-10 16:55:40.673417 7f19d34d1840  0 filestore(/home/jamesliu/fio_ceph) backend xfs (magic 0x58465342)
2015-09-10 16:55:40.724097 7f19d34d1840  1 filestore(/home/jamesliu/fio_ceph) leveldb db exists/created
2015-09-10 16:55:40.724218 7f19d34d1840 -1 journal FileJournal::_open: disabling aio for non-block journal.  Use journal_force_aio to force use of aio anyway
2015-09-10 16:55:40.724226 7f19d34d1840  1 journal _open /tmp/fio_ceph_filestore1 fd 5: 5368709120 bytes, block size 4096 bytes, directio = 1, aio = 0
2015-09-10 16:55:40.724468 7f19d34d1840 -1 journal check: ondisk fsid 7580401a-6863-4863-9873-3adda08c9150 doesn't match expected 5508d58e-dbfc-48a5-9f9c-c639af4fe73a, invalid (someone else's?) journal
2015-09-10 16:55:40.724481 7f19d34d1840  1 journal close /tmp/fio_ceph_filestore1
2015-09-10 16:55:40.724506 7f19d34d1840  1 journal _open /tmp/fio_ceph_filestore1 fd 5: 5368709120 bytes, block size 4096 bytes, directio = 1, aio = 0
2015-09-10 16:55:40.730417 7f19d34d1840  0 filestore(/home/jamesliu/fio_ceph) mkjournal created journal on /tmp/fio_ceph_filestore1
2015-09-10 16:55:40.730446 7f19d34d1840  1 filestore(/home/jamesliu/fio_ceph) mkfs done in /home/jamesliu/fio_ceph
2015-09-10 16:55:40.730527 7f19d34d1840  0 filestore(/home/jamesliu/fio_ceph) backend xfs (magic 0x58465342)
2015-09-10 16:55:40.730773 7f19d34d1840  0 genericfilestorebackend(/home/jamesliu/fio_ceph) detect_features: FIEMAP ioctl is disabled via 'filestore fiemap' config option
2015-09-10 16:55:40.730779 7f19d34d1840  0 genericfilestorebackend(/home/jamesliu/fio_ceph) detect_features: SEEK_DATA/SEEK_HOLE is disabled via 'filestore seek data hole' config option
2015-09-10 16:55:40.730793 7f19d34d1840  0 genericfilestorebackend(/home/jamesliu/fio_ceph) detect_features: splice is supported
2015-09-10 16:55:40.751951 7f19d34d1840  0 genericfilestorebackend(/home/jamesliu/fio_ceph) detect_features: syncfs(2) syscall fully supported (by glibc and kernel)
2015-09-10 16:55:40.752102 7f19d34d1840  0 xfsfilestorebackend(/home/jamesliu/fio_ceph) detect_features: extsize is supported and your kernel >= 3.5
2015-09-10 16:55:40.794731 7f19d34d1840  0 filestore(/home/jamesliu/fio_ceph) mount: enabling WRITEAHEAD journal mode: checkpoint is not enabled
2015-09-10 16:55:40.794906 7f19d34d1840 -1 journal FileJournal::_open: disabling aio for non-block journal.  Use journal_force_aio to force use of aio anyway
2015-09-10 16:55:40.794917 7f19d34d1840  1 journal _open /tmp/fio_ceph_filestore1 fd 11: 5368709120 bytes, block size 4096 bytes, directio = 1, aio = 0
2015-09-10 16:55:40.795219 7f19d34d1840  1 journal _open /tmp/fio_ceph_filestore1 fd 11: 5368709120 bytes, block size 4096 bytes, directio = 1, aio = 0
2015-09-10 16:55:40.795533 7f19d34d1840  1 filestore(/home/jamesliu/fio_ceph) upgrade
2015-09-10 16:56:36.420878 7f19d34d1840  1 journal close /tmp/fio_ceph_filestore10s]

filestore: (groupid=0, jobs=1): err= 0: pid=16515: Thu Sep 10 16:56:36 2015
  write: io=524288KB, bw=9467.5KB/s, iops=73, runt= 55378msec
    slat (usec): min=22, max=142, avg=57.93, stdev=11.46
    clat (msec): min=6, max=148, avg=13.46, stdev=10.61
     lat (msec): min=6, max=148, avg=13.51, stdev=10.61
    clat percentiles (msec):
     |  1.00th=[   10],  5.00th=[   10], 10.00th=[   10], 20.00th=[   10],
     | 30.00th=[   10], 40.00th=[   10], 50.00th=[   10], 60.00th=[   10],
     | 70.00th=[   10], 80.00th=[   15], 90.00th=[   25], 95.00th=[   29],
     | 99.00th=[   43], 99.50th=[   93], 99.90th=[  137], 99.95th=[  143],
     | 99.99th=[  149]
    bw (KB  /s): min= 1505, max=13750, per=100.00%, avg=9525.38, stdev=3821.47
    lat (msec) : 10=71.73%, 20=11.52%, 50=15.87%, 100=0.46%, 250=0.42%
  cpu          : usr=1.50%, sys=1.87%, ctx=353850, majf=0, minf=48
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued    : total=r=0/w=4096/d=0, short=r=0/w=0/d=0, drop=r=0/w=0/d=0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
  WRITE: io=524288KB, aggrb=9467KB/s, minb=9467KB/s, maxb=9467KB/s, mint=55378msec, maxt=55378msec

Disk stats (read/write):
  loop0: ios=0/0, merge=0/0, ticks=0/0, in_queue=0, util=0.00%

   
________________________________________
From: Haomai Wang [haomaiwang@gmail.com]
Sent: Friday, September 04, 2015 8:43 PM
To: James (Fei) Liu-SSI
Cc: Casey Bodley; ceph-devel@vger.kernel.org
Subject: Re: About Fio backend with ObjectStore API

On Sat, Sep 5, 2015 at 4:29 AM, James (Fei) Liu-SSI
<james.liu@ssi.samsung.com> wrote:
> Hi Casey,
>    Thanks. I even got a compiling error with fio-objectstore branch.
>
>     Here is error message:
>
>       make[3]: *** No rule to make target `rbd_fuse/rbd-fuse.c', needed by `rbd_fuse/rbd-fuse.o'.  Stop.
> make[3]: *** Waiting for unfinished jobs....
>   CXX      ceph_fuse.o

This is a old make problem. I nearly forgot the details, but you can
run "make clean" then try again. Or remove this ceph build directory
directly and git clone a clean tree

> make[3]: Leaving directory `/home/jamesliu/WorkSpace/ceph_fio/src'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/home/jamesliu/WorkSpace/ceph_fio/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/jamesliu/WorkSpace/ceph_fio/src'
> make: *** [all-recursive] Error 1
> jamesliu@jamesliu-OptiPlex-7010:~/WorkSpace/ceph_fio$ git branch
> * fio-objectstore
>   master
>
>
> Regards,
> James
>
> -----Original Message-----
> From: Casey Bodley [mailto:cbodley@redhat.com]
> Sent: Thursday, September 03, 2015 10:44 AM
> To: James (Fei) Liu-SSI
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: About Fio backend with ObjectStore API
>
> Hi James,
>
> I'm sorry for not following up on that segfault, but I wasn't ever able to reproduce it. I used it recently for memstore testing without any problems. I wonder if there's a problem with the autotools build? I've only tested it with cmake. When I find some time, I'll rebase it on master and do another round of testing.
>
> Casey
>
> ----- Original Message -----
>> From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
>> To: "Haomai Wang" <haomaiwang@gmail.com>, "Casey Bodley"
>> <cbodley@redhat.com>
>> Cc: "Casey Bodley" <cbodley@gmail.com>, "Matt W. Benjamin"
>> <matt@cohortfs.com>, ceph-devel@vger.kernel.org
>> Sent: Wednesday, September 2, 2015 8:06:14 PM
>> Subject: RE: About Fio backend with ObjectStore API
>>
>> Hi Haomai and Case,
>>      Do you have any fixes for that segfault?
>>
>>     Thanks,
>>     James
>>
>> -----Original Message-----
>> From: Haomai Wang [mailto:haomaiwang@gmail.com]
>> Sent: Wednesday, July 22, 2015 6:07 PM
>> To: Casey Bodley
>> Cc: Casey Bodley; Matt W. Benjamin; James (Fei) Liu-SSI;
>> ceph-devel@vger.kernel.org
>> Subject: Re: About Fio backend with ObjectStore API
>>
>> no special
>>
>> [global]
>> #logging
>> #write_iops_log=write_iops_log
>> #write_bw_log=write_bw_log
>> #write_lat_log=write_lat_log
>> ioengine=./ceph-int/src/.libs/libfio_ceph_objectstore.so
>> invalidate=0 # mandatory
>> rw=write
>> #bs=4k
>>
>> [filestore]
>> iodepth=1
>> # create a journaled filestore
>> objectstore=filestore
>> directory=./osd/
>> filestore_journal=./osd/journal
>>
>> On Thu, Jul 23, 2015 at 4:56 AM, Casey Bodley <cbodley@redhat.com> wrote:
>> > Hi Haomai,
>> >
>> > Sorry for the late response, I was out of the office. I'm afraid I
>> > haven't run into that segfault. The io_ops should be set at the very
>> > beginning when it calls get_ioengine(). All I can suggest is that
>> > you verify that your job file is pointing to the correct
>> > fio_ceph_objectstore.so. If you've made any other interesting
>> > changes to the job file, could you share it here?
>> >
>> > Casey
>> >
>> > ----- Original Message -----
>> > From: "Haomai Wang" <haomaiwang@gmail.com>
>> > To: "Casey Bodley" <cbodley@gmail.com>
>> > Cc: "Matt W. Benjamin" <matt@cohortfs.com>, "James (Fei) Liu-SSI"
>> > <james.liu@ssi.samsung.com>, ceph-devel@vger.kernel.org
>> > Sent: Tuesday, July 21, 2015 7:50:32 AM
>> > Subject: Re: About Fio backend with ObjectStore API
>> >
>> > Hi Casey,
>> >
>> > I check your commits and know what you fixed. I cherry-picked your
>> > new commits but I still met the same problem.
>> >
>> > """
>> > It's strange that it alwasys hit segment fault when entering
>> > "_fio_setup_ceph_filestore_data", gdb tells "td->io_ops" is NULL but
>> > when I up the stack, the "td->io_ops" is not null. Maybe it's
>> > related to dlopen?
>> > """
>> >
>> > Do you have any hint about this?
>> >
>> > On Thu, Jul 16, 2015 at 5:23 AM, Casey Bodley <cbodley@gmail.com> wrote:
>> >> Hi Haomai,
>> >>
>> >> I was able to run this after a couple changes to the filestore.fio
>> >> job file. Two of the config options were using the wrong names. I
>> >> pushed a fix for the job file, as well as a patch that renames
>> >> everything from filestore to objectstore (thanks James), to
>> >> https://github.com/linuxbox2/linuxbox-ceph/commits/fio-objectstore.
>> >>
>> >> I found that the read support doesn't appear to work anymore, so
>> >> give "rw=write" a try. And because it does a mkfs(), make sure
>> >> you're pointing it to an empty xfs directory with the "directory=" option.
>> >>
>> >> Casey
>> >>
>> >> On Tue, Jul 14, 2015 at 2:45 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
>> >>> Anyone who have successfully ran the fio with this external io
>> >>> engine ceph_objectstore?
>> >>>
>> >>> It's strange that it alwasys hit segment fault when entering
>> >>> "_fio_setup_ceph_filestore_data", gdb tells "td->io_ops" is NULL
>> >>> but when I up the stack, the "td->io_ops" is not null. Maybe it's
>> >>> related to dlopen?
>> >>>
>> >>> On Fri, Jul 10, 2015 at 3:51 PM, Haomai Wang
>> >>> <haomaiwang@gmail.com>
>> >>> wrote:
>> >>>> I have rebased the branch with master, and push it to ceph
>> >>>> upstream repo.
>> >>>> https://github.com/ceph/ceph/compare/fio-objectstore?expand=1
>> >>>>
>> >>>> Plz let me know if who is working on this. Otherwise, I would
>> >>>> like to improve this to be merge ready.
>> >>>>
>> >>>> On Fri, Jul 10, 2015 at 4:26 AM, Matt W. Benjamin
>> >>>> <matt@cohortfs.com>
>> >>>> wrote:
>> >>>>> That makes sense.
>> >>>>>
>> >>>>> Matt
>> >>>>>
>> >>>>> ----- "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com> wrote:
>> >>>>>
>> >>>>>> Hi Casey,
>> >>>>>>   Got it. I was directed to the old code base. By the way,
>> >>>>>> Since the testing case was used to exercise all of object stores.
>> >>>>>> Strongly recommend to change the name from
>> >>>>>> fio_ceph_filestore.cc to fio_ceph_objectstore.cc . And the code
>> >>>>>> in fio_ceph_filestore.cc should be refactored to reflect that
>> >>>>>> the whole objectstore will be supported by
>> >>>>>> fio_ceph_objectstore.cc. what you think?
>> >>>>>>
>> >>>>>> Let me know if you need any help from my side.
>> >>>>>>
>> >>>>>>
>> >>>>>> Regards,
>> >>>>>> James
>> >>>>>>
>> >>>>>>
>> >>>>>>
>> >>>>>> -----Original Message-----
>> >>>>>> From: Casey Bodley [mailto:cbodley@gmail.com]
>> >>>>>> Sent: Thursday, July 09, 2015 12:32 PM
>> >>>>>> To: James (Fei) Liu-SSI
>> >>>>>> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> >>>>>> Subject: Re: About Fio backend with ObjectStore API
>> >>>>>>
>> >>>>>> Hi James,
>> >>>>>>
>> >>>>>> Are you looking at the code from
>> >>>>>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectstore?
>> >>>>>> It uses ObjectStore::create() instead of new FileStore(). This
>> >>>>>> allows us to exercise all of the object stores with the same code.
>> >>>>>>
>> >>>>>> Casey
>> >>>>>>
>> >>>>>> On Thu, Jul 9, 2015 at 2:01 PM, James (Fei) Liu-SSI
>> >>>>>> <james.liu@ssi.samsung.com> wrote:
>> >>>>>> > Hi Casey,
>> >>>>>> >   Here is the code in the fio_ceph_filestore.cc. Basically,
>> >>>>>> > it
>> >>>>>> creates a filestore as backend engine for IO exercises. If we
>> >>>>>> got to send IO commands to KeyValue Store or Newstore, we got
>> >>>>>> to change the code accordingly, right?  I did not see any other
>> >>>>>> files like fio_ceph_keyvaluestore.cc or fio_ceph_newstore.cc.
>> >>>>>> In my humble opinion, we might need to create other two fio
>> >>>>>> engines for keyvaluestore and newstore if we want to exercise
>> >>>>>> these two, right?
>> >>>>>> >
>> >>>>>> > Regards,
>> >>>>>> > James
>> >>>>>> >
>> >>>>>> > static int fio_ceph_filestore_init(struct thread_data *td)
>> >>>>>> > 209 {
>> >>>>>> > 210     vector<const char*> args;
>> >>>>>> > 211     struct ceph_filestore_data *ceph_filestore_data = (struct
>> >>>>>> ceph_filestore_data *) td->io_ops->data;
>> >>>>>> > 212     ObjectStore::Transaction ft;
>> >>>>>> > 213
>> >>>>>> >
>> >>>>>> > 214     global_init(NULL, args, CEPH_ENTITY_TYPE_OSD,
>> >>>>>> CODE_ENVIRONMENT_UTILITY, 0);
>> >>>>>> > 215     //g_conf->journal_dio = false;
>> >>>>>> > 216     common_init_finish(g_ceph_context);
>> >>>>>> > 217     //g_ceph_context->_conf->set_val("debug_filestore", "20");
>> >>>>>> > 218     //g_ceph_context->_conf->set_val("debug_throttle", "20");
>> >>>>>> > 219     g_ceph_context->_conf->apply_changes(NULL);
>> >>>>>> > 220
>> >>>>>> >
>> >>>>>> > 221     ceph_filestore_data->osd_path =
>> >>>>>> strdup("/mnt/fio_ceph_filestore.XXXXXXX");
>> >>>>>> > 222     ceph_filestore_data->journal_path =
>> >>>>>> strdup("/var/lib/ceph/osd/journal-ram/fio_ceph_filestore.XXXXXXX"
>> >>>>>> );
>> >>>>>> > 223
>> >>>>>> >
>> >>>>>> > 224     if (!mkdtemp(ceph_filestore_data->osd_path)) {
>> >>>>>> > 225             cout << "mkdtemp failed: " << strerror(errno) <<
>> >>>>>> std::endl;
>> >>>>>> > 226             return 1;
>> >>>>>> > 227     }
>> >>>>>> > 228     //mktemp(ceph_filestore_data->journal_path); // NOSPC issue
>> >>>>>> > 229
>> >>>>>> >
>> >>>>>> > 230     ObjectStore *fs = new
>> >>>>>> FileStore(ceph_filestore_data->osd_path,
>> >>>>>> ceph_filestore_data->journal_path);
>> >>>>>> > 231     ceph_filestore_data->fs = fs;
>> >>>>>> > 232
>> >>>>>> >
>> >>>>>> > 233     if (fs->mkfs() < 0) {
>> >>>>>> > 234             cout << "mkfs failed" << std::endl;
>> >>>>>> > 235             goto failed;
>> >>>>>> > 236     }
>> >>>>>> > 237
>> >>>>>> > 238     if (fs->mount() < 0) {
>> >>>>>> > 239             cout << "mount failed" << std::endl;
>> >>>>>> > 240             goto failed;
>> >>>>>> > 241     }
>> >>>>>> > 242
>> >>>>>> >
>> >>>>>> > 243     ft.create_collection(coll_t());
>> >>>>>> > 244     fs->apply_transaction(ft);
>> >>>>>> > 245
>> >>>>>> >
>> >>>>>> > 246
>> >>>>>> >
>> >>>>>> > 247     return 0;
>> >>>>>> > 248
>> >>>>>> >
>> >>>>>> > 249 failed:
>> >>>>>> > 250     return 1;
>> >>>>>> > 251
>> >>>>>> >
>> >>>>>> > 252 }
>> >>>>>> > -----Original Message-----
>> >>>>>> > From: Casey Bodley [mailto:cbodley@gmail.com]
>> >>>>>> > Sent: Thursday, July 09, 2015 9:19 AM
>> >>>>>> > To: James (Fei) Liu-SSI
>> >>>>>> > Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> >>>>>> > Subject: Re: About Fio backend with ObjectStore API
>> >>>>>> >
>> >>>>>> > Hi James,
>> >>>>>> >
>> >>>>>> > In the job file src/test/filestore.fio, you can modify the
>> >>>>>> > line "objectstore=filestore" to use any objectstore type
>> >>>>>> > supported by
>> >>>>>> the
>> >>>>>> > ObjectStore::create() factory.
>> >>>>>> >
>> >>>>>> > Casey
>> >>>>>> >
>> >>>>>> > On Wed, Jul 8, 2015 at 8:02 PM, James (Fei) Liu-SSI
>> >>>>>> <james.liu@ssi.samsung.com> wrote:
>> >>>>>> >> Hi Casey,
>> >>>>>> >>   Quick questions, The code in the trunk only cover the test
>> >>>>>> >> for
>> >>>>>> filestore. I was wondering do you have any plan to cover the
>> >>>>>> test for kvstore and newstore?
>> >>>>>> >>
>> >>>>>> >>   Thanks,
>> >>>>>> >>   James
>> >>>>>> >>
>> >>>>>> >> -----Original Message-----
>> >>>>>> >> From: ceph-devel-owner@vger.kernel.org
>> >>>>>> >> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of James
>> >>>>>> >> (Fei)
>> >>>>>>
>> >>>>>> >> Liu-SSI
>> >>>>>> >> Sent: Tuesday, June 30, 2015 2:19 PM
>> >>>>>> >> To: Casey Bodley
>> >>>>>> >> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> >>>>>> >> Subject: RE: About Fio backend with ObjectStore API
>> >>>>>> >>
>> >>>>>> >> Hi Casey,
>> >>>>>> >>
>> >>>>>> >>   Thanks a lot.
>> >>>>>> >>
>> >>>>>> >>   Regards,
>> >>>>>> >>   James
>> >>>>>> >>
>> >>>>>> >> -----Original Message-----
>> >>>>>> >> From: Casey Bodley [mailto:cbodley@gmail.com]
>> >>>>>> >> Sent: Tuesday, June 30, 2015 2:16 PM
>> >>>>>> >> To: James (Fei) Liu-SSI
>> >>>>>> >> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> >>>>>> >> Subject: Re: About Fio backend with ObjectStore API
>> >>>>>> >>
>> >>>>>> >> Hi,
>> >>>>>> >>
>> >>>>>> >> When Danny Al-Gaaf & Daniel Gollub published "Ceph
>> >>>>>> >> Performance
>> >>>>>> >> Analysis: fio and RBD" at
>> >>>>>> >>
>> >>>>>> https://telekomcloud.github.io/ceph/2014/02/26/ceph-performance
>> >>>>>> -a
>> >>>>>> naly
>> >>>>>> >> s is_fio_rbd.html, they also mentioned a fio engine that
>> >>>>>> >> linked directly into ceph's FileStore. I was able to find
>> >>>>>> >> Daniel's branch
>> >>>>>> on
>> >>>>>> >> github at
>> >>>>>> >> https://github.com/gollub/ceph/tree/fio_filestore_v2, and
>> >>>>>> did some more work on it at the time.
>> >>>>>> >>
>> >>>>>> >> I just rebased that work onto the latest ceph master branch,
>> >>>>>> >> and
>> >>>>>> pushed to our github at
>> >>>>>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectstore.
>> >>>>>> You can find the source in src/test/fio_ceph_filestore.cc, and
>> >>>>>> run fio with the provided example fio job file in
>> >>>>>> src/test/filestore.fio.
>> >>>>>> >>
>> >>>>>> >> I didn't have a chance to confirm that it builds with
>> >>>>>> >> automake, but
>> >>>>>>
>> >>>>>> >> the cmake version built for me. I'm happy to help if you run
>> >>>>>> >> into problems, Casey
>> >>>>>> >>
>> >>>>>> >> On Tue, Jun 30, 2015 at 2:31 PM, James (Fei) Liu-SSI
>> >>>>>> <james.liu@ssi.samsung.com> wrote:
>> >>>>>> >>> Hi Haomai,
>> >>>>>> >>>   What are you trying to ask is to benchmark local
>> >>>>>> objectstore(like kvstore/filestore/newstore) locally with
>> >>>>>> FIO(ObjectStore engine)? You want to purely compare the
>> >>>>>> performance locally for these objectstores, right?
>> >>>>>> >>>
>> >>>>>> >>>   Regards,
>> >>>>>> >>>   James
>> >>>>>> >>>
>> >>>>>> >>> -----Original Message-----
>> >>>>>> >>> From: ceph-devel-owner@vger.kernel.org
>> >>>>>> >>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of
>> >>>>>> >>> Haomai
>> >>>>>> Wang
>> >>>>>> >>> Sent: Tuesday, June 30, 2015 9:06 AM
>> >>>>>> >>> To: ceph-devel@vger.kernel.org
>> >>>>>> >>> Subject: About Fio backend with ObjectStore API
>> >>>>>> >>>
>> >>>>>> >>> Hi all,
>> >>>>>> >>>
>> >>>>>> >>> Long long ago, is there someone said about fio backend with
>> >>>>>> >>> Ceph
>> >>>>>> ObjectStore API? So we could use the existing mature fio
>> >>>>>> facility to benchmark ceph objectstore.
>> >>>>>> >>>
>> >>>>>> >>> --
>> >>>>>> >>> Best Regards,
>> >>>>>> >>>
>> >>>>>> >>> Wheat
>> >>>>>> >>> --
>> >>>>>> >>> To unsubscribe from this list: send the line "unsubscribe
>> >>>>>> ceph-devel"
>> >>>>>> >>> in the body of a message to majordomo@vger.kernel.org More
>> >>>>>> majordomo
>> >>>>>> >>> info at  http://vger.kernel.org/majordomo-info.html
>> >>>>>> >>   {.n +       +%  lzwm  b ?  r  y? ?zX     ?}   ?z &j:+v        zZ+
>> >>>>>>  +zf   h   ~    i   z   w   ?    & )? f
>> >>>>>> N     r  y   b X  ?v ^ )?{.n +   z ]z   {ay ?? ,j  f   h   z  w
>> >>>>>>     j:+v   w j m        zZ+  ?j"
>> >>>>>
>> >>>>> --
>> >>>>> Matt Benjamin
>> >>>>> CohortFS, LLC.
>> >>>>> 315 West Huron Street, Suite 140A Ann Arbor, Michigan 48103
>> >>>>>
>> >>>>> http://cohortfs.com
>> >>>>>
>> >>>>> tel.  734-761-4689
>> >>>>> fax.  734-769-8938
>> >>>>> cel.  734-216-5309
>> >>>>
>> >>>>
>> >>>>
>> >>>> --
>> >>>> Best Regards,
>> >>>>
>> >>>> Wheat
>> >>>
>> >>>
>> >>>
>> >>> --
>> >>> Best Regards,
>> >>>
>> >>> Wheat
>> >
>> >
>> >
>> > --
>> > Best Regards,
>> >
>> > Wheat
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>> > in the body of a message to majordomo@vger.kernel.org More majordomo
>> > info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>> N     r  y   b X  ?v ^ )?{.n +   z ]z   {ay ?? ,j  f   h   z  w      j
>> :+v   w j m        zZ+  ?j"



--
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
