From: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Subject: RE: rados read ordering
Date: Wed, 10 Dec 2014 05:08:00 +0000
Message-ID: <06E7D85B3BA36C4DB207FEDE871C53489680A2@SHSMSX101.ccr.corp.intel.com>
References: <alpine.DEB.2.00.1412080855300.5263@cobra.newdream.net>,
 <CABBk=J9iA=iwAqOBrQ3zDpUvEDH2JA17+WJLRU2gLz_fFdF55w@mail.gmail.com>
 <88C3E003BB3649489ED4ECA6C80410476BCEF6@ORSMSX102.amr.corp.intel.com>
 <alpine.DEB.2.00.1412091640140.22847@cobra.newdream.net>,<06E7D85B3BA36C4DB207FEDE871C5348968009@SHSMSX101.ccr.corp.intel.com>
 <88C3E003BB3649489ED4ECA6C80410476BD543@ORSMSX102.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4810 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703AbaLJFIG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Dec 2014 00:08:06 -0500
In-Reply-To: <88C3E003BB3649489ED4ECA6C80410476BD543@ORSMSX102.amr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Cook, Nigel" <nigel.cook@intel.com>
Cc: Josh Durgin <jdurgin@redhat.com>, Yehuda Sadeh <yehuda@redhat.com>, Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>, Jason Dillaman <dillaman@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

In the 2nd scenario, what if the write by client B fails for some reaso=
n? Do we also fail the following read by A or B? Or return the read wit=
h the client A write content? If we return the read with client A write=
 content, client A still needs to communicate with B to know which vers=
ion of the content it reads. So my point is, from the client's perspect=
ive, it shouldn't expect to read the content which hasn't been successf=
ully written to the storage. Thus it's ok for ceph to not support order=
ing the reads/writes from multiple clients.

=46rom: Cook, Nigel=20
Sent: Wednesday, December 10, 2014 12:37 PM
To: Wang, Zhiqiang
Cc: Josh Durgin; Yehuda Sadeh; Samuel Just; Sage Weil; Jason Dillaman; =
ceph-devel
Subject: RE: rados read ordering

On thinking of the following use cases and the rbd client..
The ordering scenario is that with client a and b, assuming a and b are=
 messaging between them, then a read posted by client b after client a =
has successfully written will always read the client a content. Similar=
ly, an ordered write by client a and then by client b followed by a rea=
d by a or b will return the client b write content in all cases.
Regards,
Nigel Cook +1 720 319 7508
Sent from a mobile device.
Please excuse both my brevity and=A0sp3lling
On Dec 9, 2014 5:10 PM, "Wang, Zhiqiang" <zhiqiang.wang@intel.com> wrot=
e:
=46or multiple clients accessing the same volume, same object, I guess =
the clients need to do some synchronization between them to guarantee w=
hat it reads is what it wrote. That is to say, if two clients, say A an=
d B, A is doing write, B is doing read. If B wants to read what A write=
s, it needs to know A has completed the write before issuing the read. =
If A hasn't completed the write yet, it could be possible that the writ=
e fails, so you can't expect B reads what A writes. I think this makes =
sense from the client/application perspective.

-----Original Message-----
=46rom: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.=
kernel.org] On Behalf Of Sage Weil
Sent: Wednesday, December 10, 2014 8:43 AM
To: Cook, Nigel
Cc: Yehuda Sadeh; Josh Durgin; Samuel Just; Wang, Zhiqiang; Jason Dilla=
man; ceph-devel
Subject: Re: rados read ordering

On Wed, 10 Dec 2014, Cook, Nigel wrote:
> Folks
>=20
> I'm wondering if this is related to the question I posed a few days=20
> ago..
>=20
>=A0 Can CEPH support 2 clients simultaneously accessing a single volum=
e -=20
> for example a database cluster - and honor read and write order of=20
> blocks across the multiple clients?
>=20
> Can you comment?

I don't think so.=A0 This (non)change is about a single client submitti=
ng two reads to a single object (say, different blocks in the same disk=
) and whether the OSD is allowed to respond out of order (say, because =
some blocks are in cache and some aren't).

In the shared volume case, it is generally not important what happens w=
ith requests that are submitted in parallel.. they can take different a=
mounts of time on the wire and which happens first (i.e., which arrives=
 at the OSD first) depends on happenstance.=A0 What does matter is that=
 any read that happens after a complete write reflects that read, which=
 is why the concern is around caching.

sage


>=20
> Regards,
> Nigel Cook +1 720 319 7508
>=20
> Sent from a mobile device.
> Please excuse both my brevity and sp3lling
>=20
> On Dec 8, 2014 10:12 AM, Yehuda Sadeh <yehuda@redhat.com> wrote:
> On Mon, Dec 8, 2014 at 9:03 AM, Sage Weil <sweil@redhat.com> wrote:
> > The current RADOS behavior is that reads (on any given object) are =
always
> > processed in the order they are submitted by the client.=A0 This ca=
uses a
> > few headaches for the cache tiering that it would be nice to avoid.=
=A0 It
> > also occurs to me that there are likely cases where we could go a l=
ot
> > faster by not strictly ordering things.=A0 For example, a stat can =
respond
> > more quickly than a large read, and some reads may hit cache while =
others
> > go to disk.=A0 This doesn't happen currently because of the (lame) =
way we do
> > reads synchronously, but hope that can change too.
> >
> > I propose we drop this semantic.=A0 If a client wants reads to have=
 a strict
> > ordering, they can set the existing RWORDERED flag (which also orde=
rs them
> > with respect to writes).=A0 That's not the most general thing ever,=
 but I'm
> > not sure we care about callers who want reads ordered with respect =
to each
> > other but not writes.
> >
> > The real question is whether there are any users that want/need thi=
s
> > currently.=A0 I can't think of any offhand.=A0 In several places we=
 submit
> > multiple *writes* and expect them to be strictly ordered (e.g., we
> > set a completion on teh last write only).=A0 I don't think we do th=
is
> > anywhere for reads though...
> >
> > Josh, Yehuda, Jason--can you think of any in RBD or RGW that would =
depend
> > on this?
> >
>=20
> None that I can think of. For objects data, we already stripe it
> across multiple objects, and the underlying assumption is that we're
> going to get responses out of order so we make sure we commit
> in-order. Guards are used on the head object, and the read is
> synchronous there anyway. I can't think of any other place where we'd
> have an issue.
>=20
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
>=20
>=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at=A0 http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
