From: David Zafman <dzafman@redhat.com>
Subject: Re: should we prepare to release firefly v0.80.10 ?
Date: Tue, 21 Apr 2015 09:45:01 -0700
Message-ID: <55367E8D.1090805@redhat.com>
References: <55362279.5060105@dachary.org> <alpine.DEB.2.00.1504210851130.18547@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40079 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932377AbbDUQqG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 21 Apr 2015 12:46:06 -0400
In-Reply-To: <alpine.DEB.2.00.1504210851130.18547@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Shu, Xinxin" <xinxin.shu@intel.com>, sjust@redhat.com


In early march I ran rados:thrash on the firefly backport of the=20
ceph-objectstore-tool changes (wip-cot-firefly).  We considered it=20
passed, even though an obscure segfault was seen:

bug #11141: Segmentation Violation: ceph-objectstore-tool doing --op=20
list-pgs

David


On 4/21/15 8:52 AM, Sage Weil wrote:
> The bulk of it is ceph-objectstore-tool, which is important to get in=
to a
> release, IMO.  David, are these being tested in the firefly thrashing
> tests yet?
>
> The only other one I'm worried about is
>
> 6fd3dfa osd: do not ignore deleted pgs on startup
>
> Sam, I assume the recent hammer upgrade issue is would bite firefly f=
olks
> who upgrade too?
>
> sage
>
>
> On Tue, 21 Apr 2015, Loic Dachary wrote:
>
>> Hi Sage,
>>
>> The firefly branch has a number of fixes ( http://tracker.ceph.com/i=
ssues/11090#Release-information ) and has been used for upgrade tests i=
n the past few weeks. A few other issues have been backported since and=
 are being tested in the integration branch ( http://tracker.ceph.com/i=
ssues/11090#teuthology-run-commitb91bbb434e6363a99a632cf3841f70f1f2549f=
79-integration-branch-april-2015 ).
>>
>> Do you think these changes deserve a firefly v0.80.10 release ? Shou=
ld we ask each lead for their approval ? Or is it better to keep backpo=
rting what needs to be and wait a few weeks ?
>>
>> Cheers
>>
>> --=20
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
