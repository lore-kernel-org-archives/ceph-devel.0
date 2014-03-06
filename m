From: David McBride <dwm37@cam.ac.uk>
Subject: Re: Ceph Ansible Repo
Date: Thu, 06 Mar 2014 12:07:46 +0000
Message-ID: <53186512.6080405@cam.ac.uk>
References: <FA727FEF-D416-4D0E-810F-72C72E184DC1@enovance.com> <CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-40.csi.cam.ac.uk ([131.111.8.140]:40393 "EHLO
	ppsw-40.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbaCFMY1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Mar 2014 07:24:27 -0500
In-Reply-To: <CAJH6TXiWC0yRWSgU8B0=-mNDXc0tdQ62O3=K2t+Dq5T3emSCOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Sebastien Han <sebastien.han@enovance.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Weil Sage <sage@inktank.com>, Patrick McGarry <patrick@inktank.com>

On 06/03/14 09:36, Gandalf Corvotempesta wrote:
> Hi to all.
> Some question about ansible repo.
>=20
> 1. is possible to specify multiple journal devices for each OSD node?
> We have OSD with 12 spinning disks and 2 SSD as journal. We would lik=
e
> to use SSD1 for OSD1 to 6 and SSD2 for OSD 7 to 12. Is this possible =
?

One option I'm currently testing is whereby the two SSDs in a node are
stitched together into a Linux software-RAID striped array, and then
allocate the journal partitions on the resulting /dev/md device.

This is currently working well, save that the default udev rules for
mapping OSDs explicitly skip over md journal devices; removing the
"|md*" term in the relevant ruleset resolves this problem.  (This is in
my workqueue to report as a bug.)

This causes the IO load to be nicely balanced across the two SSDs,
removing any hot spots, at the cost of enlarging the failure domain of
the loss of an SSD from half a node to a full node.

One potential optimization which I haven't yet investigated is to see
whether moving the XFS filesystem journal, in addition to the OSd
journal, might result in an improvement in performance =E2=80=94 in par=
ticular
on nodes which are equipped with slower 'green' drives.

This is not something that ceph-deploy currently makes easy; if, as I
expect, I find myself re-implementing the ceph-deploy functions in term=
s
of Ansible rules =E2=80=94 perhaps using LVM rather than GPT partitions=
? =E2=80=94 I may
then be able to try some experiments.

Kind regards,
David
--=20
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Computing Service
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
