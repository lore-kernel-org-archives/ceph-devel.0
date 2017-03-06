From: Vaibhav Bhembre <vaibhav@digitalocean.com>
Subject: Re: RGW: Bucket Policies support
Date: Mon, 6 Mar 2017 16:09:42 -0500
Message-ID: <CADJota876prdk8d1wtDT0QdVdeptJwx-ZWD-iK-0H0BJoT73_A@mail.gmail.com>
References: <CADJota8vRLhZL8n9ofw_fn9t=XmiKALUQacqBWAwBw9aKy9g1A@mail.gmail.com>
 <20170306200038.GB11472@ultraspiritum.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f175.google.com ([74.125.82.175]:34981 "EHLO
        mail-ot0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbdCFVS6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Mar 2017 16:18:58 -0500
Received: by mail-ot0-f175.google.com with SMTP id x37so77924965ota.2
        for <ceph-devel@vger.kernel.org>; Mon, 06 Mar 2017 13:18:57 -0800 (PST)
In-Reply-To: <20170306200038.GB11472@ultraspiritum.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vaibhav Bhembre <vaibhav@digitalocean.com>, ceph-devel@vger.kernel.org

That's fantastic Adam! Waiting eagerly for the next dev or RC release
of Luminous where we can test this functionality out in our setup.

Thank you!

Regards,
Vaibhav

On Mon, Mar 6, 2017 at 3:00 PM, Adam C. Emerson <aemerson@redhat.com> wrote:
> On 06/03/2017, Vaibhav Bhembre wrote:
>> Hello Cephers!
>>
>> We know there is ongoing work that implements a certain subset of AWS
>> Security Token Service for RGW endpoints and were curious to know if it'd
>> include the ability to apply bucket-wide constraints as follows:
>>
>> {  "Version":"2012-10-17",
>>    "Statement":[
>>     {
>>        "Sid":"AddCannedAcl",
>>        "Effect":"Allow",
>>        "Principal": {"AWS":
>> ["arn:aws:iam::111122223333:root","arn:aws:iam::444455556666:root"]},
>>        "Action":["s3:PutObject","s3:PutObjectAcl"],
>>        "Resource":["arn:aws:s3:::examplebucket/*"],
>>     }
>>    ]
>> }
>>
>> In lieu of such facility, presently the only way to update permissions of
>> all objects within a bucket is to apply those permissions on each object
>> individually, which isn't always practical.
>>
>> It'd be quite helpful to have this feature in Luminous, if possible!
>
> Yes. That functionality SHOULD work. There's a bug at present where it
> doesn't now, but I traced that back to it being blocked by the owner
> check and I'm fixing that up.
>
> Once I make sure the we can add policies through REST and the
> radosgw_admin tool, I'll hammer on test and debug. We should have
> everything ready for luminus fairly soon.
>
> At the moment, the account ID is just the tenant name. Sometime in the
> future we'll be reifying tenants to some degree so you can make sure
> they have an account number that matches up with your AWS ID if you
> want to do mirroring, but I don't think that's necessary for the
> initial rollout/preview functionality.
>
>
> --
> Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
> IRC: Aemerson@{RedHat, OFTC}
> 0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
