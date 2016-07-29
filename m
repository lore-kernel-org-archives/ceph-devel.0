From: Gerard Braad <me@gbraad.nl>
Subject: Re: Cmake and rpmbuild
Date: Fri, 29 Jul 2016 14:24:30 +0800
Message-ID: <CAGrH30UmTME+QgRdOe+RwhtwLNQ2vLjdn4MdZCDL2FVpGJofow@mail.gmail.com>
References: <CAGrH30XYN5fsx4HojZf3QdEAyvLm+-7N=tKYJU13HhjLrrRToQ@mail.gmail.com>
 <FEE54276-2859-45C6-8D89-FB7F375A3158@Teradata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:32908 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcG2GYc convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 02:24:32 -0400
Received: by mail-io0-f176.google.com with SMTP id 38so120417340iol.0
        for <ceph-devel@vger.kernel.org>; Thu, 28 Jul 2016 23:24:31 -0700 (PDT)
In-Reply-To: <FEE54276-2859-45C6-8D89-FB7F375A3158@Teradata.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>
Cc: ceph-users <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jul 29, 2016 at 2:20 PM, Kamble, Nitin A
<Nitin.Kamble@teradata.com> wrote:
>    To me this looks like a terribly crippled environment to build cep=
h, and I won=E2=80=99t bother building in such environment. IMO, It=E2=80=
=99s not worth for anybody to optimize the build process to make it wor=
k on such a crippled environment.

PoC phase... but likely the conclusion is as expected. Builds run
perfectly in a 8G setup.

> And to answer your question, If you can not add more memory then prov=
ide more swap space to increase the virtual memory.  You can also remov=
e the  =E2=80=9C-j" parameter to =E2=80=9Cmake" in the spec file to avo=
id creating lot of processes for parallel build.

`-j` has been altered and had no effect. Just wondering why doing a
`cmake` finishes without any problem in the same environment. And why
rpmbuild is also running something else than cmake (this is a target
for future)?

regards,
Gerard
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
