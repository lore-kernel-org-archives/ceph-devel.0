From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/5] ceph: remove zero-size xattr
Date: Tue, 11 Feb 2014 11:25:28 -0600
Message-ID: <52FA5D08.6060108@ieee.org>
References: <1392096612-11481-1-git-send-email-zheng.z.yan@intel.com>	<1392096612-11481-2-git-send-email-zheng.z.yan@intel.com>	<52FA37F1.2050903@ieee.org> <CAAM7YAkrZ=r5qYHw8iwUHALa49DvjwABPwBd--izMv-CvH2OVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:60634 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbaBKRZa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Feb 2014 12:25:30 -0500
Received: by mail-ie0-f180.google.com with SMTP id at1so4530619iec.25
        for <ceph-devel@vger.kernel.org>; Tue, 11 Feb 2014 09:25:29 -0800 (PST)
In-Reply-To: <CAAM7YAkrZ=r5qYHw8iwUHALa49DvjwABPwBd--izMv-CvH2OVQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On 02/11/2014 09:10 AM, Yan, Zheng wrote:
> On Tue, Feb 11, 2014 at 10:47 PM, Alex Elder <elder@ieee.org> wrote:
>> On 02/10/2014 11:30 PM, Yan, Zheng wrote:
>>> Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>>
>> You really need to explain better under what circumstances
>> a zero-size xattr is getting removed.
>>
>> But apparently it's only when you're updating an xattr
>> (not building it up from a blob from storage).
>>
>> Why are you doing this?  Why can't an xattr exist with
>> an empty value?
> 
> That is how other FS behave, at least for ext* and btrfs.

I haven't tested this, I'm just glancing through code.
But it looks to me like a zero-length value is OK, but
a null value pointer means it should be deleted.  Note
in btrfs_setxattr(), for example, the same bit of code
I referenced before:

        if (size == 0)
                value = "";  /* empty EA, do not remove */

And ext4 seems to delete for a null value, but handle
an xattr whose value *length* is zero.  Same with XFS.

So again, I haven't verified through testing, but my
reading of the code (though rusty) still seems to show
that an attribute can have an empty (zero-size) value.

					-Alex

> Regards
> Yan, Zheng
> 
>>
>> Looking at generic_setxattr() in "fs/xattr.c" we see:
>>         if (size == 0)
>>                 value = "";  /* empty EA, do not remove */
>>
>> The code you have below looks OK, but it seems that you
>> shouldn't be doing this.
>>
>> Am I missing something?
>>
>>                                         -Alex
>>
>>> ---
>>>  fs/ceph/xattr.c | 9 +++++++++
>>>  1 file changed, 9 insertions(+)
>>>
>>> diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
>>> index 28f9793..6ed0e5a 100644
>>> --- a/fs/ceph/xattr.c
>>> +++ b/fs/ceph/xattr.c
>>> @@ -12,6 +12,9 @@
>>>  #define XATTR_CEPH_PREFIX "ceph."
>>>  #define XATTR_CEPH_PREFIX_LEN (sizeof (XATTR_CEPH_PREFIX) - 1)
>>>
>>> +static int __remove_xattr(struct ceph_inode_info *ci,
>>> +                       struct ceph_inode_xattr *xattr);
>>> +
>>>  /*
>>>   * List of handlers for synthetic system.* attributes. Other
>>>   * attributes are handled directly.
>>> @@ -359,6 +362,12 @@ static int __set_xattr(struct ceph_inode_info *ci,
>>>                       kfree(val);
>>>                       return err;
>>>               }
>>> +             if (!val_len) {
>>> +                     if (xattr)
>>> +                             __remove_xattr(ci, xattr);
>>> +                     kfree(name);
>>> +                     return 0;
>>> +             }
>>>       }
>>>
>>>       if (!xattr) {
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

