Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91831F996
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 06:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779948850; cv=none; b=ooLtMQNyso8LmX2OUBNqg2R7vi4Gt+YqyucuIcIAsEXQBSoqDqIh0+rNY90b6jL0SJOhCk400o7Jp/5BzDEmBcR1Cusw6z0DlqjWxMo2w56jgHwXYzT58jRQ4/rApGYgZcZF+UQHwgoDYR2ujMvaomZQ1Vel8DJSlDCUCyczoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779948850; c=relaxed/simple;
	bh=cEZD5K/Cb2Buq0z+muC6XLNHGnDOCXUfDp34aogJYN0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9/YHmSev+w5abUZxto0MZR2bhdinFAaDmR+f8JbMHBwI9b34xxJL4jLhWFbiWSf7RxLo5J6DRmb/dMNr8C4BxuDJih4ZvikYNq07N3HaZ4MEr8i+sgrzBtS6lDb1uAr5OW151TCcg2foHwMLjEGWgcY+UMPTAriar2LGp011ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=X4ERvsu/; arc=none smtp.client-ip=185.70.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="X4ERvsu/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1779948842; x=1780208042;
	bh=J8jOiivIlg0LO2ehsc/5I/cj5ZXZosD3QUpcZpeJqPQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=X4ERvsu/Pr4eZNtZBcrDhSK2VN7O+cPWQDwJI7qoB2pbTZHD2dSw6xWijB2GOUHuh
	 BForF6E5k05+WwG4Wxro7scHqPBNqWapwNspHHsAplyrO8wSphts7kYGxJslY1APpJ
	 /vFPdsNib+p3tqALX7qSYXLPC766uYUwNtBuhciWUfOaGzYm/mxRIND+HS8kDLUTrY
	 RcP56n6njXlbCCK2srEmI4C/jvlj4WlJ+VSTOakCOeX94DBpw5qeib0r9YgT47zkiE
	 NPHw3dzxOFiqeLx3jvbxBlVuXNXgy2tXIH9prPQ48a7KjK+KJbNY1dSH6Uo8VSdW31
	 UPpJqkcwh+cHA==
Date: Thu, 28 May 2026 06:13:58 +0000
To: Greg KH <gregkh@linuxfoundation.org>
From: hexlabsecurity@proton.me
Cc: "security@kernel.org" <security@kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, "xiubli@redhat.com" <xiubli@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: Re: [REPORT] fs/ceph: malicious-MDS kernel OOB read via unbounded snap_trace_len in CEPH_CAP_OP_IMPORT (since v2.6.34)
Message-ID: <ved5l12DIYeOrtpiOyxLZX4Q6ns8pHePwLZ9NSRbYVkoN2MgZWVMYx_5pR-MwzWqQlZ6AeWTI0PWWqprXZx0nCkjSTGR8Mv2GEsKBjIzf0o=@proton.me>
In-Reply-To: <2026052843-unread-quicksand-1da9@gregkh>
References: <cEUA87QPkzfvf28KWaj4f8hEVYBkHl6Gc9sqTYM2Ld-H76SJIpst6wVPSu55qpViAeMPeUWyLrYyDQTzG8Mj969WqjThU58gj56D1GF8X8g=@proton.me> <2026052843-unread-quicksand-1da9@gregkh>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: a3196ce02d931c4c44bb48de84a0ec5c34aadf5e
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Apologies =E2=80=94 I'm a human researcher, not an AI tool.=20
The patch was accidentally omitted from the original=20
report. Sending it now with proper CCs.

Thanks,
Bryam Vargas
Independent security researcher.
HEXLAB SAS (registration pending) =E2=80=94 Cali, Colombia.

From 1ce0769ba4ba691b879fcd35900f6c199fb7da8c Mon Sep 17 00:00:00 2001
From: Bryam Vargas <hexlabsecurity@proton.me>
Date: Wed, 27 May 2026 22:32:59 -0500
Subject: [PATCH] ceph: fix pre-auth out-of-bounds read in ceph_handle_caps
 snap-trace

ceph_handle_caps() reads snap_trace_len from the wire-format
ceph_mds_caps header and uses it unconditionally to build a fake
end pointer (snaptrace + snaptrace_len) that is later handed to
ceph_update_snap_trace() in the CEPH_CAP_OP_IMPORT case:

    snaptrace     =3D h + 1;
    snaptrace_len =3D le32_to_cpu(h->snap_trace_len);   /* 32-bit host */
    p             =3D snaptrace + snaptrace_len;
    ...
    case CEPH_CAP_OP_IMPORT:
        if (snaptrace_len) {
            ...
            if (ceph_update_snap_trace(mdsc, snaptrace,
                                       snaptrace + snaptrace_len,
                                       false, &realm)) { ... }

ceph_update_snap_trace() then decodes a struct ceph_mds_snap_realm
from snaptrace using ceph_decode_need(&p, e, sizeof(*ri), bad)
with the attacker-supplied fake end e =3D=3D snaptrace + snaptrace_len.
With snaptrace_len =3D=3D 0xFFFFFFFF the bound check is trivially
satisfied, ri =3D p reads sizeof(struct ceph_mds_snap_realm) past
the legitimate msg->front buffer, and ri->num_snaps /
ri->num_prior_parent_snaps then drive further out-of-bounds
reads of the encoded snap arrays.

The eleven msg_version >=3D 2 .. msg_version >=3D 12 decoder blocks
above the op switch each catch this OOB through their
ceph_decode_*_safe() / ceph_decode_need() helpers, but they sit
behind a hdr.version-gated if, so a malicious or compromised
MDS that sets msg->hdr.version =3D 1 reaches the IMPORT path with
no version-gated decoder having validated snap_trace_len. The
shape has been present since ceph_handle_caps() was introduced.

Validate snap_trace_len against the message front buffer before
consuming it.  This is the same shape as the existing per-decoder
checks below (if (p + flock_len > end) goto bad; etc.) and the
existing goto bad cleanup already covers this exit path.

Reported-by: Bryam Vargas <hexlabsecurity@proton.me>
Fixes: a8599bd821d0 ("ceph: capability management")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 fs/ceph/caps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d51454e995a8..d50a60af5079 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4365,6 +4365,8 @@ void ceph_handle_caps(struct ceph_mds_session *sessio=
n,
=20
 =09snaptrace =3D h + 1;
 =09snaptrace_len =3D le32_to_cpu(h->snap_trace_len);
+=09if (snaptrace_len > end - snaptrace)
+=09=09goto bad;
 =09p =3D snaptrace + snaptrace_len;
=20
 =09if (msg_version >=3D 2) {
--=20
2.43.0
