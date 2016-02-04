From: Odintsov Vladislav <VlOdintsov@croc.ru>
Subject: Re: ceph official RPMs ./configure default flags
Date: Thu, 4 Feb 2016 19:15:18 +0000
Message-ID: <1454613322703.72233@croc.ru>
References: <1454569441928.38241@croc.ru>,<CAANLjFox6GarmHS+0MEiQK=G7yJROEXUxBVUWPhSVQ+r69c9sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ironport1.croc.ru ([195.38.23.101]:8938 "EHLO ironport1.croc.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965095AbcBDTPZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 14:15:25 -0500
In-Reply-To: <CAANLjFox6GarmHS+0MEiQK=G7yJROEXUxBVUWPhSVQ+r69c9sg@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I do these commands:

git clone https://github.com/ceph/ceph
cd ceph
git reset --hard v0.94.5
./autogen.sh
./configure
make dist-bzip2
tar -tf ceph-0.94.5.tar.bz2 > make-tar
(cd ../; wget http://download.ceph.com/tarballs/ceph-0.94.5.tar.bz2)
tar -tf ../ceph-0.94.5.tar.bz2 > upstream-tar
diff make-tar upstream-tar | wc -l

Output of last command is 5474.

I've saved in my public gist four files:
- https://gist.github.com/odivlad/137e21382084e7d5a0aa#file-diff  <-- diff between tarballs
- https://gist.github.com/odivlad/137e21382084e7d5a0aa#file-output  <-- output of commands above
- https://gist.github.com/odivlad/137e21382084e7d5a0aa#file-make-tar  <-- listing of tarball made by make-bzip2
- https://gist.github.com/odivlad/137e21382084e7d5a0aa#file-upstream-tar  <-- listing of uptream tarball

So, there is a huge difference in these tarballs and I'd like to find the right way how to make my own tarball the same as upstream one.

________________________________________
From: Robert LeBlanc <robert@leblancnet.us>
Sent: Thursday, February 4, 2016 19:59
To: Odintsov Vladislav
Cc: ceph-devel@vger.kernel.org
Subject: Re: ceph official RPMs ./configure default flags

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
