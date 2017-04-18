From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Filestore directory splitting (ZFS/FreeBSD)
Date: Tue, 18 Apr 2017 08:47:00 -0500
Message-ID: <b835241f-b78e-e95b-a8cc-aab24a2634a8@redhat.com>
References: <bc464b95-08f7-d627-df00-00e9200ff259@digiware.nl>
 <alpine.DEB.2.11.1704181324240.6575@piezo.novalocal>
 <7a2df8cd-a7b2-4b69-f26b-006b5beb34b1@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752125AbdDRNrM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Apr 2017 09:47:12 -0400
In-Reply-To: <7a2df8cd-a7b2-4b69-f26b-006b5beb34b1@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 04/18/2017 08:32 AM, Willem Jan Withagen wrote:
> On 18-4-2017 15:27, Sage Weil wrote:
>> On Tue, 18 Apr 2017, Willem Jan Withagen wrote:
>>> Hi,
>>>
>>> I'm running some alrger tests with ceph-fuse on FreeBSD, and noticed
>>> that I start to run into directory splitting I think?
>>> I just Rsynced my full src and ports tree into it, which is like >
>>> 1.000.000 small files.
>>> At least I saw a rather large number of directories with relatively few
>>> files in them.
>>>
>>> I know from UFS that large directories used to be a problem, although
>>> some of the issues on FreeBSD have been fixed long ago.
>>>
>>> So can anybody explain the rationale behind this process and give a bit
>>> of a feeling why we start splitting at 320 files??
>>
>> It actually has little to do with the underlying file system's ability to
>> handle large directories.  Ceph needs to do object enumeration in sorted
>> order (based on the [g]hobject_t sort order) and readdir return entries in
>> a semi-random order based on how the fs is implemented.  We keep
>> directories smallish so that we can list the whole directory, sort in
>> memory, and then return the correct result.
>
> Oke, I see.
> So it has more to do with the efficiency of readdir and friends....?
>
> And then the odd question: ;-)
>
> why would this be (still) so extensively configurable?
> I mean, once it has been "sorted out" it could be changed into more or
> less fixed. Either bij making it a *h-file constant, or marking it so in
> common_opt.h in the comments.
> And perhaps even remove it from the documentation.
>
> I was alos triggered by some of the remarks on the user list th
> splitting was a expensive process that did have impact on performance.

It's still a bit of an on-going debate where those split values should 
be tuned, and frankly whether or not splitting should happen at all. 
This was sort of the motivation to try to "pre-split" directories if you 
think you're going to end up with lots of objects per PG.  There's a lot 
of nuance here regarding directory fragmentation, cached dentries and 
inodes, the effects of large dentry/inode cache on other things 
(syncfs), selinux behavior (or similar behavior, ie what actions 
triggers xattr security lookups).  If we could make the things that need 
to scan through the directories asynchronous that would probably let us 
push the directory limits much higher, but that would be a fairly major 
change for filestore and we are trying to keep it stable until bluestore 
is ready.

Speaking of which, bluestore doesn't suffer from this particular issue 
so eventually this whole discussion sort of becomes obsolete. We have 
other performance challenges in bluestore that we are still working on 
(mostly metadata/rocksdb related).

Mark

>
> --WjW
>
>>> FreeBSD's filestore runs of ZFS, and From waht I've seen thusfar is that
>>> ZFS has a different (better) behaviour with large directories.
>>> (I once ended up with > 1.000.000 security cam pictures in one
>>> directory, and that still was sort of workable.)
>>>
>>> So has there been any testing to quatify the settings? And how would I
>>> be able to determine if ZFS deserves better/larger settings?
>>>
>>> --WjW
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
