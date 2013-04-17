From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: test osd on zfs
Date: Wed, 17 Apr 2013 10:15:55 -0700
Message-ID: <CABBk=J_k0gAEx6a-agno8KHtn4-iZe5pfQLcrgtU2Ki2_kd8nQ@mail.gmail.com>
References: <516E7D5C.7080309@nazarianin.com>
	<alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net>
	<CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com>
	<516ECFB6.8090107@gmail.com>
	<CABBk=J93+1TRnjtr5D2cJWmre+tf85hAw3H1JnOL8hwKJuHDJA@mail.gmail.com>
	<alpine.DEB.2.00.1304171005360.30041@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:62086 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965286Ab3DQRP4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 13:15:56 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so2160912iea.4
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 10:15:56 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1304171005360.30041@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Jeff Mitchell <jeffrey.mitchell@gmail.com>, Henry C Chang <henry.cy.chang@gmail.com>, Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>, behlendorf1@llnl.gov

On Wed, Apr 17, 2013 at 10:05 AM, Sage Weil <sage@inktank.com> wrote:
> [Adding Brian to CC list again :)]
>
> On Wed, 17 Apr 2013, Yehuda Sadeh wrote:
>
>> On Wed, Apr 17, 2013 at 9:37 AM, Jeff Mitchell
>> <jeffrey.mitchell@gmail.com> wrote:
>> > Henry C Chang wrote:
>> >>
>> >> I looked into this problem earlier. The problem is that zfs does not
>> >> return ERANGE when the size of value buffer passed to getxattr is too
>> >> small. zfs returns with truncated xattr value.
>> >
>> >
>> > Is this a bug in ZFS, or simply different behavior?
>>
>> Took a brief look at the zfs code, seems like a zfs bug.
>>
>> diff --git a/module/zfs/zpl_xattr.c b/module/zfs/zpl_xattr.c
>> index c03764f..96db7dd 100644
>> --- a/module/zfs/zpl_xattr.c
>> +++ b/module/zfs/zpl_xattr.c
>> @@ -263,6 +263,9 @@ zpl_xattr_get_sa(struct inode *ip, const char
>> *name, void *value, size_t size)
>>         if (!size)
>>                 return (nv_size);
>>
>> +       if (size < nv_size)
>> +               return (-ERANGE);
>> +
>>         memcpy(value, nv_value, MIN(size, nv_size));
>>
>>         return (MIN(size, nv_size));
>>
>>
>> This should fix it. Not tested of course.

Well, looking at the code again it's not going to work, as setxattr is
going to fail with ERANGE.

Yehuda
