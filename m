From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: test osd on zfs
Date: Wed, 17 Apr 2013 15:16:33 -0500
Message-ID: <516F0321.2@inktank.com>
References: <516E7D5C.7080309@nazarianin.com> <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net> <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com> <516ECFB6.8090107@gmail.com> <CABBk=J93+1TRnjtr5D2cJWmre+tf85hAw3H1JnOL8hwKJuHDJA@mail.gmail.com> <alpine.DEB.2.00.1304171005360.30041@cobra.newdream.net> <CABBk=J_k0gAEx6a-agno8KHtn4-iZe5pfQLcrgtU2Ki2_kd8nQ@mail.gmail.com> <516EF07E.4000909@llnl.gov> <CABBk=J90_TB2hNH=rh6b=iO+=DRQoHPCiTqDP=X+ygyM0xoeVw@mail.gmail.com> <516EF34E.5000000@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qe0-f53.google.com ([209.85.128.53]:54083 "EHLO
	mail-qe0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965338Ab3DQUQi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 16:16:38 -0400
Received: by mail-qe0-f53.google.com with SMTP id q19so1140249qeb.26
        for <ceph-devel@vger.kernel.org>; Wed, 17 Apr 2013 13:16:37 -0700 (PDT)
In-Reply-To: <516EF34E.5000000@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: Yehuda Sadeh <yehuda@inktank.com>, Brian Behlendorf <behlendorf1@llnl.gov>, Sage Weil <sage@inktank.com>, Jeff Mitchell <jeffrey.mitchell@gmail.com>, Henry C Chang <henry.cy.chang@gmail.com>, Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>

I'll let Brian talk about the virtues of ZFS, but from my perspective 
it's an interesting option as there are a lot of folks banging on it for 
NFS servers and it has some interesting capabilities.  I have no idea 
how well it will work in practice, but if we can show that Ceph can run 
on it at least people can try it out and give us feedback.

Mark

On 04/17/2013 02:09 PM, Stefan Priebe wrote:
> Sorry to disturb, but what is the raeson / advantage of using zfs for ceph?
>
> Greets,
> Stefan
> Am 17.04.2013 21:07, schrieb Yehuda Sadeh:
>> On Wed, Apr 17, 2013 at 11:57 AM, Brian Behlendorf
>> <behlendorf1@llnl.gov> wrote:
>>>
>>> Here's a patch for the ERANGE error (lightly tested).  Sage's patch
>>> looks
>>> good but only covers one of two code paths for xattrs.  With zfs they
>>> may
>>> either be stored as a system attribute which is usually close to the
>>> dnode
>>> on disk (zfs set xattr=sa pool/dataset).  Or they may be stored in
>>> their own
>>> object which is how it's implemented on Solaris (zfs set xattr=on
>>> pool/dataset).  The second method is still the default for compatibility
>>> reasons even though it's slower.  Sage's patch only covered the SA case.
>>>
>>>
>>>> Well, looking at the code again it's not going to work, as setxattr is
>>>> going to fail with ERANGE.
>>>
>>> Why?  We support an arbitrary number of maximum sized xattrs (65536).
>>> What
>>> am I missing here?
>>>
>>> Incidentally, does anybody know of an good xattr test suite we could
>>> add to
>>> our regression tests?
>>>
>>> Thanks,
>>> Brian
>>>
>>> diff --git a/module/zfs/zpl_xattr.c b/module/zfs/zpl_xattr.c
>>> index c03764f..9f4d63c 100644
>>> --- a/module/zfs/zpl_xattr.c
>>> +++ b/module/zfs/zpl_xattr.c
>>> @@ -225,6 +225,11 @@ zpl_xattr_get_dir(struct inode *ip, const char
>>> *name,
>>> void *value,
>>>                  goto out;
>>>          }
>>>
>>> +       if (size < i_size_read(xip)) {
>>> +               error = -ERANGE;
>>> +               goto out;
>>> +       }
>>> +
>>>          error = zpl_read_common(xip, value, size, 0, UIO_SYSSPACE,
>>> 0, cr);
>>>   out:
>>>          if (xip)
>>> @@ -263,7 +268,10 @@ zpl_xattr_get_sa(struct inode *ip, const char
>>> *name,
>>> void *value, size_t size)
>>>          if (!size)
>>>                  return (nv_size);
>>>
>>> -       memcpy(value, nv_value, MIN(size, nv_size));
>>>
>>> +       if (size < nv_size)
>>> +               return (-ERANGE);
>>
>> Note, that zpl_xattr_get_sa() is called by __zpl_xattr_get() which can
>> also be called by zpl_xattr_get() to test for xattr existence. So it
>> needs to make sure that zpl_xattr_set() doesn't fail if getting
>> -ERANGE.
>>
>>> +
>>> +       memcpy(value, nv_value, size);
>>>
>>>          return (MIN(size, nv_size));
>>
>> No need for MIN() here.
>>
>>
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

