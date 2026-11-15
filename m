Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778761;
	b=opt68KOG0EyE51BbJ5ZnintK9nZip3BnEWnZBz0KiXbBJRSipHWMIXK4YOHbtM52t6n/
	 LwYA/UVzD/Yr0WGx6E91ar8/ZgqVnsqRP5OX13AkkNZLPWbdkjzo7N6L8gN2msq1rgXMT
	 LVrc9Det2UTMqzp+EVhLE4zREoKOVfvEd6SIi/06RO6wUfsgG/nSnMPD9zDY8OfQOELNo
	 YSAqPHGf0H/XMg0hBxqb2f2kQWi+KVrrV4hyGV9kj0RmvPmLXmR+b7x1XpgcujgAmZqDq
	 7u5BV0bpESn4h/qhZ/e89K224j6/wqiBOqodsvz2y8PyF61V31XoeljiKHFy0k2GKfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778761;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AgmXiYwsbFtClFrM0wh7o6D+RpJ4fbleaDulYZzEPzs=;
	b=hPl7o38AqGODgtsiEjbpbh7E/TtRtfAuu3iu7lFTOFFZdQhwFv0TXsvv1GPo30M55KHC
	 6raXky5Y/rSxmeM425POZI51mS0I0Z1h6OioMyzfZpdol1flfbOu68OuiZlbLT1y8/yvV
	 Ms45P5wadKrd46ej9Tx+8llTcrwQzr4MH/PQKxRdO7I3vgzMdKcZWFM4gYttaUKQL7ISZ
	 iykxb3hEfvUOXQmsJcALNY2ZBWqSziW/f9fY4tYPMRqFpk0mU7y8jx05ZiuXAxcKr4ioe
	 XxSY8w0t0zjettCUI/tUfT+smBcfyWBLqHrZAaN8oMW5uYZ09rBaX34/lpJzJA7713Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWmxyC9b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22528606A329;
	Sun, 15 Nov 2026 21:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gWmxyC9b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA571F000C4;
	Sun, 15 Nov 2026 21:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794778760;
	bh=AgmXiYwsbFtClFrM0wh7o6D+RpJ4fbleaDulYZzEPzs=;
	h=From:Date:Subject:To:Cc;
	b=gWmxyC9bKog3m9DpNjBIEoKmRHcUJIlDRSRZkKnJ7ncNpBHDUpX7AyQ+/Id+kKvXJ
	 T/qLkhd2JeTx4IMlwQpDhmdGOVSgJPMhCLyi4JUX79RhLhZEgvlFcpyxlf4lA2KpTf
	 9OnhnNpVYYH+o69Ht4YjjgSVcmBT3W4nOq4dvSkjXtkWwie1WeOck5/DJZtgACvSXH
	 pKak/xSHVmsg8F7sKbMIYjALeDs/RxJfazxaF7t+NtcMQDrn/0CosTF1DGS38fXFD4
	 pLwZaQ5QO/v+k4r/YYpZA1g2kurLBqdCGmNI8zcjBPrQ43eP8UX5G8SvDSMCbou360
	 +ERuF0paV0NwA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sun, 15 Nov 2026 14:39:13 -0700
Subject: [PATCH] libceph: Avoid unsequenced accesses to jiffies in
 dump_linger_request()
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261115-ceph-wunsequenced-v1-1-6910c560ba9b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMQQ6CMBBG4auQWduEKWCiVzEuoP0L46Jih6oJ4
 e4WWX6L91ZSJIHStVop4S0qz1jAp4rc1McRRnwx2dqembkzDvNkPjkqXhnRwZu27W3NFx+aEKh
 0c0KQ7/95ux/WPDzgln1E2/YDSrgGRHUAAAA=
X-Change-ID: 20261115-ceph-wunsequenced-44a2019df3ff
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Xiubo Li <xiubo.li@clyso.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>, ceph-devel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2758; i=nathan@kernel.org;
 h=from:subject:message-id; bh=eXBp/KB6vBLLPNVJIOG85QieDKCMzM3UE/e2kzkIpmQ=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDFm/1Jqd8rRnPOB3yWxdU39yTR5D2pKo+wGKbjz6Vtc8v
 CcuFl/UUcrCIMbFICumyFL9WPW4oeGcs4w3Tk2CmcPKBDKEgYtTACbS9o+RYdGHvU0+FonqRd0s
 ef19h62V3pvLWvqcFQvYuGXN9T8cXIwMs1fuNjty91feosw3J+Z7dVbJs/GmzQhPD990+gHzM5E
 tnAA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After a recent improvement in clang to warn on unsequenced accesses to
volatile variables [1], an instance appear in dump_linger_request(),
which can break the build with CONFIG_WERROR=y / W=e:

  net/ceph/debugfs.c:269:42: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
    267 |                    req ? jiffies_to_msecs(jiffies - req->r_start_stamp) : 0,
        |                                           ~~~~~~~
    268 |                    lreq->is_watch && lreq->committed && !lreq->last_error ?
    269 |                         jiffies_to_msecs(jiffies - lreq->watch_valid_thru) : 0,
        |                                          ^

Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
6.5.2, unsequenced side effects on the same scalar object are undefined
behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
function call is indeterminately sequenced, meaning any side effects in
the arguments are unsequenced.

Add a local variable to hold the value of jiffies before the function
call so that there are no unsequenced side effects, clearing up the
warning.

Fixes: a407f9961902 ("libceph: include current latency in debugfs osdc dump")
Closes: https://github.com/ClangBuiltLinux/linux/issues/2200
Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 net/ceph/debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index b068e25f2acc..82270f0e4d7e 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -259,14 +259,15 @@ static void dump_linger_request(struct seq_file *s,
 	struct ceph_osd_request *req =
 	    list_first_entry_or_null(&lreq->osd_reqs, struct ceph_osd_request,
 				     r_private_item);
+	unsigned long j = jiffies;
 
 	seq_printf(s, "%llu\t", lreq->linger_id);
 	dump_target(s, &lreq->t);
 
 	seq_printf(s, "\t%u\t%u\t%u\t%s%s/%d\n", lreq->register_gen,
-		   req ? jiffies_to_msecs(jiffies - req->r_start_stamp) : 0,
+		   req ? jiffies_to_msecs(j - req->r_start_stamp) : 0,
 		   lreq->is_watch && lreq->committed && !lreq->last_error ?
-                        jiffies_to_msecs(jiffies - lreq->watch_valid_thru) : 0,
+                        jiffies_to_msecs(j - lreq->watch_valid_thru) : 0,
 		   lreq->is_watch ? "W" : "N", lreq->committed ? "C" : "",
 		   lreq->last_error);
 }

---
base-commit: a407f99619029b76548774af1006319f810bb345
base-tree: git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
change-id: 20261115-ceph-wunsequenced-44a2019df3ff

Best regards,
--  
Cheers,
Nathan

