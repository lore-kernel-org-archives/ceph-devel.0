From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [RFC PATCH] ceph: serialize the direct writes when couldn't
 submit in a single req
Date: Thu, 6 Feb 2020 10:51:13 +0800
Message-ID: <9819b72a-f4fb-f45d-b1d8-c48359092faa@redhat.com>
References: <20200204015445.4435-1-xiubli@redhat.com>
 <06b35b716c6f158360f2a21f00c3c1c0232562cc.camel@kernel.org>
 <e9677dc33eecf80ee988e946cc84a4d9a9803d15.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55746 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727474AbgBFCv1 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Feb 2020 21:51:27 -0500
In-Reply-To: <e9677dc33eecf80ee988e946cc84a4d9a9803d15.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/6 0:38, Jeff Layton wrote:
> On Wed, 2020-02-05 at 11:24 -0500, Jeff Layton wrote:
>> On Mon, 2020-02-03 at 20:54 -0500, xiubli@redhat.com wrote:
>>> From: Xiubo Li <xiubli@redhat.com>
>>>
>>> If the direct io couldn't be submit in a single request, for multiple
>>> writers, they may overlap each other.
>>>
>>> For example, with the file layout:
>>> ceph.file.layout="stripe_unit=4194304 stripe_count=1 object_size=4194304
>>>
>>> fd = open(, O_DIRECT | O_WRONLY, );
>>>
>>> Writer1:
>>> posix_memalign(&buffer, 4194304, SIZE);
>>> memset(buffer, 'T', SIZE);
>>> write(fd, buffer, SIZE);
>>>
>>> Writer2:
>>> posix_memalign(&buffer, 4194304, SIZE);
>>> memset(buffer, 'X', SIZE);
>>> write(fd, buffer, SIZE);
>>>
>>>  From the test result, the data in the file possiblly will be:
>>> TTT...TTT <---> object1
>>> XXX...XXX <---> object2
>>>
>>> The expected result should be all "XX.." or "TT.." in both object1
>>> and object2.
>>>
>> I really don't see this as broken. If you're using O_DIRECT, I don't
>> believe there is any expectation that the write operations (or even read
>> operations) will be atomic wrt to one another.
>>
>> Basically, when you do this, you're saying "I know what I'm doing", and
>> need to provide synchronization yourself between competing applications
>> and clients (typically via file locking).
>>
> In fact, here's a discussion about this from a couple of years ago. This
> one mostly applies to local filesystems, but the same concepts apply to
> CephFS as well:
>
>
> https://www.spinics.net/lists/linux-fsdevel/msg118115.html
>
Okay. So for the O_DIRECT write/read, we won't guarantee it will be 
atomic in fs layer.

Thanks,
