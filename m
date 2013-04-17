From: Brian Behlendorf <behlendorf1@llnl.gov>
Subject: Re: test osd on zfs
Date: Wed, 17 Apr 2013 11:06:16 -0700
Message-ID: <516EE498.6030308@llnl.gov>
References: <516E7D5C.7080309@nazarianin.com> <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net> <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com> <516ECFB6.8090107@gmail.com> <CABBk=J93+1TRnjtr5D2cJWmre+tf85hAw3H1JnOL8hwKJuHDJA@mail.gmail.com> <alpine.DEB.2.00.1304171005360.30041@cobra.newdream.net> <CABBk=J_k0gAEx6a-agno8KHtn4-iZe5pfQLcrgtU2Ki2_kd8nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from prdiron-2.llnl.gov ([128.15.143.172]:23561 "EHLO
	prdiron-2.llnl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966324Ab3DQSQE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 14:16:04 -0400
In-Reply-To: <CABBk=J_k0gAEx6a-agno8KHtn4-iZe5pfQLcrgtU2Ki2_kd8nQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Jeff Mitchell <jeffrey.mitchell@gmail.com>, Henry C Chang <henry.cy.chang@gmail.com>, Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 04/17/2013 10:15 AM, Yehuda Sadeh wrote:
> On Wed, Apr 17, 2013 at 10:05 AM, Sage Weil <sage@inktank.com> wrote:
>> [Adding Brian to CC list again :)]
>>
>> On Wed, 17 Apr 2013, Yehuda Sadeh wrote:
>>
>>> On Wed, Apr 17, 2013 at 9:37 AM, Jeff Mitchell
>>> <jeffrey.mitchell@gmail.com> wrote:
>>>> Henry C Chang wrote:
>>>>>
>>>>> I looked into this problem earlier. The problem is that zfs does not
>>>>> return ERANGE when the size of value buffer passed to getxattr is too
>>>>> small. zfs returns with truncated xattr value.
>>>>
>>>>
>>>> Is this a bug in ZFS, or simply different behavior?
>>>
>>> Took a brief look at the zfs code, seems like a zfs bug.
>>>
>>> diff --git a/module/zfs/zpl_xattr.c b/module/zfs/zpl_xattr.c
>>> index c03764f..96db7dd 100644
>>> --- a/module/zfs/zpl_xattr.c
>>> +++ b/module/zfs/zpl_xattr.c
>>> @@ -263,6 +263,9 @@ zpl_xattr_get_sa(struct inode *ip, const char
>>> *name, void *value, size_t size)
>>>          if (!size)
>>>                  return (nv_size);
>>>
>>> +       if (size < nv_size)
>>> +               return (-ERANGE);
>>> +
>>>          memcpy(value, nv_value, MIN(size, nv_size));
>>>
>>>          return (MIN(size, nv_size));
>>>
>>>
>>> This should fix it. Not tested of course.
>
> Well, looking at the code again it's not going to work, as setxattr is
> going to fail with ERANGE.
>
> Yehuda
>

That does sounds like a zfs bug,  According to getxattr(2) it should 
return ERANGE if the buffer is too small.   I'll take a look but it's 
strange that this hasn't surfaced before.

        If the size of the value buffer is too small to hold the
        result,  errno is set to ERANGE.

Thanks,
Brian
