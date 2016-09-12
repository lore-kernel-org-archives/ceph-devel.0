From: Mark Nelson <mnelson@redhat.com>
Subject: Re: Bluestore memory leak
Date: Mon, 12 Sep 2016 16:16:53 -0500
Message-ID: <cc45aae1-a8b6-3a46-f4d1-ca0fe24437ac@redhat.com>
References: <BL2PR02MB21153E4497C3C2364B543BAEF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <3effe79d-b044-c6a2-36d0-53d0b3c149ce@redhat.com>
 <BL2PR02MB2115528CD794399F5E7D7A75F4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <777f0f87-864a-a88e-fd37-39ff7e309c62@redhat.com>
 <BL2PR02MB2115B854CD3ECBA130B8731AF4FB0@BL2PR02MB2115.namprd02.prod.outlook.com>
 <BL2PR02MB211523F7620D138235D6B2CBF4FF0@BL2PR02MB2115.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49204 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbcILVQ4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 12 Sep 2016 17:16:56 -0400
In-Reply-To: <BL2PR02MB211523F7620D138235D6B2CBF4FF0@BL2PR02MB2115.namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Somnath Roy <Somnath.Roy@sandisk.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 09/12/2016 03:54 PM, Somnath Roy wrote:
> Mark,
> Thanks for soname* param , it worked with tcmalloc for me..
>
> Sage,
> Please find the valgrind memcheck output here..
> https://docs.google.com/document/d/12yx8jVmdkXrYPmq4DSxcdUBWc8xKrPjJDOTES299_do/edit?usp=sharing
>
> It seems it is leaking memory (see 'definitely lost')..I will go through the code and try to find out if those are valid or not. Thought of sharing with you meanwhile as it will be much faster if you have time to look as well :-)

How big had the per-OSD RSS memory grown at this point?  Looks like 
we're only seeing about 408K definitely lost and 3953K indirectly lost 
in the totals at the end.  That's notable, but given the amounts of 
memory we are talking about, it doesn't seem like we are seeing the real 
culprit(s).

>
> Regards
> Somnath
>
> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Somnath Roy
> Sent: Thursday, September 08, 2016 1:32 PM
> To: Mark Nelson; ceph-devel
> Subject: RE: Bluestore memory leak
>
> Yes, a bit probably :-)..Will try to find out from where it is leaking..
>
> -----Original Message-----
> From: Mark Nelson [mailto:mnelson@redhat.com]
> Sent: Thursday, September 08, 2016 1:28 PM
> To: Somnath Roy; ceph-devel
> Subject: Re: Bluestore memory leak
>
> What I'm seeing is that after 5 minutes of 4k random writes, my OSDs are using about half the memory they were previously.  I'm not sure we have entirely fixed it, but can you you confirm that it's at least growing slower than it used to?
>
> Mark
>
> On 09/08/2016 03:24 PM, Somnath Roy wrote:
>> Sage/Mark,
>> Leak is still there with latest master, I can't complete a 5 min run , memory is getting full.
>>
>> root@emsnode11:~/ceph-master/build# ceph -v
>> *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
>> ceph version v11.0.0-2173-g0985370
>> (0985370d2d729c6b8ef373e2dc4241b0eea474bf)
>> root@emsnode11:~/ceph-master/build#
>>
>> Thanks & Regards
>> Somnath
>>
>> -----Original Message-----
>> From: Mark Nelson [mailto:mnelson@redhat.com]
>> Sent: Wednesday, September 07, 2016 7:04 PM
>> To: Somnath Roy; ceph-devel
>> Subject: Re: Bluestore memory leak
>>
>> Hi Somnath,
>>
>> I complained loudly and often enough to get Sage to take a look and he fixed a bunch of stuff. :)  The following PR dramatically improves things, though I haven't verified that it's totally fixed yet:
>>
>> https://github.com/ceph/ceph/pull/11011
>>
>> Mark
>>
>> On 09/07/2016 08:08 PM, Somnath Roy wrote:
>>> Sage,
>>> As Mark said, the latest code has severe memory leak , my system memory (64GB) started swapping after 3 min of 4K RW run.
>>>
>>> Thanks & Regards
>>> Somnath
>>> PLEASE NOTE: The information contained in this electronic mail message is intended only for the use of the designated recipient(s) named above. If the reader of this message is not the intended recipient, you are hereby notified that you have received this message in error and that any review, dissemination, distribution, or copying of this message is strictly prohibited. If you have received this communication in error, please notify the sender by telephone or e-mail (as shown above) immediately and destroy any and all copies of this message in your possession (whether hard copies or electronically stored copies).
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
