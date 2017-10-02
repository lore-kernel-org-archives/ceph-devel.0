From: Casey Bodley <cbodley@redhat.com>
Subject: Re: Encrypted over WAN?
Date: Mon, 2 Oct 2017 14:40:14 -0400
Message-ID: <c1e95b98-8f83-0ab4-b812-999401ae12ee@redhat.com>
References: <CAKRxpuuFHUgoQh8MfhS=vK9f6NVRbAWyccMWWGwJM9UCnw8dtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:43053 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdJBSkR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Oct 2017 14:40:17 -0400
Received: by mail-qk0-f180.google.com with SMTP id w134so6171241qkb.0
        for <ceph-devel@vger.kernel.org>; Mon, 02 Oct 2017 11:40:17 -0700 (PDT)
In-Reply-To: <CAKRxpuuFHUgoQh8MfhS=vK9f6NVRbAWyccMWWGwJM9UCnw8dtw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Two Spirit <twospirit6905@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi,

As this quoted text came from the RGW server-side encryption docs [1], 
I'll add some details about that.

First, this is an S3-only feature that implements two of Amazon's 
specifications, SSE-C and SSE-KMS. For each upload, the S3 client must 
specifically request server side encryption by providing extra headers 
for each object upload. For example, you can do this with boto3 [2] by 
providing a ServerSideEncryption with either a SSEKMSKeyId or 
SSECustomerKey/SSECustomerAlgorithm when uploading an object.

Because this encryption must be requested by the client on a per-object 
basis, and will not apply to the Swift protocol at all, it can't be used 
to provide blanket encryption for all radosgw object data. At best, a 
bucket policy could require SSE-KMS encryption for all contained 
objects, but this is not yet implemented in RGW.

This encryption only applies to object data. Other metadata, such as 
object names, sizes and etags, are still visible to any client that can 
GET the bucket listing or HEAD the objects.


On 10/02/2017 02:18 AM, Two Spirit wrote:
>> The Ceph Object Gateway supports server-side encryption of uploaded objects, with 3 options for the management of encryption keys. Server-side encryption means that the data is sent over HTTP in its unencrypted form, and the Ceph Object Gateway stores that data in the Ceph Storage Cluster in encrypted form.

While this says that data is sent over HTTP in its unencrypted form, the 
Amazon specifications do require that SSE requests be made over an SSL 
connection, and RGW does enforce this.

> It sounds like OSD to OSD traffic is unencrypted.
>
> 1) Does "stores data in the cluster in encrypted form" mean *only* if
> the --dmcrypt option is used?

RGW server side encryption does not rely on the dmcrypt configuration of 
the OSDs. For SSE-enabled objects, RGW will encrypt the object data 
before sending it to OSDs, so unencrypted data is not sent over Ceph's 
client/cluster networks.

>
> 2) Does that mean the zone  to zone copy across a WAN is also unencrypted?

In a multisite configuration, SSE-enabled objects are replicated between 
zones in their encrypted form. The same requirements for decryption 
apply to both zones.

> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


[1] http://docs.ceph.com/docs/luminous/radosgw/encryption/
[2] 
http://boto3.readthedocs.io/en/latest/reference/services/s3.html#S3.Client.put_object
