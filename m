From: Zack Cerza <zack@redhat.com>
Subject: Re: teuthology : 70 workers need more than 8GB RAM / 2 CPUS
Date: Mon, 20 Jul 2015 11:38:07 -0400 (EDT)
Message-ID: <1465341299.749891.1437406687557.JavaMail.zimbra@redhat.com>
References: <55AB9671.7050509@dachary.org> <55ABBD01.3070002@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:46844 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752644AbbGTPjO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 11:39:14 -0400
In-Reply-To: <55ABBD01.3070002@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Andrew Schoen <aschoen@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

This is definitely something to keep an eye on. It's actually a bit sur=
prising to me, though - I haven't seen ansible-playbook use any signifi=
cant resources in sepia.

I wouldn't really recommend running paddles on the same host as teuthol=
ogy though, to do any serious amount of testing; some teuthology tasks =
do use large amounts of RAM and/or CPU, and severe load issues could fe=
asibly cause requests to time out, affecting other jobs.

That's all theory though, as I've always used separate hosts for the tw=
o services.

Zack

----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Zack Cerza" <zack@redhat.com>, "Andrew Schoen" <aschoen@redhat.c=
om>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Sunday, July 19, 2015 9:06:41 AM
> Subject: Re: teuthology : 70 workers need more than 8GB RAM / 2 CPUS
>=20
> Hi again,
>=20
> I had the same problem when 50 workers kick in at the same time. I've=
 lowered
> the number of workers down to 25 and it went well. During a few minut=
es (~8
> minutes) the load average stayed around 25 (CPU bound, mainly the ans=
ible
> playbook competing, see the screenshot of htop). But did not see any =
error /
> timeout. then I added 15 workers, wait for the load to go back to < 2=
 (10
> minutes), then 15 more (10 minutes) to get to 55.
>=20
> That sound like a log of CPU used by a single playbook run. Is there =
a known
> way to reduce that ? If not I'll just upgrade the machine. Just want =
to make
> sure I'm not missing a simple solution ;-)
>=20
> Cheers
>=20
> On 19/07/2015 14:22, Loic Dachary wrote:
> > Hi,
> >=20
> > For the record, I launched a rados suite on an idle teuthology clus=
ter,
> > with 70 workers running on a 8GB RAM / 2 CPUS / 40GB SSD disk. The =
load
> > average reached 40 within a minute or two and some jobs started fai=
ling /
> > timeouting. I had pulpito running on the same machine and it failed=
 one
> > time out of two because of the load (see the top image).
> >=20
> > On friday I was able to run 70 workers because I gradually added th=
em. The
> > load peak is when a job starts and all workers kick in a the same t=
ime.
> >=20
> > Cheers
> >=20
>=20
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
