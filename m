From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD tests on the next dumpling release
Date: Mon, 9 Feb 2015 15:27:17 -0500 (EST)
Message-ID: <1749420664.9284413.1423513637594.JavaMail.zimbra@redhat.com>
References: <54D3EEF6.1070701@dachary.org> <1050495133.7647881.1423231520223.JavaMail.zimbra@redhat.com> <54D4CD03.8000806@dachary.org> <408976183.7693525.1423233776228.JavaMail.zimbra@redhat.com> <54D8882A.6010804@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx5-phx2.redhat.com ([209.132.183.37]:44436 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932799AbbBIU2U convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 9 Feb 2015 15:28:20 -0500
In-Reply-To: <54D8882A.6010804@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

I would agree with your assessment that http://tracker.ceph.com/issues/=
10560#teuthology-runs-on-3944c77c404c4a05886fe8276d5d0dd7e4f20410-6-feb=
ruary sounds like a repeat of http://tracker.ceph.com/issues/4959.

Josh, thoughts?

--=20

Jason Dillaman=20
Red Hat=20
dillaman@redhat.com=20
http://www.redhat.com=20


----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Jason Dillaman" <dillaman@redhat.com>
Cc: "Josh Durgin" <jdurgin@redhat.com>, "Ceph Development" <ceph-devel@=
vger.kernel.org>
Sent: Monday, February 9, 2015 5:12:58 AM
Subject: Re: RBD tests on the next dumpling release

Hi Jason,

Your backport of http://tracker.ceph.com/issues/9854 at https://github.=
com/ceph/ceph/pull/3655 was added to the dumpling-backports branch and =
the RBD suite run came back with one error.

http://tracker.ceph.com/issues/10560#teuthology-runs-on-3944c77c404c4a0=
5886fe8276d5d0dd7e4f20410-6-february

I'm under the impression that this is unrelated. What do you think ?

The error found in the previous run

http://tracker.ceph.com/issues/10560#teuthology-runs-on-fd37e5a9749c557=
9a592ebe926a3c576be0617cd-3-february

could not be repeated by another run of the same test

http://pulpito.ceph.com/loic-2015-02-05_21:41:04-rbd-dumpling-backports=
---basic-multi/

and I closed the ticket as "Can't reproduce" since you did not reproduc=
e it locally either. Feel free to change the state of the ticket if, fo=
r instance, you would like it to remain open during a few weeks in case=
 it shows up again.

Cheers

On 06/02/2015 15:42, Jason Dillaman wrote:
> I would say #9854 is critical for this dumpling point release since i=
t fixes a regression that would otherwise be introduced by this point r=
elease.
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
