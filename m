From: Wido den Hollander <wido@42on.com>
Subject: Re: Need some help with the RBD Java bindings
Date: Wed, 21 Aug 2013 14:11:34 +0200
Message-ID: <5214AE76.7070304@42on.com>
References: <520CF90B.2070106@42on.com> <CA+Hcz59PTw9u6s8J3pZpbPgyMdh78zd3qzkBmb_+S+w4_JjMOg@mail.gmail.com> <CA+Hcz58M-fz_qq6ZgEvxovj3OEGF6zG8TSFtsOOMkKUo-YZznw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:45442 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751641Ab3HUMLg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 21 Aug 2013 08:11:36 -0400
In-Reply-To: <CA+Hcz58M-fz_qq6ZgEvxovj3OEGF6zG8TSFtsOOMkKUo-YZznw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/20/2013 11:26 PM, Noah Watkins wrote:
> Wido,
>
> I pushed up a patch to
>
>     https://github.com/ceph/rados-java/commit/ca16d82bc5b596620609880e429ec9f4eaa4d5ce
>
> That includes a fix for this problem. The fix is a bit hacky, but the
> tests pass now. I included more details about the hack in the code.
>

I see. Works like a charm for me now. I'll do some further testing with 
CloudStack.

Wido

> On Thu, Aug 15, 2013 at 9:57 AM, Noah Watkins <noah.watkins@inktank.com> wrote:
>> On Thu, Aug 15, 2013 at 8:51 AM, Wido den Hollander <wido@42on.com> wrote:
>>>
>>> public List<RbdSnapInfo> snapList() throws RbdException {
>>>      IntByReference numSnaps = new IntByReference(16);
>>>      PointerByReference snaps = new PointerByReference();
>>>      List<RbdSnapInfo> list = new ArrayList<RbdSnapInfo>();
>>>      RbdSnapInfo snapInfo, snapInfos[];
>>>
>>>      while (true) {
>>>          int r = rbd.rbd_snap_list(this.getPointer(), snaps, numSnaps);
>>
>> I think you need to allocate the memory for `snaps` yourself. Here is
>> the RBD wrapper for Python which does that:
>>
>>    self.snaps = (rbd_snap_info_t * num_snaps.value)()
>>    ret = self.librbd.rbd_snap_list(image.image, byref(self.snaps),
>>                         byref(num_snaps))
>>
>> - Noah
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
