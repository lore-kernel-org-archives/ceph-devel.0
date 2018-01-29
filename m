From: Andreas Calminder <andreas.calminder@klarna.com>
Subject: Re: RGW bucket tagging
Date: Mon, 29 Jan 2018 08:25:44 +0100
Message-ID: <CAA1GxO2CbG=UR_4SKb4pV-j78ZG-nzjwaD+veqgx-RyQBryOSg@mail.gmail.com>
References: <CAA1GxO07U6t_WQhHFur9BPjaaWhZoA1nGazffSB_1Nfjptetog@mail.gmail.com>
 <CAKOnar=rwS6SKDDbAk6udCi8bJUD5pnM1g4ZSkH-VD4Edjo-rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:43624 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeA2H0G (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jan 2018 02:26:06 -0500
Received: by mail-lf0-f49.google.com with SMTP id o89so8397890lfg.10
        for <ceph-devel@vger.kernel.org>; Sun, 28 Jan 2018 23:26:05 -0800 (PST)
In-Reply-To: <CAKOnar=rwS6SKDDbAk6udCi8bJUD5pnM1g4ZSkH-VD4Edjo-rg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Matt Benjamin <mbenjami@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>

Thanks for your reply Matt, I did some more poking around; you're
right, there's no support for bucket tagging. Does anyone know if this
feature will be implemented somewhere in the foreseeable future?

Best regards,
andreas

On 26 January 2018 at 17:08, Matt Benjamin <mbenjami@redhat.com> wrote:
> Hi Andreas,
>
> I think we don't support bucket tagging yet.  There is support for
> object tagging, plus integration w/bucket policy and lifecycle.
>
> Abhishek, do you have anything to add here?
>
> Matt
>
> On Fri, Jan 26, 2018 at 9:47 AM, Andreas Calminder
> <andreas.calminder@klarna.com> wrote:
>> Hello,
>> I'm evaluating the possibility of using tags for buckets in RGW, using
>> boto3 s3.BucketTagging.put returns  client error and the rgw log
>> throws a 400 and says: provided input did not specify location
>> constraint correctly
>>
>> I figured it's most likely that I did something silly in the code,
>> however before digging deeper I figured I should probably check if
>> it's even supported in RGW, I found this:
>> http://docs.ceph.com/docs/master/dev/radosgw/s3_compliance/
>>
>> Which says Bucket Tagging "?", So I suspect Bucket Tagging isn't
>> supported? Any clarification or pointers appreciated here.
>>
>> Thanks!
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
>
> Matt Benjamin
> Red Hat, Inc.
> 315 West Huron Street, Suite 140A
> Ann Arbor, Michigan 48103
>
> http://www.redhat.com/en/technologies/storage
>
> tel.  734-821-5101
> fax.  734-769-8938
> cel.  734-216-5309
