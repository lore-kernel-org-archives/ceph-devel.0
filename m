From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About Fio backend with ObjectStore API
Date: Sat, 5 Sep 2015 11:43:26 +0800
Message-ID: <CACJqLybm+1qWHHB+mnNe8QkVyn1nfjuOYD99uz7ztX-Nb-YtiA@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B31A8D8@SSIEXCH-MB3.ssi.samsung.com>
	<CACJqLyYb2xf8TN+HXiON8G8ojob1OwedFusSnY25p53a7aiyiA@mail.gmail.com>
	<CACJqLyZYZja8nchW5=tB1AL7BdkDAALQynpCm1N-bnpBixdmew@mail.gmail.com>
	<CAMeBU_3uWeLMVbhdqRvPzuLZgUrCrTzhVbOR=cwJHuARHduuWw@mail.gmail.com>
	<CACJqLya8KW2gknveX-m+a262y8TXHqwi8As=Wi1cwh2dpnq=0A@mail.gmail.com>
	<327699266.948920.1437598600219.JavaMail.zimbra@redhat.com>
	<CACJqLyY9t_t7omJfb9vknwqBQ2V7csfLPqU-jvUtvDj2fhuyPw@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03BD79F00@SSIEXCH-MB3.ssi.samsung.com>
	<596210169.12342351.1441302227895.JavaMail.zimbra@redhat.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03BD7A59A@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f47.google.com ([209.85.213.47]:36750 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbbIEDn2 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Sep 2015 23:43:28 -0400
Received: by vkbc123 with SMTP id c123so21020404vkb.3
        for <ceph-devel@vger.kernel.org>; Fri, 04 Sep 2015 20:43:27 -0700 (PDT)
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03BD7A59A@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: Casey Bodley <cbodley@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Sep 5, 2015 at 4:29 AM, James (Fei) Liu-SSI
<james.liu@ssi.samsung.com> wrote:
> Hi Casey,
>    Thanks. I even got a compiling error with fio-objectstore branch.
>
>     Here is error message:
>
>       make[3]: *** No rule to make target `rbd_fuse/rbd-fuse.c', need=
ed by `rbd_fuse/rbd-fuse.o'.  Stop.
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
> I'm sorry for not following up on that segfault, but I wasn't ever ab=
le to reproduce it. I used it recently for memstore testing without any=
 problems. I wonder if there's a problem with the autotools build? I've=
 only tested it with cmake. When I find some time, I'll rebase it on ma=
ster and do another round of testing.
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
>> #write_iops_log=3Dwrite_iops_log
>> #write_bw_log=3Dwrite_bw_log
>> #write_lat_log=3Dwrite_lat_log
>> ioengine=3D./ceph-int/src/.libs/libfio_ceph_objectstore.so
>> invalidate=3D0 # mandatory
>> rw=3Dwrite
>> #bs=3D4k
>>
>> [filestore]
>> iodepth=3D1
>> # create a journaled filestore
>> objectstore=3Dfilestore
>> directory=3D./osd/
>> filestore_journal=3D./osd/journal
>>
>> On Thu, Jul 23, 2015 at 4:56 AM, Casey Bodley <cbodley@redhat.com> w=
rote:
>> > Hi Haomai,
>> >
>> > Sorry for the late response, I was out of the office. I'm afraid I
>> > haven't run into that segfault. The io_ops should be set at the ve=
ry
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
>> > "_fio_setup_ceph_filestore_data", gdb tells "td->io_ops" is NULL b=
ut
>> > when I up the stack, the "td->io_ops" is not null. Maybe it's
>> > related to dlopen?
>> > """
>> >
>> > Do you have any hint about this?
>> >
>> > On Thu, Jul 16, 2015 at 5:23 AM, Casey Bodley <cbodley@gmail.com> =
wrote:
>> >> Hi Haomai,
>> >>
>> >> I was able to run this after a couple changes to the filestore.fi=
o
>> >> job file. Two of the config options were using the wrong names. I
>> >> pushed a fix for the job file, as well as a patch that renames
>> >> everything from filestore to objectstore (thanks James), to
>> >> https://github.com/linuxbox2/linuxbox-ceph/commits/fio-objectstor=
e.
>> >>
>> >> I found that the read support doesn't appear to work anymore, so
>> >> give "rw=3Dwrite" a try. And because it does a mkfs(), make sure
>> >> you're pointing it to an empty xfs directory with the "directory=3D=
" option.
>> >>
>> >> Casey
>> >>
>> >> On Tue, Jul 14, 2015 at 2:45 AM, Haomai Wang <haomaiwang@gmail.co=
m> wrote:
>> >>> Anyone who have successfully ran the fio with this external io
>> >>> engine ceph_objectstore?
>> >>>
>> >>> It's strange that it alwasys hit segment fault when entering
>> >>> "_fio_setup_ceph_filestore_data", gdb tells "td->io_ops" is NULL
>> >>> but when I up the stack, the "td->io_ops" is not null. Maybe it'=
s
>> >>> related to dlopen?
>> >>>
>> >>> On Fri, Jul 10, 2015 at 3:51 PM, Haomai Wang
>> >>> <haomaiwang@gmail.com>
>> >>> wrote:
>> >>>> I have rebased the branch with master, and push it to ceph
>> >>>> upstream repo.
>> >>>> https://github.com/ceph/ceph/compare/fio-objectstore?expand=3D1
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
>> >>>>>> Since the testing case was used to exercise all of object sto=
res.
>> >>>>>> Strongly recommend to change the name from
>> >>>>>> fio_ceph_filestore.cc to fio_ceph_objectstore.cc . And the co=
de
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
>> >>>>>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectsto=
re?
>> >>>>>> It uses ObjectStore::create() instead of new FileStore(). Thi=
s
>> >>>>>> allows us to exercise all of the object stores with the same =
code.
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
>> >>>>>> to change the code accordingly, right?  I did not see any oth=
er
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
>> >>>>>> > 211     struct ceph_filestore_data *ceph_filestore_data =3D=
 (struct
>> >>>>>> ceph_filestore_data *) td->io_ops->data;
>> >>>>>> > 212     ObjectStore::Transaction ft;
>> >>>>>> > 213
>> >>>>>> >
>> >>>>>> > 214     global_init(NULL, args, CEPH_ENTITY_TYPE_OSD,
>> >>>>>> CODE_ENVIRONMENT_UTILITY, 0);
>> >>>>>> > 215     //g_conf->journal_dio =3D false;
>> >>>>>> > 216     common_init_finish(g_ceph_context);
>> >>>>>> > 217     //g_ceph_context->_conf->set_val("debug_filestore",=
 "20");
>> >>>>>> > 218     //g_ceph_context->_conf->set_val("debug_throttle", =
"20");
>> >>>>>> > 219     g_ceph_context->_conf->apply_changes(NULL);
>> >>>>>> > 220
>> >>>>>> >
>> >>>>>> > 221     ceph_filestore_data->osd_path =3D
>> >>>>>> strdup("/mnt/fio_ceph_filestore.XXXXXXX");
>> >>>>>> > 222     ceph_filestore_data->journal_path =3D
>> >>>>>> strdup("/var/lib/ceph/osd/journal-ram/fio_ceph_filestore.XXXX=
XXX"
>> >>>>>> );
>> >>>>>> > 223
>> >>>>>> >
>> >>>>>> > 224     if (!mkdtemp(ceph_filestore_data->osd_path)) {
>> >>>>>> > 225             cout << "mkdtemp failed: " << strerror(errn=
o) <<
>> >>>>>> std::endl;
>> >>>>>> > 226             return 1;
>> >>>>>> > 227     }
>> >>>>>> > 228     //mktemp(ceph_filestore_data->journal_path); // NOS=
PC issue
>> >>>>>> > 229
>> >>>>>> >
>> >>>>>> > 230     ObjectStore *fs =3D new
>> >>>>>> FileStore(ceph_filestore_data->osd_path,
>> >>>>>> ceph_filestore_data->journal_path);
>> >>>>>> > 231     ceph_filestore_data->fs =3D fs;
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
>> >>>>>> > line "objectstore=3Dfilestore" to use any objectstore type
>> >>>>>> > supported by
>> >>>>>> the
>> >>>>>> > ObjectStore::create() factory.
>> >>>>>> >
>> >>>>>> > Casey
>> >>>>>> >
>> >>>>>> > On Wed, Jul 8, 2015 at 8:02 PM, James (Fei) Liu-SSI
>> >>>>>> <james.liu@ssi.samsung.com> wrote:
>> >>>>>> >> Hi Casey,
>> >>>>>> >>   Quick questions, The code in the trunk only cover the te=
st
>> >>>>>> >> for
>> >>>>>> filestore. I was wondering do you have any plan to cover the
>> >>>>>> test for kvstore and newstore?
>> >>>>>> >>
>> >>>>>> >>   Thanks,
>> >>>>>> >>   James
>> >>>>>> >>
>> >>>>>> >> -----Original Message-----
>> >>>>>> >> From: ceph-devel-owner@vger.kernel.org
>> >>>>>> >> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Jam=
es
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
>> >>>>>> https://telekomcloud.github.io/ceph/2014/02/26/ceph-performan=
ce
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
>> >>>>>> >> I just rebased that work onto the latest ceph master branc=
h,
>> >>>>>> >> and
>> >>>>>> pushed to our github at
>> >>>>>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectsto=
re.
>> >>>>>> You can find the source in src/test/fio_ceph_filestore.cc, an=
d
>> >>>>>> run fio with the provided example fio job file in
>> >>>>>> src/test/filestore.fio.
>> >>>>>> >>
>> >>>>>> >> I didn't have a chance to confirm that it builds with
>> >>>>>> >> automake, but
>> >>>>>>
>> >>>>>> >> the cmake version built for me. I'm happy to help if you r=
un
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
>> >>>>>> >>> Long long ago, is there someone said about fio backend wi=
th
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
>> >>>>>> >>> in the body of a message to majordomo@vger.kernel.org Mor=
e
>> >>>>>> majordomo
>> >>>>>> >>> info at  http://vger.kernel.org/majordomo-info.html
>> >>>>>> >>   {.n +       +%  lzwm  b =EB=A7=B2  r  y=C7=A9 =D7=AFzX  =
   =DC=A8}   =C6=A0z &j:+v        zZ+
>> >>>>>>  +zf   h   ~    i   z   w   ?    & )=DF=A2 f
>> >>>>>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =CA=87=DA=
=99 ,j  f   h   z  w
>> >>>>>>     j:+v   w j m        zZ+  =DD=A2j"
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
>> > To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>> > in the body of a message to majordomo@vger.kernel.org More majordo=
mo
>> > info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay =CA=87=DA=99 ,=
j  f   h   z  w      j
>> :+v   w j m        zZ+  =DD=A2j"



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
