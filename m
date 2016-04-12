From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: rbd and the next hammer release v0.94.7
Date: Mon, 11 Apr 2016 20:38:19 -0400 (EDT)
Message-ID: <153564246.49912040.1460421499492.JavaMail.zimbra@redhat.com>
References: <570B8BF4.8080900@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:38489 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754600AbcDLAiZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2016 20:38:25 -0400
In-Reply-To: <570B8BF4.8080900@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Nathan Cutler <ncutler@suse.cz>

The RBD runs [1] lgtm ;-)

[1] http://pulpito.ceph.com/loic-2016-04-05_04:44:01-rbd-hammer-backpor=
ts---basic-smithi/

--=20

Jason Dillaman=20

----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Josh Durgin" <jdurgin@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Nathan Cutler" =
<ncutler@suse.cz>, "Jason Dillaman"
> <dillaman@redhat.com>
> Sent: Monday, April 11, 2016 7:35:16 AM
> Subject: rbd and the next hammer release v0.94.7
>=20
> Hi Josh,
>=20
> The next hammer release as found at https://github.com/ceph/ceph/tree=
/hammer
> passed the rbd suite (http://tracker.ceph.com/issues/14692#note-49 an=
d
> http://pulpito.ceph.com/teuthology-2015-10-12_17:29:20-rbd-hammer-dis=
tro-basic-multi/
> which has 3 failures). Do you think the hammer branch is ready for QE=
 to
> start their own round of testing ?
>=20
> Cheers
>=20
> P.S. Jason, please let us know when the time comes to ask you for thi=
s kind
> of executive decision ;-)
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
