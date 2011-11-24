From: Xiaofei Du <xiaofei.du008@gmail.com>
Subject: Re: Why Ceph's aggregate write throughput does not scale with the
 number of osd nodes
Date: Thu, 24 Nov 2011 12:31:15 -0800
Message-ID: <CAND_vCZccYerOQmU9hS3N=hKyjjYnNqTXtTw-Dgw0hUz67Tauw@mail.gmail.com>
References: <CAND_vCaQU5hFk++6mMnS7MwnAoY2_c-xxe3pEbjJsGQuAsaeiQ@mail.gmail.com>
 <CAF3hT9AqbhPDrBmeymTvBO_FZp5FF2VmwyPeh_cQFFgsi-L96A@mail.gmail.com>
 <CAND_vCZTuOmq3LMJ7eqc8jtbc7Yv7e9YSqy6=cTwGtjBsZ+rfA@mail.gmail.com>
 <CAND_vCYXQQ4bokmAvV+Z46UT7_Pygd_h0kwXSch_r+HDg5W25Q@mail.gmail.com>
 <CAF3hT9AHSHf5Gd+9_AydBDWj2if01iNLjmQ5_PXLPna_-GwXQg@mail.gmail.com>
 <CAND_vCbSNbqL8faw0yAYp3guahexo7sAr0X1cQGS5rRZv=71xw@mail.gmail.com>
 <CAF3hT9DsujHNTBiAc=Fm2Vu=FsKBSW4nouwg0QPa73kfHF0mtg@mail.gmail.com>
 <CAND_vCZZjvmKYw7dfiqv_geY-upKLNAz_JVZ0_yr5aKQ6x_jKw@mail.gmail.com> <CAF3hT9Dh-byw6h5R633GPxxiMgGmkCtd-MpzRSARoka2RYw88Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40025 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999Ab1KXUbq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Nov 2011 15:31:46 -0500
Received: by iage36 with SMTP id e36so3456599iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Nov 2011 12:31:46 -0800 (PST)
In-Reply-To: <CAF3hT9Dh-byw6h5R633GPxxiMgGmkCtd-MpzRSARoka2RYw88Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

> By default, each write goes to a primary, and the primary then
> replicates that write to a replica. The write is not considered
> complete until it is data safe on every active replica. (You can
> increase or decrease the number of replicas, but I haven't seen
> anywhere that you did.) So 1/4 of your writes will have a slow node as
> a primary, and 3/4 will have a fast node as a primary. Then 1/7 of
> your slow primary writes will also have a slow replica, and 6/7 will
> have a fast replica (but you are still bound by the slow one either
> way). And 5/7 of your fast primary writes will have a fast replica,
> but 2/7 will have a slow replica. So you end up with 1/4 (slow
> primary) plus 3/4 * 2/7 = 6/28 (slow replica) of your writes being
> bounded by the write speed on a slow node, which is 46% of the writes.
> Like I said, journaling also hurts your performance here, since it
> requires that every write go to disk twice. This is necessary to
> provide the data consistency guarantees that Ceph provides, but
> doesn't do us any favors in performance (especially on old disks).
>
> You have two nodes that write at 20MB/s and six that write at 45MB/s.
> Journaling cuts each of those in half: two nodes at 10MB/s, six at
> 23MB/s. That's an aggregate 158MB/s of write bandwidth, but each write
> goes to two OSDs so you only get half of that, or 79MB/s of write
> bandwidth. You are getting about the bandwidth I would expect out of a
> slow and unbalanced cluster.
This means no matter how many clients I have I should always get
around 79MB/s, right? This sounds reasonable. Thanks for the
explanation. So do you guys have plans to solve this "unbalanced
cluster" problem? I guess several other distributed file systems have
the same issue. HDFS has this issue too. I guess the solution is to
use stable disk IO bandwidth hardware. If that couldn't be guaranteed,
you need to detect slow nodes and kick them out of the cluster.

> Are you using ceph-fuse or the kernel client? And if it's the kernel
> client, what version?
I am using ceph-fuse

Best,
Xiaofei

On Thu, Nov 24, 2011 at 11:50 AM, Gregory Farnum
<gregory.farnum@dreamhost.com> wrote:
> On Thu, Nov 24, 2011 at 11:32 AM, Xiaofei Du <xiaofei.du008@gmail.com> wrote:
>>> Unfortunately, that is the problem. Don't forget that Ceph is writing
>>> everything twice, and it's synchronous replication. 50% of your writes
>>> have to wait on those 20MB/s nodes to finish saving the data to disk.
>>> (I believe HDFS uses async replication.) Plus because it's journaling,
>>> all data gets written twice on each OSD. Reads go much faster because
>>> they only hit the slow OSDs for 25% of operations, and are often
>>> served out of memory.
>>> We haven't yet gotten around to working out ways of automatically
>>> handling this situation, but there are a few things you can do:
>>> 1) Remove the bad nodes from your cluster. Your performance should go
>>> up by a lot.
>>> 2) Change the weight of the slow nodes so they get a lower percentage
>>> of writes compared to the other nodes. (The default is 1.)
>>> http://ceph.newdream.net/wiki/Monitor_commands#reweight
>> It is not 50%. It is still 25% of the writes need to wait for the 2
>> slow nodes no matter how many replication it has to write or
>> journaling. And even though two nodes are slower than the others. It
>> still should scale up to some extent. But now I didn't see any scale
>> up. Many times even slower I guess due to some resource contention.
>> (HDFS uses sync replication too, it uses pipeline for writing the
>> data). I tested using large files (15G), so they are not served out of
>> memory for reading.
> By default, each write goes to a primary, and the primary then
> replicates that write to a replica. The write is not considered
> complete until it is data safe on every active replica. (You can
> increase or decrease the number of replicas, but I haven't seen
> anywhere that you did.) So 1/4 of your writes will have a slow node as
> a primary, and 3/4 will have a fast node as a primary. Then 1/7 of
> your slow primary writes will also have a slow replica, and 6/7 will
> have a fast replica (but you are still bound by the slow one either
> way). And 5/7 of your fast primary writes will have a fast replica,
> but 2/7 will have a slow replica. So you end up with 1/4 (slow
> primary) plus 3/4 * 2/7 = 6/28 (slow replica) of your writes being
> bounded by the write speed on a slow node, which is 46% of the writes.
> Like I said, journaling also hurts your performance here, since it
> requires that every write go to disk twice. This is necessary to
> provide the data consistency guarantees that Ceph provides, but
> doesn't do us any favors in performance (especially on old disks).
>
> You have two nodes that write at 20MB/s and six that write at 45MB/s.
> Journaling cuts each of those in half: two nodes at 10MB/s, six at
> 23MB/s. That's an aggregate 158MB/s of write bandwidth, but each write
> goes to two OSDs so you only get half of that, or 79MB/s of write
> bandwidth. You are getting about the bandwidth I would expect out of a
> slow and unbalanced cluster.
>
>>> When you try and ls a directory the MetaData Server needs to get
>>> current statistics on every file in the directory. If there are other
>>> nodes currently writing to the directory that involves revoking
>>> "capabilities." Generally this should be pretty fast but is sometimes
>>> still noticeable.
>>> If it's more than a second or so, we probably broke things so that
>>> nodes are trying to flush out all their buffered writes before
>>> releasing caps. (We've done this before, although I thought it was
>>> fixed in current code.) What versions are you running?
>> ls is much longer than 1 second. I used v0.34 and v0.37. Both have this issue.
> Are you using ceph-fuse or the kernel client? And if it's the kernel
> client, what version?
>



-- 
Xiaofei (Gregory) Du
Department of Computer Science
University of California, Santa Barbara
