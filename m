From: Jan Schermer <jan@schermer.cz>
Subject: Re: [ceph-users] How long will the logs be kept?
Date: Thu, 3 Dec 2015 09:58:21 +0100
Message-ID: <37396A32-183A-45B5-A86B-6FC0C0939930@schermer.cz>
References: <47D132BF400BE64BAE6D71033F7D3D75030E7B67@H3CMLB12-EX.srv.huawei-3com.com> <CABAwU-bNERLVaAgF_tJ8WFJ-eH3zvVO6zdU-7CQSB1wTh8EYJQ@mail.gmail.com> <47D132BF400BE64BAE6D71033F7D3D75030E7C02@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37758 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932271AbbLCI6Y convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 03:58:24 -0500
Received: by wmww144 with SMTP id w144so12562992wmw.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 00:58:22 -0800 (PST)
In-Reply-To: <47D132BF400BE64BAE6D71033F7D3D75030E7C02@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wukongming <wu.kongming@h3c.com>
Cc: huang jun <hjwsm1989@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

You can setup logrotate however you want - not sure what the default is=
 for your distro.
Usually logrotate doesn't touch files that are smaller than some size e=
ven if they are old. It will also not delete logs for OSDs that no long=
er exist.=20

Ceph itself has nothing to do with log rotation, logrotate does the wor=
k. Ceph packages likely contain default logrotate rules for the logs bu=
t you can edit them to your liking.

Jan

> On 03 Dec 2015, at 09:38, Wukongming <wu.kongming@h3c.com> wrote:
>=20
> Yes, I can find ceph of rotate configure file in the directory of /et=
c/logrotate.d.=20
> Also, I find sth. Weird.
>=20
> drwxr-xr-x  2 root root   4.0K Dec  3 14:54 ./
> drwxrwxr-x 19 root syslog 4.0K Dec  3 13:33 ../
> -rw-------  1 root root      0 Dec  2 06:25 ceph.audit.log
> -rw-------  1 root root    85K Nov 25 09:17 ceph.audit.log.1.gz
> -rw-------  1 root root   228K Dec  3 16:00 ceph.log
> -rw-------  1 root root    28K Dec  3 06:23 ceph.log.1.gz
> -rw-------  1 root root   374K Dec  2 06:22 ceph.log.2.gz
> -rw-r--r--  1 root root   4.3M Dec  3 16:01 ceph-mon.wkm01.log
> -rw-r--r--  1 root root   561K Dec  3 06:25 ceph-mon.wkm01.log.1.gz
> -rw-r--r--  1 root root   2.2M Dec  2 06:25 ceph-mon.wkm01.log.2.gz
> -rw-r--r--  1 root root      0 Dec  2 06:25 ceph-osd.0.log
> -rw-r--r--  1 root root    992 Dec  1 09:09 ceph-osd.0.log.1.gz
> -rw-r--r--  1 root root    19K Dec  3 10:51 ceph-osd.2.log
> -rw-r--r--  1 root root   2.3K Dec  2 10:50 ceph-osd.2.log.1.gz
> -rw-r--r--  1 root root    27K Dec  1 10:31 ceph-osd.2.log.2.gz
> -rw-r--r--  1 root root    13K Dec  3 10:23 ceph-osd.5.log
> -rw-r--r--  1 root root   1.6K Dec  2 09:57 ceph-osd.5.log.1.gz
> -rw-r--r--  1 root root    22K Dec  1 09:51 ceph-osd.5.log.2.gz
> -rw-r--r--  1 root root    19K Dec  3 10:51 ceph-osd.8.log
> -rw-r--r--  1 root root    18K Dec  2 10:50 ceph-osd.8.log.1
> -rw-r--r--  1 root root   261K Dec  1 13:54 ceph-osd.8.log.2
>=20
> I deployed ceph cluster on Nov 21, from that day to Dec.1, I mean the=
 continue 10 days' logs were compressed into one file, it is not what I=
 want.
> Does any OP affect log compressing?
>=20
> Thanks!
>            Kongming Wu
> ---------------------------------------------
> wukongming ID: 12019
> Tel=EF=BC=9A0571-86760239
> Dept=EF=BC=9A2014 UIS2 ONEStor
>=20
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: huang jun [mailto:hjwsm1989@gmail.com]=20
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2015=E5=B9=B412=E6=9C=883=E6=97=
=A5 13:19
> =E6=94=B6=E4=BB=B6=E4=BA=BA: wukongming 12019 (RD)
> =E6=8A=84=E9=80=81: ceph-devel@vger.kernel.org; ceph-users@lists.ceph=
=2Ecom
> =E4=B8=BB=E9=A2=98: Re: How long will the logs be kept?
>=20
> it will rotate every week by default, you can see the logrotate file =
/etc/ceph/logrotate.d/ceph
>=20
> 2015-12-03 12:37 GMT+08:00 Wukongming <wu.kongming@h3c.com>:
>> Hi ,All
>>        Is there anyone who knows How long or how many days will the =
logs.gz (mon/osd/mds)be kept, maybe before flushed?
>>=20
>> ---------------------------------------------
>> wukongming ID: 12019
>> Tel=EF=BC=9A0571-86760239
>> Dept=EF=BC=9A2014 UIS2 OneStor
>>=20
>> --------------------------------------------------------------------=
--
>> ---------------------------------------------------------------
>> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=
=AB=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=89=E9=80=9A=E4=BF=A1=E6=8A=
=80=E6=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=
=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=
=BA
>> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=
=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=
=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=
=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=
=A8=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=
=81
>> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=
=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=
=99=E6=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=
=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=
=AC
>> =E9=82=AE=E4=BB=B6=EF=BC=81
>> This e-mail and its attachments contain confidential information fro=
m=20
>> H3C, which is intended only for the person or entity whose address i=
s=20
>> listed above. Any use of the information contained herein in any way=
=20
>> (including, but not limited to, total or partial disclosure,=20
>> reproduction, or dissemination) by persons other than the intended
>> recipient(s) is prohibited. If you receive this e-mail in error,=20
>> please notify the sender by phone or email immediately and delete it=
!
>=20
>=20
>=20
> --
> thanks
> huangjun
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
