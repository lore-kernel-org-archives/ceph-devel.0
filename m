From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: ceph official RPMs ./configure default flags
Date: Thu, 4 Feb 2016 09:59:02 -0700
Message-ID: <CAANLjFox6GarmHS+0MEiQK=G7yJROEXUxBVUWPhSVQ+r69c9sg@mail.gmail.com>
References: <1454569441928.38241@croc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:32902 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934057AbcBDQ7E (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 11:59:04 -0500
Received: by mail-vk0-f50.google.com with SMTP id e64so40580560vkg.0
        for <ceph-devel@vger.kernel.org>; Thu, 04 Feb 2016 08:59:03 -0800 (PST)
In-Reply-To: <1454569441928.38241@croc.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Odintsov Vladislav <VlOdintsov@croc.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Are you checking out the branch (constantly being merged to) or the
tag? I don't think the config options matter because at that stage it
is only configuring the version information in a couple of files. Have
you cracked open both tarballs to see what files are different? I
thought there was some issue with getting the same exact commit number
in the version information, but I don't remember the details.
- ----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Feb 4, 2016 at 12:03 AM, Odintsov Vladislav  wrote:
> Hi all,
>
> can anyone tell me, how official ceph tarballs (on download.ceph.com) are made from git repo?
>
> I tried:
>
> git reset --hard v
> ./autogen
> ./configure with flags from ceph.spec
> make dist-bzip2
>
> But tar.bz2 differs from the same tar.bz2 on download.ceph.com (I checked on hammer).
>
> Also, which ./configure flags are used? Maybe, I'm wrong with my choice...
> Where can I find actual information about ceph release & build process?
>
> I saw some repos, but it seems to me, this is not what I'm looking for...
>
> - https://github.com/ceph/ceph-build
> - https://github.com/ceph/autobuild-ceph
> - ceph docs "how to build"
>
> Thank you.
>
> Regards,
>
> Vladislav Odintsov
> System Engineer of Croc Cloud Development Team
>

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.4
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWs4NTCRDmVDuy+mK58QAAtb0P/jW9lbeOTMBfTGQPJcuc
iBTkHZWz49haDPC3kLly3HOVdKZjaMH3xh5p25L2yu10h0T7sbqBTLlIoACQ
N4RHU5DbgVdE4MmG1zQxfnhg43upZZ7rLYnLy3DH7oOMiIMYCxgdVs22Dp30
46d3ac2eTVSRZkzBlV4DUZmqyuT0DjEQZdKSwE6BB/xcYUFhxMz7C2p8vERq
HVm7LhOEkpPM8aJQlLhiWXONT0m9B7QFkVAk2646bV/SfE05ssg2i90R0IFJ
cedQz7S/rqPyF8roKYd5EJdw2JS9WgB6l7gLB0++FyHALA5ldo7GJ7HM2T1m
wBfSWvEok2czUmltpoXV32XqWh1s8nZfzY/Cjba/mz9xYTopZJjwoDe2Ewuh
VR9j0SluWs0C9BLwLSDx868GMe/8pKACogNPg5mMUA0sn8FhpC/xGXIrEPMS
IHK5F1kI7yxmoK1afvoVNy7OiGOhbIDXqKv6jw2gcT+1115mltwUv30gnxYF
Ss0sDYMgwF0EmEtFjzh4AoIumArsFUa7I3zPE9GlfsXinGgELP7KI90vr2zh
UaCBnzZgCc/+J7i3VOsqDr8qaZy2TRo62qnUlQCENokBO4SWS+c901n43tnH
p6dOLqyRe6D120zRoUPANiF5oh3B5oWu6zCXoRCa4ktt+L7gGZ3un1YQzXxl
Dlop
=EZ25
-----END PGP SIGNATURE-----
