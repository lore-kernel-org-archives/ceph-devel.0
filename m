From: wangsongbo <songbo1227@gmail.com>
Subject: Re: [ceph-users] Important security noticed regarding release signing
 key
Date: Wed, 23 Sep 2015 10:33:14 +0800
Message-ID: <56020F6A.9050406@gmail.com>
References: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net>
 <CAHRQ3VU1RFQL6AKh_CtOOeqg87wX7W5oa3n_3d8Ki9WFW=w5tw@mail.gmail.com>
 <CALqRxCw6tq0PvqMJAY1S0At1FB3cm_KPUY_bbX72Z9R_pyJ4+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:32961 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934146AbbIWCd1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 22:33:27 -0400
Received: by pacex6 with SMTP id ex6so26280222pac.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2015 19:33:27 -0700 (PDT)
In-Reply-To: <CALqRxCw6tq0PvqMJAY1S0At1FB3cm_KPUY_bbX72Z9R_pyJ4+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

Hi Ken,
     Thanks for your reply. But in the ceph-cm-ansible project schedule=
d=20
by teuthology, "ceph.com/packages/ceph-extras" is in used now, such as=20
qemu-kvm-0.12.1.2-2.415.el6.3ceph,=20
qemu-kvm-tools-0.12.1.2-2.415.el6.3ceph etc.
     Any new releases will be provided ?

On 15/9/22 =E4=B8=8B=E5=8D=8810:24, Ken Dreyer wrote:
> On Tue, Sep 22, 2015 at 2:38 AM, Songbo Wang <songbo1227@gmail.com> w=
rote:
>> Hi, all,
>>          Since the last week=E2=80=98s attack, =E2=80=9Cceph.com/pac=
kages/ceph-extras=E2=80=9D can be
>> opened never, but where can I get the releases of ceph-extra now?
>>
>> Thanks and Regards,
>> WangSongbo
>>
> The packages in "ceph-extras" were old and subject to CVEs (the big
> one being VENOM, CVE-2015-3456). So I don't intend to host ceph-extra=
s
> in the new location.
>
> - Ken

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
