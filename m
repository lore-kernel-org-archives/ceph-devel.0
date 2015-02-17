From: Mark Nelson <mnelson@redhat.com>
Subject: Re: [ceph-users] Ceph Dumpling/Firefly/Hammer SSD/Memstore performance
 comparison
Date: Tue, 17 Feb 2015 14:28:04 -0600
Message-ID: <54E3A454.1060003@redhat.com>
References: <54E37C3D.5030702@redhat.com> <CANPbtN830yy7AJ6ziWr7V7sN80vHobpy7j8XwGpFizhd7fJynQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58728 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751459AbbBQU2L (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 17 Feb 2015 15:28:11 -0500
In-Reply-To: <CANPbtN830yy7AJ6ziWr7V7sN80vHobpy7j8XwGpFizhd7fJynQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stephen Hindle <shindle@llnw.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Hi Stephen,

It's a benchmark automation tool we wrote that builds a ceph cluster and 
then runs benchmarks against it.  It's still pretty rough (no real error 
checking,  no documentation, etc).  We have some partners that are 
interested in using it too and I'd like to make it useful for the 
community so we're going to try to make it a bit more accessible.

cbt is here:

https://github.com/ceph/ceph-tools/tree/master/cbt

We've also been using it to prototype nightly performance testing of 
firefly and master for the last month or two on some of our lab nodes. 
The cron job and test suites are here:

https://github.com/ceph/ceph-tools/tree/master/regression

Mark


On 02/17/2015 02:16 PM, Stephen Hindle wrote:
> I was wondering what the 'CBT' tool is ?  Google is useless for that acronym...
>
> Thanks!
> Steve
>
> On Tue, Feb 17, 2015 at 10:37 AM, Mark Nelson <mnelson@redhat.com> wrote:
>> Hi All,
>>
>> I wrote up a short document describing some tests I ran recently to look at
>> how SSD backed OSD performance has changed across our LTS releases. This is
>> just looking at RADOS performance and not RBD or RGW.  It also doesn't offer
>> any real explanations regarding the results.  It's just a first high level
>> step toward understanding some of the behaviors folks on the mailing list
>> have reported over the last couple of releases.  I hope you find it useful.
>>
>> Mark
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
