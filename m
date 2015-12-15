From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Tue, 15 Dec 2015 18:31:12 -0500 (EST)
Message-ID: <444466180.39100292.1450222272774.JavaMail.zimbra@redhat.com>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com> <20151215142304.GI31644@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx6-phx2.redhat.com ([209.132.183.39]:40241 "EHLO
	mx6-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751954AbbLOXbP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Dec 2015 18:31:15 -0500
In-Reply-To: <20151215142304.GI31644@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Thanks for this detailed response.

----- Original Message -----
> From: "Lars Marowsky-Bree" <lmb@suse.com>
> To: "Ceph Development" <ceph-devel@vger.kernel.org>
> Sent: Tuesday, December 15, 2015 9:23:04 AM
> Subject: Re: Improving Data-At-Rest encryption in Ceph

>=20
> It's not yet perfect, but I think the approach is superior to being
> implemented in Ceph natively. If there's any encryption that should b=
e
> implemented in Ceph, I believe it'd be the on-the-wire encryption to
> protect against evasedroppers.

++

>=20
> Other scenarios would require client-side encryption.

++

>=20
> > Cryptographic keys are stored on filesystem of storage node that ho=
sts
> > OSDs. Changing them require redeploying the OSDs.
>=20
> This is solvable by storing the key on an external key server.

++

>=20
> Changing the key is only necessary if the key has been exposed. And w=
ith
> dm-crypt, that's still possible - it's not the actual encryption key
> that's stored, but the secret that is needed to unlock it, and that c=
an
> be re-encrypted quite fast. (In theory; it's not implemented yet for
> the Ceph OSDs.)
>=20
>=20
> > Data incoming from Ceph clients would be encrypted by primary OSD. =
It
> > would replicate ciphertext to non-primary members of an acting set.
>=20
> This still exposes data in coredumps or on swap on the primary OSD, a=
nd
> metadata on the secondaries.
>=20
>=20
> Regards,
>     Lars
>=20
> --
> Architect Storage/HA
> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham No=
rton, HRB
> 21284 (AG N=C3=BCrnberg)
> "Experience is the name everyone gives to their mistakes." -- Oscar W=
ilde
>=20


--=20
--=20
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
