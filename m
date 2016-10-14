From: Haomai Wang <haomai@xsky.com>
Subject: Re: bufferlist rebuild_aligned issue
Date: Fri, 14 Oct 2016 14:44:57 +0800
Message-ID: <CACJqLybyAo+OvAtST4uifze5wgkU_x8tWzhjmRCtWvaQGK=R0Q@mail.gmail.com>
References: <7BD28126D6935A4498AE6DE60B5D4CAB314E86DD@H3CMLB12-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-os2jpn01on0108.outbound.protection.outlook.com ([104.47.92.108]:40453
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754536AbcJNGqc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 14 Oct 2016 02:46:32 -0400
Received: by mail-vk0-f48.google.com with SMTP id 83so81088259vkd.0
        for <ceph-devel@vger.kernel.org>; Thu, 13 Oct 2016 23:45:05 -0700 (PDT)
In-Reply-To: <7BD28126D6935A4498AE6DE60B5D4CAB314E86DD@H3CMLB12-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zhangzengran <zhangzengran@h3c.com>
Cc: "Sage Weil (sage@newdream.net)" <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Oct 14, 2016 at 2:37 PM, Zhangzengran <zhangzengran@h3c.com> wrote:
> Hi Sage,
>   Recently I tracked some single op, and found that the bufferlist::rebui=
ld_aligned will cost some time that a litte longer.
> The whole subop spend 7ms,and the pwritev spend 1.2ms, but the rebuild_al=
igned cost 1.1ms.the test=E2=80=99s object length is 1M,
> Using rados put. I think the bufferlist rebuild and align should not cost=
 so much time. The os environment have vm.swappiness =3D 0
> and have tcmalloc. Is this normal?
>
> 2016-10-14 11:50:48.131103  queue_transactions existing 0x7f8900c302c0 os=
r(134.62s3 0x7f88ff458160)
> 2016-10-14 11:50:48.132477  queue_transactions (writeahead) 3234 [Transac=
tion(0x7f8907736000),Transaction(0x7f89077361c0)]
>>> cost 1.1ms FileJournal::prepare_entry =3D> bufferlist:: rebuild_aligned

why do you think 1.1ms is cost from rebuild... there exists a lot of
things. rebuild of course is a problem we need to resolve. but it
won't be problem in hdd case since it's just memory copy.

> 2016-10-14 11:50:48.133583  _journaled_ahead 0x7f88ff586ba0 seq 3234 osr(=
134.62s3 0x7f88ff458160) [Transaction(0x7f8907736000),Transaction(0x7f89077=
361c0)]
> 2016-10-14 11:50:48.133620  queue_op 0x7f88ff586ba0 seq 3234 osr(134.62s3=
 0x7f88ff458160) 1051330 bytes   (queue has 1 ops and 1051330 bytes)
> 2016-10-14 11:50:48.133630   queueing ondisk 0x7f8903ab77c0
> 2016-10-14 11:50:48.133654  _do_op 0x7f88ff586ba0 seq 3234 osr(134.62s3 0=
x7f88ff458160)/0x7f88ff458160 start
> 2016-10-14 11:50:48.133669  _do_transaction on 0x7f8907736000
> 2016-10-14 11:50:48.133685  remove 134.62s3_head/3#134:461e3a1c:::testfil=
e_4M:head#298
> 2016-10-14 11:50:48.133754  lfn_unlink: clearing omap on 3#134:461e3a1c::=
:testfile_4M:head#298 in cid 134.62s3_head
> 2016-10-14 11:50:48.134526  remove 134.62s3_head/3#134:461e3a1c:::testfil=
e_4M:head#298 =3D 0
> 2016-10-14 11:50:48.134557  _omap_setkeys 134.62s3_head/3#134:46000000:::=
:head#
> 2016-10-14 11:50:48.134705  _omap_setkeys 134.62s3_head/3#134:46000000:::=
:head# =3D 0
> 2016-10-14 11:50:48.134716  _do_transaction on 0x7f89077361c0
> 2016-10-14 11:50:48.134723  _collection_move_rename 134.62s3_head/3#134:4=
61e3a1c:::testfile_4M:head#29a from 134.62s3_head/3#134:461e3a1c:::testfile=
_4M:head#
> 2016-10-14 11:50:48.134736  _set_replay_guard 3234.1.0 START
> 2016-10-14 11:50:48.135859  _set_replay_guard 3234.1.0 done
> 2016-10-14 11:50:48.136130  lfn_unlink: clearing omap on 3#134:461e3a1c::=
:testfile_4M:head# in cid 134.62s3_head
> 2016-10-14 11:50:48.136305  _close_replay_guard 3234.1.0
> 2016-10-14 11:50:48.137023  _close_replay_guard 3234.1.0 done
> 2016-10-14 11:50:48.137039  _collection_move_rename 134.62s3_head/3#134:4=
61e3a1c:::testfile_4M:head#29a from 134.62s3_head/3#134:461e3a1c:::testfile=
_4M:head# =3D 0
> 2016-10-14 11:50:48.137057  write 134.62s3_head/3#134:461e3a1c:::testfile=
_4M:head# 0~1048576
>>> cost 1.2ms pwritev
> 2016-10-14 11:50:48.138255  write 134.62s3_head/3#134:461e3a1c:::testfile=
_4M:head# 0~1048576 =3D 1048576
> 2016-10-14 11:50:48.138291  setattrs 134.62s3_head/3#134:461e3a1c:::testf=
ile_4M:head#
> 2016-10-14 11:50:48.138313  setattrs 134.62s3_head/3#134:461e3a1c:::testf=
ile_4M:head# =3D 0
> 2016-10-14 11:50:48.138330  fgetattrs 70 getting 'hinfo_key'
> 2016-10-14 11:50:48.138337  setattrs 134.62s3_head/3#134:461e3a1c:::testf=
ile_4M:head#
> 2016-10-14 11:50:48.138357  setattrs 134.62s3_head/3#134:461e3a1c:::testf=
ile_4M:head# =3D 0
> 2016-10-14 11:50:48.138371  fgetattrs 70 getting '_'
> 2016-10-14 11:50:48.138376  fgetattrs 70 getting 'snapset'
> 2016-10-14 11:50:48.138381  fgetattrs 70 getting 'hinfo_key'
> 2016-10-14 11:50:48.138386  setattrs 134.62s3_head/3#134:461e3a1c:::testf=
ile_4M:head#
> 2016-10-14 11:50:48.138409  _do_op 0x7f88ff586ba0 seq 3234 r =3D 0, finis=
her 0x7f8909398680 0
> 2016-10-14 11:50:48.138420  _finish_op 0x7f88ff586ba0 seq 3234 osr(134.62=
s3 0x7f88ff458160)/0x7f88ff458160 lat 0.007306
>
> Than you, best regards
> -------------------------------------------------------------------------=
------------------------------------------------------------
> =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=AB=
=E6=9C=89=E6=9D=AD=E5=B7=9E=E5=8D=8E=E4=B8=89=E9=80=9A=E4=BF=A1=E6=8A=80=E6=
=9C=AF=E6=9C=89=E9=99=90=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=AF=86=E4=BF=
=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=81=E7=BB=99=
=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA
> =E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81=
=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=
=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=
=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=
=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81
> =E6=88=96=E6=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=
=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=
=94=B6=E4=BA=86=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=
=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=
=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC
> =E9=82=AE=E4=BB=B6=EF=BC=81
> This e-mail and its attachments contain confidential information from H3C=
, which is
> intended only for the person or entity whose address is listed above. Any=
 use of the
> information contained herein in any way (including, but not limited to, t=
otal or partial
> disclosure, reproduction, or dissemination) by persons other than the int=
ended
> recipient(s) is prohibited. If you receive this e-mail in error, please n=
otify the sender
> by phone or email immediately and delete it!
