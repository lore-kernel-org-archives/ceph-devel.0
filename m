From: Gregory Meno <gmeno@redhat.com>
Subject: Re: Advice for implementation of LED behavior in Ceph ecosystem
Date: Tue, 21 Apr 2015 10:46:32 -0400
Message-ID: <5C228677-D454-44AA-BD3D-02C6920673A1@redhat.com>
References: <2C438B34CAC8264398F5C7AF7411910A6341F7BD@G4W3206.americas.hpqcorp.net> <61596DF5-5893-4F29-B3A3-DC2CEBDCD119@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58371 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937AbbDUOqd convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Apr 2015 10:46:33 -0400
In-Reply-To: <61596DF5-5893-4F29-B3A3-DC2CEBDCD119@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Handzik, Joe" <joseph.t.handzik@hp.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, ceph-calamari@lists.ceph.com


On Apr 21, 2015, at 9:58 AM, Gregory Meno <gmeno@redhat.com> wrote:

cross posting to ceph-calamari@lists.ceph.com in case we have interest =
there too.

> On Apr 1, 2015, at 2:52 PM, Handzik, Joe <joseph.t.handzik@hp.com> wr=
ote:
>=20
> Hey all,
> =20
> Gregory Meno=E2=80=99s pull request in Calamari (https://github.com/c=
eph/calamari/pull/267) is motivating some discussion about a feature (o=
r set of features) that I=E2=80=99m about to start working on.
> =20
> My goal is to allow users to enable the identify and fault LEDs (faul=
t is negotiable) via the Calamari GUI. I=E2=80=99ve had some discussion=
 with Dan Mick and Gregory Meno about the concept, and they both see th=
e value in it. The decision that needs to be made is=E2=80=A6where shou=
ld this functionality exist? There are a couple of obvious choices, aft=
er Gregory=E2=80=99s SMART patch:
> =20
> 1.       Stick everything in Calamari via Salt calls similar to what =
Gregory is showing. I have concerns about this, I think I=E2=80=99d sti=
ll need extra information from the OSDs themselves. I might need to imp=
lement the first half of option #2 anyway.
> 2.       Scatter it across the codebases (would probably require chan=
ges in Ceph, Calamari, and Calamari-clients). Expose the storage target=
 data via the OSDs, and move that information upward via the RESTful AP=
I. Then, expose another RESTful API behavior that allows a user to chan=
ge the LED state. Implementing as much as possible in the Ceph codebase=
 itself has an added benefit (as far as I see it, at least) if someone =
ever decides that the fault LED should be toggled on based on the state=
 of the OSD or backing storage device. It should be easier for Ceph to =
hook into that kind of functionality if Calamari doesn=E2=80=99t need t=
o be involved.
> =20
> Dan mentioned something I thought about too=E2=80=A6not EVERY OSD=E2=80=
=99s backing storage is going to be able to use this (Kinetic drives, N=
VDIMMs, M.2, etc etc), I=E2=80=99d need to implement some way to filter=
 devices and communicate via the Calamari GUI that the device doesn=E2=80=
=99t have an LED to toggle or doesn=E2=80=99t understand SCSI Enclosure=
 Services (I=E2=80=99m targeting industry standard HBAs first, and I=E2=
=80=99ll deal with RAID controllers like Smart Array later).
> =20
> I=E2=80=99m trying to get this out there early so anyone with particu=
larly strong implementation opinions can give feedback. Any advice woul=
d be appreciated! I=E2=80=99m still new to the Ceph source base, and pr=
obably understand Calamari and Calamari-clients better than Ceph proper=
 at the moment.
> =20
> Thanks,
> =20
> Joe


Joe,

I=E2=80=99ve been thinking about how to expose this new hardware contex=
t in the calamari API.

I propose we add an end point like /api/v2/hardware and each entry ther=
e is something that relates to ceph in that we know what ceph subsystem=
 is affected by the hardware entry being in a particular state e.g. OK,=
 WARN, FAIL. This state is a result of the checks like SMART.

This /hardware endpoint would be a collection of all hardware that we c=
an have checks for or the OSD advertises that it rely on. This endpoint=
 is good for an overview for someone who wants a current status of hard=
ware independent of cluster context.

Naturally I expect this info to be present in context within /api/v2/cl=
uster/FSID/osd/N and other endpoints describing Ceph primitives. That h=
elps UIs have better context without having to do the correlation in th=
e client.

It seems like it would be helpful to have the OSDs report their underly=
ing data storage target.

How would you expose the backing storage for the OSD? Is it a command l=
ine query, configuration,  part of the OSD map, or something else?

regards,
Gregory

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
