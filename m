From: =?UTF-8?Q?Piotr_Da=c5=82ek?= <piotr.dalek@corp.ovh.com>
Subject: Re: Are we ready for jewel 10.2.6?
Date: Thu, 2 Feb 2017 10:02:12 +0100
Message-ID: <3f8464f9-4d23-f357-71db-b0697db9938c@corp.ovh.com>
References: <63289246-25fb-c96f-b844-dba82d7293c5@suse.cz>
 <9e856df3-aa13-834d-457c-6592474cb198@corp.ovh.com>
 <72d5cc9f-33f5-71f1-2965-2f75a799fb52@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 7.mo302.mail-out.ovh.net ([137.74.110.80]:46764 "EHLO
        7.mo302.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdBBJCP (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 2 Feb 2017 04:02:15 -0500
In-Reply-To: <72d5cc9f-33f5-71f1-2965-2f75a799fb52@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 02/02/2017 09:22 AM, Loic Dachary wrote:
>>>[..]
>>> Do you think it's time to publish a 10.2.6 point release?
>>
>> Any chance to have
>> https://github.com/ceph/ceph/pull/13131
>
> I'll let Nathan comment on this one.
>
>> and
>> https://github.com/ceph/ceph/pull/13214
>
> Since it is a backport of https://github.com/ceph/ceph/pull/13213 which is not yet merged in master, it is unlikely to make it to 10.2.6. Not impossible but things would have to move unusually fast for that to happen ;-)

The last one is of particular use (for us at least) - it could help reducing 
the time the cluster needs to recover while still serving I/O to clients -- 
of which we have a whole lot. In the past it was the throttler which was 
limiting us, and not the cluster itself, we could change the throttler 
values but that required an OSD restart... which was unacceptable because 
that would induce even more recovery.

-- 
Piotr Dałek
piotr.dalek@corp.ovh.com
https://www.ovh.com/us/
