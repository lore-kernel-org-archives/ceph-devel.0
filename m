From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: MDS connection problem
Date: Fri, 17 Nov 2017 16:40:19 +0800
Message-ID: <CAAM7YAnC1OqV5NvGUpR-iStPJ7if9eYbKQ=P5ULVtO3f62FZ_w@mail.gmail.com>
References: <d635ebd2-7ad0-5313-8245-3cc26b9d02c3@digiware.nl>
 <CAAM7YAnojjt9RAd4qubU9Bqm1so3vyfztXW+OkWeTr4Z0yU_hQ@mail.gmail.com> <fae14ef9-b13f-f75f-68e0-8805b8430703@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f45.google.com ([209.85.218.45]:35512 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965444AbdKQIkU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Nov 2017 03:40:20 -0500
Received: by mail-oi0-f45.google.com with SMTP id e142so1173007oih.2
        for <ceph-devel@vger.kernel.org>; Fri, 17 Nov 2017 00:40:20 -0800 (PST)
In-Reply-To: <fae14ef9-b13f-f75f-68e0-8805b8430703@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Nov 17, 2017 at 4:37 PM, Willem Jan Withagen <wjw@digiware.nl> wrote:
> On 16/11/2017 13:08, Yan, Zheng wrote:
>>
>> On Thu, Nov 16, 2017 at 3:06 AM, Willem Jan Withagen <wjw@digiware.nl>
>> wrote:
>>>
>>> After a server restart my MDS does not want to start, and it looks like
>>> keys
>>> don't match or something?
>>>
>>> This is de MDS log:
>>>
>>> 2017-11-15 20:03:18.180242 9e0e000 10 mds.a MDSDaemon::ms_get_authorizer
>>> type=mon
>>> 2017-11-15 20:03:18.181387 9e0f200 10 cephx: set_have_need_key no handler
>>> for service mon
>>> 2017-11-15 20:03:18.181394 9e0f200 10 cephx: set_have_need_key no handler
>>> for service mds
>>> 2017-11-15 20:03:18.181396 9e0f200 10 cephx: set_have_need_key no handler
>>> for service osd
>>> 2017-11-15 20:03:18.181399 9e0f200 10 cephx: set_have_need_key no handler
>>> for service mgr
>>> 2017-11-15 20:03:18.181401 9e0f200 10 cephx: set_have_need_key no handler
>>> for service auth
>>> 2017-11-15 20:03:18.181402 9e0f200 10 cephx: validate_tickets want 55
>>> have 0
>>> need 55
>>> 2017-11-15 20:03:18.181414 9e0f200 10 cephx client: handle_response ret =
>>> 0
>>> 2017-11-15 20:03:18.181417 9e0f200 10 cephx client:  got initial server
>>> challenge 7d0dda00ee4847b8
>>> 2017-11-15 20:03:18.181420 9e0f200 10 cephx client: validate_tickets:
>>> want=55 need=55 have=0
>>> 2017-11-15 20:03:18.181424 9e0f200 10 cephx: set_have_need_key no handler
>>> for service mon
>>> 2017-11-15 20:03:18.181426 9e0f200 10 cephx: set_have_need_key no handler
>>> for service mds
>>> 2017-11-15 20:03:18.181427 9e0f200 10 cephx: set_have_need_key no handler
>>> for service osd
>>> 2017-11-15 20:03:18.181428 9e0f200 10 cephx: set_have_need_key no handler
>>> for service mgr
>>> 2017-11-15 20:03:18.181429 9e0f200 10 cephx: set_have_need_key no handler
>>> for service auth
>>> 2017-11-15 20:03:18.181430 9e0f200 10 cephx: validate_tickets want 55
>>> have 0
>>> need 55
>>> 2017-11-15 20:03:18.181433 9e0f200 10 cephx client: want=55 need=55
>>> have=0
>>> 2017-11-15 20:03:18.181439 9e0f200 10 cephx client: build_request
>>> 2017-11-15 20:03:18.181451 9e0f200 20 cephx client: no secret found for
>>> entity: mds.a
>>> 2017-11-15 20:03:18.182114 9e0f200 10 cephx client: handle_response ret =
>>> -22
>>> 2017-11-15 20:03:18.182214 9b54480 -1 mds.a ERROR: failed to
>>> authenticate:
>>> (22) Invalid argument
>>> 2017-11-15 20:03:18.182253 9b54480  1 mds.a suicide.  wanted state
>>> up:boot
>>> 2017-11-15 20:03:18.182401 9b54480 10 mds.beacon.a set_want_state:
>>> up:boot
>>> -> down:dne
>>
>>
>> Please check if content of /var/lib/ceph/mds/ceph-a/keyring is
>> correct. I got similar error after truncating that file
>
>
> Right so how do I do that.
>
> One way or another I have a hard time getting my head wrapped around the
> auth-model that ceph uses...

ceph auth get mds.a | head -n 2 > /var/lib/ceph/mds/ceph-a/keyring
>
> --WjW
>
>
