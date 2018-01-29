From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: RGW bucket tagging
Date: Mon, 29 Jan 2018 11:04:47 +0100
Message-ID: <87inblou9s.fsf@suse.com>
References: <CAA1GxO07U6t_WQhHFur9BPjaaWhZoA1nGazffSB_1Nfjptetog@mail.gmail.com> <CAKOnar=rwS6SKDDbAk6udCi8bJUD5pnM1g4ZSkH-VD4Edjo-rg@mail.gmail.com> <CAA1GxO2CbG=UR_4SKb4pV-j78ZG-nzjwaD+veqgx-RyQBryOSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:35918 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeA2KEt (ORCPT
        <rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
        Mon, 29 Jan 2018 05:04:49 -0500
In-Reply-To: <CAA1GxO2CbG=UR_4SKb4pV-j78ZG-nzjwaD+veqgx-RyQBryOSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Calminder <andreas.calminder@klarna.com>, Matt Benjamin <mbenjami@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Andreas Calminder <andreas.calminder@klarna.com> writes:

> Thanks for your reply Matt, I did some more poking around; you're
> right, there's no support for bucket tagging. Does anyone know if this
> feature will be implemented somewhere in the foreseeable future?

Yeah, this feature isn't implemented yet.

Though it should be relatively easier to implement, since it doesn't tie
into any other functionalities unlike object tagging, and purely
provides a tagging API which is similar to what we've already
implemented for Object Tagging.
>
> Best regards,
> andreas
>
> On 26 January 2018 at 17:08, Matt Benjamin <mbenjami@redhat.com> wrote:
>> Hi Andreas,
>>
>> I think we don't support bucket tagging yet.  There is support for
>> object tagging, plus integration w/bucket policy and lifecycle.
>>
>> Abhishek, do you have anything to add here?
>>
>> Matt
>>
>> On Fri, Jan 26, 2018 at 9:47 AM, Andreas Calminder
>> <andreas.calminder@klarna.com> wrote:
>>> Hello,
>>> I'm evaluating the possibility of using tags for buckets in RGW, using
>>> boto3 s3.BucketTagging.put returns  client error and the rgw log
>>> throws a 400 and says: provided input did not specify location
>>> constraint correctly

This ideally should've reported 501 NotImplemented instead of a client
error (probably still does for AWSv4 auth?)

>>>
>>> I figured it's most likely that I did something silly in the code,
>>> however before digging deeper I figured I should probably check if
>>> it's even supported in RGW, I found this:
>>> http://docs.ceph.com/docs/master/dev/radosgw/s3_compliance/
>>>
>>> Which says Bucket Tagging "?", So I suspect Bucket Tagging isn't
>>> supported? Any clarification or pointers appreciated here.
>>>
>>> Thanks!
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>>
>> --
>>
>> Matt Benjamin
>> Red Hat, Inc.
>> 315 West Huron Street, Suite 140A
>> Ann Arbor, Michigan 48103
>>
>> http://www.redhat.com/en/technologies/storage
>>
>> tel.  734-821-5101
>> fax.  734-769-8938
>> cel.  734-216-5309
>

-- 
Abhishek Lekshmanan
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton,
HRB 21284 (AG Nürnberg)
