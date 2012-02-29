From: Alex Elder <elder@dreamhost.com>
Subject: Re: [PATCH 5/6] ceph: avoid repeatedly computing the size of constant
 vxattr names
Date: Tue, 28 Feb 2012 21:19:09 -0800
Message-ID: <4F4DB54D.9060901@dreamhost.com>
References: <4F4D98D5.1010506@dreamhost.com> <4F4D99CF.9020507@dreamhost.com> <CAC-hyiGKYNacy7ivUk-dyc4hviif4Bdq7NUfaAhhAfWZL6=X3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44362 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab2B2FTK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 00:19:10 -0500
In-Reply-To: <CAC-hyiGKYNacy7ivUk-dyc4hviif4Bdq7NUfaAhhAfWZL6=X3Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org

On 02/28/2012 08:47 PM, Yehuda Sadeh Weinraub wrote:
> On Tue, Feb 28, 2012 at 7:21 PM, Alex Elder<elder@dreamhost.com>  wrote:
>> All names defined in the directory and file virtual extended
>> attribute tables are constant, and the size of each is known at
>> compile time.  So there's no need to compute their length every
>> time any file's attribute is listed.
>>
>> Record the length of each string and use it when needed to determine
>> the space need to represent them.  In addition, compute the
>> aggregate size of strings in each table just once at initialization
>> time.
>>
>> Signed-off-by: Alex Elder<elder@dreamhost.com>
>> ---
>>   fs/ceph/super.c |    3 ++
>>   fs/ceph/super.h |    2 +
>>   fs/ceph/xattr.c |   56
>> ++++++++++++++++++++++++++++++++++++++++++++++++++----
>>   3 files changed, 56 insertions(+), 5 deletions(-)
. . .
>> @@ -87,6 +88,7 @@ static size_t ceph_vxattrcb_dir_rctime(struct
>> ceph_inode_info *ci, char *val,
>>   #define XATTR_NAME_CEPH(_type, _name) \
>>                 { \
>>                         .name = CEPH_XATTR_NAME(_type, _name), \
>> +                       .name_size = sizeof CEPH_XATTR_NAME(_type, _name), \
>
> You should use sizeof(x) instead of sizeof x.

I got the same comment when I tried using this form on XFS code.

I personally prefer this form--it tells you that "x" in this case
is an object, not a type.

However I will fix all references to "sizeof object" to use
sizeof(object) instead--here and in the future.

					-Alex


>>                         .getxattr_cb = ceph_vxattrcb_ ## _type ## _ ## _name,
>> \
>>                         .readonly = true, \
>>                 }
>> @@ -102,6 +104,7 @@ static struct ceph_vxattr ceph_dir_vxattrs[] = {
>>         XATTR_NAME_CEPH(dir, rctime),
>>         { 0 }   /* Required table terminator */
>>   };
>> +static size_t ceph_dir_vxattrs_name_size;      /* total size of all names
>> */
>>
>>   /* files */
>>
>> @@ -127,11 +130,13 @@ static struct ceph_vxattr ceph_file_vxattrs[] = {
>>         /* The following extended attribute name is deprecated */
>>         {
>>                 .name = XATTR_CEPH_PREFIX "layout",
>> +               .name_size = sizeof XATTR_CEPH_PREFIX "layout",
>
> here too.
>
>>                 .getxattr_cb = ceph_vxattrcb_file_layout,
>>                 .readonly = true,
>>         },
>>         { 0 }   /* Required table terminator */
>>   };
>> +static size_t ceph_file_vxattrs_name_size;     /* total size of all names
>> */
>>
>>   static struct ceph_vxattr *ceph_inode_vxattrs(struct inode *inode)
>>   {
>> @@ -142,6 +147,46 @@ static struct ceph_vxattr *ceph_inode_vxattrs(struct
>> inode *inode)
>>         return NULL;
>>   }
>>
>> +static size_t ceph_vxattrs_name_size(struct ceph_vxattr *vxattrs)
>> +{
>> +       if (vxattrs == ceph_dir_vxattrs)
>> +               return ceph_dir_vxattrs_name_size;
>> +       if (vxattrs == ceph_file_vxattrs)
>> +               return ceph_file_vxattrs_name_size;
>> +       BUG();
>> +
>> +       return 0;
>> +}
>> +
>> +/*
>> + * Compute the aggregate size (including terminating '\0') of all
>> + * virtual extended attribute names in the given vxattr table.
>> + */
>> +static size_t __init vxattrs_name_size(struct ceph_vxattr *vxattrs)
>> +{sizeof
>> +       struct ceph_vxattr *vxattr;
>> +       size_t size = 0;
>> +
>> +       for (vxattr = vxattrs; vxattr->name; vxattr++)
>> +               size += vxattr->name_size;
>> +
>> +       return size;
>> +}
>> +
>> +/* Routines called at initialization and exit time */
>> +
>> +void __init ceph_xattr_init(void)
>> +{
>> +       ceph_dir_vxattrs_name_size = vxattrs_name_size(ceph_dir_vxattrs);
>> +       ceph_file_vxattrs_name_size = vxattrs_name_size(ceph_file_vxattrs);
>> +}
>> +
>> +void ceph_xattr_exit(void)
>> +{
>> +       ceph_dir_vxattrs_name_size = 0;
>> +       ceph_file_vxattrs_name_size = 0;
>> +}
>> +
>>   static struct ceph_vxattr *ceph_match_vxattr(struct inode *inode,
>>                                                 const char *name)
>>   {
>> @@ -614,11 +659,12 @@ ssize_t ceph_listxattr(struct dentry *dentry, char
>> *names, size_t size)
>>                 goto out;
>>
>>   list_xattr:
>> -       vir_namelen = 0;
>> -       /* include virtual dir xattrs */
>> -       if (vxattrs)
>> -               for (i = 0; vxattrs[i].name; i++)
>> -                       vir_namelen += strlen(vxattrs[i].name) + 1;
>> +       /*
>> +        * Start with virtual dir xattr names (if any) (including
>> +        * terminating '\0' characters for each).
>> +        */
>> +       vir_namelen = ceph_vxattrs_name_size(vxattrs);
>> +
>>         /* adding 1 byte per each variable due to the null termination */
>>         namelen = vir_namelen + ci->i_xattrs.names_size + ci->i_xattrs.count;
>>         err = -ERANGE;
>> --
>> 1.7.5.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

