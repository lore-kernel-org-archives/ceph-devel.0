From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Inline dedup/compression
Date: Fri, 21 Aug 2015 11:01:12 +0800
Message-ID: <CACJqLybk7OFcewX97rp+8h4z-XNBxhqOw_yCC_VF2O_S8hftjw@mail.gmail.com>
References: <99767EA2E27DD44DB4E9F9B9ACA458C03B319727@SSIEXCH-MB3.ssi.samsung.com>
	<CACJqLybMy1Tfr8baZMbv268gbmeBpG7uJuvbkrnQ9pjdn-AOvA@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B3198B4@SSIEXCH-MB3.ssi.samsung.com>
	<CACJqLyY2P0_O-MRs9MoH1oVg8jESc0EoAjSq4dYmVjH=K0a0mQ@mail.gmail.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319BBA@SSIEXCH-MB3.ssi.samsung.com>
	<9E914F5BD7F48A4782456CEB550A422824E8F967@SACMBXIP02.sdcorp.global.sandisk.com>
	<7334B4281E425749B85E08CF7EC6F85343783D7B@SACMBXIP03.sdcorp.global.sandisk.com>
	<9E914F5BD7F48A4782456CEB550A422824E8FABA@SACMBXIP02.sdcorp.global.sandisk.com>
	<99767EA2E27DD44DB4E9F9B9ACA458C03B319E3E@SSIEXCH-MB3.ssi.samsung.com>
	<9E914F5BD7F48A4782456CEB550A422824E9070A@SACMBXIP02.sdcorp.global.sandisk.com>
	<7334B4281E425749B85E08CF7EC6F853437877B7@SACMBXIP03.sdcorp.global.sandisk.com>
	<CACJqLyaRQU2oyja___jRAY7sidfbVM1XiYgpLVUSX-N8mH3aGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34198 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbbHUDBN convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Aug 2015 23:01:13 -0400
Received: by ykdt205 with SMTP id t205so58553289ykd.1
        for <ceph-devel@vger.kernel.org>; Thu, 20 Aug 2015 20:01:12 -0700 (PDT)
In-Reply-To: <CACJqLyaRQU2oyja___jRAY7sidfbVM1XiYgpLVUSX-N8mH3aGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Allen Samuels <Allen.Samuels@sandisk.com>
Cc: Chaitanya Huilgol <Chaitanya.Huilgol@sandisk.com>, "James (Fei) Liu-SSI" <james.liu@ssi.samsung.com>, ceph-devel <ceph-devel@vger.kernel.org>

sorry, should be this
blog(http://mysqlserverteam.com/innodb-transparent-page-compression/)

On Fri, Aug 21, 2015 at 10:51 AM, Haomai Wang <haomaiwang@gmail.com> wr=
ote:
> I found a blog(http://mysqlserverteam.com/innodb-transparent-pageio-c=
ompression/)
> about mysql innodb transparent compression. It's surprised that innod=
b
> will do it at low level(just like filestore in ceph) and rely it on
> filesystem file hole feature. I'm very suspect about the performance
> afeter storing lot's of *small* hole files on fs. If reliable, it
> would be easy that filestore/newstore impl alike feature.
>
> On Fri, Jul 3, 2015 at 1:13 PM, Allen Samuels <Allen.Samuels@sandisk.=
com> wrote:
>> For non-overwriting relatively large objects, this scheme works fine=
=2E Unfortunately the real use-case for deduplication is block storage =
with virtualized infrastructure (eliminating duplicate operating system=
 files and applications, etc.) and in order for this to provide good de=
duplication, you'll need a block size that's equal or smaller than the =
cluster-size of the file system mounted on the block device. Meaning th=
at your storage is now dominated by small chunks (probably 8K-ish) rath=
er than the relatively large 4M stripes that is used today (this will a=
lso kill EC since small objects are replicated rather than ECed). This =
will have a massive impact on backend storage I/O as the basic data/met=
adata ratio is complete skewed (both for static storage and dynamic I/O=
 count).
>>
>>
>> Allen Samuels
>> Software Architect, Emerging Storage Solutions
>>
>> 2880 Junction Avenue, Milpitas, CA 95134
>> T: +1 408 801 7030| M: +1 408 780 6416
>> allen.samuels@SanDisk.com
>>
>>
>> -----Original Message-----
>> From: Chaitanya Huilgol
>> Sent: Thursday, July 02, 2015 3:50 AM
>> To: James (Fei) Liu-SSI; Allen Samuels; Haomai Wang
>> Cc: ceph-devel
>> Subject: RE: Inline dedup/compression
>>
>> Hi James et.al ,
>>
>> Here is an example for clarity,
>> 1. Client Writes object  object.abcd
>> 2. Based on the crush rules, say  OSD.a is the primary OSD which rec=
eives the write 3. OSD.a  performs segmenting/fingerprinting which can =
be static or dynamic and generates a list of segments, the object.abcd =
is now represented by a manifest object with the list of segment hash a=
nd len  [Header]  [Seg1_sha, len]  [Seg2_sha, len]  ...
>>  [Seg3_sha, len]
>> 4. OSD.a writes each segment as a new object in the cluster with obj=
ect name  <reserved_dedupe_perfix><sha> 5. The dedupe object write is t=
reated differently from regular object writes, If the object is present=
 then an object reference count is incremented and the object is not ov=
erwritten - this forms the basis of the dedupe logic. Multiple objects =
with one or more same constituent segments start sharing the segment ob=
jects.
>> 6. Once all the segments are successfully written the object 'object=
=2Eabcd' is now just a stub object with the segment manifest as describ=
ed above and is goes through a regular object write sequence
>>
>> Partial writes on objects will be complicated,
>> - Partially affected segments will have to be read and segmentation =
logic has to be run from first to last affected segment boundaries
>> -  New segments will be written
>> - Old overwritten segments have to be deleted
>> - Write merged manifest of the object
>>
>> All this will need protection of the PG lock, Also additional journa=
ling mechanism will be needed to  recover from cases where the osd goes=
 down before writing all the segments.
>>
>> Since this is quite a lot of processing, a better use case for this =
dedupe mechanism would be in the data tiering model with object redirec=
ts.
>> The manifest object fits quiet well into object redirects scheme of =
things, the idea is that, when an object is moved out of the base tier,=
 you have an option to create a dedupe stub object and write individual=
 segments into the cold backend tier with a rados plugin.
>>
>> Remaining responses inline.
>>
>> Regards,
>> Chaitanya
>>
>> -----Original Message-----
>> From: James (Fei) Liu-SSI [mailto:james.liu@ssi.samsung.com]
>> Sent: Wednesday, July 01, 2015 4:00 AM
>> To: Chaitanya Huilgol; Allen Samuels; Haomai Wang
>> Cc: ceph-devel
>> Subject: RE: Inline dedup/compression
>>
>> Hi Chaitanya,
>>    Very interesting thoughts. I am not sure whether I get all of the=
m or now. Here are several questions for the solution you provided, Mig=
ht be a little bit detailed.
>>
>>     Regards,
>>     James
>>
>> - Dedupe is set as a pool property
>> Write:
>> - Write arrives at the primary OSD/pg
>> [James] Does the OSD/PG mean PG Backend over here?
>> [Chaitanya] I mean the Primary OSD and the PG which get selected by =
the crush - not the specific OSD component
>>
>> - Data is segmented (rabin/static) and secure hash computed [James] =
Which component in OSD are you going to do the data segment and hash co=
mputation?
>> [Chaitanya] If partial writes are not supported then this could be d=
own before acquiring the PG lock, else we need the protection of the PG=
 lock.  Probably in the do_request() path?
>>
>> - A manifest is created with the offset/len/hash for all the segment=
s [James] The manifest is going to be part of xattr of object? Where ar=
e you going to save manifest?
>> [Chaitanya] The manifest is a stub object with the constituent segme=
nts list
>>
>> - OSD/pg sends rados write with a special name <__known__prefix><sec=
ure hash> for all segments [James] What's your meaning of Rados Wirte? =
 Where do the all segments with secure hash signature write to?
>> [Chaitanya] All segments are unique objects with the above mentioned=
 naming scheme, they get written back into the cluster as a regular cli=
ent rados object write
>>
>> - PG receiving dedup write will:
>>         1. check for object presence and create object if not presen=
t
>>         2. If object is already present, then an reference count is =
incremented (check and increment needs to be atomic) [James] It makes s=
ense. But I was wondering the unit for dedupe is segment or object? If =
object base, it totally make sense. However, why we need to have segmen=
t with manifest?
>>
>> - Response is received by original primary PG for all segments [Jame=
s] What response?
>> [Chaitanya] Write response indicating the status of the segment obje=
ct write
>>
>> - Primary PG writes the manifest to local and replicas or EC members=
 [James] How about the dedupe data if the data is not present in replic=
as?
>> [Chaitanya] I am sorry, I did not get your question, the manifest ob=
ject gets written in the primary and the replicas or encoded and writte=
n to the EC members, it is afforded the protection policy set for the p=
ool. Same is the case with the individual constituent segments.
>>
>> - Response sent to client
>>
>> Read:
>> - Read received at primary PG
>> [James]  The read can only fetch data from Primary PG?
>> - Reads manifest object
>>
>> - sends reads for each segment object <__know_prefix><secure hash>
>> - coalesces all the response to build the required data
>> - Responds to client
>>
>>
>> Pros:
>> No need of centralized hash index so inline with ceph no bottleneck =
philosophy
>>
>> Cons:
>> Some PGs may get overloaded due to frequently occurring segment patt=
erns Latency and increased traffic on the network
>>
>>
>>
>> -----Original Message-----
>> From: Chaitanya Huilgol [mailto:Chaitanya.Huilgol@sandisk.com]
>> Sent: Tuesday, June 30, 2015 8:50 AM
>> To: Allen Samuels; James (Fei) Liu-SSI; Haomai Wang
>> Cc: ceph-devel
>> Subject: RE: Inline dedup/compression
>>
>>
>> - Reference count has to be maintained as an attribute of the object
>> - As mentioned in the write workflow, duplicate segment writes incre=
ment the reference count
>> - Object Delete would result in delete on constituent segments liste=
d in the object segment manifest
>> - Segment object delete will decrement reference count and remove th=
e segment when there are no more references present
>>
>> Regards,
>> Chaitanya
>>
>> -----Original Message-----
>> From: Allen Samuels
>> Sent: Tuesday, June 30, 2015 9:02 PM
>> To: Chaitanya Huilgol; James (Fei) Liu-SSI; Haomai Wang
>> Cc: ceph-devel
>> Subject: RE: Inline dedup/compression
>>
>> This covers the read and write, what about the delete? One of the ma=
jor issues with Dedupe, whether global or local is to address the inher=
ent ref-counting associated with sharing of pieces of storage.
>>
>> Allen Samuels
>> Software Architect, Emerging Storage Solutions
>>
>> 2880 Junction Avenue, Milpitas, CA 95134
>> T: +1 408 801 7030| M: +1 408 780 6416
>> allen.samuels@SanDisk.com
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger=
=2Ekernel.org] On Behalf Of Chaitanya Huilgol
>> Sent: Monday, June 29, 2015 11:20 PM
>> To: James (Fei) Liu-SSI; Haomai Wang
>> Cc: ceph-devel
>> Subject: RE: Inline dedup/compression
>>
>> Below is an alternative idea at a very high level around dedup with =
ceph without a need of centralized hash index,
>>
>> - Dedupe is set as a pool property
>> Write:
>> - Write arrives at the primary OSD/pg
>> - Data is segmented (rabin/static) and secure hash computed
>> - A manifest is created with the offset/len/hash for all the segment=
s
>> - OSD/pg sends rados write with a special name <__known__prefix><sec=
ure hash> for all segments
>> - PG receiving dedup write will:
>>         1. check for object presence and create object if not presen=
t
>>         2. If object is already present, then an reference count is =
incremented (check and increment needs to be atomic)
>> - Response is received by original primary PG for all segments
>> - Primary PG writes the manifest to local and replicas or EC members
>> - Response sent to client
>>
>> Read:
>> - Read received at primary PG
>> - Reads manifest object
>> - sends reads for each segment object <__know_prefix><secure hash>
>> - coalesces all the response to build the required data
>> - Responds to client
>>
>>
>> Pros:
>> No need of centralized hash index so inline with ceph no bottleneck =
philosophy
>>
>> Cons:
>> Some PGs may get overloaded due to frequently occurring segment patt=
erns Latency and increased traffic on the network
>>
>> Regards,
>> Chaitanya
>>
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger=
=2Ekernel.org] On Behalf Of James (Fei) Liu-SSI
>> Sent: Tuesday, June 30, 2015 2:25 AM
>> To: Haomai Wang
>> Cc: ceph-devel
>> Subject: RE: Inline dedup/compression
>>
>> Hi Haomai,
>>   Thanks for moving the idea forward. Regarding to the compression. =
 However,  if we do compression on the client level, it is not global. =
And the compression was only applied to the local client, am I right?  =
I think there is pros and cons in two solutions and we can get into det=
ails more for each solution.
>>   I really like your idea for dedupe in OSD side   by the way. Let m=
e think more about it.
>>
>>  Regards,
>>  James
>>
>> -----Original Message-----
>> From: Haomai Wang [mailto:haomaiwang@gmail.com]
>> Sent: Friday, June 26, 2015 8:55 PM
>> To: James (Fei) Liu-SSI
>> Cc: ceph-devel
>> Subject: Re: Inline dedup/compression
>>
>> On Sat, Jun 27, 2015 at 2:03 AM, James (Fei) Liu-SSI <james.liu@ssi.=
samsung.com> wrote:
>>> Hi Haomai,
>>>   Thanks for your response as always. I agree compression is compar=
able easier task but still very challenge in terms of implementation no=
 matter where we should implement . Client side like RBD, or RDBGW or C=
ephFS, or PG should be a little bit better place to implementation in t=
erms of efficiency and cost reduction before the data were duplicated t=
o other OSDs. It has  two reasons :
>>> 1. Keep the data consistency among OSDs in one PG 2. Saving the
>>> computing resources
>>>
>>> IMHO , The compression should be accomplished before the replicatio=
n come into play in pool level. However, we can also have second level =
of compression in the local objectstore.  In term of unit size of compr=
ession , It really depends workload and in which layer we should implem=
ent.
>>>
>>> About inline deduplication, it will dramatically increase the compl=
exities if we bring in the replication and Erasure Coding for considera=
tion.
>>>
>>> However, Before we talk about implementation, It would be great if =
we can understand the pros and cons to implement inline dedupe/compress=
ion. We all understand the benefits of dedupe/compression. However, the=
 side effect is performance hurt and need more computing resources. It =
would be great if we can understand the problems from 30,000 feet high =
for the whole picture about the Ceph. Please correct me if I were wrong=
=2E
>>
>> Actually we may have some tricks to reduce performance hurt like com=
pression. As Joe mentioned, we can compress slave pg data to avoid perf=
ormance hurt, but it may increase the complexity of recovery and pg rem=
ap things. Another in-detail implement way if we begin to compress data=
 from messenger, osd thread and pg thread won't access data for normal =
client op, so maybe we can make it parallel with pg process. Journal th=
read will get the compressed data at last.
>>
>> The effect of compression also is a concern, we do compression in ra=
dos may not get the best compression result. If we can do compression i=
n libcephfs, librbd and radosgw and make rados unknown to compression, =
it maybe simpler and we can get file/block/object level compression. it=
 should be better?
>>
>> About dedup, my current idea is we could setup a memory pool at osd =
side for checksum store usage. Then we calculate object data and map to=
 PG instead of object name at client side, so a object could always in =
a osd where it's also responsible for dedup storage. It also could be d=
istributed at pool level.
>>
>>
>>>
>>> By the way, Both of software defined storage solution startups like=
 Hdevig and Springpath provide inline dedupe/compression.  It is not ap=
ple to apple comparison. But it is good reference. The datacenters need=
 cost effective solution.
>>>
>>> Regards,
>>> James
>>>
>>>
>>>
>>> -----Original Message-----
>>> From: Haomai Wang [mailto:haomaiwang@gmail.com]
>>> Sent: Thursday, June 25, 2015 8:08 PM
>>> To: James (Fei) Liu-SSI
>>> Cc: ceph-devel
>>> Subject: Re: Inline dedup/compression
>>>
>>> On Fri, Jun 26, 2015 at 6:01 AM, James (Fei) Liu-SSI <james.liu@ssi=
=2Esamsung.com> wrote:
>>>> Hi Cephers,
>>>>     It is not easy to ask when Ceph is going to support inline ded=
up/compression across OSDs in RADOS because it is not easy task and ans=
wered. Ceph is providing replication and EC for performance and failure=
 recovery. But we also lose the efficiency  of storage store and cost a=
ssociate with it. It is kind of contradicted with each other. But I am =
curious how other Cephers think about this question.
>>>>    Any plan for Cephers to do anything regarding to inline dedupe/=
compression except the features brought by local node itself like BRTFS=
?
>>>
>>> Compression is easier to implement in rados than dedup. The most im=
portant thing about compression is where we begin to compress, client, =
pg or objectstore. Then we need to decide how much the compress unit is=
=2E Of course, compress and dedup both like to use keyvalue-alike stora=
ge api to use, but I think it's not difficult to use existing objectsto=
re api.
>>>
>>> Dedup is more possible to implement in local osd instead of the who=
le pool or cluster, and if we want to do dedup for the pool level, we n=
eed to do dedup from client.
>>>
>>>>
>>>>   Regards,
>>>>   James
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el"
>>>> in the body of a message to majordomo@vger.kernel.org More majordo=
mo
>>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>>
>>> --
>>> Best Regards,
>>>
>>> Wheat
>>
>>
>>
>> --
>> Best Regards,
>>
>> Wheat
>>    =EC=B9=BB  & ~ &    +-  =DD=B6   w  =CB=9B   m    ^  b  ^n r   z =
   h    &    G   h  ( =E9=9A=8E =DD=A2j"     m     z =DE=96   f   h   ~=
 m
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail messa=
ge is intended only for the use of the designated recipient(s) named ab=
ove. If the reader of this message is not the intended recipient, you a=
re hereby notified that you have received this message in error and tha=
t any review, dissemination, distribution, or copying of this message i=
s strictly prohibited. If you have received this communication in error=
, please notify the sender by telephone or e-mail (as shown above) imme=
diately and destroy any and all copies of this message in your possessi=
on (whether hard copies or electronically stored copies).
>>
>> N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +   z ]z   {ay  =CA=87=DA=99 =
,j   f   h   z   w       j:+v   w j m         zZ+     =DD=A2j"  ! i
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
