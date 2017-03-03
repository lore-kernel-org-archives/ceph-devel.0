From: "Wang, Zhiye" <Zhiye.Wang@Arcserve.com>
Subject: RE: Document about ceph object class APIs
Date: Fri, 3 Mar 2017 04:36:57 +0000
Message-ID: <CY4PR10MB1591EAE795A3091A2A4597D3E42B0@CY4PR10MB1591.namprd10.prod.outlook.com>
References: <CY4PR10MB159188A69CC453D4D1337CEBE4280@CY4PR10MB1591.namprd10.prod.outlook.com>
 <alpine.DEB.2.11.1703021523380.651@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-sn1nam02on0110.outbound.protection.outlook.com ([104.47.36.110]:44960
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751083AbdCCEh1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 2 Mar 2017 23:37:27 -0500
In-Reply-To: <alpine.DEB.2.11.1703021523380.651@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thank you Sage.

Yes, I am looking at the example code. " cls_register_cxx_method" seems pre=
tty clear. Especially, there is a good blog (http://ceph.com/rados/dynamic-=
object-interfaces-with-lua/) which explains it well.

I am interested in function "cls_register_cxx_filter". What is exactly the =
function, and what is a PGLS filter? I will look into more code, but I will=
 appreciate if you can give it an introduction.

Actually, I am looking for something like this: (data comes from CephFS), b=
efore OSD writes file data to underlying storage, my filter code get a chan=
ce to modify the data content, and then write to the current object in curr=
ent pool, or write to another object in another pool.
I guess this somehow can be achieved using  "cls_register_cxx_method" relat=
ed methods, but I don't want to change anything on client side (because it'=
s difficult to modify/incorporate/distribute modify code to all clients).

Is "cls_register_cxx_filter" what I am looking for?


Thanks
Mike


-----Original Message-----
From: Sage Weil [mailto:sage@newdream.net]=20
Sent: Thursday, March 2, 2017 11:28 PM
To: Wang, Zhiye <Zhiye.Wang@Arcserve.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: Document about ceph object class APIs

On Thu, 2 Mar 2017, Wang, Zhiye wrote:
> Dear all,
>=20
> Where can I find document about how to extend ceph?
>=20
> The only doc I can see is here:
> http://docs.ceph.com/docs/master/architecture/#extending-ceph
>=20
> And some examples in https://github.com/ceph/ceph/tree/master/src/cls
>
> Where can I get document for those APIs? And are those APIs kept=20
> stable from release to release?

The example classes are the best documentation currently.  The APIs are qui=
te stable, although in principle they could change.  The class plugins need=
 to be compiled against a specific build of ceph anyway, so you would disco=
ver any future change at build time.  The storage calls (reads and
writes) roughly correspond to the RADOS operations defined in include/rados=
.h (they map to the operations interpreted by do_osd_ops() in PrimaryLogPG.=
cc), and those rados operations maintain compatibility across many Ceph rel=
eases as they are normally originating from clients connecting to the syste=
m that could be running other versions.

Hope that helps!
sage
