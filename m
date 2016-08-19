From: Radoslaw Zarzynski <rzarzynski@mirantis.com>
Subject: Re: releasing jewel v10.2.3 ?
Date: Fri, 19 Aug 2016 13:49:09 +0200
Message-ID: <CA+H5UW0pmYVaMMCukBU7OZ1C6S5ThYZ2xfT70JXkR8MSBZONOQ@mail.gmail.com>
References: <57B698D0.1050409@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36197 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbcHSLtK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2016 07:49:10 -0400
Received: by mail-oi0-f42.google.com with SMTP id f189so59767320oig.3
        for <ceph-devel@vger.kernel.org>; Fri, 19 Aug 2016 04:49:10 -0700 (PDT)
In-Reply-To: <57B698D0.1050409@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Abhishek Varshney <abhishek.varshney@flipkart.com>

Hello,

I'd love to see RadosGW v10.2.3 passing RefStack:

* jewel: rgw: Swift's object versioning doesn't support
  restoring a previous version on DELETE
  http://tracker.ceph.com/issues/16393
  https://github.com/ceph/ceph/pull/10710

Regards,
Radek


On Fri, Aug 19, 2016 at 7:27 AM, Loic Dachary <loic@dachary.org> wrote:
> Hi Sage,
>
> Here are the issues that would be in jewel v10.2.3 if we decided to relea=
se it now: http://tracker.ceph.com/versions/518
> And here is the backport queue : http://tracker.ceph.com/projects/ceph/is=
sues?query_id=3D96
>
> Do you think it is time to cut the release and ask QE to start testing ?
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
