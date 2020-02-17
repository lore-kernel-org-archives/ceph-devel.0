From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: fix dout logs for null pointers
Date: Mon, 17 Feb 2020 23:02:45 +0800
Message-ID: <cf786dd6-cb6e-1a3a-a57e-04d9525bb4a4@redhat.com>
References: <20200217112806.30738-1-xiubli@redhat.com>
 <CAOi1vP_bCGoni+tmvVri6Gcv7QRN4+qvHUrrweHLpnTyAzQw=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58874 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729300AbgBQPC7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Feb 2020 10:02:59 -0500
In-Reply-To: <CAOi1vP_bCGoni+tmvVri6Gcv7QRN4+qvHUrrweHLpnTyAzQw=A@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 2020/2/17 22:52, Ilya Dryomov wrote:
> On Mon, Feb 17, 2020 at 12:28 PM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> For example, if dentry and inode is NULL, the log will be:
>> ceph:  lookup result=000000007a1ca695
>> ceph:  submit_request on 0000000041d5070e for inode 000000007a1ca695
>>
>> The will be confusing without checking the corresponding code carefully.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/dir.c        | 2 +-
>>   fs/ceph/mds_client.c | 6 +++++-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index ffeaff5bf211..245a262ec198 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -798,7 +798,7 @@ static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
>>          err = ceph_handle_snapdir(req, dentry, err);
>>          dentry = ceph_finish_lookup(req, dentry, err);
>>          ceph_mdsc_put_request(req);  /* will dput(dentry) */
>> -       dout("lookup result=%p\n", dentry);
>> +       dout("lookup result=%d\n", err);
>>          return dentry;
>>   }
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index b6aa357f7c61..e34f159d262b 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -2772,7 +2772,11 @@ int ceph_mdsc_submit_request(struct ceph_mds_client *mdsc, struct inode *dir,
>>                  ceph_get_cap_refs(ceph_inode(req->r_old_dentry_dir),
>>                                    CEPH_CAP_PIN);
>>
>> -       dout("submit_request on %p for inode %p\n", req, dir);
>> +       if (dir)
>> +               dout("submit_request on %p for inode %p\n", req, dir);
>> +       else
>> +               dout("submit_request on %p\n", req);
> Hi Xiubo,
>
> It's been this way for a couple of years now.  There are a lot more
> douts in libceph, ceph and rbd that are sometimes fed NULL pointers.
> I don't think replacing them with conditionals is the way forward.
>
> I honestly don't know what security concern is addressed by hashing
> NULL pointers, but that is what we have...  Ultimately, douts are just
> for developers, and when you find yourself having to chase individual
> pointers, you usually have a large enough piece of log to figure out
> what the NULL hash is.

Hi Ilya

For the ceph_lookup(). The dentry will be NULL(when the directory exists 
or -ENOENT) or ERR_PTR(-errno) in most cases here, it seems for the 
rename case it will be the old dentry returned.

So today I was trying to debug and get some logs from it, the 
000000007a1ca695 really confused me for a long time before I dig into 
the source code.

Thanks,

> Thanks,
>
>                  Ilya
>
