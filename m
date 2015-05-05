From: David Zafman <dzafman@redhat.com>
Subject: Re: should we prepare to release firefly v0.80.10 ?
Date: Tue, 05 May 2015 11:58:30 -0700
Message-ID: <554912D6.7000204@redhat.com>
References: <55362279.5060105@dachary.org> <alpine.DEB.2.00.1504210851130.18547@cobra.newdream.net> <55367E8D.1090805@redhat.com> <acaeb07b-41c3-40bc-87a3-9d82ce346ae7@redhat.com> <5537229F.4050501@redhat.com> <55488AA7.5020709@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44521 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbbEES7g (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 5 May 2015 14:59:36 -0400
In-Reply-To: <55488AA7.5020709@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "Shu, Xinxin" <xinxin.shu@intel.com>, Ceph Development <ceph-devel@vger.kernel.org>


The only issue with not having wip-11139-firefly merged is getting fals=
e=20
test failures.  So I can't see how this would impact the point release.

David


On 5/5/15 2:17 AM, Loic Dachary wrote:
> Hi David,
>
> These changes have been merged in ceph-qa-suite for about two weeks n=
ow, did you notice problems ?
>
> Cheers
>
> On 22/04/2015 06:25, David Zafman wrote:
>> All the changes for testing are in ceph-qa-suite firefly branch.
>>
>> After updating from the git repo, the firefly branch doesn't include=
 these 2 commits.   Was there an issue with this change?
>>
>> David
>>
>> commit 71624947a338dabb6ed71d94e2e003bf984074cc
>> Merge: 3da69ba 35ee8e0
>> Author: Loic Dachary <loic@dachary.org>
>> Date:   Fri Apr 3 10:47:42 2015 +0200
>>
>>      Merge pull request #394 from dzafman/wip-11139-firefly
>>
>>      ceph_manager: Check for exit status 11 from ceph-objectstore-to=
ol import
>>
>>      Reviewed-by: Loic Dachary <ldachary@redhat.com>
>>
>> commit 35ee8e0d4e1e8cac61ff9f5d8d644f93de4cdf60
>> Author: David Zafman <dzafman@redhat.com>
>> Date:   Fri Mar 20 19:56:55 2015 -0700
>>
>>      ceph_manager: Check for exit status 11 from ceph-objectstore-to=
ol import
>>
>>      Fixes: #11139
>>
>>      Signed-off-by: David Zafman <dzafman@redhat.com>
>>      (cherry picked from commit 6c5300552d00232d6ecb2c1aa641d515c9d8=
cd34)
>>
>> David
>>
>> On 4/21/15 7:39 PM, Samuel Just wrote:
>>> Ok, so ceoh_objectstrore_tool is being tested in firefly as part of=
 the current firefly ceph-qa-suite branch?
>>> -Sam
>>>
>>> Sent from Nine <http://www.9folders.com/>
>>>
>>> *From:* David Zafman
>>> *Sent:* Apr 21, 2015 10:16 PM
>>> *To:* Sage Weil;Loic Dachary
>>> *Cc:* Ceph Development;Shu, Xinxin;sjust@redhat.com
>>> *Subject:* Re: should we prepare to release firefly v0.80.10 ?
>>>
>>>
>>>
>>> In early march I ran rados:thrash on the firefly backport of the
>>> ceph-objectstore-tool changes (wip-cot-firefly).  We considered it
>>> passed, even though an obscure segfault was seen:
>>>
>>> bug #11141: Segmentation Violation: ceph-objectstore-tool doing --o=
p
>>> list-pgs
>>>
>>> David
>>>
>>>
>>> On 4/21/15 8:52 AM, Sage Weil wrote:
>>>> The bulk of it is ceph-objectstore-tool, which is important to get=
 into a
>>>> release, IMO.  David, are these being tested in the firefly thrash=
ing
>>>> tests yet?
>>>>
>>>> The only other one I'm worried about is
>>>>
>>>> 6fd3dfa osd: do not ignore deleted pgs on startup
>>>>
>>>> Sam, I assume the recent hammer upgrade issue is would bite firefl=
y folks
>>>> who upgrade too?
>>>>
>>>> sage
>>>>
>>>>
>>>> On Tue, 21 Apr 2015, Loic Dachary wrote:
>>>>
>>>>> Hi Sage,
>>>>>
>>>>> The firefly branch has a number of fixes ( http://tracker.ceph.co=
m/issues/11090#Release-information ) and has been used for upgrade test=
s in the past few weeks. A few other issues have been backported since =
and are being tested in the integration branch ( http://tracker.ceph.co=
m/issues/11090#teuthology-run-commitb91bbb434e6363a99a632cf3841f70f1f25=
49f79-integration-branch-april-2015 ).
>>>>>
>>>>> Do you think these changes deserve a firefly v0.80.10 release ? S=
hould we ask each lead for their approval ? Or is it better to keep bac=
kporting what needs to be and wait a few weeks ?
>>>>>
>>>>> Cheers
>>>>>
>>>>> --
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>
>>> --=20
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
