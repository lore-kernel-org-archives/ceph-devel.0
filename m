From: James Page <james.page@canonical.com>
Subject: Re: [GIT PULL v5] java: add libcephfs Java bindings
Date: Fri, 05 Oct 2012 08:10:32 +0100
Message-ID: <506E87E8.60802@canonical.com>
References: <CAPrxi5-6JAWzUdsgdfHw=pG+6r5LN5i8X92DwxdejosY0xT0Dw@mail.gmail.com> <alpine.DEB.2.00.1209052051270.7974@cobra.newdream.net> <CAPrxi5-_AYV0UUuABCM+LkSpRVOM63R5XPDmjz9HE3UxFBe7AA@mail.gmail.com> <CAPrxi59Per-OMrc83pVLAkUs3rU=+RF9bN_X5bb+K1zC+STUng@mail.gmail.com> <alpine.DEB.2.00.1210031238300.23173@cobra.newdream.net> <506DF09B.20505@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56440 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab2JEHKg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Oct 2012 03:10:36 -0400
In-Reply-To: <506DF09B.20505@ubuntu.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: gcs@debian.hu, Noah Watkins <jayhawk@cs.ucsc.edu>, Joe Buck <buck@soe.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 04/10/12 21:24, James Page wrote:
> 4) src/java/build.xml
> 
> Please set the source/target version of Java to something sensible 
> during the build process - ideally 1.5 (as 1.6 introduced no new 
> language features).  Ubuntu quantal's default-jdk is OpenJDK7 - 
> without this it will build code which is not backwards compatible.

Actually this last point applies to both the Makefile and the
build.xml - missed that during my first review.

- -- 
James Page
Technical Lead
Ubuntu Server and Cloud Workloads Team
james.page@canonical.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBCAAGBQJQbofoAAoJEL/srsug59jDa6oQAK7jU8OLuwcn5cTliIV5XD+k
3fkVNLKZ09TeRv8HsDv4DFGcmZdVUxE0AxMnby2ANei+Nn5wGWhQp11h6g8mk2G3
eUOvAOaG8K/fPEl+6gG3HXw7okivKw9FjkxE3/H3yC3vJ4kJVunKcH6a4aN4mSYn
EddD5cT9jHT9ka1pKzel2F2dzSOp0sOwqgs0kN4H+QlVB/vQ6olNY1PvaAC7q39o
MTEHQ/3iI0KvDxWHlETrrzcSDeyN9g0/j8yUuY00DuLSsXacieWtJoN89ZuElUBh
Ma8SXNMBSRvmdUvQzBgmFjQFlNffyRY7xNftMSFPUGkp22ZQWU/tdbNmHkr/wBdB
KG4TtCrM8NVtxieXLcUsYltioKLj0On208vK5Dro/PpaDnWTmkKA1p6wUtJMX38m
7HjjWo/JS8xZ2/9UTxD4ScjTrZLuGmesJ5zPEgB9CLOMq+9yoF7e2K3qeIdRA4mF
IiMCXp5PaC57xYLBmTbz/zyJSSdEX+7e2bTUErgpKIzTehjzIeAfFXsRoPnunQWF
08X0fIyTRKrMimkextTxvqHCjiN8xF6NtzOz1x5kuQVCcuay3iKAXriYLBvU1KsO
0wR6aNj+9bobVj2uUZ3BKNDrzzwCs+/UOiz2YnYJnJtGRzMH3Bu3g8RVjxZwYlL8
Xk7hykl3tOL8f5aGV6JL
=kXxN
-----END PGP SIGNATURE-----
