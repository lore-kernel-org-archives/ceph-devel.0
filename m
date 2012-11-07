From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: unexpected problem with radosgw fcgi
Date: Wed, 7 Nov 2012 15:16:44 +0100
Message-ID: <CAMwB3TiJUmnr6H2QVancmDxSuF1M9KmWW0rTwxJxvLWk80WUyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49534 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752314Ab2KGOQo convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 7 Nov 2012 09:16:44 -0500
Received: by mail-qc0-f174.google.com with SMTP id o22so1043584qcr.19
        for <ceph-devel@vger.kernel.org>; Wed, 07 Nov 2012 06:16:44 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I have realize that requests from fastcgi in nginx from radosgw returni=
ng:

HTTP/1.1 200, not a HTTP/1.1 200 OK

Any other cgi that i run, for example php via fastcgi return this like
RFC says, with OK.

Is someone experience this problem ??

I see in code:

=2E/src/rgw/rgw_rest.cc line 36

const static struct rgw_html_errors RGW_HTML_ERRORS[] =3D {
    { 0, 200, "" },
=2E...

What if i change this into:

{ 0, 200, "OK" },

--
-----
Regards

S=C5=82awek Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
