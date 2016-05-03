From: "Handzik, Joseph" <joseph.t.handzik@hpe.com>
Subject: RE: Introducing libstoragemgmt as a Ceph dependency
Date: Tue, 3 May 2016 18:22:45 +0000
Message-ID: <TU4PR84MB00326FE52F4342863273CFA4CC7A0@TU4PR84MB0032.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR84MB0032768F74C89DF30F93BE0BCC7A0@TU4PR84MB0032.NAMPRD84.PROD.OUTLOOK.COM>
 <alpine.DEB.2.11.1605031412580.26967@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-by2on0106.outbound.protection.outlook.com ([207.46.100.106]:24522
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932756AbcECSiJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 14:38:09 -0400
In-Reply-To: <alpine.DEB.2.11.1605031412580.26967@cpach.fuggernut.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "tasleson@redhat.com" <tasleson@redhat.com>, Gris Ge <fge@redhat.com>

Hey Sage,

-----Original Message-----
=46rom: Sage Weil [mailto:sage@newdream.net]=20
Sent: Tuesday, May 3, 2016 1:15 PM
To: Handzik, Joseph <joseph.t.handzik@hpe.com>
Cc: ceph-devel@vger.kernel.org; tasleson@redhat.com; Gris Ge <fge@redha=
t.com>
Subject: Re: Introducing libstoragemgmt as a Ceph dependency

Hi Joseph,

On Tue, 3 May 2016, Handzik, Joseph wrote:
> Hey ceph-devel,
>=20
> Back around this time in 2015, I started asking questions about what=20
> the Ceph community would expect around hardware integration with an=20
> underlying storage system (my primary concern was blinking LEDs):
> http://www.spinics.net/lists/ceph-devel/msg23404.html
>=20
> I received some good feedback, which turned into this blueprint here:=
=20
> http://tracker.ceph.com/projects/ceph/wiki/Calamariapihardwarestorage
>=20
> That set me down a windy path of pulling device paths for underlying=20
> devices via the OSD, pulling metadata attributes for OSDs into=20
> calamari, and eventually over to libstoragemgmt (Github link:
> https://github.com/libstorage/libstoragemgmt).
>=20
> libstoragemgmt covers what I perceived to be the initial requirements=
=20
> for an API to talk to underlying storage devices. It's vendor=20
> agnostic, extensible, and provides C and python bindings. Over the=20
> last 6 months or so, we've spent time in the libstoragemgmt source=20
> adding a set of APIs that actually submit SCSI Enclosure Service=20
> commands via C and python bindings. The first set of functionality=20
> introduced was commands to enable and disable the IDENT and FAULT=20
> LEDs. These APIs sit alongside the vendor-specific interfaces that=20
> libstoragemgmt already provided (there's good support for Smart Array=
=20
> and MegaRAID, for example). We're working on NVMe support too, though=
=20
> that may slip out of the upcoming
> 1.3 release.
>=20
> My involvement in libstoragemgmt, as mentioned earlier, was with the=20
> purpose of integrating better hardware monitoring and management=20
> support into Ceph. I did some work on my own in a fork that I created=
=20
> of libstoragemgmt to integrate it into the Ceph cli that exists today=
=20
> (note that the APIs in upstream libstoragemgmt have changed, but the=20
> code would be conceptually similar):
> https://github.com/joehandzik/ceph/tree/wip-hw-mgmt-cli

Blinky lights, yay!
=20
> John Spray has already mentioned to me that I should convert my=20
> message interface to use "tell" commands instead, but aside from that=
=20
> I think this is roughly what a final pull would look like (with test=20
> framework code). I have tested this on HPE hardware, so the concept=20
> does work. All of this functionality will require an opt-in from the=20
> user via a ceph.conf value (to tell Ceph what storage device they're=20
> using). If the value is never set, the user will=A0 not be able to us=
e these APIs.
>=20
> I'm giving all the above for context, but what I really need to know=20
> from the ceph-devel community is: Does anyone have any concerns with=20
> adding libstoragemgmt as a Ceph dependency? It would only work for th=
e=20
> standard Linux flavors and distros (Rhel and Centos, OpenSuse and=20
> SLES, Debian and Ubuntu). The features I'm adding would be no-ops or=20
> disabled for other distros unless someone in the community finds a wa=
y=20
> to distribute libstoragemgmt for their operating environment or finds=
=20
> an adequate replacement for the functionality. It's also worth noting=
=20
> that I'm completely dependent on the previously mentioned 1.3 release=
=20
> of libstoragemgmt, which is why I've waited on this for a while (the=20
> blueprint was initially intended for Jewel).

The current distros upstream currently buidls on are:

 centos 7
 ubuntu 16.04
 ubuntu 14.04
 debian 8 (jessie)

Other packages are all down downstream (e.g., opensuse and sles).

Anyway, is libstoragemgt available for the above?

[JH] - I'm seeing packages for both 16.04 and 14.04, along with Debian =
Jessie and Centos7. I think my biggest challenge will be figuring out *=
exactly* when the 1.3 release of libstoragemgmt is available for all th=
ese distros. I don't plan to submit a pull until I can confirm that.

We will presuambly want the build system to conditionally compile it ou=
t with a flag in case it is not present or available, so we can also do=
 that as needed (e.g., on 14.04, which probably won't have it).

[JH] - Can do, I agree that I want to give folks the option to compile =
without it. Thanks!

sage
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
