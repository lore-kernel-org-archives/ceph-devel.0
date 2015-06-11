From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Duplicate bucket creation Response in RGW
Date: Thu, 11 Jun 2015 12:26:52 -0400 (EDT)
Message-ID: <1688384556.13183297.1434040012831.JavaMail.zimbra@redhat.com>
References: <CAPRac-a9gp1B9J3L-_TjkkP3-M9ZkvF-HwQ505NvJaqhEC392w@mail.gmail.com> <1875013920.12639009.1433959710332.JavaMail.zimbra@redhat.com> <CAPRac-b9O0Dx4mGnMDfe5NjW5gGmAqp7zN6k9DcTdceHK5AS8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:50740 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754963AbbFKQ0y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jun 2015 12:26:54 -0400
In-Reply-To: <CAPRac-b9O0Dx4mGnMDfe5NjW5gGmAqp7zN6k9DcTdceHK5AS8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Harshal Gupta <harshal.gupta001@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I don't see a compelling reason why to change our current behaviour. The fact that Amazon itself is inconsistent makes me think that it just an artifact of their architecture, rather than a carefully designed api.

Yehuda

----- Original Message -----
> From: "Harshal Gupta" <harshal.gupta001@gmail.com>
> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
> Cc: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Thursday, June 11, 2015 4:30:08 AM
> Subject: Re: Duplicate bucket creation Response in RGW
> 
> Hi Yehuda,
> 
> Following were my findings after I have created two buckets
> "my-bucket-test-in-main" in US-Standard and "my-bucket-test-in-eu" in
> EU region.
> 
> 1. AWS throws 409 conflict with error code "BucketAlreadyOwnedByYou"
> when I try to recreate either of the two buckets in EU region.
> 
> 2. Throws 200 OK for "my-bucket-test-in-main" and 409 Conflict for
> "my-bucket-test-in-EU" when I try to recreate the buckets in
> US-Standard region.
> 
> So we can say that except the US-Standard region,  in all the other
> regions, it throws 409 whenever you try to recreate a bucket . Thus
> US-Standard region is a special case.
> 
> Similar observations can be seen for Bucket name Restrictions, where
> it is far more relaxed in US-Standard region. I was able to create
> names as "test_.._main-by-me", in US-Standard region, which is clearly
> non DNS-compliant and which AWS discourages, according to their bucket
> names page.
> 
> So I think that we can try to implement these according to what AWS is
> following for the non-standard regions. Similarly I am planning to do
> the same for bucket name restrictions so that they are more
> DNS-compliant and similar to what AWS follows in other regions.
> 
> Please let me know your opinion. I am referring from following pages
> in AWS documentation:
> 
> 1. http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html
> 2. http://docs.aws.amazon.com/AmazonS3/latest/API/ErrorResponses.html
> 
> Thanks,
> Harshal
> 
> On Wed, Jun 10, 2015 at 11:38 PM, Yehuda Sadeh-Weinraub
> <yehuda@redhat.com> wrote:
> >
> > iirc we return 409 in case you're trying to recreate the bucket in a
> > different region. I don't see why we should return it if the user tries to
> > create it in the same region it exists in. Amazon does not return 409 if a
> > bucket is recreated on their main region (where it already exists), so I'm
> > not sure why there should be an inconsistency when dealing with other
> > regions.
> >
> > Yehuda
> >
> > ----- Original Message -----
> >> From: "Harshal Gupta" <harshal.gupta001@gmail.com>
> >> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> >> Sent: Wednesday, June 10, 2015 5:22:51 AM
> >> Subject: Duplicate bucket creation Response in RGW
> >>
> >> Hi,
> >>
> >> I was comparing response of S3 and Ceph RGW for when we try to create
> >> a bucket which already exists for the same account.
> >>
> >> S3 (non-default region) throws an error with:
> >> HTTP response code : 409 Conflict
> >> error code : BucketAlreadyOwnedByYou
> >>
> >> but on the other hand ceph gives a 200 OK while keeping the original
> >> bucket as it is.
> >>
> >> I am thinking to match the functionality of Ceph RGW same as s3
> >> (non-default regions), as the one given by S3 seems more appropriate.
> >>
> >> For this, I have added a new error code "BucketAlreadyOwnedByYou"
> >> which will be thrown in the above mentioned
> >> case.
> >>
> >> Please give your opinion about it.
> >>
> >> Thanks
> >>
> >> --
> >> HARSHAL GUPTA
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> 
> 
> 
> --
> HARSHAL GUPTA
> Software Engineer
> KIWI Inc.
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
