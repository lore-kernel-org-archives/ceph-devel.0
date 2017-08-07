From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: increasingly large packages and longer build times
Date: Mon, 7 Aug 2017 17:30:06 +0200
Message-ID: <1a1057ce-581f-8fe5-b474-d41e75c2f56a@digiware.nl>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:18120 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751541AbdHGPaM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 7 Aug 2017 11:30:12 -0400
In-Reply-To: <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 7-8-2017 16:58, Ken Dreyer wrote:
> On Wed, Aug 2, 2017 at 7:39 AM, Alfredo Deza <adeza@redhat.com> wrote:
>> The ceph-debuginfo package has continued to increase in size on almost
>> every release, reaching 1.5GB for the latest luminous RC (12.1.2).
>>
>> To contrast that, the latest ceph-debuginfo in Hammer was about 0.73GB.
>>
>> Having packages that large is problematic on a few fronts:
> 
> I agree Alfredo. Here's a similar issue I am experiencing with the source sizes:
> 
> Jewel sizes:
>   14M ceph-10.2.7.tar.gz
>   82M ceph-10.2.7 uncompressed
> 
> Luminous sizes:
>   142M ceph-12.1.2.tar.gz
>   709M ceph-12.1.2  uncompressed

I'm on that same page.

This is one reason not the use the source at download.ceph.com for
FreeBSD package building. It is too big, and bulky. And most of the time
the package builders already have most of the required stuff for other
packages.

The only reason for downloading the tar, would be the version strings in
the package. But getting 150M just for that is rather wasteful.

And my uncompressed sources to build a package are 332M of which is
 - 172M boost.
   Which I actually not use, I'm using the ported/package one)
 - .tox dirs 2x 25M (but that is after a build/testrun)
 - 18M dpdk
   Do not use that either
 - 13M civetweb
all in all about 250M on overhead, of which 190M is really not used.

--WjW


