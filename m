From: Xiaofei Du <xiaofei.du008@gmail.com>
Subject: Re: Why Ceph's aggregate write throughput does not scale with the
 number of osd nodes
Date: Thu, 24 Nov 2011 11:32:58 -0800
Message-ID: <CAND_vCZZjvmKYw7dfiqv_geY-upKLNAz_JVZ0_yr5aKQ6x_jKw@mail.gmail.com>
References: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
 <CAF3hT9AqbhPDrBmeymTvBO_FZp5FF2VmwyPeh_cQFFgsi-L96A@mail.gmail.com>
 <CAND_vCZTuOmq3LMJ7eqc8jtbc7Yv7e9YSqy6=cTwGtjBsZ+rfA@mail.gmail.com>
 <CAND_vCYXQQ4bokmAvV+Z46UT7_Pygd_h0kwXSch_r+HDg5W25Q@mail.gmail.com>
 <CAF3hT9AHSHf5Gd+9_AydBDWj2if01iNLjmQ5_PXLPna_-GwXQg@mail.gmail.com>
 <CAND_vCbSNbqL8faw0yAYp3guahexo7sAr0X1cQGS5rRZv=71xw@mail.gmail.com> <CAF3hT9DsujHNTBiAc=Fm2Vu=FsKBSW4nouwg0QPa73kfHF0mtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42083 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab1KXTd3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Nov 2011 14:33:29 -0500
Received: by ggnr5 with SMTP id r5so2859972ggn.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Nov 2011 11:33:29 -0800 (PST)
In-Reply-To: <CAF3hT9DsujHNTBiAc=Fm2Vu=FsKBSW4nouwg0QPa73kfHF0mtg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

> Unfortunately, that is the problem. Don't forget that Ceph is writing
> everything twice, and it's synchronous replication. 50% of your writes
> have to wait on those 20MB/s nodes to finish saving the data to disk.
> (I believe HDFS uses async replication.) Plus because it's journaling,
> all data gets written twice on each OSD. Reads go much faster because
> they only hit the slow OSDs for 25% of operations, and are often
> served out of memory.
> We haven't yet gotten around to working out ways of automatically
> handling this situation, but there are a few things you can do:
> 1) Remove the bad nodes from your cluster. Your performance should go
> up by a lot.
> 2) Change the weight of the slow nodes so they get a lower percentage
> of writes compared to the other nodes. (The default is 1.)
> http://ceph.newdream.net/wiki/Monitor_commands#reweight
It is not 50%. It is still 25% of the writes need to wait for the 2
slow nodes no matter how many replication it has to write or
journaling. And even though two nodes are slower than the others. It
still should scale up to some extent. But now I didn't see any scale
up. Many times even slower I guess due to some resource contention.
(HDFS uses sync replication too, it uses pipeline for writing the
data). I tested using large files (15G), so they are not served out of
memory for reading.


> When you try and ls a directory the MetaData Server needs to get
> current statistics on every file in the directory. If there are other
> nodes currently writing to the directory that involves revoking
> "capabilities." Generally this should be pretty fast but is sometimes
> still noticeable.
> If it's more than a second or so, we probably broke things so that
> nodes are trying to flush out all their buffered writes before
> releasing caps. (We've done this before, although I thought it was
> fixed in current code.) What versions are you running?
ls is much longer than 1 second. I used v0.34 and v0.37. Both have this issue.

Best,
Xiaofei


On Thu, Nov 24, 2011 at 10:54 AM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Wed, Nov 23, 2011 at 3:44 PM, Xiaofei Du <xiaofei.du008@gmail.com> wrote:
>> I am sure both the network and disk IO bandwidth are not so bad. I did
>> test on HDFS on the same machines, the throughput is much higher. I
>> just used ceph osd tell\* bench, and I got six osd nodes with 40~50
>> MB/s. But two of the osds are a little bit slower. they are around 20
>> MB/s. There is a sentence "The performance of a single OSD can bring
>> down your whole cluster! " in the OSD performance section of the link
>> you gave me. But I think two slower osds will only influence 1/4 of
>> the overall throughput. But the test result showed me no scalability.
>> And two slower disk IO would also influence HDFS throughput. But it
>> showed scalability. So I think bandwidth is not a problem.
>
> Unfortunately, that is the problem. Don't forget that Ceph is writing
> everything twice, and it's synchronous replication. 50% of your writes
> have to wait on those 20MB/s nodes to finish saving the data to disk.
> (I believe HDFS uses async replication.) Plus because it's journaling,
> all data gets written twice on each OSD. Reads go much faster because
> they only hit the slow OSDs for 25% of operations, and are often
> served out of memory.
> We haven't yet gotten around to working out ways of automatically
> handling this situation, but there are a few things you can do:
> 1) Remove the bad nodes from your cluster. Your performance should go
> up by a lot.
> 2) Change the weight of the slow nodes so they get a lower percentage
> of writes compared to the other nodes. (The default is 1.)
> http://ceph.newdream.net/wiki/Monitor_commands#reweight
>
>>>> Actually when I ls the ceph file system. it was very slow to give me
>>>> the result (There was only eight files, not tons of files). It seemed
>>>> like all the clients were competing for some resource. But the mon and
>>>> mds resource usage almost equals to zero. That's reasonable because I
>>>> only have 8 osds and several clients. So this seems quite weird.
>>> Well, ls is a slower operation on Ceph than many systems due to the
>>> way it handles client capabilities. But this issue will be separate
>>> from the one you're seeing above.
>> The problem is when I don't do writing, the ls operation is fast. When
>> I was writing two files, the ls operation became quite slow. ls
>> operation should not be so slow even I am writing the file. So I guess
>> maybe there are some resource contentions in it?
> When you try and ls a directory the MetaData Server needs to get
> current statistics on every file in the directory. If there are other
> nodes currently writing to the directory that involves revoking
> "capabilities." Generally this should be pretty fast but is sometimes
> still noticeable.
> If it's more than a second or so, we probably broke things so that
> nodes are trying to flush out all their buffered writes before
> releasing caps. (We've done this before, although I thought it was
> fixed in current code.) What versions are you running?
>



-- 
Xiaofei (Gregory) Du
Department of Computer Science
University of California, Santa Barbara
