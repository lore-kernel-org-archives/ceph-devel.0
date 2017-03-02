From: =?utf-8?B?5YiY55WF?= <liuchang0812@gmail.com>
Subject: Re: Clang not happy with unittest_hostname
Date: Thu, 2 Mar 2017 09:53:34 +0800
Message-ID: <4ACE5332-92D1-4D12-BFE4-7A28B9013C86@gmail.com>
References: <3ae8a4ec-3cd2-6d06-8562-74a5c80f44d0@digiware.nl>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36129 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754071AbdCBCAH (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Mar 2017 21:00:07 -0500
Received: by mail-pf0-f177.google.com with SMTP id x66so16693459pfb.3
        for <ceph-devel@vger.kernel.org>; Wed, 01 Mar 2017 18:00:07 -0800 (PST)
In-Reply-To: <3ae8a4ec-3cd2-6d06-8562-74a5c80f44d0@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

I will fix it soon, thanks=20

=E5=8F=91=E8=87=AA=E6=88=91=E7=9A=84 iPhone

> =E5=9C=A8 2017=E5=B9=B43=E6=9C=882=E6=97=A5=EF=BC=8C08:54=EF=BC=8CWillem J=
an Withagen <wjw@digiware.nl> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> This is with Clang on FreeBSD:
>=20
> [100%] Building CXX object
> src/test/common/CMakeFiles/unittest_hostname.dir/test_hostname.cc.o
> /home/jenkins/workspace/ceph-master/src/test/common/test_hostname.cc:34:27=
:
> error: implicit instantiation of undefined template
> 'std::__1::array<char, 128>'
>    std::array<char, 128> buffer;
>                          ^
> /usr/include/c++/v1/__tuple:198:65: note: template is declared here
> template <class _Tp, size_t _Size> struct _LIBCPP_TYPE_VIS_ONLY array;
>=20
> --WjW
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
