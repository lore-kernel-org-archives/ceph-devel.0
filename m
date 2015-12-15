From: Sage Weil <sage@newdream.net>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Tue, 15 Dec 2015 06:59:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512150651250.25269@cobra.newdream.net>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com> <20151215142304.GI31644@suse.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-669165477-1450191326=:25269"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42514 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933457AbbLOO7R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Dec 2015 09:59:17 -0500
In-Reply-To: <20151215142304.GI31644@suse.de>
Content-ID: <alpine.DEB.2.00.1512150655370.25269@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lars Marowsky-Bree <lmb@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-669165477-1450191326=:25269
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-ID: <alpine.DEB.2.00.1512150655371.25269@cobra.newdream.net>
Content-Transfer-Encoding: quoted-printable

I agree with Lars's concerns: the main problems with the current dm-crypt=
=20
approach are that there isn't any key management integration yet and the=20
root volume and swap aren't encrypted. Those are easy to solve (and I'm=20
hoping we'll be able to address them in time for Jewel).

On the other hand, implementing encryption within RADOS will be complex,=20
and I don't see what the benefits are over whole-disk encryption.  Can=20
someone summarize what per-pool encryption keys and the ability to rotate=
=20
keys gives us?  If the threat is an attacker who is on the storage networ=
k=20
and has compromised an OSD the game is pretty much up...

At a high level, I think almost anything beyond at-rest encryption (that=20
is aimed at throwing out disks or physically walking a server out of the=20
data center) turns into a key management and threat mitigation design=20
nightmare (with few, if any, compelling solutions) until you give up and=20
have clients encrypt their data and don't trust the cluster with the keys=
=20
at all...

sage


On Tue, 15 Dec 2015, Lars Marowsky-Bree wrote:
> On 2015-12-14T14:17:08, Radoslaw Zarzynski <rzarzynski@mirantis.com> wr=
ote:
>=20
> Hi all,
>=20
> great to see this revived.
>=20
> However, I have come to see some concerns with handling the encryption
> within Ceph itself.
>=20
> The key part to any such approach is formulating the threat scenario.
> For the use cases we have seen, the data-at-rest encryption matters so
> they can confidently throw away disks without leaking data. It's not
> meant as a defense against an online attacker. There usually is no
> problem with "a few" disks being privileged, or one or two nodes that
> need an admin intervention for booting (to enter some master encryption
> key somehow, somewhere).
>=20
> However, that requires *all* data on the OSDs to be encrypted.
>=20
> Crucially, that includes not just the file system meta data (so not jus=
t
> the data), but also the root and especially the swap partition. Those
> potentially include swapped out data, coredumps, logs, etc.
>=20
> (As an optional feature, it'd be cool if an OSD could be moved to a
> different chassis and continue operating there, to speed up recovery.
> Another optional feature would be to eventually be able, for those
> customers that trust them ;-), supply the key to the on-disk encryption
> (OPAL et al).)
>=20
> The proposal that Joshua posted a while ago essentially remained based
> on dm-crypt, but put in simple hooks to retrieve the keys from some
> "secured" server via sftp/ftps instead of loading them from the root fs=
.
> Similar to deo, that ties the key to being on the network and knowing
> the OSD UUID.
>=20
> This would then also be somewhat easily extensible to utilize the same
> key management server via initrd/dracut.
>=20
> Yes, this means that each OSD disk is separately encrypted, but given
> modern CPUs, this is less of a problem. It does have the benefit of
> being completely transparent to Ceph, and actually covering the whole
> node.
>=20
> Of course, one of the key issues is always the key server.
> Putting/retrieving/deleting keys is reasonably simple, but the question
> of how to ensure HA for it is a bit tricky. But doable; people have bee=
n
> building HA ftp/http servers for a while ;-) Also, a single key server
> setup could theoretically serve multiple Ceph clusters.
>=20
> It's not yet perfect, but I think the approach is superior to being
> implemented in Ceph natively. If there's any encryption that should be
> implemented in Ceph, I believe it'd be the on-the-wire encryption to
> protect against evasedroppers.
>=20
> Other scenarios would require client-side encryption.
>=20
> > Current data at rest encryption is achieved through dm-crypt placed
> > under OSD?s filestore. This solution is a generic one and cannot
> > leverage Ceph-specific characteristics. The best example is that
> > encryption is done multiple times - one time for each replica. Anothe=
r
> > issue is lack of granularity - either OSD encrypts nothing, or OSD
> > encrypts everything (with dm-crypt on).
>=20
> True. But for the threat scenario, a holistic approach to encryption
> seems actually required.
>=20
> > Cryptographic keys are stored on filesystem of storage node that host=
s
> > OSDs. Changing them require redeploying the OSDs.
>=20
> This is solvable by storing the key on an external key server.
>=20
> Changing the key is only necessary if the key has been exposed. And wit=
h
> dm-crypt, that's still possible - it's not the actual encryption key
> that's stored, but the secret that is needed to unlock it, and that can
> be re-encrypted quite fast. (In theory; it's not implemented yet for
> the Ceph OSDs.)
>=20
>=20
> > Data incoming from Ceph clients would be encrypted by primary OSD. It
> > would replicate ciphertext to non-primary members of an acting set.
>=20
> This still exposes data in coredumps or on swap on the primary OSD, and
> metadata on the secondaries.
>=20
>=20
> Regards,
>     Lars
>=20
> --=20
> Architect Storage/HA
> SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard, Graham Norton,=
 HRB 21284 (AG N=FCrnberg)
> "Experience is the name everyone gives to their mistakes." -- Oscar Wil=
de
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-669165477-1450191326=:25269--
