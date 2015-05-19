From: flisky <yinjifeng@lianjia.com>
Subject: Re: [EMG]incomplete pgs make RGW unusable
Date: Tue, 19 May 2015 23:30:59 +0800
Message-ID: <mjfkvj$a4$1@ger.gmane.org>
References: <mjdupr$jtu$1@ger.gmane.org> <mjettq$dj6$1@ger.gmane.org> <alpine.DEB.2.00.1505190741450.9510@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:36337 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753683AbbESPbN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 May 2015 11:31:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcfcd-ceph-devel3-2@m.gmane.org>)
	id 1YujU3-0001Mz-6b
	for ceph-devel@vger.kernel.org; Tue, 19 May 2015 17:31:07 +0200
Received: from 101.254.26.15 ([101.254.26.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 17:31:07 +0200
Received: from yinjifeng by 101.254.26.15 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <ceph-devel@vger.kernel.org>; Tue, 19 May 2015 17:31:07 +0200
In-Reply-To: <alpine.DEB.2.00.1505190741450.9510@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Thanks, sage!

On 2015=E5=B9=B405=E6=9C=8819=E6=97=A5 22:42, Sage Weil wrote:
> On Tue, 19 May 2015, flisky wrote:
>> I follow the instruction from http://tracker.ceph.com/issues/10411#n=
ote-4, and
>> finally get force_create_pg work.
>>
>> Thanks, Brian Rak. It helps a lot.
>>
>> And, it would be great if the [feature](http://tracker.ceph.com/issu=
es/10098)
>> is implemented.
>
> I've bumped this up toward the top of the backlog.. it shouldn't be
> terribly difficult to implement!
>
> sage
>
>
>>
>> BR,
>>
>> On 2015?05?19? 08:06, flisky wrote:
>>> Hi core developers,
>>>
>>> Sorry, I have to raise this from user list because there is no resp=
onse.
>>>
>>> I reformat the disks to increase osd journal size. During the proce=
ss, I
>>> lost 9 pgs.
>>>
>>> The incomplete pgs belong to the pool .rgw.buckets, which causes sl=
ow
>>> requests and make RGW unusable.
>>> I have to restart the OSDs and RGWs time to time, to make RGW respo=
nsible.
>>>
>>> The most scary things happen. I cannot recovery the incomplete pgs.
>>>
>>> [force_create_pg](http://tracker.ceph.com/issues/10098) marks it a
>>> feature to handle this.
>>>
>>> The [blog](https://ceph.com/community/incomplete-pgs-oh-my/) is not
>>> working, either.
>>>
>>> And finally I give up the recovery, and use 'rados cppool' to copy =
our
>>> huge pool, it's STUCK...
>>>
>>> I'm very frustrated, and very surprised that Ceph doesn't offer a w=
ay to
>>> just let the lost data lost.
>>>
>>> Could anyone give any advise on this? Thanks!
>>>
>>> Sincerely,
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
