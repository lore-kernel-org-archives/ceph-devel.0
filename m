From: kefu chai <tchaikov@gmail.com>
Subject: Re: increasingly large packages and longer build times
Date: Fri, 27 Oct 2017 11:21:51 +0800
Message-ID: <CAJE9aOOmYCHwfWk865r-r37_w_hAcUBosPLNdMWdybsiwVnGsQ@mail.gmail.com>
References: <CAC-Np1yg062K==JMEQhRTVKRe7orS3YoXz9hcgfKH+xfiZBiww@mail.gmail.com>
 <CALqRxCzmEN0UUD5iGcDw+iSp8+=cBmJpVa2Z=27fyVD_RWzRmw@mail.gmail.com>
 <CAJ4mKGZ5eAvOTTDwAzoAjv2Ed0C3mb1E7PxQvphY85rXZy5Oow@mail.gmail.com> <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:57018 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751399AbdJ0DVw (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 26 Oct 2017 23:21:52 -0400
Received: by mail-oi0-f54.google.com with SMTP id v9so8947365oif.13
        for <ceph-devel@vger.kernel.org>; Thu, 26 Oct 2017 20:21:52 -0700 (PDT)
In-Reply-To: <CAJE9aON9ELevTue_DXdcYnqBVO2LbTe8mthbytegbtyfLm+K7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>, Ken Dreyer <kdreyer@redhat.com>

On Tue, Aug 22, 2017 at 3:01 PM, kefu chai <tchaikov@gmail.com> wrote:
> On Thu, Aug 17, 2017 at 5:44 AM, Gregory Farnum <gfarnum@redhat.com> wrot=
e:
>> On Mon, Aug 7, 2017 at 7:58 AM, Ken Dreyer <kdreyer@redhat.com> wrote:
>>
>> On (3), there are a few causes. One is that we just have a lot of
>> code. But a far bigger impact seems to come from all the ceph_test_*
>> binaries and other things which we have statically linked with
>> ceph-common et al. There are two approaches we can take there: we can
>> figure out how to dynamically link them (which I haven't been involved
>> in but recall being difficult =E2=80=94 but also have caused other issue=
s to
>
> actually almost all ceph_test_* are linking against libceph-common.
> but they are linking against libglobal and libos statically.

hey guys,

i just realized that librados.a is linked by quite a few test
binaries. so, i am posting https://github.com/ceph/ceph/pull/18576.
probably it could help a little bit regarding to reduce the size of
debug-info package.

--=20
Regards
Kefu Chai
