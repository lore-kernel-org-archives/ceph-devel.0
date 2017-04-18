From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: Filestore directory splitting (ZFS/FreeBSD)
Date: Tue, 18 Apr 2017 15:32:52 +0200
Message-ID: <7a2df8cd-a7b2-4b69-f26b-006b5beb34b1@digiware.nl>
References: <bc464b95-08f7-d627-df00-00e9200ff259@digiware.nl>
 <alpine.DEB.2.11.1704181324240.6575@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:61883 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756524AbdDRNcl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 18 Apr 2017 09:32:41 -0400
In-Reply-To: <alpine.DEB.2.11.1704181324240.6575@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 18-4-2017 15:27, Sage Weil wrote:
> On Tue, 18 Apr 2017, Willem Jan Withagen wrote:
>> Hi,
>>
>> I'm running some alrger tests with ceph-fuse on FreeBSD, and noticed
>> that I start to run into directory splitting I think?
>> I just Rsynced my full src and ports tree into it, which is like >
>> 1.000.000 small files.
>> At least I saw a rather large number of directories with relatively few
>> files in them.
>>
>> I know from UFS that large directories used to be a problem, although
>> some of the issues on FreeBSD have been fixed long ago.
>>
>> So can anybody explain the rationale behind this process and give a bit
>> of a feeling why we start splitting at 320 files??
> 
> It actually has little to do with the underlying file system's ability to 
> handle large directories.  Ceph needs to do object enumeration in sorted 
> order (based on the [g]hobject_t sort order) and readdir return entries in 
> a semi-random order based on how the fs is implemented.  We keep 
> directories smallish so that we can list the whole directory, sort in 
> memory, and then return the correct result.

Oke, I see.
So it has more to do with the efficiency of readdir and friends....?

And then the odd question: ;-)

why would this be (still) so extensively configurable?
I mean, once it has been "sorted out" it could be changed into more or
less fixed. Either bij making it a *h-file constant, or marking it so in
common_opt.h in the comments.
And perhaps even remove it from the documentation.

I was alos triggered by some of the remarks on the user list that
splitting was a expensive process that did have impact on performance.

--WjW

>> FreeBSD's filestore runs of ZFS, and From waht I've seen thusfar is that
>> ZFS has a different (better) behaviour with large directories.
>> (I once ended up with > 1.000.000 security cam pictures in one
>> directory, and that still was sort of workable.)
>>
>> So has there been any testing to quatify the settings? And how would I
>> be able to determine if ZFS deserves better/larger settings?
>>
>> --WjW
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>

