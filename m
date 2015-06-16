From: Harshal Gupta <harshal.gupta001@gmail.com>
Subject: Re: Duplicate bucket creation Response in RGW
Date: Wed, 17 Jun 2015 01:54:02 +0530
Message-ID: <CAPRac-Y04yTjmxDF=BTi5bSuwmqSoXTckRLok+3TWnxLWVTz7A@mail.gmail.com>
References: <CAPRac-a9gp1B9J3L-_TjkkP3-M9ZkvF-HwQ505NvJaqhEC392w@mail.gmail.com>
 <1875013920.12639009.1433959710332.JavaMail.zimbra@redhat.com>
 <CAPRac-b9O0Dx4mGnMDfe5NjW5gGmAqp7zN6k9DcTdceHK5AS8Q@mail.gmail.com>
 <1688384556.13183297.1434040012831.JavaMail.zimbra@redhat.com>
 <CAFMfnwqsxGyQSE64G6_MsQMdN5PD-yoBsfrujpKxXj2zOQUUsA@mail.gmail.com> <724456735.13364839.1434066715855.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38117 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754848AbbFPUYY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2015 16:24:24 -0400
Received: by wibdq8 with SMTP id dq8so30989247wib.1
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 13:24:23 -0700 (PDT)
In-Reply-To: <724456735.13364839.1434066715855.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Kyle Bader <kyle.bader@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

I understand here the major concern is for the clients who have
developed their apps keeping in mind 200 OK as the response in
duplicate bucket creation. However 409 can be useful in a scenario
which can be derived as below:

A customer belonging to a company account creates a bucket and fill it with some
files. A colleague of his then tries to create a bucket with the same
name as above with the same keys which are shared by the employees of
that company or a team in particular. Now since he gets 200 OK, he
thinks the bucket is created anew and tries to use it to upload some
modified versions of the previously uploaded files in that bucket, for
his own use. Now the original files will be lost.

In case if he gets 409, he will actually know that there may be some
data in the already created bucket and might check on it before
overriding it.

Since Changing the response to 409 might cause a problem to the
existing customers, we can instead provide a option (boolean probably)
'use_aws_standard_region_responses' which checks whether the region is
standard or different. Default can be true. Existing users can go with
true and we can give option to configure for new users. This flag
might as well used for fixing for other region based discrepancies in
AWS S3.

Thanks,

On Fri, Jun 12, 2015 at 5:21 AM, Yehuda Sadeh-Weinraub
<yehuda@redhat.com> wrote:
>
>
> ----- Original Message -----
>> From: "Kyle Bader" <kyle.bader@gmail.com>
>> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
>> Cc: "Harshal Gupta" <harshal.gupta001@gmail.com>, "ceph-devel" <ceph-devel@vger.kernel.org>
>> Sent: Thursday, June 11, 2015 2:22:56 PM
>> Subject: Re: Duplicate bucket creation Response in RGW
>>
>> > I don't see a compelling reason why to change our current behaviour. The
>> > fact that Amazon itself is inconsistent makes me think that it just an
>> > artifact of their architecture, rather than a carefully designed api.
>>
>> Interesting.. if we look at the Amazon S3 FAQ we can understand the
>> differences in API responses:
>>
>> "Q: What data consistency model does Amazon S3 employ?
>>
>> Amazon S3 buckets in the US Standard region provide eventual
>> consistency. Amazon S3 buckets in all other regions provide
>> read-after-write consistency for PUTS of new objects and eventual
>> consistency for overwrite PUTS and DELETES."
>>
>> If we consider buckets in our implementation to be eventually
>> consistent, we should probably return 200. If we can provide
>> read-after-write consistency, then we should probably return 209.
>>
>
> Do they tie the different responses to the different consistency models in the different regions? We're strongly consistent, however, I still think that bucket creation should be idempotent. Impatient client applications tend to retry operations and end up with error responses that can be avoided.
>
> Yehuda



-- 
HARSHAL GUPTA
Software Engineer
KIWI Inc.
