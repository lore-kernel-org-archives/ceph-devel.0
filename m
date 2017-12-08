From: kefu chai <tchaikov@gmail.com>
Subject: Re: build on centos-7 and trusty
Date: Sat, 9 Dec 2017 00:58:13 +0800
Message-ID: <CAJE9aOOxtTOJpjGYmh2FpLg8kLG68yfN4uKHaFf_8y1tZSSTCw@mail.gmail.com>
References: <CAJE9aOPA03dJmJKfwch+XkgzYh8uUBNa0TkUFHu=AK0fJ4G=kQ@mail.gmail.com>
 <CAF-p1-Kg4WK=NpEeMyjB5-O8J+Uo__ZLjoZHsDN4n7-LPPmXhw@mail.gmail.com> <alpine.DEB.2.11.1712081616250.2838@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44283 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752050AbdLHQ6O (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Dec 2017 11:58:14 -0500
Received: by mail-qt0-f194.google.com with SMTP id m59so27333112qte.11
        for <ceph-devel@vger.kernel.org>; Fri, 08 Dec 2017 08:58:14 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1712081616250.2838@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Casey Bodley <cbodley@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Dec 9, 2017 at 12:16 AM, Sage Weil <sage@newdream.net> wrote:
> On Fri, 8 Dec 2017, Casey Bodley wrote:
>> Thanks Kefu! is there anything more we need to do before turning on -std=
=3Dc++14?

not sure, i will check the C++14 support of GCC-6.

>
> Have we addressed the aarch64 build question?  Is a sufficiently new
> toolchain available?

i am copying the my reply on https://github.com/ceph/ceph/pull/19403 here:

sadly, centos community does not have SCL repo ready for aarch64:
http://mirror.centos.org/centos/7/sclo/: x86_64 only. and the testing
repo only has devtools-6, see
https://buildlogs.centos.org/centos/7/sclo/aarch64/rh/, the
https://buildlogs.centos.org/centos/7/sclo/aarch64/rh/devtoolset-7/ is
empty!

but RHEL does have the support for developer toolset of aarch64, see
https://developers.redhat.com/blog/2017/10/25/announcing-release-software-c=
ollections-developer-toolset-new-compilers/

> New architecture support
>
> In recognition that different CPU architectures solve different IT proble=
ms, Red Hat is now supporting additional architectures as part of Red Hat S=
oftware Collections 3. In addition to x86_64, the curated, supported compon=
ents in Red Hat Software Collections 3 and Red Hat Developer Toolset 7 are =
now available across 64-bit ARM architecture (aarch64), IBM z Systems and I=
BM Power, little endian. This extends the ability of IT organizations to bu=
ild supported enterprise applications using the latest stable open source t=
ools on the architecture that meets their unique needs.
>

so, if we have the luxury to use RHEL for building aarch64 binaries,
we are good. if all we have is CentOS, either we need to build the DTS
by ourselves, or we should stick with GCC-6.

<strike>also, i have not reached out to centos community on this.
probably i am just missing something.</strike>

i just found this:
https://lists.centos.org/pipermail/arm-dev/2016-July/002247.html, and
https://bugs.centos.org/view.php?id=3D14078&nbn=3D1

>
> sage
>
>
>>
>> On Fri, Dec 8, 2017 at 12:28 AM, kefu chai <tchaikov@gmail.com> wrote:
>> > hi developers building master and mimic-dev1 on centos-7 and/or trusty=
,
>> >
>> > please use install-deps.sh to install the gcc-7 for compiling Ceph. as
>> > from now on, we will need GCC >=3D 5.1 [1] for better C++11 support.
>> >
>> > cheers,
>> >
>> > ---
>> > [1] https://github.com/ceph/ceph/pull/19344
>> >
>> > --
>> > Regards
>> > Kefu Chai
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>



--=20
Regards
Kefu Chai
