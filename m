From: sheng qiu <herbert1984106@gmail.com>
Subject: Re: some performance issue
Date: Mon, 4 Feb 2013 11:15:19 -0600
Message-ID: <CAB7xdinzWjS7PfWCf+3HLby7DYVr4Yz21C1WLV6Fa=6CwzjTOA@mail.gmail.com>
References: <CAB7xdinwhd6gmqbzeC7Gp+ugDbJhOcr1TwX-1KYg5=geWbT0+g@mail.gmail.com>
	<510C2F49.8010401@inktank.com>
	<CAB7xdi=y-n0P=vptiO-LvRUF7pcuqe1gJVwRtDkWbi+K7U=u8Q@mail.gmail.com>
	<6F3FA899187F0043BA1827A69DA2F7CC5ECFFC@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:53624 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753176Ab3BDRPU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Feb 2013 12:15:20 -0500
Received: by mail-ie0-f180.google.com with SMTP id bn7so4949208ieb.39
        for <ceph-devel@vger.kernel.org>; Mon, 04 Feb 2013 09:15:19 -0800 (PST)
In-Reply-To: <6F3FA899187F0043BA1827A69DA2F7CC5ECFFC@SHSMSX102.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Xiaoxi,

thanks for your reply.

On Mon, Feb 4, 2013 at 10:52 AM, Chen, Xiaoxi <xiaoxi.chen@intel.com> w=
rote:
> I doubt your data is correct ,even the ext4 data, have you use O_DIRE=
CT when doing the test? It's unusual to have 2X random write IOPS than =
random read.
>

 i did not use O_DIRECT. so page cache is used during the test.
one thing i guess why random write is better than random read is that
since the io request size is 4KB, so for each write request if miss on
page cache, it will allocate a new page and write the complete 4KB
dirty data there (since no partitional writes, no need to fetch the
missed data from OSDs). While for read requests, it has to wait until
the data are fetched from the OSDs.

> CephFS kernel client seems not stable enough, think twice before you =
use it.
> From your previous mail I guess you would like to do some caching or =
dynamic tiring ,introducing ssd into DFS for better performance. There =
are a lot of layer you can do such kind of caching or migration, you ca=
n cache on client side , or do as sage said ,having a disk pool and a s=
sd pool then migrate data between them, or you can cache inside OSD.
> We are also interested in similar research. But it's still WIP.

i think ceph's CRUSH already support that which can create multiple
rulesets and specified for HDD pools or SSD pools. So there is not
much research work there.
Hybrid drive for individual OSD is also not new, many research work
proposed hybrid drive management.
Thanks a lot for your suggestions.

Sheng

>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of sheng qiu
> Sent: 2013=E5=B9=B42=E6=9C=884=E6=97=A5 23:37
> To: Mark Nelson
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: some performance issue
>
> Hi Mark,
>
> thanks a lot for your reply.
>
> On Fri, Feb 1, 2013 at 3:10 PM, Mark Nelson <mark.nelson@inktank.com>=
 wrote:
>> On 02/01/2013 02:20 PM, sheng qiu wrote:
>>>
>>> Hi,
>>>
>>> i did one experiment which gives some interesting result.
>>>
>>> i create two OSD (ext4), each is a SSD attached on the same PC. i
>>> also configure one monitor and one mds on that PC.
>>> so generally, my OSDs, monitor and mds locate on the same node.
>>>
>>> i set up the ceph service and mount the ceph also on a local
>>> directory on that PC. so client, OSDs, monitor and mds all on the s=
ame node.
>>> i suppose this will exclude the network communication cost.
>>>
>>> i run fio benchmark which create one 10GB file (larger than main
>>> memory) on the ceph mount point. it perform sequential read/write a=
nd
>>> random read/write on the file, and generate the throughput result.
>>>
>>> next i umount the ceph and stop ceph service. i create ext4 on the
>>> same SSD that used as OSD before. then run the same workloads and g=
et
>>> the throughput result.
>>>
>>> here are the results:
>>>
>>> (throughput kb/s)Seq-read       Rand-read       Seq-write       Ran=
d-write
>>> ceph                     7378   4740               790  1211
>>> ext4                     58260  17334    54697  34257
>>>
>>> as you see, the ceph has huge performance down, even monitor, mds,
>>> client and osds locate on the same physical machine.
>>> another interesting thing is the seq-write has lower throughput
>>> compared with random-write under ceph. not quite clear....
>>>
>>> does anyone have idea about why ceph has that performance down?
>>
>>
>> Hi Sheng,
>>
>> Are you using RBD or CephFS (and kernel or userland clients?)  How
>> much replication?  Also, what FIO settings?
>>
>
>    i am using CephFS and kernel clients. the replication is by defaul=
t (3?). the FIO is using the ssd-test script, IO request size is 4kb.
>
>> In general, it is difficult to make distributed storage systems
>> perform as well as local storage for small read/write workloads.  Yo=
u
>> need a lot of concurrency to hide the latencies, and if the local
>> storage is incredibly fast (like an SSD!) you have a huge uphill bat=
tle.
>>
>> Regarding the network, Even though you ran everything on localhost,
>> ceph is still using TCP sockets to do all of the communication.
>>
>
>    i guess when it checked the remote ip is actually the local addres=
s, it will directly patch the send packets to the receive buffer. right=
?
>
>> Having said that, I think we can do better than 790 IOPs for seq
>> writes, even if it's 2x replication.  The trick is to find where in
>> the stack things are getting held up.  You might want to look at too=
ls
>> like iostat and collectl, and look at some of the op latency data in=
 the ceph admin socket.
>> A basic introduction is described in sebastian's article here:
>>
>> http://www.sebastien-han.fr/blog/2012/08/14/ceph-admin-socket/
>>
>>>
>>> Thanks,
>>> Sheng
>>>
>>>
>>
>
> I would try your suggestion to find where the bottleneck is.
> the reason i did this experiment is just trying to find some potentia=
l issues with ceph. i am a Ph.d. student and trying to do some research=
 work on it.
> i would be happy to hear your suggestions.
>
> Thanks,
> Sheng
>
> --
> Sheng Qiu
> Texas A & M University
> Room 332B Wisenbaker
> email: herbert1984106@gmail.com
> College Station, TX 77843-3259
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in the body of a message to majordomo@vger.kernel.org More majordomo i=
nfo at  http://vger.kernel.org/majordomo-info.html



--=20
Sheng Qiu
Texas A & M University
Room 332B Wisenbaker
email: herbert1984106@gmail.com
College Station, TX 77843-3259
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
