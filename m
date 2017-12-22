From: Lenz Grimmer <lgrimmer@suse.com>
Subject: Re: dashboard in mimic
Date: Sat, 23 Dec 2017 00:56:24 +0100
Message-ID: <398c92be-3f11-cfca-00b5-03fe429e65f8@suse.com>
References: <CALe9h7eOv-P35oJT5L2T+CmOe=VTw6V3yBHB0LUK_-ojyeKKCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="uDnjbLuvNLSsjQt8eBjXhIFWh1Pw7bUFN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756218AbdLVX4b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 22 Dec 2017 18:56:31 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B52C4AE57
        for <ceph-devel@vger.kernel.org>; Fri, 22 Dec 2017 23:56:30 +0000 (UTC)
In-Reply-To: <CALe9h7eOv-P35oJT5L2T+CmOe=VTw6V3yBHB0LUK_-ojyeKKCw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uDnjbLuvNLSsjQt8eBjXhIFWh1Pw7bUFN
Content-Type: multipart/mixed; boundary="rkpBAVbTCQkI2UscBgJWwtxht3NUUBXf7";
 protected-headers="v1"
From: Lenz Grimmer <lgrimmer@suse.com>
To: Ceph Development <ceph-devel@vger.kernel.org>
Message-ID: <398c92be-3f11-cfca-00b5-03fe429e65f8@suse.com>
Subject: Re: dashboard in mimic
References: <CALe9h7eOv-P35oJT5L2T+CmOe=VTw6V3yBHB0LUK_-ojyeKKCw@mail.gmail.com>
In-Reply-To: <CALe9h7eOv-P35oJT5L2T+CmOe=VTw6V3yBHB0LUK_-ojyeKKCw@mail.gmail.com>

--rkpBAVbTCQkI2UscBgJWwtxht3NUUBXf7
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi John,

On 12/20/2017 11:55 AM, John Spray wrote:

> There have been some discussions about making big additions to the=20
> dashboard module (the web gui that runs in ceph-mgr), so as a couple=20
> of people have suggested, let's have a mailing list thread about it!

Thanks a lot for kicking this off! Please find some comments inline, I'd
be glad to discuss this in more depth after the holiday break.

> This is a bit wordy so I've written it more like a document than an=20
> email, see below.  It's a very broad topic, so what I've written
> here is far from complete.  We're still at the point of discussion,
> there's no UI code being written so far for any of the stuff that I
> mention below.

For additional context, I think it makes sense to mention that
this topic was also discussed in the last CDM call:

https://youtu.be/YNfp_4S7mYE?t=3D28m37s

The collection of ideas that Sage mentioned during the call have been
noted down here:

http://pad.ceph.com/p/mimic-dashboard

Looking at that list, I think we've implemented several of that items in
openATTIC/DeepSea already (https://www.openattic.org/features.html) and
many of the other topics are on our TODO as well.

As Jan already mentioned during the call, a good first step for us could
be to contribute the Grafana dashboards that we developed and embed in
openATTIC. They are currently maintained in the DeepSea git (somewhat
hidden at
https://github.com/SUSE/DeepSea/tree/master/srv/salt/ceph/monitoring/graf=
ana/files),
but I think it would make sense to incorporate them upstream instead, or
maintain them as a separate project.

They have been developed to display data collected by the DigitalOcean
Ceph Exporter for Prometheus
(https://github.com/digitalocean/ceph_exporter). We also created a RGW
metrics exporter for the RGW dashboard parts:
https://github.com/SUSE/DeepSea/tree/master/srv/salt/ceph/monitoring/prom=
etheus/exporters

The embedding of Grafana dashboards into another web app is actually not
that trivial (a simply iframe is way too inflexible) - we ended up with
writing a small proxy for the oA backend that talks to Grafana and then
forwards the filtered output to the oA web UI. You can see some examples
at https://www.openattic.org/galleries/oa-3.x-screenshots/

It should be relatively straightforward to port that to the manager
dashboard.

> What? =3D=3D=3D=3D=3D
>=20
> Extend the dashboard module to provide management of the cluster, in=20
> addition to monitoring.  This would potentially include anything you=20
> can currently do with the Ceph CLI, plus additional functionality
> like calling out to a container framework to spawn additional
> daemons.
>=20
> The idea is to wrap things up into friendlier higher-level
> operations, rather than just having buttons for the existing CLI
> operations. Example workflows of interest: - a CephFS page where you
> can click "New Filesystem", and the pools and MDS daemons will all be
> created for you. - similarly for RGW: ability to enable RGW and
> control the number of gateway daemons - driving OSD
> additional/retirement, and also format conversions (e.g.
> filestore->bluestore)

OSD lifecycle management is definitely a frequently occurring task that
would benefit from an easy UI.

I'd focus on addressing the most popular and regular admin chores first
before diving into adding one-off management/deployment features.

> Some of the functionality would depend on how Ceph is being run:=20
> especially, anything that detects devices and starts/stops physical=20
> services would depend on an environment that provides that (such as=20
> Kubenetes).

Right, this part could become be quite complex, as there are multiple
methods for deploying and orchestrating Ceph: bare-metal vs. Kubernetes,
using tools like ceph-ansible vs. DeepSea/Salt...

It may make sense to start with adding management functionality that is
based on existing/built-in Ceph APIs, e.g. Pools/RBDs/RGW and CephFS,
starting with read-only methods for obtaining information about these
and then extending that code path incrementally by adding functionality
to modify these objects. This evolutionary approach served us well for
many oA features that we created.

But at some point you will have to reach out to external services and
orchestration tools.

> Why build it in? =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Historically, Ceph management UIs were usually doing lots of
> non-Ceph work too, configuring the underlying OS and hardware as well
> as the Ceph cluster itself.  Consequently, it often made sense build
> the user interface into an external tool/framework that already knew
> how to do all that labour-intensive infrastructure stuff, rather than
> trying to reinvent it for a Ceph-specific management tool.

We came to the same conclusion and initially started off from the
assumption, that the Ceph Cluster is already deployed and up and running
and our tool can then take it from there.

Of course, everybody wants that GUI-based "one click" install, but it's
the most complicated part to get right, and a lot of effort. Considering
you only use it once in the life cycle of your cluster, we currently
tried focusing on the more frequently occurring tasks...

> As some of us are moving towards running Ceph in container=20
> environments like Kubernetes, the hardware/OS piece is increasingly=20
> taken care of for us.  The container platform provides a simpler way=20
> to discover and use hosts and block devices, which we can use
> directly from Ceph (or from the ceph dashboard).

The key is to make the dashboard usable in as many environments as
possible, even if only with limited functionality.

One thought however: the current UI framework is likely not well suited
for developing functionality that requires user interaction and some
more sophisticated widgets and other UI elements.

While I think that CherryPy is a great choice for the backend
functionality, AngularJS might be a better choice than Rivets.js for the
frontend in the long run. We've had very good experiences with it and
are currently in the process of migrating our UI to Angular2. But this
of course complicates the build and testing process.

> What about external UIs? =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>=20
> Building more UI functionality into Ceph should not get in the way
> of integrating with any external tools/projects.  It should actually=20
> benefit those projects: as we connect up functionality into the=20
> dashboard module, those same ceph-mgr/python code paths can easily
> be connected to REST endpoints in the restful module.

That would be really useful indeed.

> The work to actually expose the REST bits will probably still fall
> on the people who really want/need that functionality, but it should
> be a very lightweight task for things where the functionality
> already exists in the dashboard.

So the Dashboard won't use the REST API itself by default? Wouldn't it
be better to have a clear separation between the UI and backend here,
and using one common API?

> Currently modules are somewhat isolated from one another, but I've=20
> recently added an inter-module RPC interface so that we can have=20
> better sharing of state -- the idea is to have some common things
> like a table of long-running-jobs that would be shared between the=20
> dashboard and restful modules.

Have you already started working on this part? We created a TaskQueue
implementation for oA that might be worthwhile using here.

> Security =3D=3D=3D=3D=3D=3D
>=20
> The dashboard is currently completely read-only: that's convenient=20
> because it makes it less scary to run it over unencrypted http
> and/or without login (or in practice, leaving https/login as an
> exercise to the sysadmin).  When administrative functionality is
> added, we'll need some sort of login, and https too.

Agreed, access control will be required as soon as you will be able to
actually modify things.

> The https part can probably be done in the same way as the restful=20
> module: require a user-generated certificate (i.e. for their proper=20
> domain) by default, but also provide a helper for the adventurous
> user to run with a self-signed cert if they want to.

Sounds good.

> The login part could be as simple as creating users/passwords using
> a CLI and just prompting for them in the GUI, or we could also have
> some GUI functionality for managing users.  I wouldn't want to go too
> far with the latter: if someone has complex requirements then it's=20
> generally better to be plugging into some external user database.

Agreed - external auth using SAML/oAUTH/LDAP/AD is usually high on the
wishlist for "enterprise" users. But it seems like CherryPy does not
provide any support for these methods yet?

> It would still be very nice to retain the read only mode as an option
> of course.

Being able to flag a user as "read-only" might be good enough to begin
with, instead of devising a full-fledged role/privilege system.

Thanks for kicking this off! I think our work on openATTIC and the
experiences that we've gathered while doing so might be useful here, so
we should continue this conversation.

Lenz

--=20
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 Nuernberg (Germany)
GF:Felix Imend=C3=B6rffer,Jane Smithard,Graham Norton,HRB 21284 (AG N=C3=BC=
rnberg)


--rkpBAVbTCQkI2UscBgJWwtxht3NUUBXf7--

--uDnjbLuvNLSsjQt8eBjXhIFWh1Pw7bUFN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRwnM6QdoQNrjll2jdJUOEqsnKR8gUCWj2bqQAKCRBJUOEqsnKR
8mXNAJ4kzMAcbyOP7CJUZiWzLF0w1mgmVQCeO2J4dcArlBVDQI60Wtg0CoAB1uM=
=yq9y
-----END PGP SIGNATURE-----

--uDnjbLuvNLSsjQt8eBjXhIFWh1Pw7bUFN--
