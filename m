From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph OSD facts file
Date: Thu, 3 Mar 2016 22:41:30 +0700
Message-ID: <56D85B2A.2000709@dachary.org>
References: <CALqRxCwLovLsdhWKMztqsuz5Mv46XYyjU6Z9O9BRt1GtnONKBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:42959 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbcCCPlk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Mar 2016 10:41:40 -0500
In-Reply-To: <CALqRxCwLovLsdhWKMztqsuz5Mv46XYyjU6Z9O9BRt1GtnONKBg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Ken,

I'll work on http://tracker.ceph.com/issues/14972 and create that scrip=
t.

Thanks for a nice and precise description :-)

On 03/03/2016 05:50, Ken Dreyer wrote:
> Hi Loic,
>=20
> In Red Hat we're interested in having a Ceph "facts" file that we can
> integrate with RHEL's subscription-manager (upstream
> http://www.candlepinproject.org/ fyi) in order to report on the
> available raw disk capacity available per OSD.
>=20
> We need a script to write a "/etc/rhsm/facts/ceph_disk.facts" file.
> That file needs to contain JSON of the form:
>=20
> {
>   "band.storage.usage": <integer number of TB used on this node, such=
 as 55>
> }
>=20
> for example:
> {
>   "band.storage.usage": 55
> }
>=20
> As long as that file exists (and it can be named anything that ends i=
n
> ".facts") the contents will be read in and added to the system facts.
> On RHEL this can be verified by running `subscription-manager facts`
> to ensure that your value is showing up properly.
>=20
> In terms of creating this .facts file, we will need a script to do
> that. We could call it /usr/bin/ceph-update-fact-file, or make it a
> ceph-disk sub-command, or whatever you want, really.
>=20
> The facts file should be kept up-to-date every four hours, which make=
s
> me think that we could implement this as a systemd service and timer.
> Something like
>=20
>   $ cat /etc/systemd/system/ceph-update-facts-file.service
>=20
>   [Unit]
>   Description=3DUpdate Ceph OSD fact file
>=20
>   [Service]
>   Type=3Doneshot
>   ExecStart=3D/usr/bin/ceph-update-fact-file
>=20
>=20
> ...and:
>=20
>   $ cat /etc/systemd/system/ceph-update-facts-file.timer
>   [Unit]
>   Description=3DTrigger an automatic rewrite every four hours
>=20
>   [Timer]
>   OnCalendar=3D4hours
>   Persistent=3Dtrue
>=20
>   [Install]
>   WantedBy=3Dmulti-user.target
>=20
> (The above is untested, it's just an idea).  What do you think?
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
