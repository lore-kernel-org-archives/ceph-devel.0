From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About Fio backend with ObjectStore API
Date: Tue, 14 Jul 2015 14:45:30 +0800
Message-ID: <CACJqLyZYZja8nchW5=tB1AL7BdkDAALQynpCm1N-bnpBixdmew@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B31A8D8@SSIEXCH-MB3.ssi.samsung.com>
	<814413230.286.1436473608097.JavaMail.root@thunderbeast.private.linuxbox.com>
	<CACJqLyYb2xf8TN+HXiON8G8ojob1OwedFusSnY25p53a7aiyiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35135 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbbGNGpb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jul 2015 02:45:31 -0400
Received: by ykdu72 with SMTP id u72so476303ykd.2
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2015 23:45:30 -0700 (PDT)
In-Reply-To: <CACJqLyYb2xf8TN+HXiON8G8ojob1OwedFusSnY25p53a7aiyiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Matt W. Benjamin" <matt@cohortfs.com>
Cc: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@gmail.com>

Anyone who have successfully ran the fio with this external io engine
ceph_objectstore?

It's strange that it alwasys hit segment fault when entering
"_fio_setup_ceph_filestore_data", gdb tells "td->io_ops" is NULL but
when I up the stack, the "td->io_ops" is not null. Maybe it's related
to dlopen?

On Fri, Jul 10, 2015 at 3:51 PM, Haomai Wang <haomaiwang@gmail.com> wro=
te:
> I have rebased the branch with master, and push it to ceph upstream
> repo. https://github.com/ceph/ceph/compare/fio-objectstore?expand=3D1
>
> Plz let me know if who is working on this. Otherwise, I would like to
> improve this to be merge ready.
>
> On Fri, Jul 10, 2015 at 4:26 AM, Matt W. Benjamin <matt@cohortfs.com>=
 wrote:
>> That makes sense.
>>
>> Matt
>>
>> ----- "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com> wrote:
>>
>>> Hi Casey,
>>>   Got it. I was directed to the old code base. By the way, Since th=
e
>>> testing case was used to exercise all of object stores.  Strongly
>>> recommend to change the name from fio_ceph_filestore.cc to
>>> fio_ceph_objectstore.cc . And the code in fio_ceph_filestore.cc sho=
uld
>>> be refactored to reflect that the whole objectstore will be support=
ed
>>> by fio_ceph_objectstore.cc. what you think?
>>>
>>> Let me know if you need any help from my side.
>>>
>>>
>>> Regards,
>>> James
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Casey Bodley [mailto:cbodley@gmail.com]
>>> Sent: Thursday, July 09, 2015 12:32 PM
>>> To: James (Fei) Liu-SSI
>>> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>>> Subject: Re: About Fio backend with ObjectStore API
>>>
>>> Hi James,
>>>
>>> Are you looking at the code from
>>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectstore? It
>>> uses ObjectStore::create() instead of new FileStore(). This allows =
us
>>> to exercise all of the object stores with the same code.
>>>
>>> Casey
>>>
>>> On Thu, Jul 9, 2015 at 2:01 PM, James (Fei) Liu-SSI
>>> <james.liu@ssi.samsung.com> wrote:
>>> > Hi Casey,
>>> >   Here is the code in the fio_ceph_filestore.cc. Basically, it
>>> creates a filestore as backend engine for IO exercises. If we got t=
o
>>> send IO commands to KeyValue Store or Newstore, we got to change th=
e
>>> code accordingly, right?  I did not see any other files like
>>> fio_ceph_keyvaluestore.cc or fio_ceph_newstore.cc. In my humble
>>> opinion, we might need to create other two fio engines for
>>> keyvaluestore and newstore if we want to exercise these two, right?
>>> >
>>> > Regards,
>>> > James
>>> >
>>> > static int fio_ceph_filestore_init(struct thread_data *td)
>>> > 209 {
>>> > 210     vector<const char*> args;
>>> > 211     struct ceph_filestore_data *ceph_filestore_data =3D (stru=
ct
>>> ceph_filestore_data *) td->io_ops->data;
>>> > 212     ObjectStore::Transaction ft;
>>> > 213
>>> >
>>> > 214     global_init(NULL, args, CEPH_ENTITY_TYPE_OSD,
>>> CODE_ENVIRONMENT_UTILITY, 0);
>>> > 215     //g_conf->journal_dio =3D false;
>>> > 216     common_init_finish(g_ceph_context);
>>> > 217     //g_ceph_context->_conf->set_val("debug_filestore", "20")=
;
>>> > 218     //g_ceph_context->_conf->set_val("debug_throttle", "20");
>>> > 219     g_ceph_context->_conf->apply_changes(NULL);
>>> > 220
>>> >
>>> > 221     ceph_filestore_data->osd_path =3D
>>> strdup("/mnt/fio_ceph_filestore.XXXXXXX");
>>> > 222     ceph_filestore_data->journal_path =3D
>>> strdup("/var/lib/ceph/osd/journal-ram/fio_ceph_filestore.XXXXXXX");
>>> > 223
>>> >
>>> > 224     if (!mkdtemp(ceph_filestore_data->osd_path)) {
>>> > 225             cout << "mkdtemp failed: " << strerror(errno) <<
>>> std::endl;
>>> > 226             return 1;
>>> > 227     }
>>> > 228     //mktemp(ceph_filestore_data->journal_path); // NOSPC iss=
ue
>>> > 229
>>> >
>>> > 230     ObjectStore *fs =3D new
>>> FileStore(ceph_filestore_data->osd_path,
>>> ceph_filestore_data->journal_path);
>>> > 231     ceph_filestore_data->fs =3D fs;
>>> > 232
>>> >
>>> > 233     if (fs->mkfs() < 0) {
>>> > 234             cout << "mkfs failed" << std::endl;
>>> > 235             goto failed;
>>> > 236     }
>>> > 237
>>> > 238     if (fs->mount() < 0) {
>>> > 239             cout << "mount failed" << std::endl;
>>> > 240             goto failed;
>>> > 241     }
>>> > 242
>>> >
>>> > 243     ft.create_collection(coll_t());
>>> > 244     fs->apply_transaction(ft);
>>> > 245
>>> >
>>> > 246
>>> >
>>> > 247     return 0;
>>> > 248
>>> >
>>> > 249 failed:
>>> > 250     return 1;
>>> > 251
>>> >
>>> > 252 }
>>> > -----Original Message-----
>>> > From: Casey Bodley [mailto:cbodley@gmail.com]
>>> > Sent: Thursday, July 09, 2015 9:19 AM
>>> > To: James (Fei) Liu-SSI
>>> > Cc: Haomai Wang; ceph-devel@vger.kernel.org
>>> > Subject: Re: About Fio backend with ObjectStore API
>>> >
>>> > Hi James,
>>> >
>>> > In the job file src/test/filestore.fio, you can modify the line
>>> > "objectstore=3Dfilestore" to use any objectstore type supported b=
y
>>> the
>>> > ObjectStore::create() factory.
>>> >
>>> > Casey
>>> >
>>> > On Wed, Jul 8, 2015 at 8:02 PM, James (Fei) Liu-SSI
>>> <james.liu@ssi.samsung.com> wrote:
>>> >> Hi Casey,
>>> >>   Quick questions, The code in the trunk only cover the test for
>>> filestore. I was wondering do you have any plan to cover the test f=
or
>>> kvstore and newstore?
>>> >>
>>> >>   Thanks,
>>> >>   James
>>> >>
>>> >> -----Original Message-----
>>> >> From: ceph-devel-owner@vger.kernel.org
>>> >> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of James (Fe=
i)
>>>
>>> >> Liu-SSI
>>> >> Sent: Tuesday, June 30, 2015 2:19 PM
>>> >> To: Casey Bodley
>>> >> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>>> >> Subject: RE: About Fio backend with ObjectStore API
>>> >>
>>> >> Hi Casey,
>>> >>
>>> >>   Thanks a lot.
>>> >>
>>> >>   Regards,
>>> >>   James
>>> >>
>>> >> -----Original Message-----
>>> >> From: Casey Bodley [mailto:cbodley@gmail.com]
>>> >> Sent: Tuesday, June 30, 2015 2:16 PM
>>> >> To: James (Fei) Liu-SSI
>>> >> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>>> >> Subject: Re: About Fio backend with ObjectStore API
>>> >>
>>> >> Hi,
>>> >>
>>> >> When Danny Al-Gaaf & Daniel Gollub published "Ceph Performance
>>> >> Analysis: fio and RBD" at
>>> >>
>>> https://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-ana=
ly
>>> >> s is_fio_rbd.html, they also mentioned a fio engine that linked
>>> >> directly into ceph's FileStore. I was able to find Daniel's bran=
ch
>>> on
>>> >> github at https://github.com/gollub/ceph/tree/fio_filestore_v2, =
and
>>> did some more work on it at the time.
>>> >>
>>> >> I just rebased that work onto the latest ceph master branch, and
>>> pushed to our github at
>>> https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectstore. Yo=
u
>>> can find the source in src/test/fio_ceph_filestore.cc, and run fio
>>> with the provided example fio job file in src/test/filestore.fio.
>>> >>
>>> >> I didn't have a chance to confirm that it builds with automake, =
but
>>>
>>> >> the cmake version built for me. I'm happy to help if you run int=
o
>>> >> problems, Casey
>>> >>
>>> >> On Tue, Jun 30, 2015 at 2:31 PM, James (Fei) Liu-SSI
>>> <james.liu@ssi.samsung.com> wrote:
>>> >>> Hi Haomai,
>>> >>>   What are you trying to ask is to benchmark local
>>> objectstore(like kvstore/filestore/newstore) locally with
>>> FIO(ObjectStore engine)? You want to purely compare the performance
>>> locally for these objectstores, right?
>>> >>>
>>> >>>   Regards,
>>> >>>   James
>>> >>>
>>> >>> -----Original Message-----
>>> >>> From: ceph-devel-owner@vger.kernel.org
>>> >>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai
>>> Wang
>>> >>> Sent: Tuesday, June 30, 2015 9:06 AM
>>> >>> To: ceph-devel@vger.kernel.org
>>> >>> Subject: About Fio backend with ObjectStore API
>>> >>>
>>> >>> Hi all,
>>> >>>
>>> >>> Long long ago, is there someone said about fio backend with Cep=
h
>>> ObjectStore API? So we could use the existing mature fio facility t=
o
>>> benchmark ceph objectstore.
>>> >>>
>>> >>> --
>>> >>> Best Regards,
>>> >>>
>>> >>> Wheat
>>> >>> --
>>> >>> To unsubscribe from this list: send the line "unsubscribe
>>> ceph-devel"
>>> >>> in the body of a message to majordomo@vger.kernel.org More
>>> majordomo
>>> >>> info at  http://vger.kernel.org/majordomo-info.html
>>> >>   {.n +       +%  lzwm  b =EB=A7=B2  r  y=C7=A9 =D7=AFzX     =DC=
=A8}   =C6=A0z &j:+v        zZ+
>>>  +zf   h   ~    i   z   w   ?    & )=DF=A2 f
>>> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=
=BF=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=
=BF=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD]z=EF=BF=
=BD=EF=BF=BD=EF=BF=BD{ay=EF=BF=BD=CA=87=DA=99=EF=BF=BD,j=EF=BF=BD=EF=BF=
=BDf=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BDz=EF=BF=BD=EF=
=BF=BDw=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDj:+v=EF=BF=
=BD=EF=BF=BD=EF=BF=BDw=EF=BF=BDj=EF=BF=BDm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=
=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDzZ+=EF=BF=BD=EF=BF=BD=DD=A2j"=
=EF=BF=BD=EF=BF=BD
>>
>> --
>> Matt Benjamin
>> CohortFS, LLC.
>> 315 West Huron Street, Suite 140A
>> Ann Arbor, Michigan 48103
>>
>> http://cohortfs.com
>>
>> tel.  734-761-4689
>> fax.  734-769-8938
>> cel.  734-216-5309
>
>
>
> --
> Best Regards,
>
> Wheat



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
