From: Sage Weil <sage@newdream.net>
Subject: RE: Cache pool bug?
Date: Mon, 27 Oct 2014 09:04:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410270902320.13498@cobra.newdream.net>
References: <CANE=7sUW0e-vp8LROZFA+5BGNoENA4MLthsnPUKb1ks=hnoyEA@mail.gmail.com> <BLU169-W9B3F7EAC2250B1425B560DA9E0@phx.gbl> <06E7D85B3BA36C4DB207FEDE871C5348950BD2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1198200864-1414425864=:13498"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46853 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607AbaJ0QEZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Oct 2014 12:04:25 -0400
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C5348950BD2@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: "xmdxcxz@gmail.com" <xmdxcxz@gmail.com>, "'ceph-devel@vger.kernel.org'" <ceph-devel@vger.kernel.org>, "wonzhq@hotmail.com" <wonzhq@hotmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1198200864-1414425864=:13498
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Oct 2014, Wang, Zhiqiang wrote:
> Hi,
>=20
> I agree with you this is a bug.
>=20
> I think we should change the following code:
>=20
>     // KISS: if [lower,upper] spans our target effort, evict it.
>     if (atime_lower >=3D agent_state->evict_effort)
>       return false;
>=20
> to something like this:
>=20
>     if (1000000 - atime_upper >=3D agent_state->evict_effort)
>       return false;
>=20
> cc the ceph-devel list for comments.

Yes, that does look backwards. Good catch!  If you submit a pull request=20
we can get it merged and then backported.

Thanks!
sage


> ________________________________________
> Date: Mon, 27 Oct 2014 10:20:01 +0800
> Subject: Cache pool bug?
> From: xmdxcxz@gmail.com
> To: wonzhq@hotmail.com
> hi, zhiqiang?
>=20
> =C2=A0 =C2=A0 =C2=A0When I read the=C2=A0ReplicatedPG::agent_maybe_evic=
, I found than the newest object has=C2=A0
>=20
> more=C2=A0probability to be evicted. For Example:
>=20
> =C2=A0 =C2=A0 =C2=A0the object in hit_set is newest object, =C2=A0 call=
=C2=A0
>=20
> =C2=A0 =C2=A0 =C2=A0 the funtion agent_estimate_atime_temp(soid, &atime=
, NULL /*FIXME &temp*/); atime is 0 when return.=C2=A0
>=20
> =C2=A0 =C2=A0 =C2=A0agent_state->atime_hist.get_position_micro(atime, &=
atime_lower, &atime_upper), the atime_lower is 0 when return.
>=20
> =C2=A0 =C2=A0 // KISS: if [lower,upper] spans our target effort, evict =
it.
> =C2=A0 =C2=A0 if (atime_lower >=3D agent_state->evict_effort)
> =C2=A0 =C2=A0 =C2=A0 return false;
>=20
> =C2=A0 =C2=A0 Above, the newest object in hit_set is evicted.
>=20
> =C2=A0 =C2=A0 Is there a bug? Or, whether I skip something?
>=20
>=20
> =C2=A0 =C2=A0 Thanks
> N?????r??y??????X???v???)?{.n?????z?]z????ay?=1D????j=07??f???h?????=1E=
?w???=0C???j:+v???w????????=07????zZ+???????j"????i
--557981400-1198200864-1414425864=:13498--
