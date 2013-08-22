From: Wido den Hollander <wido@42on.com>
Subject: Re: Need some help with the RBD Java bindings
Date: Thu, 22 Aug 2013 08:20:41 +0200
Message-ID: <5215ADB9.2010607@42on.com>
References: <520CF90B.2070106@42on.com> <CA+Hcz59PTw9u6s8J3pZpbPgyMdh78zd3qzkBmb_+S+w4_JjMOg@mail.gmail.com> <CA+Hcz58M-fz_qq6ZgEvxovj3OEGF6zG8TSFtsOOMkKUo-YZznw@mail.gmail.com> <5214AE76.7070304@42on.com> <CA+Hcz5_uDJcOv_RiSswGmu6sfikp=rdX4=rn3WrxZA21DsHSMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:46233 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753162Ab3HVGUn (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 22 Aug 2013 02:20:43 -0400
In-Reply-To: <CA+Hcz5_uDJcOv_RiSswGmu6sfikp=rdX4=rn3WrxZA21DsHSMg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 08/21/2013 09:47 PM, Noah Watkins wrote:
> Wido,
>
> How would you feel about creating two RbdSnapInfo objects. The first
> would be something like ceph.rbd.RbdSnapInfo and the second would be
> ceph.rbd.jna.RbdSnapInfo. The former is what will be exposed through
> the API, and the later is used only internally. That should address
> the hacky-ness of my snap listing fix: just create a copy of the
> SnapInfo into the public struct. it also means we can avoid exposing
> users to JNA structures.
>

Yes, seems like a good thing to do. I wasn't sure myself when I was 
writing the bindings on how the packaging should be.

One of the things I haven't tested thoroughly enough is if you as a user 
of the bindings are able to crash the JVM. Since that should never happen.

Wido

> On Wed, Aug 21, 2013 at 5:11 AM, Wido den Hollander <wido@42on.com> wrote:
>> On 08/20/2013 11:26 PM, Noah Watkins wrote:
>>>
>>> Wido,
>>>
>>> I pushed up a patch to
>>>
>>>
>>> https://github.com/ceph/rados-java/commit/ca16d82bc5b596620609880e429ec9f4eaa4d5ce
>>>
>>> That includes a fix for this problem. The fix is a bit hacky, but the
>>> tests pass now. I included more details about the hack in the code.
>>>
>>
>> I see. Works like a charm for me now. I'll do some further testing with
>> CloudStack.
>>
>> Wido
>>
>>> On Thu, Aug 15, 2013 at 9:57 AM, Noah Watkins <noah.watkins@inktank.com>
>>> wrote:
>>>>
>>>> On Thu, Aug 15, 2013 at 8:51 AM, Wido den Hollander <wido@42on.com>
>>>> wrote:
>>>>>
>>>>>
>>>>> public List<RbdSnapInfo> snapList() throws RbdException {
>>>>>       IntByReference numSnaps = new IntByReference(16);
>>>>>       PointerByReference snaps = new PointerByReference();
>>>>>       List<RbdSnapInfo> list = new ArrayList<RbdSnapInfo>();
>>>>>       RbdSnapInfo snapInfo, snapInfos[];
>>>>>
>>>>>       while (true) {
>>>>>           int r = rbd.rbd_snap_list(this.getPointer(), snaps, numSnaps);
>>>>
>>>>
>>>> I think you need to allocate the memory for `snaps` yourself. Here is
>>>> the RBD wrapper for Python which does that:
>>>>
>>>>     self.snaps = (rbd_snap_info_t * num_snaps.value)()
>>>>     ret = self.librbd.rbd_snap_list(image.image, byref(self.snaps),
>>>>                          byref(num_snaps))
>>>>
>>>> - Noah
>>>
>>> --
>>>
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> --
>> Wido den Hollander
>> 42on B.V.
>>
>> Phone: +31 (0)20 700 9902
>> Skype: contact42on
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
