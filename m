From: "Wang, Zhiye" <Zhiye.Wang@Arcserve.com>
Subject: RE: Document about ceph object class APIs
Date: Mon, 6 Mar 2017 09:03:08 +0000
Message-ID: <CY4PR10MB159138A6BB5D4EB2A311968EE42C0@CY4PR10MB1591.namprd10.prod.outlook.com>
References: <CY4PR10MB159188A69CC453D4D1337CEBE4280@CY4PR10MB1591.namprd10.prod.outlook.com>
 <alpine.DEB.2.11.1703021523380.651@piezo.novalocal>
 <CY4PR10MB1591EAE795A3091A2A4597D3E42B0@CY4PR10MB1591.namprd10.prod.outlook.com>
 <alpine.DEB.2.11.1703031446020.651@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-co1nam03on0124.outbound.protection.outlook.com ([104.47.40.124]:53120
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753186AbdCFKjM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 6 Mar 2017 05:39:12 -0500
In-Reply-To: <alpine.DEB.2.11.1703031446020.651@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,

You are correct.

I was trying to find certain IO plugin architecture so that I get a chance =
to insert my code/module to change read/write operations' behavior.

I'd suggest such kind of plugin architecture to ceph. It will make it easy =
to add new function to ceph.

A good example is MS Windows IO Manager, it's designed to give user chance =
to insert code/modules at every layers of IO path. It's helpful for enlargi=
ng its ecosystem.

Of course, it's much complicated for a distributed storage system.


Thanks
Zhiye


-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]=20
Sent: Friday, March 3, 2017 10:51 PM
To: Wang, Zhiye <Zhiye.Wang@Arcserve.com>
Cc: ceph-devel@vger.kernel.org
Subject: RE: Document about ceph object class APIs

On Fri, 3 Mar 2017, Wang, Zhiye wrote:
> Thank you Sage.
>=20
> Yes, I am looking at the example code. " cls_register_cxx_method"=20
> seems pretty clear. Especially, there is a good blog
> (http://ceph.com/rados/dynamic-object-interfaces-with-lua/) which=20
> explains it well.
>=20
> I am interested in function "cls_register_cxx_filter". What is exactly=20
> the function, and what is a PGLS filter? I will look into more code,=20
> but I will appreciate if you can give it an introduction.

The filter is for PGLS, which lists objects.  It lets you define a selectio=
n function so that onyl certain objects are included in the result.  It's u=
sed for cephfs repair when it is searching for unlinked objects/files (roug=
hly speaking).
=20
> Actually, I am looking for something like this: (data comes from=20
> CephFS), before OSD writes file data to underlying storage, my filter=20
> code get a chance to modify the data content, and then write to the=20
> current object in current pool, or write to another object in another=20
> pool. I guess this somehow can be achieved using=20
> "cls_register_cxx_method" related methods, but I don't want to change=20
> anything on client side (because it's difficult to=20
> modify/incorporate/distribute modify code to all clients).

Ah, this unfortunatey isn't possible with the cls mechanism.  The class met=
hods are intended to work like methods on objects (in teh OOP sense) in tha=
t they only operate on a single object and must operate in isolation withou=
t blocking.  (This lets us bury it into a complex request processing and re=
plication pipeline with transactional semantics.)  Also, since CephFS is is=
suing the requests, you'd have to change the client to issue a different ty=
pe of op if you wanted to do something other than write.

I'm guessing you're trying to do some sort of tiering or dedup here?  That =
won't be something that cls ops can do... it needs to be built into RADOS.

HTH!
sage

> Is "cls_register_cxx_filter" what I am looking for?
>=20
>=20
> Thanks
> Mike
>=20
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sage@newdream.net]
> Sent: Thursday, March 2, 2017 11:28 PM
> To: Wang, Zhiye <Zhiye.Wang@Arcserve.com>
> Cc: ceph-devel@vger.kernel.org
> Subject: Re: Document about ceph object class APIs
>=20
> On Thu, 2 Mar 2017, Wang, Zhiye wrote:
> > Dear all,
> >=20
> > Where can I find document about how to extend ceph?
> >=20
> > The only doc I can see is here:
> > http://docs.ceph.com/docs/master/architecture/#extending-ceph
> >=20
> > And some examples in=20
> > https://github.com/ceph/ceph/tree/master/src/cls
> >
> > Where can I get document for those APIs? And are those APIs kept=20
> > stable from release to release?
>=20
> The example classes are the best documentation currently.  The APIs=20
> are quite stable, although in principle they could change.  The class=20
> plugins need to be compiled against a specific build of ceph anyway,=20
> so you would discover any future change at build time.  The storage=20
> calls (reads and
> writes) roughly correspond to the RADOS operations defined in include/rad=
os.h (they map to the operations interpreted by do_osd_ops() in PrimaryLogP=
G.cc), and those rados operations maintain compatibility across many Ceph r=
eleases as they are normally originating from clients connecting to the sys=
tem that could be running other versions.
>=20
> Hope that helps!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=20
> in the body of a message to majordomo@vger.kernel.org More majordomo=20
> info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
