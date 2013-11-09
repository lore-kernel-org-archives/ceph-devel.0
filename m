From: Tim Bell <Tim.Bell@cern.ch>
Subject: Re: HSM
Date: Sat, 9 Nov 2013 14:20:37 +0000
Message-ID: <5D7F9996EA547448BC6C54C8C5AAF4E5D980ABD2@CERNXCHG02.cern.ch>
References: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cernmx13.cern.ch ([188.184.36.46]:12818 "EHLO CERNMX13.cern.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752907Ab3KIOZx convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 09:25:53 -0500
In-Reply-To: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
Content-Language: en-US
Content-ID: <262BEBA305901845943BB8C7646C9752@cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "<ceph-devel@vger.kernel.org>" <ceph-devel@vger.kernel.org>


Looking at the potential applications of HSM, an implementation based a=
round the object store/radosgw may also be highly desirable.

Spectralogic recently announced their DS3 API which adds bring online/o=
ffline operations to S3.

In particular,

- People using S3/SWIFT think in terms of bulk per-file operations rath=
er than POSIX semantics. Updates are a problem for tape based systems. =
It can be done but recovering from a bad migration of active data is no=
t easy.

- Containers group related files together. The expensive operations on =
tape are mount and seek. Thus, the aim should be to maximise the number=
 of related files on a tape for ease of recall. When moving files aroun=
d from one media for another (repack operations), container level group=
ing ensures that the number of recall mounts is minimised.

- Keeping the tape drives busy js always difficult=85 tape drives are n=
ow regularly exceeding 250MB/s on a single stream so the storage system=
 needs to be able to maintain a high data rate. Tape drive performance =
drops rapidly when the drives have to stop and then restart as the buff=
ers fill up again.

Tim

On 9 Nov 2013, at 09:33, Sage Weil <sage@inktank.com> wrote:

> The latest Lustre just added HSM support:
>=20
> 	http://archive.hpcwire.com/hpcwire/2013-11-06/lustre_scores_business=
_class_upgrade_with_hsm.html
>=20
> Here is a slide deck with some high-level detail:
> =09
> 	https://jira.hpdd.intel.com/secure/attachment/13185/Lustre_HSM_Desig=
n.pdf
>=20
> Is anyone familiar with the interfaces and requirements of the file s=
ystem=20
> itself?  I don't know much about how these systems are implemented, b=
ut I=20
> would guess there are relatively lightweight requirements on the fs (=
ceph=20
> mds in our case) to keep track of file state (online or archived=20
> elsewhere).  And some hooks to trigger migrations?
>=20
> If anyone is interested in this area, I would be happy to help figure=
 out=20
> how to integrate things cleanly!
>=20
> sage
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
