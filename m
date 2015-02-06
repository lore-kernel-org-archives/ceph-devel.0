From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD tests on the next dumpling release
Date: Fri, 6 Feb 2015 09:42:56 -0500 (EST)
Message-ID: <408976183.7693525.1423233776228.JavaMail.zimbra@redhat.com>
References: <54D3EEF6.1070701@dachary.org> <1050495133.7647881.1423231520223.JavaMail.zimbra@redhat.com> <54D4CD03.8000806@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:49486 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754795AbbBFOn6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 09:43:58 -0500
In-Reply-To: <54D4CD03.8000806@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

I would say #9854 is critical for this dumpling point release since it =
fixes a regression that would otherwise be introduced by this point rel=
ease.

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
Sent: Friday, February 6, 2015 9:17:39 AM
Subject: Re: RBD tests on the next dumpling release

Hi Jason,

Thanks for taking time to check :-)=20

http://tracker.ceph.com/issues/9854 is indeed in the list of issues tha=
t need backporting for dumpling:

http://workbench.dachary.org/ceph/ceph-backports/wikis/dumpling#issues-=
that-need-backporting

so is http://tracker.ceph.com/issues/10299. I'm happy to do another rou=
nd of testing if you think these two need to be in the next release. Ot=
herwise they will be in the next point release. I'm hopeful we'll be ab=
le to do more frequent point releases in the future.

On 06/02/2015 15:05, Jason Dillaman wrote:> I'll take a look at it toda=
y, but my gut tells me it probably has something to do w/ a new version=
 of QEMU (assuming the binary isn't source controlled).  On a semi-rela=
ted note, I just discovered that http://tracker.ceph.com/issues/9854 is=
 missing a dumpling backport request.  I'll get a dumpling pull request=
 for that issue ASAP.
>=20

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
