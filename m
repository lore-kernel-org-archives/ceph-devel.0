From: Chengguang Xu <cgxu519@icloud.com>
Subject: Re: [PATCH] ceph: Check memory allocation result
Date: Tue, 30 Jan 2018 08:08:56 +0800
Message-ID: <BCF48816-962F-4314-BDD6-84F7BC57267F@icloud.com>
References: <1516949683-127606-1-git-send-email-cgxu519@icloud.com>
 <CAOi1vP_b_1Um6gwo+Zz+YF8jmBbJY79Gndx8ie0caWrcGwStuA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pv33p36im-asmtp001.me.com ([17.142.213.62]:62403 "EHLO
        pv33p36im-asmtp001.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751464AbeA3BJX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jan 2018 20:09:23 -0500
Received: from process-dkim-sign-daemon.pv33p36im-asmtp001.me.com by
 pv33p36im-asmtp001.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3C00600DILPX00@pv33p36im-asmtp001.me.com> for
 ceph-devel@vger.kernel.org; Tue, 30 Jan 2018 00:09:02 +0000 (GMT)
In-reply-to: <CAOi1vP_b_1Um6gwo+Zz+YF8jmBbJY79Gndx8ie0caWrcGwStuA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>

Hi Ilya

Is there a specific tree for ceph kernel client?

I found below git repository is quite old.

https://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git/


Thanks,
Chengguang.



> =D4=DA 2018=C4=EA1=D4=C230=C8=D5=A3=AC=C9=CF=CE=E712:42=A3=ACIlya =
Dryomov <idryomov@gmail.com> =D0=B4=B5=C0=A3=BA
>=20
> On Fri, Jan 26, 2018 at 7:54 AM, Chengguang Xu <cgxu519@icloud.com> =
wrote:
>> Should check result of kstrndup() in case of memory allocation =
failure.
>>=20
>> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
>> ---
>> net/ceph/ceph_common.c | 4 ++++
>> 1 file changed, 4 insertions(+)
>>=20
>> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
>> index 5c036d2..1e492ef 100644
>> --- a/net/ceph/ceph_common.c
>> +++ b/net/ceph/ceph_common.c
>> @@ -421,6 +421,10 @@ struct ceph_options *
>>                        opt->name =3D kstrndup(argstr[0].from,
>>                                              =
argstr[0].to-argstr[0].from,
>>                                              GFP_KERNEL);
>> +                       if (!opt->name) {
>> +                               err =3D -ENOMEM;
>> +                               goto out;
>> +                       }
>>                        break;
>>                case Opt_secret:
>>                        opt->key =3D kzalloc(sizeof(*opt->key), =
GFP_KERNEL);
>=20
> Applied.
>=20
> Thanks,
>=20
>                Ilya

