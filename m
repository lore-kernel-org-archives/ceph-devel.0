From: Sage Weil <sage@newdream.net>
Subject: Re: OSD::op_is_discardable condition doubled
Date: Tue, 22 Sep 2015 05:26:01 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509220524500.11876@cobra.newdream.net>
References: <90EABA838E32E141BC06296A2C40520A1A62D80F@IRSMSX108.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1457832326-1442924761=:11876"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34558 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbbIVM0C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Sep 2015 08:26:02 -0400
In-Reply-To: <90EABA838E32E141BC06296A2C40520A1A62D80F@IRSMSX108.ger.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Lakis, Jacek" <jacek.lakis@intel.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1457832326-1442924761=:11876
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Sep 2015, Lakis, Jacek wrote:
> Hi ceph-devel!
> We're checking OSD::op_is_discardable condition two times: in dispatche=
r (handle_op) and in worker threads (do_request->can_discard_request->can=
_discard_op)
>=20
> =A0 if (!op->get_connection()->is_connected() &&
> =A0=A0=A0=A0=A0 op->get_version().version =3D=3D 0) {
> =A0=A0=A0 return true;
> =A0 }
>=20
> Is there any purpose to do this? If not, which of those should be=20
> removed in your opinion? If condition in handle_op will remain, OP won'=
t=20
> pass to the worker threads through the prioritized queue. On the other=20
> hand, leaving it in do_request will parallelize this check (I started=20
> parallelizing in PR 5211).

Is there a reason not to do it twice?  It looks pretty cheap.

But, if we have to choose, I'd leave it in the worker thread.  It is=20
unlikely to trigger on newly dispatched messages (that were *just* taken=20
off the wire), and the worker thread check is critical to avoid wasting=20
work on requeued/delayed messages that no longer have clients waiting on=20
them.

sage
--557981400-1457832326-1442924761=:11876--
