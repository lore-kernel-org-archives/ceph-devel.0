From: Erwan Velu <evelu@redhat.com>
Subject: Re: Ceph 0.94.8 for Precise has build issues
Date: Mon, 29 Aug 2016 11:39:29 -0400 (EDT)
Message-ID: <1865565590.6858495.1472485169410.JavaMail.zimbra@redhat.com>
References: <CAC-Np1yrGo-N2gFRoxRquEdFEz-+yHhNgdJDAKvjaHcHsCwvmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:46316 "EHLO
        mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752808AbcH2Pjb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Aug 2016 11:39:31 -0400
In-Reply-To: <CAC-Np1yrGo-N2gFRoxRquEdFEz-+yHhNgdJDAKvjaHcHsCwvmw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com

I'm not a Ubuntu expert by I found that :

The 1.48 version of -dev package depends on libboost1.46-dev
1.48 package doesn't provide any content (http://us.archive.ubuntu.com/ubuntu/pool/main/b/boost-defaults/libboost-dev_1.48.0.2_amd64.deb)

As a result, we get a 1.46 which doesn't have the random_device.hpp.

That's very confusing and explains what you are reporting.

Anyone have ideas why it's done like that ?

----- Mail original -----
De: "Alfredo Deza" <adeza@redhat.com>
À: "ceph-devel" <ceph-devel@vger.kernel.org>, ceph-maintainers@ceph.com
Envoyé: Lundi 29 Août 2016 16:44:38
Objet: Ceph 0.94.8 for Precise has build issues

0.94.8 was released a few days ago, but Precise will refuse to build
correctly with the following error:

In file included from ./include/types.h:21:0,
                 from ./msg/msg_types.h:20,
                 from ./common/entity_name.h:24,
                 from ./common/config.h:26,
                 from ./common/dout.h:20,
                 from ./common/debug.h:18,
                 from erasure-code/jerasure/ErasureCodeJerasure.cc:18:
./include/uuid.h:14:42: fatal error: boost/random/random_device.hpp:
No such file or directory

This is not an issue specific to the environment where we try Precise
builds (Jenkins)  as it is also present in the Precise gitbuilder [0]

It looks like there is an inconsistency in the package versions for libboost.

The debian/control file specifies a version of libboost-dev >= 1.42,
but there are changes in library paths that Ceph relies that are
present in 1.47 and above [1]. Precise has a few libboost versions
including 1.46 and 1.48, since 1.46 meets the requirement in the
control file it gets installed.

I have tried changing the control file at build time (completely
non-ideal) but still facing the same issue:

-               libboost-dev (>= 1.42),
+               libboost-dev (>= 1.48),

If someone else can chime in on how to properly fix this for Precise
would be great. If it means a change in the Ceph source it will mean
that we will be required to get 0.94.9 out with that fix (0.94.8 is
already tagged)

-Alfredo

[0] http://gitbuilder.sepia.ceph.com/gitbuilder-ceph-deb-precise-amd64-basic/log.cgi?log=838cd35201e4fe1339e16d987cc33e873524af90
[1] http://www.boost.org/doc/libs/1_46_0/doc/html/boost/random_device.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
