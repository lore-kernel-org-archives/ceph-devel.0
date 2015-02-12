From: Samuel Just <sam.just@inktank.com>
Subject: Re: dumpling integration branch for v0.67.12 ready for QE
Date: Thu, 12 Feb 2015 14:23:24 -0800
Message-ID: <CA+4uBUZd_cqudz6TPcu_K8f3jXQVNDYeqAsXotv2sNmQEN__Fw@mail.gmail.com>
References: <54DA3A5B.5050509@dachary.org>
	<1520027977.15929683.1423693473209.JavaMail.zimbra@redhat.com>
	<1586599856.17187011.1423778777774.JavaMail.zimbra@redhat.com>
Reply-To: sjust@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:33829 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536AbbBLWX0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Feb 2015 17:23:26 -0500
Received: by mail-lb0-f181.google.com with SMTP id b6so12187636lbj.12
        for <ceph-devel@vger.kernel.org>; Thu, 12 Feb 2015 14:23:24 -0800 (PST)
In-Reply-To: <1586599856.17187011.1423778777774.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Tamil Muthamizhan <tmuthami@redhat.com>, Zack Cerza <zack@redhat.com>, Sandon Van Ness <svanness@redhat.com>

Yeah, the rados run had too much environmental noise to be useful.
-Sam

On Thu, Feb 12, 2015 at 2:06 PM, Yuri Weinstein <yweinste@redhat.com> w=
rote:
> I linked all issues related to this release testing to the ticket htt=
p://tracker.ceph.com/issues/10560
>
> After the team leads make a call of those, including environment issu=
es, I suggest re-running suites the failed again.
>
> Loic, I'd re-run them in the Octo, since we already started there, if=
 you agree ?
>
> Thx
> YuriW
>
> ----- Original Message -----
> From: "Yuri Weinstein" <yweinste@redhat.com>
> To: "Loic Dachary" <loic@dachary.org>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Sage Weil" <sag=
e@redhat.com>, "Tamil Muthamizhan" <tmuthami@redhat.com>
> Sent: Wednesday, February 11, 2015 2:24:33 PM
> Subject: Re: dumpling integration branch for v0.67.12 ready for QE
>
> I replied to individual suites runs, but just wanted to summarize QE =
validation status.
>
> The following suites were executed in the Octo lab (we will use Sepia=
 in the future if nobody objects).
>
> upgrade:dumpling
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45493']
> http://tracker.ceph.com/issues/10694 - Known "Won't fix"
> "Assertion: osd/Watch.cc: 290: FAILED assert(!cb)"
>
> *** Sam - pls confirm the "Won't fix" status.
>
> ['45495', '45496', '45498', '45499', '45500']
> http://tracker.ceph.com/issues/10838
> "s3tests failed"
>
> *** Yehuda - need your verdict on s3tests.
>
> fs
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> All green !
>
> rados
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45054']
> http://tracker.ceph.com/issues/10841
> "Issued certificate has expired"
> *** Sandon pls comment.
>
> ['45168', '45169']
> http://tracker.ceph.com/issues/10840
> coredump "ceph_test_filestore_idempotent_sequence"
> *** Sam - pls comment
>
> ['45215']
> Missing packages - no ticket FYI
> "Failed to fetch http://apt-mirror.front.sepia.ceph.com/archive.ubunt=
u.com/ubuntu/dists/trusty-updates/universe/binary-i386/Packages  Hash S=
um mismatch"
>
> *** Zack, Sandon ?
>
> ceph-deploy
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Travis - pls suggest
> In general I am not sure if we needed to test this - Sage?
>
> rbd
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45365', '45366', '45367']
> http://tracker.ceph.com/issues/10842
> "unable to connect to apt-mirror.front.sepia.ceph.com"
>
> ['45349', '45350', '45351', '45355', '45356', '45357', '45363']
> http://tracker.ceph.com/issues/10802
> "error: image still has watchers"
> (duplicate of 10680)
>
> *** Zack, Sandon, Josh - all environment noise, pls comment.
>
> rgw
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> ['45382', '45390']
> http://tracker.ceph.com/issues/10843
> "s3tests failed" - could be related or duplicate of 10838
>
> *** Yehuda - same as issues in upgrades?
>
> I am standing by for you analysis/replies and recommendations for nex=
t steps.
>
> Loic - let me know is you want to follow specific items in our backpo=
rt testing process that I missed here.
> PS:  I would think that you could've wanted to assign the release tic=
ket to QE (me) for validation and at this point I could've re-assigned =
it back to devel (you), a?
>
> Thx
> YuriW
>
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, February 10, 2015 9:05:31 AM
> Subject: dumpling integration branch for v0.67.12 ready for QE
>
> Hi Yuri,
>
> The dumpling integration branch for v0.67.12 as found at https://gith=
ub.com/ceph/ceph/commits/dumpling-backports has been approved by Yehuda=
, Josh and Sam and is ready for QE.
>
> For the record, the head is https://github.com/ceph/ceph/commit/3944c=
77c404c4a05886fe8276d5d0dd7e4f20410
>
> I think it would be best for the QE tests to use the dumpling-backpor=
ts. The alternative would be to merge dumpling-backports into dumpling.=
 However, since testing may take a long time and require more patches, =
it probably is better to not do that iterative process on the dumpling =
branch itself. As it is now, there already are a number of commits in t=
he dumpling branch that should really be in the dumpling-backports: the=
y do not belong to v0.67.11 and are going to be released in v0.67.12. I=
n the future though, the dumpling branch will only receive commits that=
 have been carefully tested and all the integration work will be on the=
 dumpling-backports branch exclusively. So that third parties do not ha=
ve to worry that the dumpling branch contains commits that have not bee=
n tested yet.
>
> Cheers
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
