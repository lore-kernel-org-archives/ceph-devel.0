From: Sage Weil <sage@newdream.net>
Subject: Re: Introducing libstoragemgmt as a Ceph dependency
Date: Tue, 3 May 2016 14:15:22 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605031412580.26967@cpach.fuggernut.com>
References: <TU4PR84MB0032768F74C89DF30F93BE0BCC7A0@TU4PR84MB0032.NAMPRD84.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1167448298-1462299325=:26967"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38405 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933754AbcECSPO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2016 14:15:14 -0400
In-Reply-To: <TU4PR84MB0032768F74C89DF30F93BE0BCC7A0@TU4PR84MB0032.NAMPRD84.PROD.OUTLOOK.COM>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Handzik, Joseph" <joseph.t.handzik@hpe.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "tasleson@redhat.com" <tasleson@redhat.com>, Gris Ge <fge@redhat.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1167448298-1462299325=:26967
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi Joseph,

On Tue, 3 May 2016, Handzik, Joseph wrote:
> Hey ceph-devel,
> 
> Back around this time in 2015, I started asking questions about what the 
> Ceph community would expect around hardware integration with an 
> underlying storage system (my primary concern was blinking LEDs): 
> http://www.spinics.net/lists/ceph-devel/msg23404.html
> 
> I received some good feedback, which turned into this blueprint here: 
> http://tracker.ceph.com/projects/ceph/wiki/Calamariapihardwarestorage
> 
> That set me down a windy path of pulling device paths for underlying 
> devices via the OSD, pulling metadata attributes for OSDs into calamari, 
> and eventually over to libstoragemgmt (Github link: 
> https://github.com/libstorage/libstoragemgmt).
> 
> libstoragemgmt covers what I perceived to be the initial requirements 
> for an API to talk to underlying storage devices. It's vendor agnostic, 
> extensible, and provides C and python bindings. Over the last 6 months 
> or so, we've spent time in the libstoragemgmt source adding a set of 
> APIs that actually submit SCSI Enclosure Service commands via C and 
> python bindings. The first set of functionality introduced was commands 
> to enable and disable the IDENT and FAULT LEDs. These APIs sit alongside 
> the vendor-specific interfaces that libstoragemgmt already provided 
> (there's good support for Smart Array and MegaRAID, for example). We're 
> working on NVMe support too, though that may slip out of the upcoming 
> 1.3 release.
> 
> My involvement in libstoragemgmt, as mentioned earlier, was with the 
> purpose of integrating better hardware monitoring and management support 
> into Ceph. I did some work on my own in a fork that I created of 
> libstoragemgmt to integrate it into the Ceph cli that exists today (note 
> that the APIs in upstream libstoragemgmt have changed, but the code 
> would be conceptually similar): 
> https://github.com/joehandzik/ceph/tree/wip-hw-mgmt-cli

Blinky lights, yay!
 
> John Spray has already mentioned to me that I should convert my message 
> interface to use "tell" commands instead, but aside from that I think 
> this is roughly what a final pull would look like (with test framework 
> code). I have tested this on HPE hardware, so the concept does work. All 
> of this functionality will require an opt-in from the user via a 
> ceph.conf value (to tell Ceph what storage device they're using). If the 
> value is never set, the user will  not be able to use these APIs.
> 
> I'm giving all the above for context, but what I really need to know 
> from the ceph-devel community is: Does anyone have any concerns with 
> adding libstoragemgmt as a Ceph dependency? It would only work for the 
> standard Linux flavors and distros (Rhel and Centos, OpenSuse and SLES, 
> Debian and Ubuntu). The features I'm adding would be no-ops or disabled 
> for other distros unless someone in the community finds a way to 
> distribute libstoragemgmt for their operating environment or finds an 
> adequate replacement for the functionality. It's also worth noting that 
> I'm completely dependent on the previously mentioned 1.3 release of 
> libstoragemgmt, which is why I've waited on this for a while (the 
> blueprint was initially intended for Jewel).

The current distros upstream currently buidls on are:

 centos 7
 ubuntu 16.04
 ubuntu 14.04
 debian 8 (jessie)

Other packages are all down downstream (e.g., opensuse and sles).

Anyway, is libstoragemgt available for the above?

We will presuambly want the build system to conditionally compile it out 
with a flag in case it is not present or available, so we can also do that 
as needed (e.g., on 14.04, which probably won't have it).

sage
--8323329-1167448298-1462299325=:26967--
