From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: Adding flashcache for data disk to cache Ceph metadata writes
Date: Tue, 15 Jan 2013 22:38:53 -0600
Message-ID: <50F62EDD.8000503@inktank.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC5DED31@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52677 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758538Ab3APEi5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 23:38:57 -0500
Received: by mail-ie0-f170.google.com with SMTP id k10so1723018iea.1
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 20:38:57 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5DED31@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Xiaoxi,

That's fantastic!  This is really exciting!  Congrats on getting this
working.  Once I have free time again I will try to replicate your
findings.  Again, great job!

Mark

On 01/15/2013 10:00 PM, Chen, Xiaoxi wrote:
> Hi List,
> 	I have introduced flashcache (https://github.com/facebook/flashcache=
) aim at reduce Ceph metadata IOs to OSD's disk. Basically, for every d=
ata writes, ceph need to write 3 things:
> Pg log
> Pg info
> Actual data
> 	First 2 requests are small, but for non-btrfs filesystem, the first =
2 writes will results OSD disk to do 2 seeks, it's critical to spindle-=
disk's throughput as mentioned in earlier mail.
>=20
> 	I list the detail of my experiment , any inputs is highly appreciate=
=2E
>=20
> 	[Setup]
> 	2 Host, 1 SSD with 1 SATA disk, SSD is partitioned into 4 partitions=
=2E P1 as OSD Journal, P2 as FlashCache for sata. P3 used as XFS metada=
ta journal.
> 	1 Client,1 RBD Volume created and mounted
> 	[FlashCache setup]
> 		[Create cached device]
> 			flashcache_create -v -p back fsdc /dev/sda2 /dev/sdc
> 		[Create filesystem]
> 			mkfs.xfs -f -i size=3D2048 -d agcount=3D1 -l logdev=3D/dev/sda3,si=
ze=3D128m /dev/mapper/fsdc
> 		[Mount]
> 			mount -o logdev=3D/dev/sda3 -o logbsize=3D256k -o delaylog -o inod=
e64 /dev/mapper/fsdc /data/osd.21/
> 		[Tuning]
> 			sysctl dev.flashcache.sda9+sdc.skip_seq_thresh_kb=3D32
> 		=09
> 			Since I am aiming to cache only ceph metadata and the metadata wri=
tes are very small, so I configured flashcache to skip all sequential w=
rite larger than 32K. Basically you can set this to 1K because the 			m=
eta writes are all less than 1K. I set it to 32K just for a quick test.
> 	[Experiment]
> 		Doing dd from the client on top of the RBD Volume
> 	[Result]
> 		Throughput boost from 37MB/s to ~ 90MB/s, since the flashcache work=
ing in DM level, it's transparent to Ceph.
>=20
> 	My test is just a quick test, further test (include sequential R/W,r=
andom R/W) are in schedule. Will come back with you if there are some p=
rogress.
> 			=09
> 																																					Xiaoxi
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com]
> Sent: 2013=C4=EA1=D4=C216=C8=D5 5:43
> To: Chen, Xiaoxi
> Cc: Mark Nelson; Yan, Zheng
> Subject: RE: Seperate metadata disk for OSD
>=20
> On Tue, 15 Jan 2013, Chen, Xiaoxi wrote:
>> Hi Sage,
>> 	FlashCache works well for this scenarios, I created a hybrid-disk w=
ith 1 ssd partition(shared the same ssd but different patition with Cep=
h journal and XFS journal) and 1 sata disk.Configured the FlashCache to=
 ignore all sequential request larger than 32K(Well, it can be set to a=
 smaller number).
>> 	The results shows a comparable performance with CephMeta-to-ssd sol=
ution.
>> 	Since flashcache working in the DM layer , I suppose it's transpare=
nt
>> to Ceph, right?
>=20
> Right.  That's great to hear that it works well.  If you don't mind, =
it would be great if you could report the same thing to ceph-devel with=
 a bit of detail about how you configured FlashCache so that others can=
 do the same.
>=20
> Thanks!
> sage
>=20
>=20
>> 																									Xiaoxi
>>
>> -----Original Message-----
>> From: Sage Weil [mailto:sage@inktank.com]
>> Sent: 2013?1?15? 2:19
>> To: Chen, Xiaoxi
>> Cc: Mark Nelson; Yan, Zheng ; ceph-devel@vger.kernel.org
>> Subject: RE: Seperate metadata disk for OSD
>>
>> On Mon, 14 Jan 2013, Chen, Xiaoxi wrote:
>>> Hi Sage,
>>>      Thanks for your mail~
>>> 	Would you have a timetable about when such improvement can be read=
y?It's critical for non-btrfs filesystem.
>>> 	I am thinking about introducing flashcache into my configuration t=
o cache such meta write, since flashcache working under the filesystem,=
 I suppose it will not break the assumption inside Ceph. I will try it =
on tomorrow and come back with you ~
>>> 	Thanks again for the helps!
>>
>> I think avoiding the pginfo change may be pretty simple.  The log on=
e I am a bit less concerned about (the appends from many rbd IOs will g=
et aggregated into a small number of XFS IOs), and changing that around=
 would be a bigger deal.
>>
>> sage
>>
>>
>>> 																								Xiaoxi
>>>
>>> -----Original Message-----
>>> From: Sage Weil [mailto:sage@inktank.com]
>>> Sent: 2013?1?13? 0:57
>>> To: Chen, Xiaoxi
>>> Cc: Mark Nelson; Yan, Zheng ; ceph-devel@vger.kernel.org
>>> Subject: RE: Seperate metadata disk for OSD
>>>
>>> On Sat, 12 Jan 2013, Chen, Xiaoxi wrote:
>>>> Hi Zheng?
>>>> 	I have put XFS log to a separate disk, indeed it provide some per=
formance gain but not that significant.
>>>> 	Ceph's metadata is somehow separate(it's some files reside in OSD=
's disk), therefore,it cannot be helped by neither XFS journal log nor =
OSD's journal.That's why I am trying to put ceph's metadata(/data/osd.x=
/meta folder ) to a separate SSD disk.
>>>> To Nelson,
>>>> 	I did the experiment with just 1 client, if using more clients, t=
he gain will not be that much.
>>>> 	It looks to me that a single write from client side become 3 writ=
es to disk is somehow a big overhead for in-place-update filesystem suc=
h like XFS since it introduce more seeks.Out-of-place-update filesystem=
 will not suffer a lot for such pattern,I didn?t find this problem when=
 I using BTRFS as backend filesystem. But forBTRFS, fragmentation is an=
other performance killer, for a single RBD volume, if you did a lot of =
random write on it, the sequential read performance will drop to 30% of=
 a new RBD volume. This make BTRFS unusable in production.
>>>> 	Separate Ceph meta seems quite easy to me ( I just mount a partit=
ion to /data/osd.X/meta), is it right  ? is there any potential problem=
 in it?
>>>
>>> Unfortunately, yes.  The ceph journal and fs sync are carefully tim=
ed.
>>> The ceph-osd assumes that syncfs(2) on the $osd_data/current/commit=
_op_seq file will sync everything, but if meta/ is another fs that isnt=
 true.  At the every least, the code needs to be modified to sync that =
as well.
>>>
>>> That said, there is a lot of improvement that can be had here.  The=
 three things we write are:
>>>
>>>   the pg log
>>>   the pg info, spread across the pg dir xattr and that pginfo file
>>> the actual io
>>>
>>> The pg log could go in leveldb, which would translate those writes =
into a single sequential stream across the entire OSD.  And the PG info=
 separate between the xattr and the file is far from optimal: most of t=
hat data doesn't actually change on each write.  What little does is ve=
ry small, and could be moved into the xattr, avoiding touching the file=
 (which means an inode + data block write) at all.
>>>
>>> We need to look a bit more closely to see how difficult that will r=
eally be to implement, but I think it is promising!
>>>
>>> sage
>>>
>>>
>>>>
>>>> 																														Xiaoxi -----Original Message-----
>>>> From: Mark Nelson [mailto:mark.nelson@inktank.com]
>>>> Sent: 2013?1?12? 21:36
>>>> To: Yan, Zheng
>>>> Cc: Chen, Xiaoxi; ceph-devel@vger.kernel.org
>>>> Subject: Re: Seperate metadata disk for OSD
>>>>
>>>> Hi Xiaoxi and Zheng,
>>>>
>>>> We've played with both of these some internally, but not for a pro=
duction deployment. Mostly just for diagnosing performance problems.
>>>>    It's been a while since I last played with this, but I hadn't s=
een a whole lot of performance improvements at the time.  That may have=
 been due to the hardware in use, or perhaps other parts of Ceph have i=
mproved to the point where this matters now!
>>
>>>>
>>>> On a side note, Btrfs also had a google summer of code project to =
let you put metadata on an external device.  Originally I think that wa=
s supposed to make it into 3.7, but am not sure if that happened.
>>>>
>>>> Mark
>>>>
>>>> On 01/12/2013 06:21 AM, Yan, Zheng wrote:
>>>>> On Sat, Jan 12, 2013 at 2:57 PM, Chen, Xiaoxi <xiaoxi.chen@intel.=
com> wrote:
>>>>>>
>>>>>> Hi list,
>>>>>>           For a rbd write request, Ceph need to do 3 writes:
>>>>>> 2013-01-10 13:10:15.539967 7f52f516c700 10
>>>>>> filestore(/data/osd.21) _do_transaction on 0x327d790
>>>>>> 2013-01-10 13:10:15.539979 7f52f516c700 15
>>>>>> filestore(/data/osd.21) write meta/516b801c/pglog_2.1a/0//-1
>>>>>> 36015~147
>>>>>> 2013-01-10 13:10:15.540016 7f52f516c700 15
>>>>>> filestore(/data/osd.21)
>>>>>> path:
>>>>>> /data/osd.21/current/meta/DIR_C/pglog\u2.1a__0_516B801C__none
>>>>>> 2013-01-10 13:10:15.540164 7f52f516c700 15
>>>>>> filestore(/data/osd.21) write meta/28d2f4a8/pginfo_2.1a/0//-1
>>>>>> 0~496
>>>>>> 2013-01-10 13:10:15.540189 7f52f516c700 15
>>>>>> filestore(/data/osd.21)
>>>>>> path:
>>>>>> /data/osd.21/current/meta/DIR_8/pginfo\u2.1a__0_28D2F4A8__none
>>>>>> 2013-01-10 13:10:15.540217 7f52f516c700 10
>>>>>> filestore(/data/osd.21) _do_transaction on 0x327d708
>>>>>> 2013-01-10 13:10:15.540222 7f52f516c700 15
>>>>>> filestore(/data/osd.21) write
>>>>>> 2.1a_head/8abf341a/rb.0.106e.6b8b4567.0000000002d3/head//2
>>>>>> 3227648~524288
>>>>>> 2013-01-10 13:10:15.540245 7f52f516c700 15
>>>>>> filestore(/data/osd.21)
>>>>>> path:
>>>>>> /data/osd.21/current/2.1a_head/rb.0.106e.6b8b4567.0000000002d3__
>>>>>> he
>>>>>> ad
>>>>>> _8
>>>>>> ABF341A__2
>>>>>> l
>>>>>>           If using XFS as backend file system and running xfs on=
 top of traditional sata disk, it will introduce a lot of seeks and the=
refore reduce bandwidth, a blktrace is available here :( http://ww3.sin=
aimg.cn/mw690/6e1aee47jw1e0qsbxbvddj.jpg) to demonstrate this issue.( s=
ingle client running dd on top of a new RBD volumes).
>>>>>>           Then I tried to move /osd.X/current/meta to a separate=
 disk, the bandwidth boosted.(look blktrace at http://ww4.sinaimg.cn/mw=
690/6e1aee47jw1e0qsadz1bij.jpg).
>>>>>>           I haven't test other access pattern or something else,=
 but it looks to me that moving such meta to a separate disk (ssd or sa=
ta with btrfs) will benefit ceph write performance, is it true? Will ce=
ph introduce this feature in the future?  Is there any potential proble=
m for such hack?
>>>>>>
>>>>>
>>>>> Did you try putting XFS metadata log a separate and fast device
>>>>> (mkfs.xfs -l logdev=3D/dev/sdbx,size=3D10000b). I think it will
>>>>> boost performance too.
>>>>>
>>>>> Regards
>>>>> Yan, Zheng
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
>>>>> in the body of a message to majordomo@vger.kernel.org More
>>>>> majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> N????y????b?????v?????{.n??????z??ay????????j ???f????????????????=
:+v???????? ??zZ+??????"?!?
>>> N????y????b?????v?????{.n??????z??ay????????j ???f????????????????:=
+v???????? ??zZ+??????"?!?
>>
> N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7v=D8^=81=7F)=DE=BA=
{.n=81=7F+=89=B7=9Cz=98]z=F7=A5=8A{ay=81=7F=1D=CA=87=DA=99=81=7F,j=07=AD=
=A2f=A3=A2=B7h=9A=8B=E0z=81=7F=1E=AEw=A5=A2=81=7F=0C=A2=B7=A6j:+v=89=A8=
=8Aw=E8j=D8m=B6=9F=81=7F=81=7F=07=AB=91=EA=E7zZ+=83=F9=9A=8E=8A=DD=A2j"=
=9D=FA!tml=3D
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
