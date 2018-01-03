From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: formatting bytes and object counts in ceph status ouput
Date: Wed, 3 Jan 2018 13:46:17 +0100
Message-ID: <6d7d981c-f781-4d70-e21d-0a3c0b029a94@digiware.nl>
References: <20180102104303.hr4ohy2dkxapj6id@jf_suse_laptop>
 <CALe9h7fCJHV+UPeNUreN-gbK3xgdBgmDJLqxC+6ZiDTA1YPPSQ@mail.gmail.com>
 <6eed9c92-fe9d-bfb0-0978-f3ba43f875f1@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:50510 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751571AbeACMqX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 3 Jan 2018 07:46:23 -0500
In-Reply-To: <6eed9c92-fe9d-bfb0-0978-f3ba43f875f1@redhat.com>
Content-Language: nl
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dmick@redhat.com>, John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ceph-Users <ceph-users@ceph.com>

On 3-1-2018 00:44, Dan Mick wrote:
> On 01/02/2018 08:54 AM, John Spray wrote:
>> On Tue, Jan 2, 2018 at 10:43 AM, Jan Fajerski <jfajerski@suse.com> wrote:
>>> Hi lists,
>>> Currently the ceph status output formats all numbers with binary unit
>>> prefixes, i.e. 1MB equals 1048576 bytes and an object count of 1M equals
>>> 1048576 objects.  I received a bug report from a user that printing object
>>> counts with a base 2 multiplier is confusing (I agree) so I opened a bug and
>>> https://github.com/ceph/ceph/pull/19117.
>>> In the PR discussion a couple of questions arose that I'd like to get some
>>> opinions on:
>>
>>> - Should we print binary unit prefixes (MiB, GiB, ...) since that would be
>>> technically correct?
>>
>> I'm not a fan of the technically correct base 2 units -- they're still
>> relatively rarely used, and I've spent most of my life using kB to
>> mean 1024, not 1000.
>>
>>> - Should counters (like object counts) be formatted with a base 10
>>> multiplier or  a multiplier woth base 2?
>>
>> I prefer base 2 for any dimensionless quantities (or rates thereof) in
>> computing.  Metres and kilograms go in base 10, bytes go in base 2.
>>
>> It's all very subjective and a matter of opinion of course, and my
>> feelings aren't particularly strong :-)
>>
>> John
> 
> 100% agreed.  "iB" is an affectation IMO.  But I'm grumpy and old.

+1 on all 3 cases. :)

--WjW

