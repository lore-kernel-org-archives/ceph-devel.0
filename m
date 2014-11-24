From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] rbd: don't treat CEPH_OSD_OP_DELETE as extent op
Date: Mon, 24 Nov 2014 11:46:51 -0600
Message-ID: <54736F0B.6030702@ieee.org>
References: <1416823190-10246-1-git-send-email-idryomov@redhat.com>	<54732326.7050301@ieee.org> <CALFYKtB1qOj0d4eGdKGe=kS3-u+odgGFt-euSt5Zhshs8RXbPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:47566 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530AbaKXRqx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Nov 2014 12:46:53 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so9229210ier.4
        for <ceph-devel@vger.kernel.org>; Mon, 24 Nov 2014 09:46:52 -0800 (PST)
In-Reply-To: <CALFYKtB1qOj0d4eGdKGe=kS3-u+odgGFt-euSt5Zhshs8RXbPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On 11/24/2014 07:30 AM, Ilya Dryomov wrote:
> On Mon, Nov 24, 2014 at 3:23 PM, Alex Elder <elder@ieee.org> wrote:
>> On 11/24/2014 03:59 AM, Ilya Dryomov wrote:
>>> CEPH_OSD_OP_DELETE is not an extent op, stop treating it as such.  This
>>> sneaked in with discard patches - it's one of the three osd ops (the
>>> other two are CEPH_OSD_OP_TRUNCATE and CEPH_OSD_OP_ZERO) that discard
>>> is implemented with.
>>>
>>> Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
>>
>> Is the CEPH_OSD_OP_DELETE used in ceph_zero_partial_object()
>> an extent op?  If it is not, you should get rid of the BUG_ON()
>> in osd_req_op_extent_init() that allows CEPH_OSD_OP_DELETE.
>>
>> And if that's the case it looks like that function or
>> ceph_osdc_new_request() handle CEPH_OSD_OP_DELETE
>> properly--so it's not treated as an extent op.
>>
>> And:  osd_req_encode_op() encodes a CEPH_OSD_OP_DELETE
>> as an extent op as well.
>>
>> If it *can* be an extent op (but just not as used by RBD)
>> then it warrants a comment here that explains why it is
>> not being initialized as an extent op.
> 
> Hi Alex,
> 
> Clearly I didn't provide enough background.
> 
> OSDs don't look at extent part of the op union when processing
> CEPH_OSD_OP_DELETE, so it's not an extent op.
> 
> Zheng added support for CEPH_OSD_OP_CREATE and in the same commit
> changed osd_req_op_extent_init(), ceph_osdc_new_request() and
> osd_req_encode_op() to not allow/encode CEPH_OSD_OP_DELETE, see [1].
> This patch was rebased into testing before [1] in order to not break
> git bisect as Zheng didn't care of rbd, which only recently started
> issuing CEPH_OSD_OP_DELETE for whole-object discards.

So it sounds like my concerns were addressed in the Zheng's
original patch.  RBD didn't used to use OP_DELETE, and once it
did, the fact that it encoded it as an extent op didn't matter
because the OSD ignored anything it sent for the extent.
Therefore this is just cleaning up RBD code that was not
exhibiting erroneous behavior.

I'm sorry I didn't update my tree before reviewing the patch...

Reviewed-by: Alex Elder <elder@linaro.org>

> [1] https://github.com/ceph/ceph-client/commit/6d23aa137d1861fc48f86ba6532458fcebcdd038
> 
> Thanks,
> 
>                 Ilya
> 

