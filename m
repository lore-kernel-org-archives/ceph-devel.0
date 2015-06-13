From: Abhishek L <abhishek.lekshmanan@gmail.com>
Subject: Re: Hammer Backports integration branch population
Date: Sat, 13 Jun 2015 21:41:26 +0530
Message-ID: <87616ra8r5.fsf@gmail.com>
References: <877fr89mtr.fsf@gmail.com> <557BF658.7050408@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36213 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721AbbFMQOV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Jun 2015 12:14:21 -0400
Received: by pabqy3 with SMTP id qy3so39036455pab.3
        for <ceph-devel@vger.kernel.org>; Sat, 13 Jun 2015 09:14:20 -0700 (PDT)
In-reply-to: <557BF658.7050408@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Loic Dachary writes:

> [cc'ing ceph-devel for Nathan and Xinxin to read]
>
> Hi Abhishek,
>
> On 13/06/2015 07:52, Abhishek L wrote:
>> Hi Loic,
>>=20
>> I've populated the integration branch for my fork[1], with pending pull
>> requests in queue against hammer milestone. Can you push it against the
>> official repo (ceph-ci ?) so that the gitbuilders can start
>> building.
>
> $ git --no-pager log --oneline --merges ceph/hammer..theanalyst/hammer-ba=
ckports
> 3677fd2 Merge 4657: DNM: common/admin_socket: close socket descriptor in =
destructor
> 6f89359 Merge 4667: ceph.spec: update OpenSUSE BuildRequires
> 7d50492 Merge 4687: utf8 and old gcc breakage on RHEL6.5
> 26c1f8a Merge 4776: ceph: cli interactive mode does not understand quotes
> b9b015a Merge 4846: missing man pages for ceph-create-keys, ceph-disk-*
> ae2a2cb Merge 4862: Bucket header is enclosed by quotes
> e82807f Merge 4868: Clock skew causes missing summary and confuses Calama=
ri
> f0ae884 Merge 4875: librbd: aio calls may block
> c840979 Merge 4877: admin/build-doc: script fails silently under certain =
circumstances
> c5f51fe Merge 4883: ceph.spec.in: ceph-common subpackage def needs tweaki=
ng for SUSE/openSUSE
> 8e3662e Merge 4884: Keystone PKI token expiration is not enforced
> 5fdace1 Merge 4885: Object copy bug
> 29c563a Merge 4886: MDS is crashed (mds/CDir.cc: 1391: FAILED assert(!is_=
complete()))
> 43eb346 Merge 4889: OPT_INT option interprets 3221225472 as -1073741824, =
and crashes in Throttle::Throttle()
> 7768fb2 Merge 4891: crush: take crashes due to invalid arg
> a5885bc Merge 4892: ceph-disk: get_partition_type fails on /dev/cciss...
> 8b79288 Merge 4899: start_flush: filter out removed snaps before determin=
ing snapc's
> 59c4d78 Merge 4902: Fixes for rados ops with snaps
> b0e083e Merge 4936: mon crashes when "ceph osd tree 85 --format json"
>
> I see a DNM here: is it intentional ?
>
> http://ceph.com/gitbuilder.cgi is building https://github.com/ceph/ceph/t=
ree/hammer-backports

Since I used a script to extract the PR's, I guess this commit got
pulled in as well. However looking at the particular PR [1], it looks
like DNM was only marked because it shouldn't be making it to the last
hammer, (and you marked it as DNM ;) So no harm done.

[1]: https://github.com/ceph/ceph/pull/4657

>
>>=20
>> Also, for finding out PR's against a milestone, I've used the github's
>> api to get the relevant PR numbers, I've updated the wiki for populating
>> the integration branch[2] Let me know if this looks okay to you.=20
>
> Very convenient, great addition the snippets collection !
>
> Cheers
>
>> [1] https://github.com/theanalyst/ceph/tree/hammer-backports
>> [2] http://tracker.ceph.com/projects/ceph-releases/wiki/HOWTO_populate_t=
he_integration_branch
>>=20
>> Cheers,=20
>> Abhishek
>>=20

=2D-=20
Abhishek

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"; name="signature.asc"; description="Digital signature"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJVfFY4AAoJEPnwZB8bZe1fjjwH/jt/CCDztUEftY/mi4UeuhtV
H1ZA/aweiqDlqULNJ7sRGb3h+3BIx/MXOasYnt2c6iQNuFoM6j09kBgNMbF6lZxq
0/SpLTmcmsZZc1590wB8+kbS3LUWal0xm3WUayrhILqDA6uB0lO+eavZbmKPbioa
qwqoyOBFFOmuzaYZDcNB3LZfd4Z7Ble8Oj4XWUmWWqZKqh5k6nV2Cy+k2xVfbqlY
eUR5+NmNJWOSGnV6oCrb1MoV3eulJUDYoQ7ytkw1e3ElGRzntZVCA6pfYghWXtjo
aoqm7cThXeGpTugUrEfzLs+1eAF15oYBkd7atcddUOE0F0Ixd/GPCrJE7JbP95U=
=QVuZ
-----END PGP SIGNATURE-----
--=-=-=--
