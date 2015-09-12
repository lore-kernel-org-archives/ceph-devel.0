From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About Fio backend with ObjectStore API
Date: Sat, 12 Sep 2015 17:04:24 +0800
Message-ID: <CACJqLyZ+_T7yMCcOCc_k+ay0fnQtTFSfVydfj+JbPWhSEJx3dQ@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B31A8D8@SSIEXCH-MB3.ssi.samsung.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03BD79F00@SSIEXCH-MB3.ssi.samsung.com>
	<596210169.12342351.1441302227895.JavaMail.zimbra@redhat.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03BD7A59A@SSIEXCH-MB3.ssi.samsung.com>
	<CACJqLybm+1qWHHB+mnNe8QkVyn1nfjuOYD99uz7ztX-Nb-YtiA@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03BD7D259@SSIEXCH-MB3.ssi.samsung.com>
	<1169204779.15582423.1441981694437.JavaMail.zimbra@redhat.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03BD7D436@SSIEXCH-MB3.ssi.samsung.com>
	<1111823139.15730495.1442002091053.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36147 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbILJEZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 12 Sep 2015 05:04:25 -0400
Received: by vkfp126 with SMTP id p126so36786307vkf.3
        for <ceph-devel@vger.kernel.org>; Sat, 12 Sep 2015 02:04:24 -0700 (PDT)
In-Reply-To: <1111823139.15730495.1442002091053.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I found my problem why segment:

because fio links librbd/librados from my /usr/local/lib but use
ceph/src/.libs/libfio_ceph_objectstore.so. They are different ceph
version.

So maybe we need to add check for abi version?

On Sat, Sep 12, 2015 at 4:08 AM, Casey Bodley <cbodley@redhat.com> wrot=
e:
> Hi James,
>
> I just looked back at the results you posted, and saw that you were u=
sing iodepth=3D1. Setting this higher should help keep the FileStore bu=
sy.
>
> Casey
>
> ----- Original Message -----
>> From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
>> To: "Casey Bodley" <cbodley@redhat.com>
>> Cc: "Haomai Wang" <haomaiwang@gmail.com>, ceph-devel@vger.kernel.org
>> Sent: Friday, September 11, 2015 1:18:31 PM
>> Subject: RE: About Fio backend with ObjectStore API
>>
>> Hi Casey,
>>   You are right. I think the bottleneck is in fio side rather than i=
n
>>   filestore side in this case. The fio did not issue the io commands=
 faster
>>   enough to saturate the filestore.
>>   Here is one of possible solution for it: Create a  async engine wh=
ich are
>>   normally way faster than sync engine in fio.
>>
>>    Here is possible framework. This new Objectstore-AIO engine in FI=
O in
>>    theory will be way faster than sync engine. Once we have FIO whic=
h can
>>    saturate newstore, memstore and filestore, we can investigate the=
m in
>>    very details of where the bottleneck in their design.
>>
>> .........................
>> struct objectstore_aio_data {
>>       struct aio_ctx *q_aio_ctx;
>>       struct aio_completion_data *a_data;
>>       aio_ses_ctx_t *p_ses_ctx;
>>       unsigned int entries;
>> };
>> ...................................
>> /*
>>  * Note that the structure is exported, so that fio can get it via
>>  * dlsym(..., "ioengine");
>>  */
>> struct ioengine_ops us_aio_ioengine =3D {
>>       .name           =3D "objectstore-aio",
>>       .version        =3D FIO_IOOPS_VERSION,
>>       .init           =3D fio_objectstore_aio_init,
>>       .prep           =3D fio_objectstore_aio_prep,
>>       .queue          =3D fio_objectstore_aio_queue,
>>       .cancel         =3D fio_objectstore_aio_cancel,
>>       .getevents      =3D fio_objectstore_aio_getevents,
>>       .event          =3D fio_objectstore_aio_event,
>>       .cleanup        =3D fio_objectstore_aio_cleanup,
>>       .open_file      =3D fio_objectstore_aio_open,
>>       .close_file     =3D fio_objectstore_aio_close,
>> };
>>
>>
>> Let me know what you think.
>>
>> Regards,
>> James
>> ........................
>> -----Original Message-----
>> From: Casey Bodley [mailto:cbodley@redhat.com]
>> Sent: Friday, September 11, 2015 7:28 AM
>> To: James (Fei) Liu-SSI
>> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> Subject: Re: About Fio backend with ObjectStore API
>>
>> Hi James,
>>
>> That's great that you were able to get fio-objectstore running! Than=
ks to you
>> and Haomai for all the help with testing.
>>
>> In terms of performance, it's possible that we're not handling the
>> completions optimally. When profiling with MemStore I remember seein=
g a
>> significant amount of cpu time spent in polling with
>> fio_ceph_os_getevents().
>>
>> The issue with reads is more of a design issue than a bug. Because t=
he test
>> starts with a mkfs(), there are no objects to read from initially. Y=
ou would
>> just have to add a write job to run before the read job, to make sur=
e that
>> the objects are initialized. Or perhaps the mkfs() step could be an =
optional
>> part of the configuration.
>>
>> Casey
>>
>> ----- Original Message -----
>> From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
>> To: "Haomai Wang" <haomaiwang@gmail.com>, "Casey Bodley" <cbodley@re=
dhat.com>
>> Cc: ceph-devel@vger.kernel.org
>> Sent: Thursday, September 10, 2015 8:08:04 PM
>> Subject: RE: About Fio backend with ObjectStore API
>>
>> Hi Casey and Haomai,
>>
>>   We finally made the fio-objectstore works in our end . Here is fio=
 data
>>   against filestore with Samsung 850 Pro. It is sequential write and=
 the
>>   performance is very poor which is expected though.
>>
>>     Run status group 0 (all jobs):
>>   WRITE: io=3D524288KB, aggrb=3D9467KB/s, minb=3D9467KB/s, maxb=3D94=
67KB/s,
>>   mint=3D55378msec, maxt=3D55378msec
>>
>>   But anyway, it works even though still some bugs to fix like read =
and
>>   filesytem issues. thanks a lot for your great work.
>>
>>   Regards,
>>   James
>>
>>   jamesliu@jamesliu-OptiPlex-7010:~/WorkSpace/ceph_casey/src$ sudo .=
/fio/fio
>>   ./test/objectstore.fio
>> filestore: (g=3D0): rw=3Dwrite, bs=3D128K-128K/128K-128K/128K-128K,
>> ioengine=3Dcephobjectstore, iodepth=3D1 fio-2.2.9-56-g736a Starting =
1 process
>> test1
>> filestore: Laying out IO file(s) (1 file(s) / 512MB)
>> 2015-09-10 16:55:40.614494 7f19d34d1840  1 filestore(/home/jamesliu/=
fio_ceph)
>> mkfs in /home/jamesliu/fio_ceph
>> 2015-09-10 16:55:40.614924 7f19d34d1840  1 filestore(/home/jamesliu/=
fio_ceph)
>> mkfs generated fsid 5508d58e-dbfc-48a5-9f9c-c639af4fe73a
>> 2015-09-10 16:55:40.630326 7f19d34d1840  1 filestore(/home/jamesliu/=
fio_ceph)
>> write_version_stamp 4
>> 2015-09-10 16:55:40.673417 7f19d34d1840  0 filestore(/home/jamesliu/=
fio_ceph)
>> backend xfs (magic 0x58465342)
>> 2015-09-10 16:55:40.724097 7f19d34d1840  1 filestore(/home/jamesliu/=
fio_ceph)
>> leveldb db exists/created
>> 2015-09-10 16:55:40.724218 7f19d34d1840 -1 journal FileJournal::_ope=
n:
>> disabling aio for non-block journal.  Use journal_force_aio to force=
 use of
>> aio anyway
>> 2015-09-10 16:55:40.724226 7f19d34d1840  1 journal _open
>> /tmp/fio_ceph_filestore1 fd 5: 5368709120 bytes, block size 4096 byt=
es,
>> directio =3D 1, aio =3D 0
>> 2015-09-10 16:55:40.724468 7f19d34d1840 -1 journal check: ondisk fsi=
d
>> 7580401a-6863-4863-9873-3adda08c9150 doesn't match expected
>> 5508d58e-dbfc-48a5-9f9c-c639af4fe73a, invalid (someone else's?) jour=
nal
>> 2015-09-10 16:55:40.724481 7f19d34d1840  1 journal close
>> /tmp/fio_ceph_filestore1
>> 2015-09-10 16:55:40.724506 7f19d34d1840  1 journal _open
>> /tmp/fio_ceph_filestore1 fd 5: 5368709120 bytes, block size 4096 byt=
es,
>> directio =3D 1, aio =3D 0
>> 2015-09-10 16:55:40.730417 7f19d34d1840  0 filestore(/home/jamesliu/=
fio_ceph)
>> mkjournal created journal on /tmp/fio_ceph_filestore1
>> 2015-09-10 16:55:40.730446 7f19d34d1840  1 filestore(/home/jamesliu/=
fio_ceph)
>> mkfs done in /home/jamesliu/fio_ceph
>> 2015-09-10 16:55:40.730527 7f19d34d1840  0 filestore(/home/jamesliu/=
fio_ceph)
>> backend xfs (magic 0x58465342)
>> 2015-09-10 16:55:40.730773 7f19d34d1840  0
>> genericfilestorebackend(/home/jamesliu/fio_ceph) detect_features: FI=
EMAP
>> ioctl is disabled via 'filestore fiemap' config option
>> 2015-09-10 16:55:40.730779 7f19d34d1840  0
>> genericfilestorebackend(/home/jamesliu/fio_ceph) detect_features:
>> SEEK_DATA/SEEK_HOLE is disabled via 'filestore seek data hole' confi=
g option
>> 2015-09-10 16:55:40.730793 7f19d34d1840  0
>> genericfilestorebackend(/home/jamesliu/fio_ceph) detect_features: sp=
lice is
>> supported
>> 2015-09-10 16:55:40.751951 7f19d34d1840  0
>> genericfilestorebackend(/home/jamesliu/fio_ceph) detect_features: sy=
ncfs(2)
>> syscall fully supported (by glibc and kernel)
>> 2015-09-10 16:55:40.752102 7f19d34d1840  0
>> xfsfilestorebackend(/home/jamesliu/fio_ceph) detect_features: extsiz=
e is
>> supported and your kernel >=3D 3.5
>> 2015-09-10 16:55:40.794731 7f19d34d1840  0 filestore(/home/jamesliu/=
fio_ceph)
>> mount: enabling WRITEAHEAD journal mode: checkpoint is not enabled
>> 2015-09-10 16:55:40.794906 7f19d34d1840 -1 journal FileJournal::_ope=
n:
>> disabling aio for non-block journal.  Use journal_force_aio to force=
 use of
>> aio anyway
>> 2015-09-10 16:55:40.794917 7f19d34d1840  1 journal _open
>> /tmp/fio_ceph_filestore1 fd 11: 5368709120 bytes, block size 4096 by=
tes,
>> directio =3D 1, aio =3D 0
>> 2015-09-10 16:55:40.795219 7f19d34d1840  1 journal _open
>> /tmp/fio_ceph_filestore1 fd 11: 5368709120 bytes, block size 4096 by=
tes,
>> directio =3D 1, aio =3D 0
>> 2015-09-10 16:55:40.795533 7f19d34d1840  1 filestore(/home/jamesliu/=
fio_ceph)
>> upgrade
>> 2015-09-10 16:56:36.420878 7f19d34d1840  1 journal close
>> /tmp/fio_ceph_filestore10s]
>>
>> filestore: (groupid=3D0, jobs=3D1): err=3D 0: pid=3D16515: Thu Sep 1=
0 16:56:36 2015
>>   write: io=3D524288KB, bw=3D9467.5KB/s, iops=3D73, runt=3D 55378mse=
c
>>     slat (usec): min=3D22, max=3D142, avg=3D57.93, stdev=3D11.46
>>     clat (msec): min=3D6, max=3D148, avg=3D13.46, stdev=3D10.61
>>      lat (msec): min=3D6, max=3D148, avg=3D13.51, stdev=3D10.61
>>     clat percentiles (msec):
>>      |  1.00th=3D[   10],  5.00th=3D[   10], 10.00th=3D[   10], 20.0=
0th=3D[   10],
>>      | 30.00th=3D[   10], 40.00th=3D[   10], 50.00th=3D[   10], 60.0=
0th=3D[   10],
>>      | 70.00th=3D[   10], 80.00th=3D[   15], 90.00th=3D[   25], 95.0=
0th=3D[   29],
>>      | 99.00th=3D[   43], 99.50th=3D[   93], 99.90th=3D[  137], 99.9=
5th=3D[  143],
>>      | 99.99th=3D[  149]
>>     bw (KB  /s): min=3D 1505, max=3D13750, per=3D100.00%, avg=3D9525=
=2E38,
>>     stdev=3D3821.47
>>     lat (msec) : 10=3D71.73%, 20=3D11.52%, 50=3D15.87%, 100=3D0.46%,=
 250=3D0.42%
>>   cpu          : usr=3D1.50%, sys=3D1.87%, ctx=3D353850, majf=3D0, m=
inf=3D48
>>   IO depths    : 1=3D100.0%, 2=3D0.0%, 4=3D0.0%, 8=3D0.0%, 16=3D0.0%=
, 32=3D0.0%,
>>   >=3D64=3D0.0%
>>      submit    : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0=
%, 64=3D0.0%,
>>      >=3D64=3D0.0%
>>      complete  : 0=3D0.0%, 4=3D100.0%, 8=3D0.0%, 16=3D0.0%, 32=3D0.0=
%, 64=3D0.0%,
>>      >=3D64=3D0.0%
>>      issued    : total=3Dr=3D0/w=3D4096/d=3D0, short=3Dr=3D0/w=3D0/d=
=3D0, drop=3Dr=3D0/w=3D0/d=3D0
>>      latency   : target=3D0, window=3D0, percentile=3D100.00%, depth=
=3D1
>>
>> Run status group 0 (all jobs):
>>   WRITE: io=3D524288KB, aggrb=3D9467KB/s, minb=3D9467KB/s, maxb=3D94=
67KB/s,
>>   mint=3D55378msec, maxt=3D55378msec
>>
>> Disk stats (read/write):
>>   loop0: ios=3D0/0, merge=3D0/0, ticks=3D0/0, in_queue=3D0, util=3D0=
=2E00%
>>
>>
>> ________________________________________
>> From: Haomai Wang [haomaiwang@gmail.com]
>> Sent: Friday, September 04, 2015 8:43 PM
>> To: James (Fei) Liu-SSI
>> Cc: Casey Bodley; ceph-devel@vger.kernel.org
>> Subject: Re: About Fio backend with ObjectStore API
>>
>> On Sat, Sep 5, 2015 at 4:29 AM, James (Fei) Liu-SSI
>> <james.liu@ssi.samsung.com> wrote:
>> > Hi Casey,
>> >    Thanks. I even got a compiling error with fio-objectstore branc=
h.
>> >
>> >     Here is error message:
>> >
>> >       make[3]: *** No rule to make target `rbd_fuse/rbd-fuse.c', n=
eeded by
>> >       `rbd_fuse/rbd-fuse.o'.  Stop.
>> > make[3]: *** Waiting for unfinished jobs....
>> >   CXX      ceph_fuse.o
>>
>> This is a old make problem. I nearly forgot the details, but you can=
 run
>> "make clean" then try again. Or remove this ceph build directory dir=
ectly
>> and git clone a clean tree
>>
>> > make[3]: Leaving directory `/home/jamesliu/WorkSpace/ceph_fio/src'
>> > make[2]: *** [all-recursive] Error 1
>> > make[2]: Leaving directory `/home/jamesliu/WorkSpace/ceph_fio/src'
>> > make[1]: *** [all] Error 2
>> > make[1]: Leaving directory `/home/jamesliu/WorkSpace/ceph_fio/src'
>> > make: *** [all-recursive] Error 1
>> > jamesliu@jamesliu-OptiPlex-7010:~/WorkSpace/ceph_fio$ git branch
>> > * fio-objectstore
>> >   master
>> >
>> >
>> > Regards,
>> > James
>> >
>> > -----Original Message-----
>> > From: Casey Bodley [mailto:cbodley@redhat.com]
>> > Sent: Thursday, September 03, 2015 10:44 AM
>> > To: James (Fei) Liu-SSI
>> > Cc: ceph-devel@vger.kernel.org
>> > Subject: Re: About Fio backend with ObjectStore API
>> >
>> > Hi James,
>> >
>> > I'm sorry for not following up on that segfault, but I wasn't ever=
 able to
>> > reproduce it. I used it recently for memstore testing without any
>> > problems. I wonder if there's a problem with the autotools build? =
I've
>> > only tested it with cmake. When I find some time, I'll rebase it o=
n master
>> > and do another round of testing.
>> >
>> > Casey
>> >
>> > ----- Original Message -----
>> >> From: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
>> >> To: "Haomai Wang" <haomaiwang@gmail.com>, "Casey Bodley"
>> >> <cbodley@redhat.com>
>> >> Cc: "Casey Bodley" <cbodley@gmail.com>, "Matt W. Benjamin"
>> >> <matt@cohortfs.com>, ceph-devel@vger.kernel.org
>> >> Sent: Wednesday, September 2, 2015 8:06:14 PM
>> >> Subject: RE: About Fio backend with ObjectStore API
>> >>
>> >> Hi Haomai and Case,
>> >>      Do you have any fixes for that segfault?
>> >>
>> >>     Thanks,
>> >>     James
>> >>
>> >> -----Original Message-----
>> >> From: Haomai Wang [mailto:haomaiwang@gmail.com]
>> >> Sent: Wednesday, July 22, 2015 6:07 PM
>> >> To: Casey Bodley
>> >> Cc: Casey Bodley; Matt W. Benjamin; James (Fei) Liu-SSI;
>> >> ceph-devel@vger.kernel.org
>> >> Subject: Re: About Fio backend with ObjectStore API
>> >>
>> >> no special
>> >>
>> >> [global]
>> >> #logging
>> >> #write_iops_log=3Dwrite_iops_log
>> >> #write_bw_log=3Dwrite_bw_log
>> >> #write_lat_log=3Dwrite_lat_log
>> >> ioengine=3D./ceph-int/src/.libs/libfio_ceph_objectstore.so
>> >> invalidate=3D0 # mandatory
>> >> rw=3Dwrite
>> >> #bs=3D4k
>> >>
>> >> [filestore]
>> >> iodepth=3D1
>> >> # create a journaled filestore
>> >> objectstore=3Dfilestore
>> >> directory=3D./osd/
>> >> filestore_journal=3D./osd/journal
>> >>
>> >> On Thu, Jul 23, 2015 at 4:56 AM, Casey Bodley <cbodley@redhat.com=
> wrote:
>> >> > Hi Haomai,
>> >> >
>> >> > Sorry for the late response, I was out of the office. I'm afrai=
d I
>> >> > haven't run into that segfault. The io_ops should be set at the
>> >> > very beginning when it calls get_ioengine(). All I can suggest =
is
>> >> > that you verify that your job file is pointing to the correct
>> >> > fio_ceph_objectstore.so. If you've made any other interesting
>> >> > changes to the job file, could you share it here?
>> >> >
>> >> > Casey
>> >> >
>> >> > ----- Original Message -----
>> >> > From: "Haomai Wang" <haomaiwang@gmail.com>
>> >> > To: "Casey Bodley" <cbodley@gmail.com>
>> >> > Cc: "Matt W. Benjamin" <matt@cohortfs.com>, "James (Fei) Liu-SS=
I"
>> >> > <james.liu@ssi.samsung.com>, ceph-devel@vger.kernel.org
>> >> > Sent: Tuesday, July 21, 2015 7:50:32 AM
>> >> > Subject: Re: About Fio backend with ObjectStore API
>> >> >
>> >> > Hi Casey,
>> >> >
>> >> > I check your commits and know what you fixed. I cherry-picked y=
our
>> >> > new commits but I still met the same problem.
>> >> >
>> >> > """
>> >> > It's strange that it alwasys hit segment fault when entering
>> >> > "_fio_setup_ceph_filestore_data", gdb tells "td->io_ops" is NUL=
L
>> >> > but when I up the stack, the "td->io_ops" is not null. Maybe it=
's
>> >> > related to dlopen?
>> >> > """
>> >> >
>> >> > Do you have any hint about this?
>> >> >
>> >> > On Thu, Jul 16, 2015 at 5:23 AM, Casey Bodley <cbodley@gmail.co=
m> wrote:
>> >> >> Hi Haomai,
>> >> >>
>> >> >> I was able to run this after a couple changes to the filestore=
=2Efio
>> >> >> job file. Two of the config options were using the wrong names=
=2E I
>> >> >> pushed a fix for the job file, as well as a patch that renames
>> >> >> everything from filestore to objectstore (thanks James), to
>> >> >> https://github.com/linuxbox2/linuxbox-ceph/commits/fio-objects=
tore.
>> >> >>
>> >> >> I found that the read support doesn't appear to work anymore, =
so
>> >> >> give "rw=3Dwrite" a try. And because it does a mkfs(), make su=
re
>> >> >> you're pointing it to an empty xfs directory with the "directo=
ry=3D"
>> >> >> option.
>> >> >>
>> >> >> Casey
>> >> >>
>> >> >> On Tue, Jul 14, 2015 at 2:45 AM, Haomai Wang <haomaiwang@gmail=
=2Ecom>
>> >> >> wrote:
>> >> >>> Anyone who have successfully ran the fio with this external i=
o
>> >> >>> engine ceph_objectstore?
>> >> >>>
>> >> >>> It's strange that it alwasys hit segment fault when entering
>> >> >>> "_fio_setup_ceph_filestore_data", gdb tells "td->io_ops" is N=
ULL
>> >> >>> but when I up the stack, the "td->io_ops" is not null. Maybe =
it's
>> >> >>> related to dlopen?
>> >> >>>
>> >> >>> On Fri, Jul 10, 2015 at 3:51 PM, Haomai Wang
>> >> >>> <haomaiwang@gmail.com>
>> >> >>> wrote:
>> >> >>>> I have rebased the branch with master, and push it to ceph
>> >> >>>> upstream repo.
>> >> >>>> https://github.com/ceph/ceph/compare/fio-objectstore?expand=3D=
1
>> >> >>>>
>> >> >>>> Plz let me know if who is working on this. Otherwise, I woul=
d
>> >> >>>> like to improve this to be merge ready.
>> >> >>>>
>> >> >>>> On Fri, Jul 10, 2015 at 4:26 AM, Matt W. Benjamin
>> >> >>>> <matt@cohortfs.com>
>> >> >>>> wrote:
>> >> >>>>> That makes sense.
>> >> >>>>>
>> >> >>>>> Matt
>> >> >>>>>
>> >> >>>>> ----- "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com> wro=
te:
>> >> >>>>>
>> >> >>>>>> Hi Casey,
>> >> >>>>>>   Got it. I was directed to the old code base. By the way,
>> >> >>>>>> Since the testing case was used to exercise all of object =
stores.
>> >> >>>>>> Strongly recommend to change the name from
>> >> >>>>>> fio_ceph_filestore.cc to fio_ceph_objectstore.cc . And the
>> >> >>>>>> code in fio_ceph_filestore.cc should be refactored to refl=
ect
>> >> >>>>>> that the whole objectstore will be supported by
>> >> >>>>>> fio_ceph_objectstore.cc. what you think?
>> >> >>>>>>
>> >> >>>>>> Let me know if you need any help from my side.
>> >> >>>>>>
>> >> >>>>>>
>> >> >>>>>> Regards,
>> >> >>>>>> James
>> >> >>>>>>
>> >> >>>>>>
>> >> >>>>>>
>> >> >>>>>> -----Original Message-----
>> >> >>>>>> From: Casey Bodley [mailto:cbodley@gmail.com]
>> >> >>>>>> Sent: Thursday, July 09, 2015 12:32 PM
>> >> >>>>>> To: James (Fei) Liu-SSI
>> >> >>>>>> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> >> >>>>>> Subject: Re: About Fio backend with ObjectStore API
>> >> >>>>>>
>> >> >>>>>> Hi James,
>> >> >>>>>>
>> >> >>>>>> Are you looking at the code from
>> >> >>>>>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-object=
store?
>> >> >>>>>> It uses ObjectStore::create() instead of new FileStore(). =
This
>> >> >>>>>> allows us to exercise all of the object stores with the sa=
me code.
>> >> >>>>>>
>> >> >>>>>> Casey
>> >> >>>>>>
>> >> >>>>>> On Thu, Jul 9, 2015 at 2:01 PM, James (Fei) Liu-SSI
>> >> >>>>>> <james.liu@ssi.samsung.com> wrote:
>> >> >>>>>> > Hi Casey,
>> >> >>>>>> >   Here is the code in the fio_ceph_filestore.cc. Basical=
ly,
>> >> >>>>>> > it
>> >> >>>>>> creates a filestore as backend engine for IO exercises. If=
 we
>> >> >>>>>> got to send IO commands to KeyValue Store or Newstore, we =
got
>> >> >>>>>> to change the code accordingly, right?  I did not see any
>> >> >>>>>> other files like fio_ceph_keyvaluestore.cc or fio_ceph_new=
store.cc.
>> >> >>>>>> In my humble opinion, we might need to create other two fi=
o
>> >> >>>>>> engines for keyvaluestore and newstore if we want to exerc=
ise
>> >> >>>>>> these two, right?
>> >> >>>>>> >
>> >> >>>>>> > Regards,
>> >> >>>>>> > James
>> >> >>>>>> >
>> >> >>>>>> > static int fio_ceph_filestore_init(struct thread_data *t=
d)
>> >> >>>>>> > 209 {
>> >> >>>>>> > 210     vector<const char*> args;
>> >> >>>>>> > 211     struct ceph_filestore_data *ceph_filestore_data =
=3D (struct
>> >> >>>>>> ceph_filestore_data *) td->io_ops->data;
>> >> >>>>>> > 212     ObjectStore::Transaction ft;
>> >> >>>>>> > 213
>> >> >>>>>> >
>> >> >>>>>> > 214     global_init(NULL, args, CEPH_ENTITY_TYPE_OSD,
>> >> >>>>>> CODE_ENVIRONMENT_UTILITY, 0);
>> >> >>>>>> > 215     //g_conf->journal_dio =3D false;
>> >> >>>>>> > 216     common_init_finish(g_ceph_context);
>> >> >>>>>> > 217     //g_ceph_context->_conf->set_val("debug_filestor=
e",
>> >> >>>>>> > "20");
>> >> >>>>>> > 218     //g_ceph_context->_conf->set_val("debug_throttle=
", "20");
>> >> >>>>>> > 219     g_ceph_context->_conf->apply_changes(NULL);
>> >> >>>>>> > 220
>> >> >>>>>> >
>> >> >>>>>> > 221     ceph_filestore_data->osd_path =3D
>> >> >>>>>> strdup("/mnt/fio_ceph_filestore.XXXXXXX");
>> >> >>>>>> > 222     ceph_filestore_data->journal_path =3D
>> >> >>>>>> strdup("/var/lib/ceph/osd/journal-ram/fio_ceph_filestore.X=
XXXXXX"
>> >> >>>>>> );
>> >> >>>>>> > 223
>> >> >>>>>> >
>> >> >>>>>> > 224     if (!mkdtemp(ceph_filestore_data->osd_path)) {
>> >> >>>>>> > 225             cout << "mkdtemp failed: " << strerror(e=
rrno) <<
>> >> >>>>>> std::endl;
>> >> >>>>>> > 226             return 1;
>> >> >>>>>> > 227     }
>> >> >>>>>> > 228     //mktemp(ceph_filestore_data->journal_path); // =
NOSPC
>> >> >>>>>> > issue
>> >> >>>>>> > 229
>> >> >>>>>> >
>> >> >>>>>> > 230     ObjectStore *fs =3D new
>> >> >>>>>> FileStore(ceph_filestore_data->osd_path,
>> >> >>>>>> ceph_filestore_data->journal_path);
>> >> >>>>>> > 231     ceph_filestore_data->fs =3D fs;
>> >> >>>>>> > 232
>> >> >>>>>> >
>> >> >>>>>> > 233     if (fs->mkfs() < 0) {
>> >> >>>>>> > 234             cout << "mkfs failed" << std::endl;
>> >> >>>>>> > 235             goto failed;
>> >> >>>>>> > 236     }
>> >> >>>>>> > 237
>> >> >>>>>> > 238     if (fs->mount() < 0) {
>> >> >>>>>> > 239             cout << "mount failed" << std::endl;
>> >> >>>>>> > 240             goto failed;
>> >> >>>>>> > 241     }
>> >> >>>>>> > 242
>> >> >>>>>> >
>> >> >>>>>> > 243     ft.create_collection(coll_t());
>> >> >>>>>> > 244     fs->apply_transaction(ft);
>> >> >>>>>> > 245
>> >> >>>>>> >
>> >> >>>>>> > 246
>> >> >>>>>> >
>> >> >>>>>> > 247     return 0;
>> >> >>>>>> > 248
>> >> >>>>>> >
>> >> >>>>>> > 249 failed:
>> >> >>>>>> > 250     return 1;
>> >> >>>>>> > 251
>> >> >>>>>> >
>> >> >>>>>> > 252 }
>> >> >>>>>> > -----Original Message-----
>> >> >>>>>> > From: Casey Bodley [mailto:cbodley@gmail.com]
>> >> >>>>>> > Sent: Thursday, July 09, 2015 9:19 AM
>> >> >>>>>> > To: James (Fei) Liu-SSI
>> >> >>>>>> > Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> >> >>>>>> > Subject: Re: About Fio backend with ObjectStore API
>> >> >>>>>> >
>> >> >>>>>> > Hi James,
>> >> >>>>>> >
>> >> >>>>>> > In the job file src/test/filestore.fio, you can modify t=
he
>> >> >>>>>> > line "objectstore=3Dfilestore" to use any objectstore ty=
pe
>> >> >>>>>> > supported by
>> >> >>>>>> the
>> >> >>>>>> > ObjectStore::create() factory.
>> >> >>>>>> >
>> >> >>>>>> > Casey
>> >> >>>>>> >
>> >> >>>>>> > On Wed, Jul 8, 2015 at 8:02 PM, James (Fei) Liu-SSI
>> >> >>>>>> <james.liu@ssi.samsung.com> wrote:
>> >> >>>>>> >> Hi Casey,
>> >> >>>>>> >>   Quick questions, The code in the trunk only cover the
>> >> >>>>>> >> test for
>> >> >>>>>> filestore. I was wondering do you have any plan to cover t=
he
>> >> >>>>>> test for kvstore and newstore?
>> >> >>>>>> >>
>> >> >>>>>> >>   Thanks,
>> >> >>>>>> >>   James
>> >> >>>>>> >>
>> >> >>>>>> >> -----Original Message-----
>> >> >>>>>> >> From: ceph-devel-owner@vger.kernel.org
>> >> >>>>>> >> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of
>> >> >>>>>> >> James
>> >> >>>>>> >> (Fei)
>> >> >>>>>>
>> >> >>>>>> >> Liu-SSI
>> >> >>>>>> >> Sent: Tuesday, June 30, 2015 2:19 PM
>> >> >>>>>> >> To: Casey Bodley
>> >> >>>>>> >> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> >> >>>>>> >> Subject: RE: About Fio backend with ObjectStore API
>> >> >>>>>> >>
>> >> >>>>>> >> Hi Casey,
>> >> >>>>>> >>
>> >> >>>>>> >>   Thanks a lot.
>> >> >>>>>> >>
>> >> >>>>>> >>   Regards,
>> >> >>>>>> >>   James
>> >> >>>>>> >>
>> >> >>>>>> >> -----Original Message-----
>> >> >>>>>> >> From: Casey Bodley [mailto:cbodley@gmail.com]
>> >> >>>>>> >> Sent: Tuesday, June 30, 2015 2:16 PM
>> >> >>>>>> >> To: James (Fei) Liu-SSI
>> >> >>>>>> >> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> >> >>>>>> >> Subject: Re: About Fio backend with ObjectStore API
>> >> >>>>>> >>
>> >> >>>>>> >> Hi,
>> >> >>>>>> >>
>> >> >>>>>> >> When Danny Al-Gaaf & Daniel Gollub published "Ceph
>> >> >>>>>> >> Performance
>> >> >>>>>> >> Analysis: fio and RBD" at
>> >> >>>>>> >>
>> >> >>>>>> https://telekomcloud.github.io/ceph/2014/02/26/ceph-perfor=
manc
>> >> >>>>>> e
>> >> >>>>>> -a
>> >> >>>>>> naly
>> >> >>>>>> >> s is_fio_rbd.html, they also mentioned a fio engine tha=
t
>> >> >>>>>> >> linked directly into ceph's FileStore. I was able to fi=
nd
>> >> >>>>>> >> Daniel's branch
>> >> >>>>>> on
>> >> >>>>>> >> github at
>> >> >>>>>> >> https://github.com/gollub/ceph/tree/fio_filestore_v2, a=
nd
>> >> >>>>>> did some more work on it at the time.
>> >> >>>>>> >>
>> >> >>>>>> >> I just rebased that work onto the latest ceph master
>> >> >>>>>> >> branch, and
>> >> >>>>>> pushed to our github at
>> >> >>>>>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-object=
store.
>> >> >>>>>> You can find the source in src/test/fio_ceph_filestore.cc,=
 and
>> >> >>>>>> run fio with the provided example fio job file in
>> >> >>>>>> src/test/filestore.fio.
>> >> >>>>>> >>
>> >> >>>>>> >> I didn't have a chance to confirm that it builds with
>> >> >>>>>> >> automake, but
>> >> >>>>>>
>> >> >>>>>> >> the cmake version built for me. I'm happy to help if yo=
u
>> >> >>>>>> >> run into problems, Casey
>> >> >>>>>> >>
>> >> >>>>>> >> On Tue, Jun 30, 2015 at 2:31 PM, James (Fei) Liu-SSI
>> >> >>>>>> <james.liu@ssi.samsung.com> wrote:
>> >> >>>>>> >>> Hi Haomai,
>> >> >>>>>> >>>   What are you trying to ask is to benchmark local
>> >> >>>>>> objectstore(like kvstore/filestore/newstore) locally with
>> >> >>>>>> FIO(ObjectStore engine)? You want to purely compare the
>> >> >>>>>> performance locally for these objectstores, right?
>> >> >>>>>> >>>
>> >> >>>>>> >>>   Regards,
>> >> >>>>>> >>>   James
>> >> >>>>>> >>>
>> >> >>>>>> >>> -----Original Message-----
>> >> >>>>>> >>> From: ceph-devel-owner@vger.kernel.org
>> >> >>>>>> >>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of
>> >> >>>>>> >>> Haomai
>> >> >>>>>> Wang
>> >> >>>>>> >>> Sent: Tuesday, June 30, 2015 9:06 AM
>> >> >>>>>> >>> To: ceph-devel@vger.kernel.org
>> >> >>>>>> >>> Subject: About Fio backend with ObjectStore API
>> >> >>>>>> >>>
>> >> >>>>>> >>> Hi all,
>> >> >>>>>> >>>
>> >> >>>>>> >>> Long long ago, is there someone said about fio backend
>> >> >>>>>> >>> with Ceph
>> >> >>>>>> ObjectStore API? So we could use the existing mature fio
>> >> >>>>>> facility to benchmark ceph objectstore.
>> >> >>>>>> >>>
>> >> >>>>>> >>> --
>> >> >>>>>> >>> Best Regards,
>> >> >>>>>> >>>
>> >> >>>>>> >>> Wheat
>> >> >>>>>> >>> --
>> >> >>>>>> >>> To unsubscribe from this list: send the line "unsubscr=
ibe
>> >> >>>>>> ceph-devel"
>> >> >>>>>> >>> in the body of a message to majordomo@vger.kernel.org =
More
>> >> >>>>>> majordomo
>> >> >>>>>> >>> info at  http://vger.kernel.org/majordomo-info.html
>> >> >>>>>> >>   {.n +       +%  lzwm  b ?  r  y? ?zX     ?}   ?z &j:+=
v
>> >> >>>>>> >>   zZ+
>> >> >>>>>>  +zf   h   ~    i   z   w   ?    & )? f
>> >> >>>>>> N     r  y   b X  ?v ^ )?{.n +   z ]z   {ay ?? ,j  f   h  =
 z  w
>> >> >>>>>>     j:+v   w j m        zZ+  ?j"
>> >> >>>>>
>> >> >>>>> --
>> >> >>>>> Matt Benjamin
>> >> >>>>> CohortFS, LLC.
>> >> >>>>> 315 West Huron Street, Suite 140A Ann Arbor, Michigan 48103
>> >> >>>>>
>> >> >>>>> http://cohortfs.com
>> >> >>>>>
>> >> >>>>> tel.  734-761-4689
>> >> >>>>> fax.  734-769-8938
>> >> >>>>> cel.  734-216-5309
>> >> >>>>
>> >> >>>>
>> >> >>>>
>> >> >>>> --
>> >> >>>> Best Regards,
>> >> >>>>
>> >> >>>> Wheat
>> >> >>>
>> >> >>>
>> >> >>>
>> >> >>> --
>> >> >>> Best Regards,
>> >> >>>
>> >> >>> Wheat
>> >> >
>> >> >
>> >> >
>> >> > --
>> >> > Best Regards,
>> >> >
>> >> > Wheat
>> >> > --
>> >> > To unsubscribe from this list: send the line "unsubscribe ceph-=
devel"
>> >> > in the body of a message to majordomo@vger.kernel.org More
>> >> > majordomo info at  http://vger.kernel.org/majordomo-info.html
>> >>
>> >>
>> >>
>> >> --
>> >> Best Regards,
>> >>
>> >> Wheat
>> >> N     r  y   b X  ?v ^ )?{.n +   z ]z   {ay ?? ,j  f   h   z  w  =
    j
>> >> :+v   w j m        zZ+  ?j"
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in the
>> body of a message to majordomo@vger.kernel.org More majordomo info a=
t
>> http://vger.kernel.org/majordomo-info.html
>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
