From: Chengguang Xu <cgxu519@icloud.com>
Subject: Re: [PATCH v2] ceph: minor cleanups of showing options
Date: Tue, 13 Feb 2018 09:38:00 +0800
Message-ID: <439D9F49-DB62-4BD5-A881-1FD7DAA1A602@icloud.com>
References: <1517925261-50747-1-git-send-email-cgxu519@icloud.com>
 <CAOi1vP9NOTMNVZgGvAf1OHXX4Ew+u67p3oUqqJsHXAD+BkotYw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p36im-asmtp002.me.com ([17.142.213.63]:29744 "EHLO
        pv33p36im-asmtp002.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933287AbeBMBiG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 20:38:06 -0500
Received: from process-dkim-sign-daemon.pv33p36im-asmtp002.me.com by
 pv33p36im-asmtp002.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P4200700F72M500@pv33p36im-asmtp002.me.com> for
 ceph-devel@vger.kernel.org; Tue, 13 Feb 2018 01:38:05 +0000 (GMT)
In-reply-to: <CAOi1vP9NOTMNVZgGvAf1OHXX4Ew+u67p3oUqqJsHXAD+BkotYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>

Hi Ilya

I=A1=AFve resent patch and changed the title properly.


Thanks,
Chengguang.



> =D4=DA 2018=C4=EA2=D4=C212=C8=D5=A3=AC=CF=C2=CE=E711:58=A3=ACIlya =
Dryomov <idryomov@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Tue, Feb 6, 2018 at 2:54 PM, Chengguang Xu <cgxu519@icloud.com> =
wrote:
>> Minor cleanups of showing options for mount and client.
>>=20
>> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
>> ---
>> Changes since v1:
>> - Do not change comma seqence in ceph_print_client_options()
>> because there is another caller from different path.
>>=20
>> fs/ceph/super.c        | 13 ++-----------
>> net/ceph/ceph_common.c |  3 +++
>> 2 files changed, 5 insertions(+), 11 deletions(-)
>>=20
>> diff --git a/fs/ceph/super.c b/fs/ceph/super.c
>> index bfc85b2..7f1e212 100644
>> --- a/fs/ceph/super.c
>> +++ b/fs/ceph/super.c
>> @@ -489,21 +489,12 @@ static int ceph_show_options(struct seq_file =
*m, struct dentry *root)
>> {
>>        struct ceph_fs_client *fsc =3D ceph_sb_to_client(root->d_sb);
>>        struct ceph_mount_options *fsopt =3D fsc->mount_options;
>> -       size_t pos;
>>        int ret;
>>=20
>> -       /* a comma between MNT/MS and client options */
>> -       seq_putc(m, ',');
>> -       pos =3D m->count;
>> -
>>        ret =3D ceph_print_client_options(m, fsc->client);
>>        if (ret)
>>                return ret;
>>=20
>> -       /* retract our comma if no client options */
>> -       if (m->count =3D=3D pos)
>> -               m->count--;
>> -
>>        if (fsopt->flags & CEPH_MOUNT_OPT_DIRSTAT)
>>                seq_puts(m, ",dirstat");
>>        if ((fsopt->flags & CEPH_MOUNT_OPT_RBYTES))
>> @@ -514,7 +505,7 @@ static int ceph_show_options(struct seq_file *m, =
struct dentry *root)
>>                seq_puts(m, ",nodcache");
>>        if (fsopt->flags & CEPH_MOUNT_OPT_FSCACHE) {
>>                if (fsopt->fscache_uniq)
>> -                       seq_printf(m, ",fsc=3D%s", =
fsopt->fscache_uniq);
>> +                       seq_show_option(m, "fsc", =
fsopt->fscache_uniq);
>>                else
>>                        seq_puts(m, ",fsc");
>>        }
>> @@ -529,7 +520,7 @@ static int ceph_show_options(struct seq_file *m, =
struct dentry *root)
>> #endif
>>=20
>>        if (fsopt->mds_namespace)
>> -               seq_printf(m, ",mds_namespace=3D%s", =
fsopt->mds_namespace);
>> +               seq_show_option(m, "mds_namespace", =
fsopt->mds_namespace);
>>        if (fsopt->wsize)
>>                seq_printf(m, ",wsize=3D%d", fsopt->wsize);
>>        if (fsopt->rsize !=3D CEPH_MAX_READ_SIZE)
>=20
> I don't think changing the way commas work is worth it.  If you resend
> just the seq_printf -> seq_show_option bits, I'll take that patch.
>=20
> Thanks,
>=20
>                Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

