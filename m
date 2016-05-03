From: "Handzik, Joseph" <joseph.t.handzik@hpe.com>
Subject: Introducing libstoragemgmt as a Ceph dependency
Date: Tue, 3 May 2016 17:54:19 +0000
Message-ID: <TU4PR84MB0032768F74C89DF30F93BE0BCC7A0@TU4PR84MB0032.NAMPRD84.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0136.outbound.protection.outlook.com ([157.56.110.136]:33265
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933925AbcECSIi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 14:08:38 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "tasleson@redhat.com" <tasleson@redhat.com>, Gris Ge <fge@redhat.com>

Hey ceph-devel,

Back around this time in 2015, I started asking questions about what th=
e Ceph community would expect around hardware integration with an under=
lying storage system (my primary concern was blinking LEDs): http://www=
=2Espinics.net/lists/ceph-devel/msg23404.html

I received some good feedback, which turned into this blueprint here: h=
ttp://tracker.ceph.com/projects/ceph/wiki/Calamariapihardwarestorage

That set me down a windy path of pulling device paths for underlying de=
vices via the OSD, pulling metadata attributes for OSDs into calamari, =
and eventually over to libstoragemgmt (Github link: https://github.com/=
libstorage/libstoragemgmt).=20

libstoragemgmt covers what I perceived to be the initial requirements f=
or an API to talk to underlying storage devices. It's vendor agnostic, =
extensible, and provides C and python bindings. Over the last 6 months =
or so, we've spent time in the libstoragemgmt source adding a set of AP=
Is that actually submit SCSI Enclosure Service commands via C and pytho=
n bindings. The first set of functionality introduced was commands to e=
nable and disable the IDENT and FAULT LEDs. These APIs sit alongside th=
e vendor-specific interfaces that libstoragemgmt already provided (ther=
e's good support for Smart Array and MegaRAID, for example). We're work=
ing on NVMe support too, though that may slip out of the upcoming 1.3 r=
elease.

My involvement in libstoragemgmt, as mentioned earlier, was with the pu=
rpose of integrating better hardware monitoring and management support =
into Ceph. I did some work on my own in a fork that I created of libsto=
ragemgmt to integrate it into the Ceph cli that exists today (note that=
 the APIs in upstream libstoragemgmt have changed, but the code would b=
e conceptually similar): https://github.com/joehandzik/ceph/tree/wip-hw=
-mgmt-cli

John Spray has already mentioned to me that I should convert my message=
 interface to use "tell" commands instead, but aside from that I think =
this is roughly what a final pull would look like (with test framework =
code). I have tested this on HPE hardware, so the concept does work. Al=
l of this functionality will require an opt-in from the user via a ceph=
=2Econf value (to tell Ceph what storage device they're using). If the =
value is never set, the user will=A0 not be able to use these APIs.

I'm giving all the above for context, but what I really need to know fr=
om the ceph-devel community is: Does anyone have any concerns with addi=
ng libstoragemgmt as a Ceph dependency? It would only work for the stan=
dard Linux flavors and distros (Rhel and Centos, OpenSuse and SLES, Deb=
ian and Ubuntu). The features I'm adding would be no-ops or disabled fo=
r other distros unless someone in the community finds a way to distribu=
te libstoragemgmt for their operating environment or finds an adequate =
replacement for the functionality. It's also worth noting that I'm comp=
letely dependent on the previously mentioned 1.3 release of libstoragem=
gmt, which is why I've waited on this for a while (the blueprint was in=
itially intended for Jewel).=20

I've copied the libstoragemgmt leads here, please feel free to ask any =
questions that come to mind. I'm looking to add the dependency and at l=
east one or two features in during the Kraken development cycle. In the=
 future, my plan is to extend libstoragemgmt to support extracting SMAR=
T data from drives, and expose that data through Ceph in some useful wa=
y.

Joe Handzik
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
