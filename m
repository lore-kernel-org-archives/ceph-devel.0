From: Greg Farnum <greg@inktank.com>
Subject: Re: rbd locking and handling broken clients
Date: Wed, 13 Jun 2012 16:41:30 -0700
Message-ID: <7BD677C5759B4061987311B2526E81D3@inktank.com>
References: <CAPYLRzhWkma7rrR=ATQTFmq_pwizeJ+SDi3efMEU9gTYPqAY3g@mail.gmail.com>
 <4FD8FA13.6070006@hastexo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:55039 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab2FNANQ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Jun 2012 20:13:16 -0400
Received: by dady13 with SMTP id y13so1754988dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 13 Jun 2012 17:13:15 -0700 (PDT)
In-Reply-To: <4FD8FA13.6070006@hastexo.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org, mandell@pistoncloud.com, Tommi Virtanen <tv@inktank.com>

On Wednesday, June 13, 2012 at 1:37 PM, Florian Haas wrote:
> Greg,
> =20
> My understanding of Ceph code internals is far too limited to comment=
 on
> your specific points, but allow me to ask a naive question.
> =20
> Couldn't you be stealing a lot of ideas from SCSI-3 Persistent
> Reservations? If you had server-side (OSD) persistence of information=
 of
> the "this device is in use by X" type (where anything other than X wo=
uld
> get an I/O error when attempting to access data), and you had a manua=
l,
> authenticated override akin to SCSI PR preemption, plus key
> registration/exchange for that authentication, then you would at leas=
t
> have to have the combination of a misbehaving OSD plus a malicious
> client for data corruption. A non-malicious but just broken client
> probably won't do.
> =20
> Clearly I may be totally misguided, as Ceph is fundamentally
> decentralized and SCSI isn't, but if PR-ish behavior comes even close=
 to
> what you're looking for, grabbing those ideas would look better to me
> than designing your own wheel.

Yeah, the problem here is exactly that Ceph (and RBD) are fundamentally=
 decentralized. :) I'm not familiar with the SCSI PR mechanism either, =
but it looks to me like it deals in entirely local information =E2=80=94=
 the equivalent with RBD would require performing a locking operation o=
n every object in the RBD image before you accessed it. We could do tha=
t, but then opening an image would take time linear in its size=E2=80=A6=
 :(


On Wednesday, June 13, 2012 at 4:14 PM, Tommi Virtanen wrote:
> On Wed, Jun 13, 2012 at 10:40 AM, Gregory Farnum <greg@inktank.com (m=
ailto:greg@inktank.com)> wrote:
> > 2) Client fencing. See http://tracker.newdream.net/issues/2531. The=
re
> > is an existing "blacklist" functionality in the OSDs/OSDMap, where =
you
> > can specify an "entity_addr_t" (consisting of an IP, a port, and a
> > nonce =E2=80=94 so essentially unique per-process) which is not all=
owed to
> > communicate with the cluster any longer. The problem with this is t=
hat
> =20
> Does that work even after a TCP connection close & re-establish, wher=
e
> the client now has a new source port address? (Perhaps the port is 0
> for clients?)

Precisely =E2=80=94 client ports are 0 since they never accept incoming=
 connections.



> You know, I'd be really happy if this could be achieved by means of
> removing cephx keys.

Unfortunately, that wouldn't really solve the problem without dramatica=
lly decreasing the rotation interval for cluster access keys which ceph=
x shares. Alternative (entirely theoretical) security schemes might, bu=
t they're well behind what's feasible for us to work on any time soon..=
=2E



--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
