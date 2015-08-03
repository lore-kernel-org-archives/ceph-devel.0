From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: Odd QA Test Running
Date: Tue, 4 Aug 2015 00:57:12 +0800
Message-ID: <CACJqLyb9xF2U0+b9Os7H52vxkrGmzOPBhxDvR=cmr4RgZxigCg@mail.gmail.com>
References: <CACJqLyY4kocnovRH0JTNtPWuB8CKbKZ3J_sT7yJUJ99pTXak1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35803 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbbHCQ5M convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 12:57:12 -0400
Received: by pdrg1 with SMTP id g1so76502381pdr.2
        for <ceph-devel@vger.kernel.org>; Mon, 03 Aug 2015 09:57:12 -0700 (PDT)
In-Reply-To: <CACJqLyY4kocnovRH0JTNtPWuB8CKbKZ3J_sT7yJUJ99pTXak1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I found https://github.com/ceph/ceph-qa-suite/blob/master/erasure-code/=
ec-rados-plugin%3Dshec-k%3D4-m%3D3-c%3D2.yaml
has override section and will override user's "enable experimental
unrecoverable data corrupting features" config. So my jobs are
corrupted.

I made a PR(https://github.com/ceph/ceph-qa-suite/pull/518) and hope
fix this point.

On Fri, Jul 31, 2015 at 5:50 PM, Haomai Wang <haomaiwang@gmail.com> wro=
te:
> Hi all,
>
> I  ran a test suite(http://pulpito.ceph.com/haomai-2015-07-29_11:40:4=
0-rados-master-distro-basic-multi/)
> and found the failed jobs are failed by "2015-07-29 10:52:35.313197
> 7f16ae655780 -1 unrecognized ms_type 'async'"
>
> Then I found the failed jobs(like
> http://pulpito.ceph.com/haomai-2015-07-29_11:40:40-rados-master-distr=
o-basic-multi/991540/)
> lack of =E2=80=9Cenable experimental unrecoverable data corrupting fe=
atures:
> ms-type-async=E2=80=9D.
>
> Other successful jobs(like
> http://pulpito.ceph.com/haomai-2015-07-29_11:40:40-rados-master-distr=
o-basic-multi/991517/)
> can find "enable experimental unrecoverable data corrupting features:
> ms-type-async" in yaml.
>
> So that's mean the same schedule suite will generate the different
> yaml file? Is there something tricky?
>
> --
>
> Best Regards,
>
> Wheat



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
