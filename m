From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: ceph official RPMs ./configure default flags
Date: Thu, 4 Feb 2016 13:22:22 -0700
Message-ID: <CAANLjFpWFUYuR_O===S_m2cS9=xODofKjPTx5q6EbC292fZC+w@mail.gmail.com>
References: <1454569441928.38241@croc.ru>
	<CAANLjFox6GarmHS+0MEiQK=G7yJROEXUxBVUWPhSVQ+r69c9sg@mail.gmail.com>
	<1454613322703.72233@croc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35784 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933136AbcBDUWY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 15:22:24 -0500
Received: by mail-vk0-f52.google.com with SMTP id e6so43843088vkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 04 Feb 2016 12:22:23 -0800 (PST)
In-Reply-To: <1454613322703.72233@croc.ru>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Odintsov Vladislav <VlOdintsov@croc.ru>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

I can't get it to exactly match either, but I have far fewer differences:

git checkout v0.94.5
git reset --hard HEAD
./autogen.sh
./configure
make clean
make dist-bzip2

$ diff --brief -Nr make-tar/ upstream-tar/
Files make-tar/ceph-0.94.5/aclocal.m4 and
upstream-tar/ceph-0.94.5/aclocal.m4 differ
Files make-tar/ceph-0.94.5/ar-lib and upstream-tar/ceph-0.94.5/ar-lib differ
Files make-tar/ceph-0.94.5/ChangeLog and
upstream-tar/ceph-0.94.5/ChangeLog differ
Files make-tar/ceph-0.94.5/compile and upstream-tar/ceph-0.94.5/compile differ
Files make-tar/ceph-0.94.5/config.guess and
upstream-tar/ceph-0.94.5/config.guess differ
Files make-tar/ceph-0.94.5/config.sub and
upstream-tar/ceph-0.94.5/config.sub differ
Files make-tar/ceph-0.94.5/configure and
upstream-tar/ceph-0.94.5/configure differ
Files make-tar/ceph-0.94.5/depcomp and upstream-tar/ceph-0.94.5/depcomp differ
Files make-tar/ceph-0.94.5/install-sh and
upstream-tar/ceph-0.94.5/install-sh differ
Files make-tar/ceph-0.94.5/ltmain.sh and
upstream-tar/ceph-0.94.5/ltmain.sh differ
Files make-tar/ceph-0.94.5/m4/pkg.m4 and
upstream-tar/ceph-0.94.5/m4/pkg.m4 differ
Files make-tar/ceph-0.94.5/Makefile.in and
upstream-tar/ceph-0.94.5/Makefile.in differ
Files make-tar/ceph-0.94.5/man/Makefile.in and
upstream-tar/ceph-0.94.5/man/Makefile.in differ
Files make-tar/ceph-0.94.5/missing and upstream-tar/ceph-0.94.5/missing differ
Files make-tar/ceph-0.94.5/py-compile and
upstream-tar/ceph-0.94.5/py-compile differ
Files make-tar/ceph-0.94.5/src/ceph-crush-location and
upstream-tar/ceph-0.94.5/src/ceph-crush-location differ
Files make-tar/ceph-0.94.5/src/gmock/aclocal.m4 and
upstream-tar/ceph-0.94.5/src/gmock/aclocal.m4 differ
Files make-tar/ceph-0.94.5/src/gmock/build-aux/compile and
upstream-tar/ceph-0.94.5/src/gmock/build-aux/compile differ
Files make-tar/ceph-0.94.5/src/gmock/build-aux/config.guess and
upstream-tar/ceph-0.94.5/src/gmock/build-aux/config.guess differ
Files make-tar/ceph-0.94.5/src/gmock/build-aux/config.sub and
upstream-tar/ceph-0.94.5/src/gmock/build-aux/config.sub differ
Files make-tar/ceph-0.94.5/src/gmock/build-aux/depcomp and
upstream-tar/ceph-0.94.5/src/gmock/build-aux/depcomp differ
Files make-tar/ceph-0.94.5/src/gmock/build-aux/install-sh and
upstream-tar/ceph-0.94.5/src/gmock/build-aux/install-sh differ
Files make-tar/ceph-0.94.5/src/gmock/build-aux/ltmain.sh and
upstream-tar/ceph-0.94.5/src/gmock/build-aux/ltmain.sh differ
Files make-tar/ceph-0.94.5/src/gmock/build-aux/missing and
upstream-tar/ceph-0.94.5/src/gmock/build-aux/missing differ
Files make-tar/ceph-0.94.5/src/gmock/build-aux/test-driver and
upstream-tar/ceph-0.94.5/src/gmock/build-aux/test-driver differ
Files make-tar/ceph-0.94.5/src/gmock/configure and
upstream-tar/ceph-0.94.5/src/gmock/configure differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/aclocal.m4 and
upstream-tar/ceph-0.94.5/src/gmock/gtest/aclocal.m4 differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/build-aux/compile and
upstream-tar/ceph-0.94.5/src/gmock/gtest/build-aux/compile differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/build-aux/config.guess and
upstream-tar/ceph-0.94.5/src/gmock/gtest/build-aux/config.guess differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/build-aux/config.sub and
upstream-tar/ceph-0.94.5/src/gmock/gtest/build-aux/config.sub differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/build-aux/depcomp and
upstream-tar/ceph-0.94.5/src/gmock/gtest/build-aux/depcomp differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/build-aux/install-sh and
upstream-tar/ceph-0.94.5/src/gmock/gtest/build-aux/install-sh differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/build-aux/ltmain.sh and
upstream-tar/ceph-0.94.5/src/gmock/gtest/build-aux/ltmain.sh differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/build-aux/missing and
upstream-tar/ceph-0.94.5/src/gmock/gtest/build-aux/missing differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/build-aux/test-driver and
upstream-tar/ceph-0.94.5/src/gmock/gtest/build-aux/test-driver differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/configure and
upstream-tar/ceph-0.94.5/src/gmock/gtest/configure differ
Files make-tar/ceph-0.94.5/src/gmock/gtest/Makefile.in and
upstream-tar/ceph-0.94.5/src/gmock/gtest/Makefile.in differ
Files make-tar/ceph-0.94.5/src/gmock/Makefile.in and
upstream-tar/ceph-0.94.5/src/gmock/Makefile.in differ
Files make-tar/ceph-0.94.5/src/java/Makefile.in and
upstream-tar/ceph-0.94.5/src/java/Makefile.in differ
Files make-tar/ceph-0.94.5/src/Makefile.in and
upstream-tar/ceph-0.94.5/src/Makefile.in differ
Files make-tar/ceph-0.94.5/src/ocf/Makefile.in and
upstream-tar/ceph-0.94.5/src/ocf/Makefile.in differ
Files make-tar/ceph-0.94.5/src/tracing/Makefile.in and
upstream-tar/ceph-0.94.5/src/tracing/Makefile.in differ
Files make-tar/ceph-0.94.5/test-driver and
upstream-tar/ceph-0.94.5/test-driver differ

At lot of files point to using a different version of automake, but
there seemed to be a lot of differences in the changelogs.

I don't know the exact process either, I'm just trying to help you out.
-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v1.3.4
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJWs7L8CRDmVDuy+mK58QAAiQQP/AoXZviCa/dm89xC5LZ6
GszZWnQf4vNUbl02jMebAOQXU9CxKSHSTfgU51NCDUkWEeXyhPHGFzivE2Sh
bqWsjtZ33kYfLFrmfl7Ywna/OAdnQBjlg4C15fIYJq6DRo8I+n5MHaeMfCvs
sSh3Dfr6po0G66w+CFVv/UNorW7JyCPBGHZrIwFSbYT1Y49YlEOUVV2aywwQ
xfWhVTU8mFEsGACyqvs4+X04mAUHHZAyEWu5YeSqDM6DcoxERC0H8hgQ170r
Ot4uinQvQh5O964cb/v2mfNRvgn7Du8yz7o3Wj/O6i1WnYp6iUDwAxKyDV2i
Qgu0F4WSA/YpUoRJKUQH8wLjJaerWk4+q/STdRfmL5aauKitHsxBPEkhZwhF
F2dPbHDj4emxxvB9EnRyt+mYllnJ711rlKavn3PZhPTih+s7iK2PSmxqW65Q
RgUqGOBqg9T2MVx7DmyCIBk9bO+LXlBwQJZmS6IvzH06G15o6EkLVYgJ2LFA
Oea26WV9sNQR6EnCcLkmPuF11JLVzwTAJOHBwfv+r1b2HUb+CmNoxmy4Ax9G
7vTXPBBDRTFuRmitb8KgDggB2nKKvLI7OdehQ2PiqN+wcEwvAvd8bmEfw0Ug
THUhBzbmxQ7hrHpLaIQKFnvXmsNgR36ltlSn2E7z4HIyK/LnkmX9+64a0L1a
DzQr
=ZZ09
-----END PGP SIGNATURE-----
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Feb 4, 2016 at 12:15 PM, Odintsov Vladislav <VlOdintsov@croc.ru> wrote:
> I do these commands:
>
> git clone https://github.com/ceph/ceph
> cd ceph
> git reset --hard v0.94.5
> ./autogen.sh
> ./configure
> make dist-bzip2
> tar -tf ceph-0.94.5.tar.bz2 > make-tar
> (cd ../; wget http://download.ceph.com/tarballs/ceph-0.94.5.tar.bz2)
> tar -tf ../ceph-0.94.5.tar.bz2 > upstream-tar
> diff make-tar upstream-tar | wc -l
>
> Output of last command is 5474.
>
> I've saved in my public gist four files:
> - https://gist.github.com/odivlad/137e21382084e7d5a0aa#file-diff  <-- diff between tarballs
> - https://gist.github.com/odivlad/137e21382084e7d5a0aa#file-output  <-- output of commands above
> - https://gist.github.com/odivlad/137e21382084e7d5a0aa#file-make-tar  <-- listing of tarball made by make-bzip2
> - https://gist.github.com/odivlad/137e21382084e7d5a0aa#file-upstream-tar  <-- listing of uptream tarball
>
> So, there is a huge difference in these tarballs and I'd like to find the right way how to make my own tarball the same as upstream one.
>
> ________________________________________
> From: Robert LeBlanc <robert@leblancnet.us>
> Sent: Thursday, February 4, 2016 19:59
> To: Odintsov Vladislav
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: ceph official RPMs ./configure default flags
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> Are you checking out the branch (constantly being merged to) or the
> tag? I don't think the config options matter because at that stage it
> is only configuring the version information in a couple of files. Have
> you cracked open both tarballs to see what files are different? I
> thought there was some issue with getting the same exact commit number
> in the version information, but I don't remember the details.
> - ----------------
> Robert LeBlanc
> PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
>
>
> On Thu, Feb 4, 2016 at 12:03 AM, Odintsov Vladislav  wrote:
>> Hi all,
>>
>> can anyone tell me, how official ceph tarballs (on download.ceph.com) are made from git repo?
>>
>> I tried:
>>
>> git reset --hard v
>> ./autogen
>> ./configure with flags from ceph.spec
>> make dist-bzip2
>>
>> But tar.bz2 differs from the same tar.bz2 on download.ceph.com (I checked on hammer).
>>
>> Also, which ./configure flags are used? Maybe, I'm wrong with my choice...
>> Where can I find actual information about ceph release & build process?
>>
>> I saw some repos, but it seems to me, this is not what I'm looking for...
>>
>> - https://github.com/ceph/ceph-build
>> - https://github.com/ceph/autobuild-ceph
>> - ceph docs "how to build"
>>
>> Thank you.
>>
>> Regards,
>>
>> Vladislav Odintsov
>> System Engineer of Croc Cloud Development Team
>>
>
> -----BEGIN PGP SIGNATURE-----
> Version: Mailvelope v1.3.4
> Comment: https://www.mailvelope.com
>
> wsFcBAEBCAAQBQJWs4NTCRDmVDuy+mK58QAAtb0P/jW9lbeOTMBfTGQPJcuc
> iBTkHZWz49haDPC3kLly3HOVdKZjaMH3xh5p25L2yu10h0T7sbqBTLlIoACQ
> N4RHU5DbgVdE4MmG1zQxfnhg43upZZ7rLYnLy3DH7oOMiIMYCxgdVs22Dp30
> 46d3ac2eTVSRZkzBlV4DUZmqyuT0DjEQZdKSwE6BB/xcYUFhxMz7C2p8vERq
> HVm7LhOEkpPM8aJQlLhiWXONT0m9B7QFkVAk2646bV/SfE05ssg2i90R0IFJ
> cedQz7S/rqPyF8roKYd5EJdw2JS9WgB6l7gLB0++FyHALA5ldo7GJ7HM2T1m
> wBfSWvEok2czUmltpoXV32XqWh1s8nZfzY/Cjba/mz9xYTopZJjwoDe2Ewuh
> VR9j0SluWs0C9BLwLSDx868GMe/8pKACogNPg5mMUA0sn8FhpC/xGXIrEPMS
> IHK5F1kI7yxmoK1afvoVNy7OiGOhbIDXqKv6jw2gcT+1115mltwUv30gnxYF
> Ss0sDYMgwF0EmEtFjzh4AoIumArsFUa7I3zPE9GlfsXinGgELP7KI90vr2zh
> UaCBnzZgCc/+J7i3VOsqDr8qaZy2TRo62qnUlQCENokBO4SWS+c901n43tnH
> p6dOLqyRe6D120zRoUPANiF5oh3B5oWu6zCXoRCa4ktt+L7gGZ3un1YQzXxl
> Dlop
> =EZ25
> -----END PGP SIGNATURE-----
