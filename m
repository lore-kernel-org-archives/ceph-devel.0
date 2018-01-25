From: Lenz Grimmer <lgrimmer@suse.com>
Subject: Re: dashboard_v2 (was: dashboard in mimic)
Date: Thu, 25 Jan 2018 14:51:21 +0100
Message-ID: <91c65672-7f26-4950-2cf2-798eb31e6e2c@suse.com>
References: <CALe9h7eOv-P35oJT5L2T+CmOe=VTw6V3yBHB0LUK_-ojyeKKCw@mail.gmail.com>
 <398c92be-3f11-cfca-00b5-03fe429e65f8@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="mhF5vexrVkaijB08bi6hbqiUoAKe6s5Tf"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750980AbeAYNvY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 25 Jan 2018 08:51:24 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9E9CBAAC5
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jan 2018 13:51:22 +0000 (UTC)
In-Reply-To: <398c92be-3f11-cfca-00b5-03fe429e65f8@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mhF5vexrVkaijB08bi6hbqiUoAKe6s5Tf
Content-Type: multipart/mixed; boundary="oyDAsrYj3E2yqGY0B0zcjMzdEAzGuGuob";
 protected-headers="v1"
From: Lenz Grimmer <lgrimmer@suse.com>
To: Ceph Development <ceph-devel@vger.kernel.org>
Message-ID: <91c65672-7f26-4950-2cf2-798eb31e6e2c@suse.com>
Subject: Re: dashboard_v2 (was: dashboard in mimic)
References: <CALe9h7eOv-P35oJT5L2T+CmOe=VTw6V3yBHB0LUK_-ojyeKKCw@mail.gmail.com>
 <398c92be-3f11-cfca-00b5-03fe429e65f8@suse.com>
In-Reply-To: <398c92be-3f11-cfca-00b5-03fe429e65f8@suse.com>

--oyDAsrYj3E2yqGY0B0zcjMzdEAzGuGuob
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

time to follow up on this...

On 12/23/2017 12:56 AM, Lenz Grimmer wrote:

> http://pad.ceph.com/p/mimic-dashboard
>
> Looking at that list, I think we've implemented several of that items
> in openATTIC/DeepSea already
> (https://www.openattic.org/features.html) and many of the other
> topics are on our TODO as well.
>
>> Extend the dashboard module to provide management of the cluster,
>> in addition to monitoring.  This would potentially include anything
>> you can currently do with the Ceph CLI, plus additional
>> functionality like calling out to a container framework to spawn
>> additional daemons.

[...]

> Thanks for kicking this off! I think our work on openATTIC and the
> experiences that we've gathered while doing so might be useful here,
> so we should continue this conversation.

We did have some initial conversations with Sage and John about this in
the meanwhile. After creating a prototype of the current dashboard based
on Angular, we proposed the following: we (the openATTIC team at SUSE),
will go ahead and start a new Manager module, currently dubbed
"dashboard_v2".

The code and architecture of this module is derived from and inspired by
the openATTIC Ceph management and monitoring tool (both the backend and
WebUI). The development is actively driven by the team behind openATTIC
and we aim to migrate as much of the existing openATTIC functionality as
possible (plus all the functionality currently provided by the existing
dashboard).

The groundwork is still in the early stages, but we openened a WIP pull
request so you can follow the ongoing development here:

  https://github.com/ceph/ceph/pull/20103

Please see the PR description and the README included in the module for
more background information and details.

At the moment, we have a basic backend framework (based on CherryPy) in
place, including a simple authentication mechanism based on username and
password (freely definable).

Next up is adding the initial WebUI scaffold, which will be based on
Angular. After this groundwork is done, we'll migrate the openATTIC and
dashboard modules one by one.

Our main development branch is located here:

  https://github.com/openattic/ceph/commits/wip-mgr-dashboard_v2

For the time being, pull requests for the module are managed on this fork=
:

  https://github.com/openattic/ceph/pulls

If you have any questions or would like to help, don't hesitate to get
in touch with us!

We also have two weekly conference calls where we discuss the progress
and open issues. If you're interested in joining, please contact John
Spray or myself for details.

Thanks!

Lenz

--=20
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 Nuernberg (Germany)
GF:Felix Imend=C3=B6rffer,Jane Smithard,Graham Norton,HRB 21284 (AG N=C3=BC=
rnberg)



--oyDAsrYj3E2yqGY0B0zcjMzdEAzGuGuob--

--mhF5vexrVkaijB08bi6hbqiUoAKe6s5Tf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRwnM6QdoQNrjll2jdJUOEqsnKR8gUCWmng2gAKCRBJUOEqsnKR
8vxWAJ0aW5oorwoJ44df7Feb3AbXXZniAQCdFrjRrUZfwQ62SauKD7bCk0cAcio=
=i5i/
-----END PGP SIGNATURE-----

--mhF5vexrVkaijB08bi6hbqiUoAKe6s5Tf--
