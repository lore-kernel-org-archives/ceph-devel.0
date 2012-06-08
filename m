From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: Ceph/OpenStack integration on Ubuntu precise: horribly broken,
 or am I doing something wrong?
Date: Fri, 08 Jun 2012 08:48:28 -0700
Message-ID: <4FD21ECC.7040906@inktank.com>
References: <CAPUexz846keC+6KvFeethXV4xzpke3n_YKU0_oh-YfTCVR1ozw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57681 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab2FHPsa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 11:48:30 -0400
Received: by obbtb18 with SMTP id tb18so2558084obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 08 Jun 2012 08:48:30 -0700 (PDT)
In-Reply-To: <CAPUexz846keC+6KvFeethXV4xzpke3n_YKU0_oh-YfTCVR1ozw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Florian Haas <florian@hastexo.com>
Cc: ceph-devel@vger.kernel.org, Openstack <openstack@lists.launchpad.net>

Hi Florian,

There's an Ubuntu bug already:

https://bugs.launchpad.net/ubuntu/+source/ceph/+bug/981130

librgw was not complete, and wasn't actually used by radosgw, so it was
dropped. The Ubuntu package just needs to be updated to remove the
dependency and rgw.py, like upstream did.

Josh

On 06/08/2012 08:24 AM, Florian Haas wrote:
> Hi everyone,
>
> apologies for the cross-post, and not sure if this is new information=
=2E
> I did do a cursory check of both list archives and didn't find
> anything pertinent, so here goes. Feel free to point me to an existin=
g
> thread if I'm merely regurgitating something that's already known.
>
> Either I'm doing something terribly wrong, or the current state of
> OpenStack/Ceph integration in Ubuntu precise is somewhat suboptimal.
> At least as far as sticking to packages available in Ubuntu repos is
> concerned.
>
> Steps to reproduce:
>
> 1. On an installation using 12.04 with current updates, create a RADO=
S pool.
> 2. Configure glance to use "rbd" as its backend storage.
> 3. Attempt to upload an image.
>
> glance add name=3D"Ubuntu 12.04 cloudimg amd64" is_public=3Dtrue
> container_format=3Dovf disk_format=3Dqcow2<
> precise-server-cloudimg-amd64-disk1.img
> Uploading image 'Ubuntu 12.04 cloudimg amd64'
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D[
> 92%]         222.109521M/s, ETA  0h  0m  0sFailed to add image. Got
> error:
> Data supplied was not valid.
> Details: 400 Bad Request
>
> The server could not comply with the request since it is either
> malformed or otherwise incorrect.
>
>   Error uploading image: (NameError): global name 'rados' is not defi=
ned
>
> Digging around in glance/store/rbd.py yields this:
>
> try:
>      import rados
>      import rbd
> except ImportError:
>      pass
>
> I will go so far as say the error handling here could be improved --
> however, the Swift store implementation seems to do the same.
>
> Now, in Ubuntu rados.py and rbd.py ship in the python-ceph package,
> which is available in universe, but has an unresolvable dependency on
> librgw1. librgw1 apparently had been in Ubuntu for quite a while, but
> was dropped just before the Essex release:
>
> https://launchpad.net/ubuntu/precise/amd64/radosgw
>
> ... and if I read
> http://changelogs.ubuntu.com/changelogs/pool/main/c/ceph/ceph_0.41-1u=
buntu2/changelog
> correctly, then the rationale for it was to "drop radosgw since
> libfcgi is not in main and the code may not be suitable for LTS." (I
> wonder why this wasn't factored out into a separate package then, as
> was apparently the case for ceph-mds).
>
> Does this really mean that radosgw functionality was dropped from
> Ubuntu because it wasn't considered ready for main, and now it
> completely breaks a package in universe that's essential for
> Ceph/OpenStack integration? AFAICT the only thing that would be
> unaffected by this would be nova-volume (now cinder) which rather tha=
n
> using the Ceph Python bindings just calls out to the rados and rbd
> binaries. But both the glance RBD store and the RADOS Swift and S3
> frontends (via radosgw) would be affected.
>
> This can of course all be fixed by using "upstream" packages from the
> Ceph guys (thanks to S=C3=A9bastien Han for pointing that out to me).
>
> Anyone able to confirm or refute these findings? Should there be an
> Ubuntu bug for this? If so, against what package?
>
> Cheers,
> Florian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
