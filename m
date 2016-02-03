From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 09/10] fs: ceph: Replace CURRENT_TIME by ktime_get_real_ts()
Date: Wed, 3 Feb 2016 15:58:58 +0100
Message-ID: <CAOi1vP_nNtt5FX+9Q_+GcZtEY=G2KX8zGF0TC9=Y-GQghF8SvQ@mail.gmail.com>
References: <1454479670-8204-1-git-send-email-deepa.kernel@gmail.com>
	<1454479670-8204-10-git-send-email-deepa.kernel@gmail.com>
	<CAAM7YAm6enhGMJd+BMDAuAzXCMxVwb24Ch951A3_ygGUhXivxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:36638 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755119AbcBCO67 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 09:58:59 -0500
Received: by mail-wm0-f44.google.com with SMTP id p63so169140913wmp.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 06:58:58 -0800 (PST)
In-Reply-To: <CAAM7YAm6enhGMJd+BMDAuAzXCMxVwb24Ch951A3_ygGUhXivxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <ukernel@gmail.com>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Feb 3, 2016 at 3:34 PM, Yan, Zheng <ukernel@gmail.com> wrote:
> On Wed, Feb 3, 2016 at 2:07 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>> This is in preparation for the series that transitions
>> filesystem timestamps to use 64 bit time and hence make
>> them y2038 safe.
>>
>> CURRENT_TIME macro will be deleted before merging the
>> aforementioned series.
>>
>> Filesystems will use current_fs_time() instead of
>> CURRENT_TIME.
>> Use ktime_get_real_ts() here as this is not filesystem time.
>> ktime_get_real_ts() returns the timestamp in ns which can
>> be used to calculate MDS request timestamp.
>>
>> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>> Cc: "Yan, Zheng" <zyan@redhat.com>
>> Cc: Sage Weil <sage@redhat.com>
>> Cc: Ilya Dryomov <idryomov@gmail.com>
>> Cc: ceph-devel@vger.kernel.org
>> ---
>>  fs/ceph/mds_client.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index e7b130a..348b22e 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -1721,7 +1721,7 @@ ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>>         init_completion(&req->r_safe_completion);
>>         INIT_LIST_HEAD(&req->r_unsafe_item);
>>
>> -       req->r_stamp = CURRENT_TIME;
>> +       ktime_get_real_ts(&req->r_stamp);
>
> I think we should use current_fs_time() here. I have squash the change
> into another patch

That actually caused me to scratch my head for a second.  What you
really did is you replaced an older commit of yours (d3f683a74f8e,
"ceph: use current_fs_time() to get timestamp", committed on Jan 28)
with a new commit, authored by Deepa (3dcf84823f6a, "fs: ceph: replace
CURRENT_TIME by current_fs_time()") - the bodies are the same.  Is that
what you intended to do?
