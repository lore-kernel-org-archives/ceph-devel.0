From: =?UTF-8?B?6KKB5Yas?= <yuandong1222@gmail.com>
Subject: Re: Quick CentOS/RHEL question ...
Date: Wed, 1 Aug 2012 08:44:23 +0800
Message-ID: <CAMm-wcL-FMEDQDgye4nppipP5UQG1ecQdyJxRipQY=XjOXwa9A@mail.gmail.com>
References: <50185964.3010803@scalableinformatics.com>
	<CAMm-wcKuD98z=7n=VvmEcRY6HduKKBrJ9bMyFKmN2-3VP51iLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64684 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab2HAAoY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jul 2012 20:44:24 -0400
Received: by qcro28 with SMTP id o28so4193245qcr.19
        for <ceph-devel@vger.kernel.org>; Tue, 31 Jul 2012 17:44:23 -0700 (PDT)
In-Reply-To: <CAMm-wcKuD98z=7n=VvmEcRY6HduKKBrJ9bMyFKmN2-3VP51iLA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ceph can work well on CentOS6.2 including File Access and RBD while
radowsgw is not still under our testing.

To install ceph on CentOS6, the main problem is the difference of the
packages' names between CentOS and Ubuntu, 'yum search ' may help. and
some times, 'ldconfig' is needed after the 'make install'

On 1 August 2012 06:17, Joe Landman <landman@scalableinformatics.com> w=
rote:
> Hi folks
>
>   I was struggling and failing to get Ceph properly built/installed f=
or
> CentOS 6 (and 5) last week.  Is this simply not a recommended platfor=
m?
> Please advise.  Thanks!
>
>
>
> --
> Joseph Landman, Ph.D
> Founder and CEO
> Scalable Informatics Inc.
> email: landman@scalableinformatics.com
> web  : http://scalableinformatics.com
>        http://scalableinformatics.com/sicluster
> phone: +1 734 786 8423 x121
> fax  : +1 866 888 3112
> cell : +1 734 612 4615
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--
=E8=A2=81=E5=86=AC
Tel:13573888215
Email:yuandong1222@gmail.com
QQ:10200230
MSN:yuandong1222@hotmail.com


--=20
=E8=A2=81=E5=86=AC
Tel:13573888215
Email:yuandong1222@gmail.com
QQ:10200230
MSN:yuandong1222@hotmail.com
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
