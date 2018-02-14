From: Chengguang Xu <cgxu519@icloud.com>
Subject: Re: [PATCH] ceph: use seq_show_option for string type options
Date: Wed, 14 Feb 2018 22:09:11 +0800
Message-ID: <4B12D238-1885-42ED-B006-8DB6F7852E37@icloud.com>
References: <1518485459-199037-1-git-send-email-cgxu519@icloud.com>
 <CAOi1vP9pT2GSpOqULvrUiACZ-tAdh8bHXASyDEfqrcsyaUTFXA@mail.gmail.com>
 <E32473B2-E7B8-4058-8FCF-CB72BCEF1EEB@icloud.com>
 <CAOi1vP-JETNP4ou77tnDGMf4APUy8rgNF7V5Efk5Hijj_nK5YQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p36im-asmtp001.me.com ([17.142.213.62]:37277 "EHLO
        pv33p36im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030256AbeBNOJT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Feb 2018 09:09:19 -0500
Received: from process-dkim-sign-daemon.pv33p36im-asmtp001.me.com by
 pv33p36im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P4500C008E1PI00@pv33p36im-asmtp001.me.com> for
 ceph-devel@vger.kernel.org; Wed, 14 Feb 2018 14:09:18 +0000 (GMT)
In-reply-to: <CAOi1vP-JETNP4ou77tnDGMf4APUy8rgNF7V5Efk5Hijj_nK5YQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


> =D4=DA 2018=C4=EA2=D4=C213=C8=D5=A3=AC=CF=C2=CE=E77:52=A3=ACIlya =
Dryomov <idryomov@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Tue, Feb 13, 2018 at 11:55 AM, Chengguang Xu <cgxu519@icloud.com> =
wrote:
>>=20
>>> =D4=DA 2018=C4=EA2=D4=C213=C8=D5=A3=AC=CF=C2=CE=E75:45=A3=ACIlya =
Dryomov <idryomov@gmail.com> =D0=B4=B5=C0=A3=BA
>>>=20
>>> On Tue, Feb 13, 2018 at 2:30 AM, Chengguang Xu <cgxu519@icloud.com> =
wrote:
>>>> Using seq_show_option to replace seq_printf for string type =
options.
>>>>=20
>>>> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
>>>> ---
>>>> fs/ceph/super.c | 4 ++--
>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>=20
>>>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>>>> index a62d2a9..d8a33ad 100644
>>>> --- a/fs/ceph/super.c
>>>> +++ b/fs/ceph/super.c
>>>> @@ -512,7 +512,7 @@ static int ceph_show_options(struct seq_file =
*m, struct dentry *root)
>>>>               seq_puts(m, ",nodcache");
>>>>       if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
>>>>               if (fsopt->fscache_uniq)
>>>> -                       seq_printf(m, ",fsc=3D%s", =
fsopt->fscache_uniq);
>>>> +                       seq_show_option(m, "fsc", =
fsopt->fscache_uniq);
>>>>               else
>>>>                       seq_puts(m, ",fsc");
>>>=20
>>> Hi Chengguang,
>>>=20
>>> seq_show_option() should be able to handle !fsopt->fscache_uniq?
>>=20
>> Hi Ilya
>>=20
>> Sorry, I don=A1=AFt get your point here.
>=20
> I think it can be just
>=20
>    if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE)
>            seq_show_option(m, "fsc", fsopt->fscache_uniq);

Yes, it can work well in this case, I=A1=AFll resend revised version.

Thanks,
Chengguang.=20



