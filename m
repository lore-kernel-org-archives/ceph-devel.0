Received: from mail-24427.protonmail.ch (mail-24427.protonmail.ch [109.224.244.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8F25D530
	for <ceph-devel@vger.kernel.org>; Thu, 28 May 2026 23:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780010289; cv=none; b=FCscOlblnu8r8ADASONIFoRVnJgTxjoIaXyeLVsItPLJiGkZ/iQyt9R1qry94TDyNVMhuMylZQbJYivmjADuLBoCBUCsvc5fSMf3scwsBypAScx2lrDX090RbgOu1jsBHNGoeDsieLIqWDqYUCQV3lz7X6Q0OOQ+604INQgexAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780010289; c=relaxed/simple;
	bh=ZyBtiqkwyhtG22PZW1w3EBWOFg9BOEkMrWhsW2JDbYE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3yRViVC6UEA8XaTNVrZK8MpJu0vw/VKQTx821/XDbOw/JsHlF5yO6B+VHv/rhXF7xLfPr2IwGN8DMRcZW7dQMfhGxhpKpgqXeEcByQwuJ0ONwQN/vnTcs/g8JIpoHUwWlR9+bGklAaTh+6Y0JO2qDBW18VlHC7drI0y55pPUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FKfNsBjh; arc=none smtp.client-ip=109.224.244.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FKfNsBjh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=usdxjdlrojhoxjwbjsvaaqhuh4.protonmail; t=1780010283; x=1780269483;
	bh=86C6kqXr3Fx24FK9Rz7oilENwR1ONcrsI20oXslvOoU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FKfNsBjhtIFg7/2ot+DjsozQLpsoIQQ5cd3QAVfYP6JQk5+mVACeI0L/SOpDf4nbB
	 mtbm+cxCj6w27v8Fiz1ADhMIIn1pw7OXEF/LD1Cvkj3jEbBji3UGKyUmwZfd8bwrTi
	 E7VtkQKB52D8vtgBkkZlgOp2mzv+0V957s3ls9iluLE+G4vyccyLN1gvIGLW0jjjar
	 BDzyKIoeKLxQTicgqispD0ls+cpGaL4r1CWHSV69FoU9k9JS8aPFETOOlaoOZXUE8T
	 G6ZTZTZN1JMLOtmd3IaAPS6oQnflrwUnzbXipcA4IMqXCkEEE8vrto+plwA9VCgeMw
	 hdbTxWfJDH5yw==
Date: Thu, 28 May 2026 23:17:59 +0000
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
From: hexlabsecurity@proton.me
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "security@kernel.org" <security@kernel.org>, "idryomov@gmail.com" <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Subject: RE: [REPORT] fs/ceph: malicious-MDS kernel OOB read via unbounded snap_trace_len in CEPH_CAP_OP_IMPORT (since v2.6.34)
Message-ID: <L-m2MCIXcXV8COv8VZ3KxX7UtnbDB6zYlSmb-0m39OXp14kxgQ_PSenP2p1WUtrXmqQvQ4-5yxdYi3lKUTlvPPBGaoLBGjbqfY5BUCilY_8=@proton.me>
In-Reply-To: <449e934b182ba6d8f6f4912f71bd1263630396d6.camel@ibm.com>
References: <cEUA87QPkzfvf28KWaj4f8hEVYBkHl6Gc9sqTYM2Ld-H76SJIpst6wVPSu55qpViAeMPeUWyLrYyDQTzG8Mj969WqjThU58gj56D1GF8X8g=@proton.me> <2026052843-unread-quicksand-1da9@gregkh> <ved5l12DIYeOrtpiOyxLZX4Q6ns8pHePwLZ9NSRbYVkoN2MgZWVMYx_5pR-MwzWqQlZ6AeWTI0PWWqprXZx0nCkjSTGR8Mv2GEsKBjIzf0o=@proton.me> <449e934b182ba6d8f6f4912f71bd1263630396d6.camel@ibm.com>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 9dc0c1a3f380f694f7a7baa5a87d00f6897880eb
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Viacheslav,

Thanks for the review!

I used the subtraction form on purpose.  snap_trace_len is an
attacker-controlled u32, and on 32-bit (ILP32) builds the additive form
snaptrace + snaptrace_len can wrap the address space for values near
0xFFFFFFFF and silently pass the bound check, whereas
snaptrace_len > end - snaptrace is wrap-safe -- it is the same
arithmetic ceph_has_room() uses internally (n <=3D end - *p).  The earlier
msg->front.iov_len < sizeof(*h) guard guarantees end >=3D snaptrace, so the
subtraction can't go negative.  (CONFIG_CEPH_FS only depends on INET, so
the 32-bit case is reachable in principle, even if real deployments are
64-bit.)

I double-checked both forms in a small userspace test compiled at -m32
and -m64 (gcc -fno-strict-overflow, to match the kernel), feeding
snap_trace_len =3D 0xffffffff:

  - 64-bit (LP64):  Form A -> goto bad,  Form B -> goto bad  (equivalent)
  - 32-bit (ILP32): Form A -> goto bad,  Form B -> passes, OOB proceeds

So on the usual 64-bit configs the two are equivalent (your "not
critical" read holds there); the divergence only shows up on 32-bit,
where snaptrace + 0xffffffff wraps below end.

If you'd rather keep it consistent with the surrounding decode code, I'm
happy to respin via the canonical helper, which stays wrap-safe and
reads the same way as the pool_ns_len check a few lines below:

    ceph_decode_need(&snaptrace, end, snaptrace_len, bad);

Just let me know which you prefer and I'll send v2 carrying your
Reviewed-by.

Thanks,
Bryam
