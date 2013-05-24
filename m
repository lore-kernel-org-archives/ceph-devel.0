From: Dan Mick <dan.mick@inktank.com>
Subject: Re: [doc] strange navigation error
Date: Fri, 24 May 2013 16:40:57 -0700
Message-ID: <519FFA89.1050907@inktank.com>
References: <CACkq2mo6nRDYxDYEEbWJYGmVfiKcEEL8dMKrEYz_Yqx9MbVR1Q@mail.gmail.com> <519FD3D8.6040309@inktank.com> <CACkq2mqVR3znk3TE6cdDvwrq6t1T=nBY7YRnT1PzMriFLka0oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36579 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871Ab3EXXlC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 24 May 2013 19:41:02 -0400
Received: by mail-pa0-f45.google.com with SMTP id lj1so4849185pab.32
        for <ceph-devel@vger.kernel.org>; Fri, 24 May 2013 16:41:01 -0700 (PDT)
In-Reply-To: <CACkq2mqVR3znk3TE6cdDvwrq6t1T=nBY7YRnT1PzMriFLka0oQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 05/24/2013 02:16 PM, Travis Rhoden wrote:
> On Fri, May 24, 2013 at 4:55 PM, Dan Mick <dan.mick@inktank.com> wrote:
>>
>>
>> On 05/24/2013 10:05 AM, Travis Rhoden wrote:
>>>
>>> I stumbled across a weird TOC/navigation error in the docs.
>>>
>>> On the page:
>>> http://ceph.com/docs/master/rados/deployment/ceph-deploy-mds/,
>>> if you hover over "next" on the top right, it wants to go to
>>> mds-config-ref, even though the TOC on the left says the next entry
>>> should be ceph-deploy-purge.
>>
>>
>> Ah.  That's because the TOC *also* says that the next is MDS Configuration
>> (under CephFS).  I guess we're sharing the Add/Remove MDS page at two places
>> in the hierarchy.
>
> Yes, that is exactly what is happening.  Since the Add/Remove MDS page
> is specific to ceph-deploy, I would think you want to keep it in the
> ceph-deploy section, and not add it ot the TOC a second time from the
> CephFS section.  We could instead a reference/link to it, but a page
> should really only ever be in one TOC.  If someone says that is okay
> to do, I can send a pull-request with the offending line removed (and
> potentially a reference/link instead).
>
>   - Travis
>>


Sure.  I'm gonna go look at your earlier pull request now, too.  Thanks.

