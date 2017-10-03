From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Encrypted over WAN?
Date: Tue, 3 Oct 2017 11:06:03 -0400
Message-ID: <80a9112a-d071-d96a-2a0a-28a44623c14b@redhat.com>
References: <CAKRxpuuFHUgoQh8MfhS=vK9f6NVRbAWyccMWWGwJM9UCnw8dtw@mail.gmail.com>
 <c1e95b98-8f83-0ab4-b812-999401ae12ee@redhat.com>
 <CAKRxpusbLgXBvMCAcLtR2Ox37ORtc4m=z=r605BcqQ6H+YfUMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:44497 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdJCPGH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Oct 2017 11:06:07 -0400
Received: by mail-qt0-f178.google.com with SMTP id v28so4651246qtv.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Oct 2017 08:06:07 -0700 (PDT)
In-Reply-To: <CAKRxpusbLgXBvMCAcLtR2Ox37ORtc4m=z=r605BcqQ6H+YfUMQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>



On 10/02/2017 04:20 PM, Two Spirit wrote:
> Thank you for the details. Very helpful to understand the state of
> this. I needed some more clarifications inline below:
>
>> This encryption only applies to object data. Other metadata, such as
>> object names, sizes and etags, are still visible to any client that can
>> GET the bucket listing or HEAD the objects.
> Just for clarification, does the "object data" imply block data too?
> and was this statement about the S3 only or also applies to Swift?

This applies only to the contents of S3 objects, which RGW stores on 
OSDs as rados objects.

>
>>> It sounds like OSD to OSD traffic is unencrypted.
>>>
>>> 1) Does "stores data in the cluster in encrypted form" mean *only* if
>>> the --dmcrypt option is used?
>> RGW server side encryption does not rely on the dmcrypt configuration
>> of the OSDs. For SSE-enabled objects, RGW will encrypt the object
>> data before sending it to OSDs, so unencrypted data is not sent over
>> Ceph's client/cluster networks.
> Got it, so --dmcrypt is basically on disk encryption of the OSDs and
> not related to any transport encryption.
>
>
>>> 2) Does that mean the zone  to zone copy across a WAN is also
>>> unencrypted?
>> In a multisite configuration, SSE-enabled objects are replicated between
>> zones in their encrypted form. The same requirements for decryption
>> apply to both zones.
> I'm considering evaluating Swift integration with Ceph for multisite
> configuration. Does "and will not apply to the Swift protocol at all",
> mean there is no encryption between RGWs? (I wasn't sure if I even
> needed RGWs if Swift handles all the multisite traffic -- haven't
> looked into details yet) Or is there an implication that the Swift
> protocol itself could potentially now or in the future handle
> encrypted transport?

You should use SSL to protect the transport between zones. This would be 
independent of any object level encryption, so would work for both Swift 
and S3.

>
>
> thanks!
>
> On Mon, Oct 2, 2017 at 11:40 AM, Casey Bodley <cbodley@redhat.com> wrote:
>> Hi,
>>
>> As this quoted text came from the RGW server-side encryption docs [1], I'll
>> add some details about that.
>>
>> First, this is an S3-only feature that implements two of Amazon's
>> specifications, SSE-C and SSE-KMS. For each upload, the S3 client must
>> specifically request server side encryption by providing extra headers for
>> each object upload. For example, you can do this with boto3 [2] by providing
>> a ServerSideEncryption with either a SSEKMSKeyId or
>> SSECustomerKey/SSECustomerAlgorithm when uploading an object.
>>
>> Because this encryption must be requested by the client on a per-object
>> basis, and will not apply to the Swift protocol at all, it can't be used to
>> provide blanket encryption for all radosgw object data. At best, a bucket
>> policy could require SSE-KMS encryption for all contained objects, but this
>> is not yet implemented in RGW.
>>
>> This encryption only applies to object data. Other metadata, such as object
>> names, sizes and etags, are still visible to any client that can GET the
>> bucket listing or HEAD the objects.
>>
>>
>> On 10/02/2017 02:18 AM, Two Spirit wrote:
>>>> The Ceph Object Gateway supports server-side encryption of uploaded
>>>> objects, with 3 options for the management of encryption keys. Server-side
>>>> encryption means that the data is sent over HTTP in its unencrypted form,
>>>> and the Ceph Object Gateway stores that data in the Ceph Storage Cluster in
>>>> encrypted form.
>>
>> While this says that data is sent over HTTP in its unencrypted form, the
>> Amazon specifications do require that SSE requests be made over an SSL
>> connection, and RGW does enforce this.
>>
>>> It sounds like OSD to OSD traffic is unencrypted.
>>>
>>> 1) Does "stores data in the cluster in encrypted form" mean *only* if
>>> the --dmcrypt option is used?
>>
>> RGW server side encryption does not rely on the dmcrypt configuration of the
>> OSDs. For SSE-enabled objects, RGW will encrypt the object data before
>> sending it to OSDs, so unencrypted data is not sent over Ceph's
>> client/cluster networks.
>>
>>> 2) Does that mean the zone  to zone copy across a WAN is also unencrypted?
>>
>> In a multisite configuration, SSE-enabled objects are replicated between
>> zones in their encrypted form. The same requirements for decryption apply to
>> both zones.
>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> [1] http://docs.ceph.com/docs/luminous/radosgw/encryption/
>> [2]
>> http://boto3.readthedocs.io/en/latest/reference/services/s3.html#S3.Client.put_object

