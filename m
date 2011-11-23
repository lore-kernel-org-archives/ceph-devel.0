From: Xiaofei Du <xiaofei.du008@gmail.com>
Subject: Re: Why Ceph's aggregate write throughput does not scale with the
 number of osd nodes
Date: Wed, 23 Nov 2011 15:47:31 -0800
Message-ID: <CAND_vCYnMhtvy-BpAWahujWakkYHd9q5brjBq2BvMfR62+D7CA@mail.gmail.com>
References: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
 <CAF3hT9AqbhPDrBmeymTvBO_FZp5FF2VmwyPeh_cQFFgsi-L96A@mail.gmail.com>
 <CAND_vCZTuOmq3LMJ7eqc8jtbc7Yv7e9YSqy6=cTwGtjBsZ+rfA@mail.gmail.com>
 <CAND_vCYXQQ4bokmAvV+Z46UT7_Pygd_h0kwXSch_r+HDg5W25Q@mail.gmail.com>
 <CAF3hT9AHSHf5Gd+9_AydBDWj2if01iNLjmQ5_PXLPna_-GwXQg@mail.gmail.com> <CAND_vCbSNbqL8faw0yAYp3guahexo7sAr0X1cQGS5rRZv=71xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:56718 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037Ab1KWXsE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Nov 2011 18:48:04 -0500
Received: by iage36 with SMTP id e36so2244930iag.19
        for <ceph-devel@vger.kernel.org>; Wed, 23 Nov 2011 15:48:03 -0800 (PST)
In-Reply-To: <CAND_vCbSNbqL8faw0yAYp3guahexo7sAr0X1cQGS5rRZv=71xw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

And the reading throughput could scale, which also shows IO bandwidth
should not be a problem.

Best,
Xiaofei

On Wed, Nov 23, 2011 at 3:44 PM, Xiaofei Du <xiaofei.du008@gmail.com> w=
rote:
>> I just want to make sure: each client is writing to a different file=
?
> Yes, each client is writing to a different file.
>
>> My first question is if you're sure that your EC2 cluster actually
>> provides more bandwidth than you're getting! We haven't tried Ceph o=
n
>> EC2 but I've heard elsewhere that the disk IO rates are pretty
>> atrocious. (Don't forget to account for replication =97 that 60MB is
>> actually 120MB of data going to disk, and 15MB/s per disk isn't out =
of
>> the realm of possibility in many cloud setups.)
>> If you don't have your own tools for measuring this, you can use the
>> built-in one described at
>> http://ceph.newdream.net/wiki/Troubleshooting#OSD_performance:
>> Watch the monitor output with ceph -w, then in a different window ru=
n:
>> ceph osd tell \* bench
>> Each OSD will write 1GB of data to disk and report it back (you'll s=
ee
>> it in the monitor output). Make sure those numbers are significantly
>> higher than the bandwidth you're seeing!
> I am sure both the network and disk IO bandwidth are not so bad. I di=
d
> test on HDFS on the same machines, the throughput is much higher. I
> just used ceph osd tell\* bench, and I got six osd nodes with 40~50
> MB/s. But two of the osds are a little bit slower. they are around 20
> MB/s. There is a sentence "The performance of a single OSD can bring
> down your whole cluster! " in the OSD performance section of the link
> you gave me. But I think two slower osds will only influence 1/4 of
> the overall throughput. But the test result showed me no scalability.
> And two slower disk IO would also influence HDFS throughput. But it
> showed scalability. So I think bandwidth is not a problem.
>
>>> Actually when I ls the ceph file system. it was very slow to give m=
e
>>> the result (There was only eight files, not tons of files). It seem=
ed
>>> like all the clients were competing for some resource. But the mon =
and
>>> mds resource usage almost equals to zero. That's reasonable because=
 I
>>> only have 8 osds and several clients. So this seems quite weird.
>> Well, ls is a slower operation on Ceph than many systems due to the
>> way it handles client capabilities. But this issue will be separate
>> from the one you're seeing above.
> The problem is when I don't do writing, the ls operation is fast. Whe=
n
> I was writing two files, the ls operation became quite slow. ls
> operation should not be so slow even I am writing the file. So I gues=
s
> maybe there are some resource contentions in it?
>
> In overall, do you know other causes for my problem? Or may be the ol=
d
> bugs still exist?
>
> Best,
> Xiaofei
>
> On Wed, Nov 23, 2011 at 1:04 PM, Gregory Farnum
> <gregory.farnum@dreamhost.com> wrote:
>> On Wed, Nov 23, 2011 at 12:07 PM, Xiaofei Du <xiaofei.du008@gmail.co=
m> wrote:
>>> Hi Greg,>> I installed Ceph on 10 ec2 instances. one for mon, one f=
or mds, and> the other eights are osds. I used IOZONE's distributed mea=
surement> mode (Multiple clients that are on different nodes and creati=
ng =A0same> type of workload in parallel) to test the scalability of Ce=
ph. The> problem is with the increase of the number of clients that was=
 doing> writing. the aggregate write throughput didn't scale up. For ex=
ample.> when I had only one client writing data to ceph, the throughput=
 was> around 60 MB/s. when I had 2 clients writing to two different fil=
es to> ceph, the throughput was still around 60MB/s. Same condition wit=
h 4> clients and 8 clients. And the Clients were all on different nodes=
=2E> But the aggregate reading throughput did scale up, which told us t=
hat> the data was distributed on different osds. Otherwise it wouldn't>=
 scale up with the number of the reading clients.
>> I just want to make sure: each client is writing to a different file=
?
>>
>> My first question is if you're sure that your EC2 cluster actually
>> provides more bandwidth than you're getting! We haven't tried Ceph o=
n
>> EC2 but I've heard elsewhere that the disk IO rates are pretty
>> atrocious. (Don't forget to account for replication =97=A0that 60MB =
is
>> actually 120MB of data going to disk, and 15MB/s per disk isn't out =
of
>> the realm of possibility in many cloud setups.)
>> If you don't have your own tools for measuring this, you can use the
>> built-in one described at
>> http://ceph.newdream.net/wiki/Troubleshooting#OSD_performance:
>> Watch the monitor output with ceph -w, then in a different window ru=
n:
>> ceph osd tell \* bench
>> Each OSD will write 1GB of data to disk and report it back (you'll s=
ee
>> it in the monitor output). Make sure those numbers are significantly
>> higher than the bandwidth you're seeing!
>>
>> There are a number of other problems you could be running into, but
>> actual disk IO limits (or possibly network troubles) is my suspicion
>> since we generally see that one client can push 100+MB/s of data. :)
>> On Wed, Nov 23, 2011 at 12:48 PM, Xiaofei Du <xiaofei.du008@gmail.co=
m> wrote:
>>> Actually when I ls the ceph file system. it was very slow to give m=
e
>>> the result (There was only eight files, not tons of files). It seem=
ed
>>> like all the clients were competing for some resource. But the mon =
and
>>> mds resource usage almost equals to zero. That's reasonable because=
 I
>>> only have 8 osds and several clients. So this seems quite weird.
>> Well, ls is a slower operation on Ceph than many systems due to the
>> way it handles client capabilities. But this issue will be separate
>> from the one you're seeing above.
>>
>
>
>
> --
> Xiaofei (Gregory) Du
> Department of Computer Science
> University of California, Santa Barbara
>



--=20
Xiaofei (Gregory) Du
Department of Computer Science
University of California, Santa Barbara
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
