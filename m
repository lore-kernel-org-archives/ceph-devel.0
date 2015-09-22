From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: [ceph-users] Important security noticed regarding release signing key
Date: Tue, 22 Sep 2015 08:24:04 -0600
Message-ID: <CALqRxCw6tq0PvqMJAY1S0At1FB3cm_KPUY_bbX72Z9R_pyJ4+Q@mail.gmail.com>
References: <alpine.DEB.2.00.1509170925140.31198@cobra.newdream.net>
	<CAHRQ3VU1RFQL6AKh_CtOOeqg87wX7W5oa3n_3d8Ki9WFW=w5tw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34951 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257AbbIVOYF convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 10:24:05 -0400
Received: by wicge5 with SMTP id ge5so164000659wic.0
        for <ceph-devel@vger.kernel.org>; Tue, 22 Sep 2015 07:24:04 -0700 (PDT)
In-Reply-To: <CAHRQ3VU1RFQL6AKh_CtOOeqg87wX7W5oa3n_3d8Ki9WFW=w5tw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Songbo Wang <songbo1227@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

On Tue, Sep 22, 2015 at 2:38 AM, Songbo Wang <songbo1227@gmail.com> wro=
te:
> Hi, all,
>         Since the last week=E2=80=98s attack, =E2=80=9Cceph.com/packa=
ges/ceph-extras=E2=80=9D can be
> opened never, but where can I get the releases of ceph-extra now?
>
> Thanks and Regards,
> WangSongbo
>

The packages in "ceph-extras" were old and subject to CVEs (the big
one being VENOM, CVE-2015-3456). So I don't intend to host ceph-extras
in the new location.

- Ken
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
