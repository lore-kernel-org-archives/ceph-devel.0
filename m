From: Mike Lowe <j.michael.lowe@gmail.com>
Subject: Keystone auth v3 changes
Date: Thu, 15 Oct 2015 14:52:59 -0400
Message-ID: <FAC82F91-8D73-4475-950E-77A5AF60391F@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33889 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664AbbJOSxC convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 15 Oct 2015 14:53:02 -0400
Received: by iow1 with SMTP id 1so100685311iow.1
        for <ceph-devel@vger.kernel.org>; Thu, 15 Oct 2015 11:53:01 -0700 (PDT)
Received: from ?IPv6:2601:801::60db:7948:7ab2:5fbf:3ff1? ([2601:801:0:60db:7948:7ab2:5fbf:3ff1])
        by smtp.gmail.com with ESMTPSA id mh8sm127284igb.3.2015.10.15.11.53.00
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Oct 2015 11:53:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The keystone v2 api is slated for removal sometime in the near future m=
aking radosgw unusable with new openstack deployments.  Hoping to jumps=
tart the process of adding v3 support I propose the following changes a=
s a minimum to make radosgw compatible with the v3 auth api.  There is =
an open issue for this http://tracker.ceph.com/issues/13303

=46irst the version to use must be determined, quickest and easiest is =
to add a configurable.  Other clients use the unversioned endpoint to g=
et a list of available versions; this is probably too complicated for t=
he initial implementation.
i.e.
rgw use keystone version =3D 3

Based on the value of that configurable the token_url would need to be =
changed from =E2=80=9Cv2.0/tokens=E2=80=9D to =E2=80=9C/v3/auth/tokens=E2=
=80=9D.  The auth section needs an Identity object that contains a meth=
ods section listing password as the method and a password object  with =
the credentials including the domain (domains are new).  These changes =
should be made to get_keystone_admin_token  The revoked token list is a=
n undocumented api feature for v2 and doesn=E2=80=99t seem to exist for=
 v3.  When validating a token the =E2=80=9C/v3/auth/tokens=E2=80=9D end=
point is used but unlike v2 the token to be validated is in =E2=80=9CX-=
Subject-Token=E2=80=9D instead of appended to the url.

The users now need a domain designation because testuser with domain1 i=
sn=E2=80=99t the same user as testuser with domain2.  Backwards compati=
bility with V2 is done by assigning them all to the default domain of =E2=
=80=9Cdefault=E2=80=9D although this may need to be a configurable. =20

The copy of the token json returned when validating has a top level =E2=
=80=9Ctoken=E2=80=9D instead of =E2=80=9Caccess=E2=80=9D: {=E2=80=9Ctok=
en=E2=80=9D: =E2=80=A6}  and that key has =E2=80=9Cproject=E2=80=9D, =E2=
=80=9Croles=E2=80=9D, and =E2=80=9Cuser=E2=80=9D objects.  This will ne=
ed some slightly different parsing vs a v2 token.

Some details of moving from v2 to v3:
http://docs.openstack.org/developer/keystone/http-api.html

API definitions for v2 and v3:
http://developer.openstack.org/api-ref-identity-v3.html
http://developer.openstack.org/api-ref-identity-admin-v2.html--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
