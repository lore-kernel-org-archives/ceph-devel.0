From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Any concern about Ceph on CentOS
Date: Wed, 17 Jul 2013 14:22:32 +0800
Message-ID: <F638260E-BF37-460E-AEEE-C18C7879076A@gmail.com>
References: <6F3FA899187F0043BA1827A69DA2F7CC01E43F83@SHSMSX102.ccr.corp.intel.com> <20130717061655.GB13122@oder.mch.fsc.net>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:36223 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab3GQGWj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jul 2013 02:22:39 -0400
Received: by mail-pb0-f49.google.com with SMTP id jt11so1524616pbb.36
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jul 2013 23:22:38 -0700 (PDT)
In-Reply-To: <20130717061655.GB13122@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Cc: "Chen, Xiaoxi" <xiaoxi.chen@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Kasper,

Can you talk about how you make use of Ceph and detail information on C=
entOS?

I guess that you use the CephFS on Ceph Cluster?

Best regards,
Wheats



=D4=DA 2013-7-17=A3=AC=CF=C2=CE=E72:16=A3=ACKasper Dieter <dieter.kaspe=
r@ts.fujitsu.com> =D0=B4=B5=C0=A3=BA

> Hi Xiaoxi,
>=20
> we are really running Ceph on CentOS-6.4
> (6 server nodes, 3 client nodes, 160 OSDs).
>=20
> We put a 3.8.13 Kernel on top and installed the ceph-0.61.4 cluster w=
ith mkcephfs,=20
> because ceph-deploy seems to be still very buggy and has big dependen=
cies to the newest python.
>=20
> ceph.ko
> rbd.ko
> and ceph-fuse are running fast, well and stable (so far ;-) ).
>=20
> Cheers,
> -Dieter
>=20
> On Wed, Jul 17, 2013 at 03:18:22AM +0200, Chen, Xiaoxi wrote:
>> Hi list,
>>   I would like to ask if anyone really run Ceph on CentOS/RHEL?=20
>>   Since the kernel version for Cent/RHEL is much older than that of =
Ubuntu,=20
>>   I am thinking about whether we have some known performance/functio=
nality issue?
>>   Thanks for everyone could share your insight for Ceph+CentOS.
>> 																												Xiaoxi=20
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
