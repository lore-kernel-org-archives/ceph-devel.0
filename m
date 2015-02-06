From: Jason Dillaman <dillaman@redhat.com>
Subject: Re: RBD tests on the next dumpling release
Date: Fri, 6 Feb 2015 09:05:20 -0500 (EST)
Message-ID: <1050495133.7647881.1423231520223.JavaMail.zimbra@redhat.com>
References: <54D3EEF6.1070701@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:47407 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbbBFOG1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 09:06:27 -0500
In-Reply-To: <54D3EEF6.1070701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Josh Durgin <jdurgin@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

I'll take a look at it today, but my gut tells me it probably has somet=
hing to do w/ a new version of QEMU (assuming the binary isn't source c=
ontrolled).  On a semi-related note, I just discovered that http://trac=
ker.ceph.com/issues/9854 is missing a dumpling backport request.  I'll =
get a dumpling pull request for that issue ASAP.

--=20

Jason Dillaman=20
Red Hat=20
dillaman@redhat.com=20
http://www.redhat.com=20


----- Original Message -----
=46rom: "Loic Dachary" <loic@dachary.org>
To: "Jason Dillaman" <dillaman@redhat.com>, "Josh Durgin" <jdurgin@redh=
at.com>
Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
Sent: Thursday, February 5, 2015 5:30:14 PM
Subject: RBD tests on the next dumpling release

Hi Jason & Josh,

http://tracker.ceph.com/issues/10773 is the last unresolved issue for t=
he next dumpling point release. I tried to collect information about th=
e problem but I'm not sure if it should be a blocker or not. I suspect =
it's not but ... what do you think ?

=46or the record, the commits that are included in the backport branch =
being tested are summarized here : http://workbench.dachary.org/ceph/ce=
ph-backports/wikis/dumpling up to and including http://workbench.dachar=
y.org/ceph/ceph-backports/wikis/dumpling#pull-requests-waiting-to-be-in=
tegrated

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
