From: Casey Bodley <cbodley@gmail.com>
Subject: Re: About Fio backend with ObjectStore API
Date: Thu, 9 Jul 2015 15:32:00 -0400
Message-ID: <CAMeBU_0CvWZ1S7VatNrUCbHS65WOcP=xx3RZh1A3YFoLgv+aUQ@mail.gmail.com>
References: <CACJqLyZcAzb5wocrN8b8WoK6j3ynWF-_3=T+1aQkDko4Mv_SmQ@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319D0D@SSIEXCH-MB3.ssi.samsung.com>
	<CAMeBU_3ty6ae5VXP=_D8py1_Pk4rLKxCa4Larz0oKnyTYDtz8w@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319DF2@SSIEXCH-MB3.ssi.samsung.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B31A700@SSIEXCH-MB3.ssi.samsung.com>
	<CAMeBU_3eyRiEvgG=sPe3m=QiQiRBkeVquBpo+XpJ4GtTq4K+8Q@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B31A865@SSIEXCH-MB3.ssi.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33265 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbbGITcB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jul 2015 15:32:01 -0400
Received: by qkhu186 with SMTP id u186so193020077qkh.0
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jul 2015 12:32:00 -0700 (PDT)
In-Reply-To: <99767EA2E27DD44DB4E9F9B9ACA458C03B31A865@SSIEXCH-MB3.ssi.samsung.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>
Cc: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi James,

Are you looking at the code from
https://github.com/linuxbox2/linuxbox-ceph/tree/fio-objectstore? It
uses ObjectStore::create() instead of new FileStore(). This allows us
to exercise all of the object stores with the same code.

Casey

On Thu, Jul 9, 2015 at 2:01 PM, James (Fei) Liu-SSI
<james.liu@ssi.samsung.com> wrote:
> Hi Casey,
>   Here is the code in the fio_ceph_filestore.cc. Basically, it create=
s a filestore as backend engine for IO exercises. If we got to send IO =
commands to KeyValue Store or Newstore, we got to change the code accor=
dingly, right?  I did not see any other files like fio_ceph_keyvaluesto=
re.cc or fio_ceph_newstore.cc. In my humble opinion, we might need to c=
reate other two fio engines for keyvaluestore and newstore if we want t=
o exercise these two, right?
>
> Regards,
> James
>
> static int fio_ceph_filestore_init(struct thread_data *td)
> 209 {
> 210     vector<const char*> args;
> 211     struct ceph_filestore_data *ceph_filestore_data =3D (struct c=
eph_filestore_data *) td->io_ops->data;
> 212     ObjectStore::Transaction ft;
> 213
>
> 214     global_init(NULL, args, CEPH_ENTITY_TYPE_OSD, CODE_ENVIRONMEN=
T_UTILITY, 0);
> 215     //g_conf->journal_dio =3D false;
> 216     common_init_finish(g_ceph_context);
> 217     //g_ceph_context->_conf->set_val("debug_filestore", "20");
> 218     //g_ceph_context->_conf->set_val("debug_throttle", "20");
> 219     g_ceph_context->_conf->apply_changes(NULL);
> 220
>
> 221     ceph_filestore_data->osd_path =3D strdup("/mnt/fio_ceph_files=
tore.XXXXXXX");
> 222     ceph_filestore_data->journal_path =3D strdup("/var/lib/ceph/o=
sd/journal-ram/fio_ceph_filestore.XXXXXXX");
> 223
>
> 224     if (!mkdtemp(ceph_filestore_data->osd_path)) {
> 225             cout << "mkdtemp failed: " << strerror(errno) << std:=
:endl;
> 226             return 1;
> 227     }
> 228     //mktemp(ceph_filestore_data->journal_path); // NOSPC issue
> 229
>
> 230     ObjectStore *fs =3D new FileStore(ceph_filestore_data->osd_pa=
th, ceph_filestore_data->journal_path);
> 231     ceph_filestore_data->fs =3D fs;
> 232
>
> 233     if (fs->mkfs() < 0) {
> 234             cout << "mkfs failed" << std::endl;
> 235             goto failed;
> 236     }
> 237
> 238     if (fs->mount() < 0) {
> 239             cout << "mount failed" << std::endl;
> 240             goto failed;
> 241     }
> 242
>
> 243     ft.create_collection(coll_t());
> 244     fs->apply_transaction(ft);
> 245
>
> 246
>
> 247     return 0;
> 248
>
> 249 failed:
> 250     return 1;
> 251
>
> 252 }
> -----Original Message-----
> From: Casey Bodley [mailto:cbodley@gmail.com]
> Sent: Thursday, July 09, 2015 9:19 AM
> To: James (Fei) Liu-SSI
> Cc: Haomai Wang; ceph-devel@vger.kernel.org
> Subject: Re: About Fio backend with ObjectStore API
>
> Hi James,
>
> In the job file src/test/filestore.fio, you can modify the line "obje=
ctstore=3Dfilestore" to use any objectstore type supported by the
> ObjectStore::create() factory.
>
> Casey
>
> On Wed, Jul 8, 2015 at 8:02 PM, James (Fei) Liu-SSI <james.liu@ssi.sa=
msung.com> wrote:
>> Hi Casey,
>>   Quick questions, The code in the trunk only cover the test for fil=
estore. I was wondering do you have any plan to cover the test for kvst=
ore and newstore?
>>
>>   Thanks,
>>   James
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of James (Fei)
>> Liu-SSI
>> Sent: Tuesday, June 30, 2015 2:19 PM
>> To: Casey Bodley
>> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> Subject: RE: About Fio backend with ObjectStore API
>>
>> Hi Casey,
>>
>>   Thanks a lot.
>>
>>   Regards,
>>   James
>>
>> -----Original Message-----
>> From: Casey Bodley [mailto:cbodley@gmail.com]
>> Sent: Tuesday, June 30, 2015 2:16 PM
>> To: James (Fei) Liu-SSI
>> Cc: Haomai Wang; ceph-devel@vger.kernel.org
>> Subject: Re: About Fio backend with ObjectStore API
>>
>> Hi,
>>
>> When Danny Al-Gaaf & Daniel Gollub published "Ceph Performance
>> Analysis: fio and RBD" at
>> https://telekomcloud.github.io/ceph/2014/02/26/ceph-performance-anal=
ys
>> is_fio_rbd.html, they also mentioned a fio engine that linked direct=
ly
>> into ceph's FileStore. I was able to find Daniel's branch on github =
at https://github.com/gollub/ceph/tree/fio_filestore_v2, and did some m=
ore work on it at the time.
>>
>> I just rebased that work onto the latest ceph master branch, and pus=
hed to our github at https://github.com/linuxbox2/linuxbox-ceph/tree/fi=
o-objectstore. You can find the source in src/test/fio_ceph_filestore.c=
c, and run fio with the provided example fio job file in src/test/files=
tore.fio.
>>
>> I didn't have a chance to confirm that it builds with automake, but
>> the cmake version built for me. I'm happy to help if you run into
>> problems, Casey
>>
>> On Tue, Jun 30, 2015 at 2:31 PM, James (Fei) Liu-SSI <james.liu@ssi.=
samsung.com> wrote:
>>> Hi Haomai,
>>>   What are you trying to ask is to benchmark local objectstore(like=
 kvstore/filestore/newstore) locally with FIO(ObjectStore engine)? You =
want to purely compare the performance locally for these objectstores, =
right?
>>>
>>>   Regards,
>>>   James
>>>
>>> -----Original Message-----
>>> From: ceph-devel-owner@vger.kernel.org
>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Haomai Wang
>>> Sent: Tuesday, June 30, 2015 9:06 AM
>>> To: ceph-devel@vger.kernel.org
>>> Subject: About Fio backend with ObjectStore API
>>>
>>> Hi all,
>>>
>>> Long long ago, is there someone said about fio backend with Ceph Ob=
jectStore API? So we could use the existing mature fio facility to benc=
hmark ceph objectstore.
>>>
>>> --
>>> Best Regards,
>>>
>>> Wheat
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o
>>> info at  http://vger.kernel.org/majordomo-info.html
>>   {.n +       +%  lzwm  b =EB=A7=B2  r  y=C7=A9 =D7=AFzX     =DC=A8}=
   =C6=A0z &j:+v        zZ+  +zf   h   ~    i   z   w   ?    & )=DF=A2 =
f
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
