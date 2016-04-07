From: Lars Marowsky-Bree <lmb@suse.com>
Subject: Re: ceph-disk improvements
Date: Thu, 7 Apr 2016 12:51:29 +0200
Message-ID: <20160407105129.GG26235@suse.de>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
 <2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
 <20160407092627.GE26235@suse.de>
 <CA+HUO7+7v5NjiP-3+h-OMkez3L8MSRoo27+=HCdEc20ntW9=gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33910 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751780AbcDGKva (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 7 Apr 2016 06:51:30 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2E800ABC7
	for <ceph-devel@vger.kernel.org>; Thu,  7 Apr 2016 10:51:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CA+HUO7+7v5NjiP-3+h-OMkez3L8MSRoo27+=HCdEc20ntW9=gw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 2016-04-07T12:31:21, Sebastien Han <shan@redhat.com> wrote:

> One thing I'd like to see and I know we discussed that with Lo=EFc a
> while ago is ceph-disk being idempotent when it comes to the device
> preparation.
> Running "ceph-disk prepare" against a device should result in an exit
> 0 if the disk already has an OSD prepared on it (unless we do
> something like --force, which will then zap the disk).
> I had to implement this logic in ceph-ansible (and the guys from
> chef/puppet probably did the same), so now it's done but i'll be happ=
y
> to leave ceph-disk doing it :).
>=20
> Thoughts?

Basically, +1.

Owen (who works on salt-ceph) has a love/love relationship with the wor=
d
"idempotent" as well.

Note that it should probably only exit=3D0 if the OSD matches the curre=
nt
fsid?


Regards,
    Lars

--=20
Architect SDS, Distinguished Engineer
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton,=
 HRB 21284 (AG N=FCrnberg)
"Experience is the name everyone gives to their mistakes." -- Oscar Wil=
de

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
