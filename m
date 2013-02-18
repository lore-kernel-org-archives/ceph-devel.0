From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: [ceph-users] RGW Multipart Uplaods
Date: Mon, 18 Feb 2013 11:15:58 -0800
Message-ID: <CAC-hyiHFcJwmA+AH+YkKrVN2QP5=UXzs9qR2hPJsMZYzPY0u9A@mail.gmail.com>
References: <512256AA.6070408@umiacs.umd.edu>
	<CAC-hyiE_UAojZCDJ14BRn-hSN-RKJtNDSaaMfzhsPboF8NZ2vA@mail.gmail.com>
	<512278F4.1000701@umiacs.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:44641 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756801Ab3BRTQA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Feb 2013 14:16:00 -0500
Received: by mail-la0-f45.google.com with SMTP id er20so5876265lab.32
        for <ceph-devel@vger.kernel.org>; Mon, 18 Feb 2013 11:15:59 -0800 (PST)
In-Reply-To: <512278F4.1000701@umiacs.umd.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: derek@umiacs.umd.edu
Cc: "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Mon, Feb 18, 2013 at 10:54 AM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
> On 2/18/13 11:53 AM, Yehuda Sadeh wrote:
>> On Mon, Feb 18, 2013 at 8:28 AM, Derek Yarnell <derek@umiacs.umd.edu> wrote:
>>> Hi,
>>>
>>> I am trying to write some multipart parallel upload scripts.  I have run
>>> into an issue with listing the current multipart uploads.  Is this
>>> feature available in the current radosgw (0.56.3)?  I am able to upload
>>> using multipart when initiatiating the upload and then itterating over
>>> the chunks sequentially.  But when I try to iterate over a pool of
>>> chunks in parallel I can't call the listing of multipart uploads on the
>>> given bucket.
>>>
>>> The response I get back from the 'GET /?uploads HTTP/1.1' (the server is
>>> setup to handle bucket DNS names) is a 200 OK, with a XML
>>> <ListBucketResult> with the contents of the bucket.
>>>
>>
>> The code is there, but looking at it right now, I see some issue. Try
>> doing 'GET /?uploadId HTTP/1.1' instead.
>>
>> The fix is trivial, I opened issue #4177 for that. I'm also opening an
>> issue for fixing our test suite, as it was supposed to catch this
>> issue.
>>
>> Thanks,
>> Yehuda
>>
>
> Hi Yehuda,
>
> Many thanks as usual.  The uploadID syntax seems to give 500 errors as
> seen by this request (anonomized) below.
>
> Thanks,
> derek
>
> Mon, 18 Feb 2013 18:32:39 GMT
> /zeta/?uploadId
> 2013-02-18 13:32:44.023609 7fe36aff7700 15 b64=###
> 2013-02-18 13:32:44.023611 7fe36aff7700 15 auth_sign=###
> 2013-02-18 13:32:44.023612 7fe36aff7700 15 compare=0
> 2013-02-18 13:32:44.023614 7fe36aff7700  2 req 6:0.000240:s3:GET
> /zeta/:list_multipart:reading permissions
> 2013-02-18 13:32:44.023621 7fe36aff7700 20 get_obj_state:
> rctx=0x7fe2fc001070 obj=.rgw:zeta state=0x7fe2fc009c08 s->prefetch_data=0
> 2013-02-18 13:32:44.023625 7fe36aff7700 10 moving .rgw+zeta to cache LRU end
> 2013-02-18 13:32:44.023627 7fe36aff7700 10 cache get: name=.rgw+zeta : hit
> 2013-02-18 13:32:44.023631 7fe36aff7700 20 get_obj_state: s->obj_tag was
> set empty
> 2013-02-18 13:32:44.023633 7fe36aff7700 10 moving .rgw+zeta to cache LRU end
> 2013-02-18 13:32:44.023634 7fe36aff7700 10 cache get: name=.rgw+zeta : hit
> 2013-02-18 13:32:44.023643 7fe36aff7700 20 rgw_get_bucket_info:
> bucket=zeta(@.rgw.buckets[4631.3]) owner derek
> 2013-02-18 13:32:44.023650 7fe36aff7700 20 get_obj_state:
> rctx=0x7fe2fc001070 obj=zeta: state=0x7fe2fc009c08 s->prefetch_data=0
> 2013-02-18 13:32:44.023659 7fe36aff7700 15 Read
> AccessControlPolicy<AccessControlPolicy
> xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>derek</ID><DisplayName>Derek
> Yarnell</DisplayName></Owner><AccessControlList><Grant><Grantee
> xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
> xsi:type="CanonicalUser"><ID>derek</ID><DisplayName>Derek
> Yarnell</DisplayName></Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlList></AccessControlPolicy>
> 2013-02-18 13:32:44.023669 7fe36aff7700 20 get_obj_state:
> rctx=0x7fe2fc001070 obj=zeta: state=0x7fe2fc009c08 s->prefetch_data=0
> 2013-02-18 13:32:44.023675 7fe36aff7700 15 Read
> AccessControlPolicy<AccessControlPolicy
> xmlns="http://s3.amazonaws.com/doc/2006-03-01/"><Owner><ID>derek</ID><DisplayName>Derek
> Yarnell</DisplayName></Owner><AccessControlList><Grant><Grantee
> xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
> xsi:type="CanonicalUser"><ID>derek</ID><DisplayName>Derek
> Yarnell</DisplayName></Grantee><Permission>FULL_CONTROL</Permission></Grant></AccessControlList></AccessControlPolicy>
> 2013-02-18 13:32:44.023680 7fe36aff7700  2 req 6:0.000305:s3:GET
> /zeta/:list_multipart:verifying op permissions
> 2013-02-18 13:32:44.023682 7fe36aff7700  5 Searching permissions for
> uid=derek mask=1
> 2013-02-18 13:32:44.023684 7fe36aff7700  5 Found permission: 15
> 2013-02-18 13:32:44.023685 7fe36aff7700 10  uid=derek requested perm
> (type)=1, policy perm=1, user_perm_mask=15, acl perm=1
> 2013-02-18 13:32:44.023687 7fe36aff7700  2 req 6:0.000313:s3:GET
> /zeta/:list_multipart:verifying op params
> 2013-02-18 13:32:44.023689 7fe36aff7700  2 req 6:0.000315:s3:GET
> /zeta/:list_multipart:executing
> 2013-02-18 13:32:44.023692 7fe36aff7700  0 WARNING: set_req_state_err
> err_no=95 resorting to 500

Right. It's executing the wrong operation (list_multipart instead of
list_bucket_multipart). I pushed a fix to a branch (wip-4177-bobtail)
that is on top of bobtail. You could experiment with it once our
gitbuilders pick it up and build it (shouldn't take too long).

Yehuda
