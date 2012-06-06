From: Sam Zaydel <sam.zaydel@inktank.com>
Subject: Re: Can we mount cephfs in centos 5.7 ?
Date: Wed, 6 Jun 2012 06:58:14 -0700
Message-ID: <CAAs1YtF5UkoG1O6yKBZq0KY4Z-MDsQ2K9VxneySpr5+JHFcA=g@mail.gmail.com>
References: <8512670932FB654F81AF0FEF1BE6D49D01790CEA@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54799 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753591Ab2FFN6Q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jun 2012 09:58:16 -0400
Received: by yenm10 with SMTP id m10so4964071yen.19
        for <ceph-devel@vger.kernel.org>; Wed, 06 Jun 2012 06:58:15 -0700 (PDT)
In-Reply-To: <8512670932FB654F81AF0FEF1BE6D49D01790CEA@WHQBEMAIL1.whq.wistron>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Eric_YH_Chen@wiwynn.com
Cc: ceph-devel@vger.kernel.org

I think you will be able to build from source the client bits that you
need, but I saw this from an earlier similar discussion mentioning
Python version, so I would make sure that python > 2.5 is used,
realistically 2.6 should be the norm today.

http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/5717

On Tue, Jun 5, 2012 at 6:16 PM,  <Eric_YH_Chen@wiwynn.com> wrote:
> Dear All:
>
> =E3=80=80=E3=80=80My ceph cluster is installed on Ubuntu 12.04 with k=
ernel 3.2.0.
>
> =E3=80=80=E3=80=80 =C2=A0But I have a situation that I may need to mo=
unt cephfs on centos 5.7, which with kernel 2.6.18.
>
> =C2=A0 =C2=A0(that is to say , I only need to execute mount.ceph on t=
he centos 5.7, not the whole ceph system)
>
> =C2=A0 =C2=A0I want to find a solution that can provide reliable and =
high availability share file system.
>
> =C2=A0 =C2=A0Is it possible to do this? Or any other recommend way? =C2=
=A0Ex: =C2=A0export NFS=E2=80=A6
>
> =C2=A0 =C2=A0Thanks!
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
Inked by Sam Zaydel
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
