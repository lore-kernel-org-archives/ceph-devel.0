Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A5D3DA7D7
	for <ceph-devel@vger.kernel.org>; Mon, 10 Aug 2026 12:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786364922; cv=none; b=Aov9HqrFty+PhoGPiViTO775MpS97mAPg7PWTBXabUW6MnH5ScUH53Ppd4tJYcmGGQ2cUhO5zcAhf21sMUMmbDZQMUIjSf+6l0qlI+JPN58O6kNb7x+fYkyj9Rc9I94QCQXyQ/uwq5FThNdKDDlxBIO0Oi6hOB3gCnO5nm3Vjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786364922; c=relaxed/simple;
	bh=xB/SG+nkoVeBZn29ex9klFEeocmanwbNit2zBGT8Vpo=;
	h=Message-ID:Date:MIME-Version:Subject:References:To:Cc:From:
	 In-Reply-To:Content-Type; b=CsVIJqUH0MBeVcXypTT2GCDyx3X/qBIfgpPtruzV2M4GEy17vd1pmBvcZwaTP3Ek3qtpbWBUoaebG1lahLitvmCsy1Cx5JcZlN8a6SolU7abs9zUK0c9pD1Ns+knukihSe8c0B0KR+88Z4Jyv/+WilyzexbszJrhiJN+aPc11DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=zsbZBbAB; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="zsbZBbAB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1786364909; h=message-id
 : date : mime-version : subject : references : to : cc : from :
 in-reply-to : content-type : content-transfer-encoding : from;
 bh=xB/SG+nkoVeBZn29ex9klFEeocmanwbNit2zBGT8Vpo=;
 b=zsbZBbABoLaeKLXZRZ3aA5kZE/Ak1KxZ7NG5H760DnndB4EK4rGLE8mASgs0mOcQDd0Pv
 BIm3XNDlS8ocaHI00dV6/B6uIRmvinnqbeSDZch8UTNZ1AOAEz2nXU3L0OQ6HoqfKlemoBf
 hTUG8K4kzPW/2KrR1IOR41/Ezj60INtB27+nuZqA1xp+zbiBNnDwQZghuxutiiR0oDOibrj
 Owt1PcLkfokrxvwQw7KFs8chpGble3XgHDjUGQFR1eff0/XB80QqqLav3P8h37FPkiJEsXh
 eH1e7SiWj3CJN0qSTSDs2S6zFGeACW//lPhamm00Xv6qLrU+LIlUcjBjqLdQ==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id BD55C5FB4B;
	Mon, 10 Aug 2026 14:28:29 +0200 (CEST)
Received: from [141.24.212.106] (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 973E25FB4B;
	Mon, 10 Aug 2026 14:28:29 +0200 (CEST)
Message-ID: <d1dc7faa-2373-4c96-ba0e-0e6d3e3b8457@tu-ilmenau.de>
Date: Mon, 10 Aug 2026 14:28:29 +0200
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [bug report] libceph: ceph_pg_is_split() may get stuck in infinite
 loop
Content-Language: en-US
References: <5c6c41a0-a25a-4a0e-90ea-426eed554fb9@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Autocrypt: addr=raphael.zimmer@tu-ilmenau.de; keydata=
 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
In-Reply-To: <5c6c41a0-a25a-4a0e-90ea-426eed554fb9@tu-ilmenau.de>
X-Forwarded-Message-Id: <5c6c41a0-a25a-4a0e-90ea-426eed554fb9@tu-ilmenau.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,
I noticed some problems in ceph_pg_is_split() (net/ceph/osdmap.c) that
may result in an infinite loop for certain values of old_pg_num and
new_pg_num.
The issue arises if old_pg_num and new_pg_num have values greater than
or equal to 2^31. In this case, calc_bits_of(old_pg_num) calculates 32
and assigns this value to old_bits. The next statement:
	int old_mask = (1 << old_bits) - 1;
results in a left shift operation of 32 bits, which is undefined
behavior when performed in 32-bit width. This should be avoided in any
case. If only the last 5 bits of the shift count are evaluated (as done
on my machine), old_mask will be 0.
Inside the for loop, next_bit is calculated as
	int next_bit = n << (old_bits - 1);
which results in either 2^31 or 0 depending on whether n is odd or even.
In the next step, s is calculated as
	u32 s = next_bit | pgid->seed;
which results in either s = pgid->seed or s = pgid->seed + 2^31.
If old_pg_num > pgid->seed | 2^31, the following if statement always
evaluates to true and the loop continues with the next iteration.
This causes the loop to never terminate.
If old_pg_num <= pgid->seed | 2^31, the following if statement only
evaluates to true in case of s = pgid->seed. With s = pgid->seed + 2^31,
the remaining part of the loop's body will be executed. If new_pg_num is
greater than pgid->seed + 2^31 the
	if(s >= new_pg_num)
		break;
will never exit the loop.
Subsequently,
	s = ceph_stable_mod(s, old_pg_num, old_mask);
will return s = 0, and the return statement is only executed for
pgid->seed == 0. (In case the undefined shift operation evaluates the
same way as seen on my machine.)
If not, the loop never terminates.

This happens for all values that fulfill:
(new_pg_num > old_pg_num >= 2^31) and (old_pg_num > pgid->seed | 2^31)
|| ((new_pg_num > pgid->seed | 2^31) && pgid->seed > 0)
An actual example for this is new_pg_num == 2^32-1, old_pg_num == 2^32-2
and pgid->seed < 2^31-2.

Another case that results in a bit-shift being undefined behavior is
old_pg_num == 0. In this case, old_bits is 0, and the first statement
inside the for loop:
	int next_bit = n << (old_bits - 1);
results in n << -1, which is also undefined behavior.

In the first case, a misbehaving Ceph daemon or an attacker that
modifies messages can deliberately trigger infinite loops and thereby
force resource depletion.
This is the case because the values are read from the previous and
current osdmap, which have been received over the network and can
therefore contain arbitrary attacker-supplied data.

To handle these issues, additional logic could be introduced to
ceph_pg_is_split(). The infinite loop could be easily prevented by
adding an upper bound to the for loop. However, another solution would
be to not allow pg_num to take on such values directly when receiving an
osdmap. I'm not sure if these values can be treated as invalid. More
than 2^31 seems very unlikely to me, but 0 could possibly be a valid value.

Do you have an opinion or guidance on how to handle this, resp. which
possible solution to prefer? In this case, I can create a patch for it.

Best regards,
Raphael

