From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Re: v0.48.2 argonaut update released
Date: Mon, 01 Oct 2012 12:06:37 +0200
Message-ID: <50696B2D.7020301@filoo.de>
References: <alpine.DEB.2.00.1209200948180.8980@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-7.de-punkt.de ([93.190.64.37]:42400 "EHLO
	mail-7.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457Ab2JAKGj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Oct 2012 06:06:39 -0400
In-Reply-To: <alpine.DEB.2.00.1209200948180.8980@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi *,

with reference to the below mentioned

"objecter: misc fixes for op reordering"


I assumed it could have something to do with slow requests not being=20
solved for too long. I just not saw it anymore in 0.51 in our=20
testing-evironment.
But today we took one of our nodes into maintenance, and I see many of:

--- 8-<---

2012-10-01 11:58:46.766999 osd.10 [WRN] 38 slow requests, 1 included=20
below; oldest blocked for > 1189.312605 secs
2012-10-01 11:58:46.767013 osd.10 [WRN] slow request 240.183032 seconds=
=20
old, received at 2012-10-01 11:54:46.583860:=20
osd_op(client.110046.0:2143984 rb.0.1adf5.6733efe2.00000000061a [write=20
208384~4096] 6.f511e801) v4 currently delayed
2

--- 8-< ---

which is bad, as I assume, that some of the VM's are now stalled.=20
Anybody else experienced such things?

Thnx n regards,

Oliver.

On 09/20/2012 06:52 PM, Sage Weil wrote:
> Hi everyone,
>
> Another update to the stable "argonaut" series has been released.  Th=
is
> fixes a few important bugs in rbd and radosgw and includes a series o=
f
> changes to upstart and deployment related scripts that will allow the
> upcoming 'ceph-deploy' tool to work with the argonaut release.
>
> Upgrading:
>
>   * The default search path for keyring files now includes
>     /etc/ceph/ceph.$name.keyring. If such files are present on your
>     cluster, be aware that by default they may now be used.
>   * There are several changes to the upstart init files. These have n=
ot
>     been previously documented or recommended. Any existing users sho=
uld
>     review the changes before upgrading.
>   * The ceph-disk-prepare and ceph-disk-active scripts have been upda=
ted
>     significantly. These have not been previously documented or
>     recommended. Any existing users should review the changes before =
upgrading.
>
> Notable changes include:
>
>   * mkcephfs: fix keyring generation for mds, osd when default paths =
are
>     used
>   * radosgw: fix bug causing occasional corruption of per-bucket stat=
s
>   * radosgw: workaround to avoid previously corrupted stats from goin=
g
>     negative
>   * radosgw: fix bug in usage stats reporting on busy buckets
>   * radosgw: fix Content-Range: header for objects bigger than 2 GB.
>   * rbd: avoid leaving watch acting when command line tool errors out
>     (avoids 30s delay on subsequent operations)
>   * rbd: friendlier use of pool/image options for import (old calling
>     convention still works)
>   * librbd: fix rare snapshot creation race (could lose a snap when
>     creation is concurrent)
>   * librbd: fix discard handling when spanning holes
>   * librbd: fix memory leak on discard when caching is enabled
>   * objecter: misc fixes for op reordering
>   * objecter: fix for rare startup-time deadlock waiting for osdmap
>   * ceph: fix usage
>   * mon: reduce log noise about check_sub
>   * ceph-disk-activate: misc fixes, improvements
>   * ceph-disk-prepare: partition and format osd disks automatically
>   * upstart: start everyone on a reboot
>   * upstart: always update the osd crush location on start if specifi=
ed in
>     the config
>   * config: add /etc/ceph/ceph.$name.keyring to default keyring searc=
h path
>   * ceph.spec: don't package crush headers
>
> You can get this release from the usual locations:
>
>   * Git at git://github.com/ceph/ceph.git
>   * Tarball at http://ceph.newdream.net/download/ceph-0.48.2.tar.gz
>   * For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/mas=
ter/install/debian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
