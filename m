From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: use seq_show_option for string type options
Date: Tue, 13 Feb 2018 12:52:00 +0100
Message-ID: <CAOi1vP-JETNP4ou77tnDGMf4APUy8rgNF7V5Efk5Hijj_nK5YQ@mail.gmail.com>
References: <1518485459-199037-1-git-send-email-cgxu519@icloud.com>
 <CAOi1vP9pT2GSpOqULvrUiACZ-tAdh8bHXASyDEfqrcsyaUTFXA@mail.gmail.com> <E32473B2-E7B8-4058-8FCF-CB72BCEF1EEB@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:43935 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934583AbeBMLwB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Feb 2018 06:52:01 -0500
Received: by mail-io0-f194.google.com with SMTP id 72so20967074iom.10
        for <ceph-devel@vger.kernel.org>; Tue, 13 Feb 2018 03:52:00 -0800 (PST)
In-Reply-To: <E32473B2-E7B8-4058-8FCF-CB72BCEF1EEB@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Feb 13, 2018 at 11:55 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
>
>> =E5=9C=A8 2018=E5=B9=B42=E6=9C=8813=E6=97=A5=EF=BC=8C=E4=B8=8B=E5=8D=885=
:45=EF=BC=8CIlya Dryomov <idryomov@gmail.com> =E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Tue, Feb 13, 2018 at 2:30 AM, Chengguang Xu <cgxu519@icloud.com> wrot=
e:
>>> Using seq_show_option to replace seq_printf for string type options.
>>>
>>> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
>>> ---
>>> fs/ceph/super.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>>> index a62d2a9..d8a33ad 100644
>>> --- a/fs/ceph/super.c
>>> +++ b/fs/ceph/super.c
>>> @@ -512,7 +512,7 @@ static int ceph_show_options(struct seq_file *m, st=
ruct dentry *root)
>>>                seq_puts(m, ",nodcache");
>>>        if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
>>>                if (fsopt->fscache_uniq)
>>> -                       seq_printf(m, ",fsc=3D%s", fsopt->fscache_uniq)=
;
>>> +                       seq_show_option(m, "fsc", fsopt->fscache_uniq);
>>>                else
>>>                        seq_puts(m, ",fsc");
>>
>> Hi Chengguang,
>>
>> seq_show_option() should be able to handle !fsopt->fscache_uniq?
>
> Hi Ilya
>
> Sorry, I don=E2=80=99t get your point here.

I think it can be just

    if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE)
            seq_show_option(m, "fsc", fsopt->fscache_uniq);

Thanks,

                Ilya
