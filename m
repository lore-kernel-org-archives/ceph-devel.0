From: Brian Behlendorf <behlendorf1@llnl.gov>
Subject: Re: test osd on zfs
Date: Wed, 17 Apr 2013 14:14:38 -0700
Message-ID: <516F10BE.6020103@llnl.gov>
References: <516E7D5C.7080309@nazarianin.com> <alpine.DEB.2.00.1304170818000.27056@cobra.newdream.net> <CANExM-OE+zd4QVBufmy3v=Yu4ki5N5KqmZiOQJkYt0xd66YtrQ@mail.gmail.com> <516ECFB6.8090107@gmail.com> <CABBk=J93+1TRnjtr5D2cJWmre+tf85hAw3H1JnOL8hwKJuHDJA@mail.gmail.com> <alpine.DEB.2.00.1304171005360.30041@cobra.newdream.net> <CABBk=J_k0gAEx6a-agno8KHtn4-iZe5pfQLcrgtU2Ki2_kd8nQ@mail.gmail.com> <516EF07E.4000909@llnl.gov> <CABBk=J90_TB2hNH=rh6b=iO+=DRQoHPCiTqDP=X+ygyM0xoeVw@mail.gmail.com> <516EF34E.5000000@profihost.ag> <516F0321.2@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from prdiron-3.llnl.gov ([128.15.143.173]:56146 "EHLO
	prdiron-3.llnl.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965436Ab3DQVO6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Apr 2013 17:14:58 -0400
In-Reply-To: <516F0321.2@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Stefan Priebe <s.priebe@profihost.ag>, Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>, Jeff Mitchell <jeffrey.mitchell@gmail.com>, Henry C Chang <henry.cy.chang@gmail.com>, Aleksey Leonov <aleonov@nazarianin.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 04/17/2013 01:16 PM, Mark Nelson wrote:
> I'll let Brian talk about the virtues of ZFS,

I think the virtues of ZFS have been discussed at length in various 
other forums.  But in short it brings some nice functionality to the 
table which may be useful to ceph and that's worth exploring.

>>>>
>>>> diff --git a/module/zfs/zpl_xattr.c b/module/zfs/zpl_xattr.c
>>>> index c03764f..9f4d63c 100644
>>>> --- a/module/zfs/zpl_xattr.c
>>>> +++ b/module/zfs/zpl_xattr.c
>>>> @@ -225,6 +225,11 @@ zpl_xattr_get_dir(struct inode *ip, const char
>>>> *name,
>>>> void *value,
>>>>                  goto out;
>>>>          }
>>>>
>>>> +       if (size < i_size_read(xip)) {
>>>> +               error = -ERANGE;
>>>> +               goto out;
>>>> +       }
>>>> +
>>>>          error = zpl_read_common(xip, value, size, 0, UIO_SYSSPACE,
>>>> 0, cr);
>>>>   out:
>>>>          if (xip)
>>>> @@ -263,7 +268,10 @@ zpl_xattr_get_sa(struct inode *ip, const char
>>>> *name,
>>>> void *value, size_t size)
>>>>          if (!size)
>>>>                  return (nv_size);
>>>>
>>>> -       memcpy(value, nv_value, MIN(size, nv_size));
>>>>
>>>> +       if (size < nv_size)
>>>> +               return (-ERANGE);
>>>
>>> Note, that zpl_xattr_get_sa() is called by __zpl_xattr_get() which can
>>> also be called by zpl_xattr_get() to test for xattr existence. So it
>>> needs to make sure that zpl_xattr_set() doesn't fail if getting
>>> -ERANGE.

This shouldn't be a problem.  The zpl_xattr_get() call from 
zpl_xattr_set() passes a NULL value and zero size which will prevent it 
from hitting the ERANGE error.  It will return instead the xattr size as 
expected.

>>>
>>>> +
>>>> +       memcpy(value, nv_value, size);
>>>>
>>>>          return (MIN(size, nv_size));
>>>
>>> No need for MIN() here.

Thanks for catching that.

I've opened a pull request at github with the updated fix and kicked it 
off for automated testing.  It would be nice to verify this resolves the 
crash.

https://github.com/zfsonlinux/zfs/pull/1409

diff --git a/module/zfs/zpl_xattr.c b/module/zfs/zpl_xattr.c
index c03764f..42a06ad 100644
--- a/module/zfs/zpl_xattr.c
+++ b/module/zfs/zpl_xattr.c
@@ -225,6 +225,11 @@ zpl_xattr_get_dir(struct inode *ip, const char 
*name, void
                 goto out;
         }

+       if (size < i_size_read(xip)) {
+               error = -ERANGE;
+               goto out;
+       }
+
         error = zpl_read_common(xip, value, size, 0, UIO_SYSSPACE, 0, cr);
  out:
         if (xip)
@@ -263,9 +268,12 @@ zpl_xattr_get_sa(struct inode *ip, const char 
*name, void *
         if (!size)
                 return (nv_size);

-       memcpy(value, nv_value, MIN(size, nv_size));
+       if (size < nv_size)
+               return (-ERANGE);
+
+       memcpy(value, nv_value, size);

-       return (MIN(size, nv_size));
+       return (size);
  }

  static int
