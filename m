From: Loic Dachary <loic@dachary.org>
Subject: Re: Jenkins error in running tests ....
Date: Wed, 10 Feb 2016 21:17:46 +0700
Message-ID: <56BB468A.7080700@dachary.org>
References: <56B9B0A1.6090807@digiware.nl>
 <CAJE9aONSEzJVWe4Ows7oNrg403_ucT4vYdvCNEujGr74h7cYqw@mail.gmail.com>
 <56BB273D.2040007@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:59357 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbcBJOSP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Feb 2016 09:18:15 -0500
In-Reply-To: <56BB273D.2040007@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've seen it too. Filed http://tracker.ceph.com/issues/14723

On 10/02/2016 19:04, Willem Jan Withagen wrote:
>=20
> https://jenkins.ceph.com/job/ceph-pull-requests/1261/console
>=20
> .......
> PASS: test/osd/osd-scrub-repair.sh
> make[5]: execvp: /bin/sh: Argument list too long
> make[5]: *** [test-suite.log] Error 127
> make[5]: Leaving directory
> `/home/jenkins-build/build/workspace/ceph-pull-requests/src'
> make[4]: *** [check-TESTS] Error 2
> make[4]: Leaving directory
> `/home/jenkins-build/build/workspace/ceph-pull-requests/src'
> make[3]: *** [check-am] Error 2
>=20
> I'm assuming that it is not something I did in my code.
> But then again I've been proven wrong....

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
