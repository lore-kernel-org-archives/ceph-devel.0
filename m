From: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Subject: Re: Duplicate bucket creation Response in RGW
Date: Wed, 10 Jun 2015 14:08:30 -0400 (EDT)
Message-ID: <1875013920.12639009.1433959710332.JavaMail.zimbra@redhat.com>
References: <CAPRac-a9gp1B9J3L-_TjkkP3-M9ZkvF-HwQ505NvJaqhEC392w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:49412 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932164AbbFJSId (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jun 2015 14:08:33 -0400
In-Reply-To: <CAPRac-a9gp1B9J3L-_TjkkP3-M9ZkvF-HwQ505NvJaqhEC392w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Harshal Gupta <harshal.gupta001@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


iirc we return 409 in case you're trying to recreate the bucket in a different region. I don't see why we should return it if the user tries to create it in the same region it exists in. Amazon does not return 409 if a bucket is recreated on their main region (where it already exists), so I'm not sure why there should be an inconsistency when dealing with other regions.

Yehuda

----- Original Message -----
> From: "Harshal Gupta" <harshal.gupta001@gmail.com>
> To: "ceph-devel" <ceph-devel@vger.kernel.org>
> Sent: Wednesday, June 10, 2015 5:22:51 AM
> Subject: Duplicate bucket creation Response in RGW
> 
> Hi,
> 
> I was comparing response of S3 and Ceph RGW for when we try to create
> a bucket which already exists for the same account.
> 
> S3 (non-default region) throws an error with:
> HTTP response code : 409 Conflict
> error code : BucketAlreadyOwnedByYou
> 
> but on the other hand ceph gives a 200 OK while keeping the original
> bucket as it is.
> 
> I am thinking to match the functionality of Ceph RGW same as s3
> (non-default regions), as the one given by S3 seems more appropriate.
> 
> For this, I have added a new error code "BucketAlreadyOwnedByYou"
> which will be thrown in the above mentioned
> case.
> 
> Please give your opinion about it.
> 
> Thanks
> 
> --
> HARSHAL GUPTA
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
