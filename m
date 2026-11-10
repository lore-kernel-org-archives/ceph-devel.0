Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341468;
	b=ZmGHxvGu8TPWKxa+xFw7ONy/7Wj8zEZOUgfc604fzQMcWuyOoOsRvJ5etq8mRBSiwrw3
	 Nc3op8bexbUgrfekVmoUEGG8f2YAPLXUB5xhQiDJo7j9UsaN3+a8bPVFKE1bg7/TBbyQ8
	 RExpqLfyx1ovC+WZU2J90fNP09VESYP0UEJi7D8qpjVaivKUsBHcssd3CVn+g9y/a3JL7
	 Ubtp1QOPm4uIbl+23WvuZd85QM7MOTRbC48xxu0poAcxBftzmnpM+f5yNkD5RY15P7b1Q
	 hmOtHxHij+rpc/LSwlKqwLLBVe5+382bxRoPBB+JG785MACrR8aNNT23o++m3xg4Rnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=on48w80Rou176JAdjsPSGWQMmQDfqhFmi5vMFS9k5gg=;
	b=BLXANAnfsfu+46T4uCJQ5z30mkYw4tIGyKHN1F8wst767Ipp3OJC7VsUhgnCflcLbYm3
	 H3JzM/WpwDLy73OrOqlRAYAZj3bNRAW9Ghp1sfn4NKAoTP6kEGMUMcn3UmvoatUer3lAh
	 G5Yf20j2LB6yyA8ptndrLMibsX4Q2mIWDV+9cSEIUjhPH5OERuXWRG5QxJPQkDR0qyJEo
	 EDhOY7Qqr39/u96dylWzAJg+v/1GdxEUSyaklqeuZaycH+F0hSyKuHDRlrQc4vYnpq5Rp
	 55NSJ174Hhg71iiUhNMR/WOFUygs5wh27sduR0JkgsahGEzNOIByoOCORM4g0lzRcVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="dgI/SSV1";
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECD660A2605
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 20:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ECD660A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dgI/SSV1
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9441591aa5cso279230085a.1
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 12:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794341467; x=1794946267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=on48w80Rou176JAdjsPSGWQMmQDfqhFmi5vMFS9k5gg=;
        b=dgI/SSV15f7OOipsBzaEI8JwMpA0nxu9BWiG7niGGBCFFz8LLa4LgLgIItY6xiwMDM
         XCyDBW2E7BYVtmDNbCiG03uMwUz0sfAACJos369yD2vsRiaxERVTbUfdEnmFMPVJ8WA4
         HdCI+82mGt6S5Tz6DYIjJDdJaj4/+J5QLdIlcuQWbwwFkpe4MrZyokjyK3V8o0g9uPcP
         O+P+27cJwxzrPuuQgxRw1koWJ1VepBJ3lPymvF3V5Cu3BKIv4kDDAAjND60C+AIU4+Ac
         nOGVPzf0bwvmcvTyK3B9axKCDPYe3fa0gCeTDv0TG7uBXaXnB5p+e1QZ0GQej11wFWjY
         uciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341467; x=1794946267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=on48w80Rou176JAdjsPSGWQMmQDfqhFmi5vMFS9k5gg=;
        b=b+PhCWU053fbAzJN+K4OR9wLtulI9w8b+Et57yBY1MW2aZmIKUqosDVewcXLIvbaAu
         Wl3zRdvzVl5k+wzGzknWfsVxobfAjhp2Cbq1qD2kcgTQEyEazN0KB1JQ03n+SOUSoqfD
         gZMKwemTYh3C+GFvbbaQ0zYtyKWvTu5oxqGMEq6QtJPnSSi82RHmKOT8RAes5NjexlF2
         PeRKBvrFmyvnzKSjaPKNSkb0fefSEVGy+d044OfIRhmCi/5/t8OTd41nIlOoxb0I+TOc
         JQ2iRRHLIU27vFzVbEDzskMYGiEF1vU7DEmBh6pxVHpeIGi3qirs+XRmFgA1+CIRYdGn
         uSEQ==
X-Gm-Message-State: APuU4Z/rP7Js5UbjVJXtoy7ajeDHIe9ZgDKcIHABQL83ZOgPZMLDiKMV
	MSJ2yNQKRjzl0wFJHSFNFwh9qvjfZOZDWqxOW8AXPIMo01bfQEgehOQR7nH4+Aca
X-Gm-Gg: AYBFou3RBxupOmAEKrztX7H1tx2RXYd6QBxRhTqUZmEEoELZlYzBC3xTZ4DrIoiQGB3
	xbqMR34fF8jOqKSfpKO4Cyg/4mXd/JBjNfE8KNWIsk0YbaqVT82/gkDEo52VNJVtAOAyXfCXbwi
	LojEAk4LvHovxImAsVd/wAs6PvDEMBfipR+oSh2oyqzaUBbF8Vv8pZP2MHAqUxKR8HdbCOiZkSq
	hMHou41yCNQPO/Em+UE8ygRezM6f3InPRZ0kNZ290belSgi+NdraR3r2e8WzU/SMVb5MfIyjRMc
	MQiRM9XAWfXqTYf5NEtzJH3BQ20j1fU3AUrPuxx1sKZCsaAsU3lIfts4vQcb4tEVDSVwQUNa64O
	2mh+vDG13OTIw+LXhEaLEPXAhrCfoOtrwBdg7ZmZAVsPLX5PrOv0Nf5Sou6m91SEzSDmxzOZwLx
	ufFYe4+1m8nfOHu95A2pCR2M24tETYRDqRsmvwN6DsWGZVNzKaD6a2XfM9HQsqZiKqTzieYw8/Q
	1vfLSEDIyb3+DuX42Q4y1u6TBdjAHT+gs2hkS5XXXQfFX5qosr0XuXsD0r4WyYoL14ZeaHBTo8W
	4C9oU2akT7Uzbhq/MrQyiBXdlQwEdpoBZFfVppdKOE2VN/qZBC8aIZFVSOmbTd3wHbdLiYsItQ=
	=
X-Received: by 2002:a05:620a:46a3:b0:945:d7a2:4b57 with SMTP id af79cd13be357-947afff049emr9749085a.21.1794341467313;
        Tue, 10 Nov 2026 12:11:07 -0800 (PST)
Received: from zambezi.front.sepia.ceph.com ([2a02:8308:b10e:9400:faf:460b:2f23:8f6f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73c84bsm301815085a.9.2026.11.10.12.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:11:06 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH 3/3] libceph: include current latency in debugfs osdc dump
Date: Tue, 10 Nov 2026 21:10:16 +0100
Message-ID: <20261110201025.255594-4-idryomov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110201025.255594-1-idryomov@gmail.com>
References: <20261110201025.255594-1-idryomov@gmail.com>
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Post: <mailto:ceph-devel@vger.kernel.org>
List-Help: <mailto:ceph-devel+help@vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:ceph-devel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For regular OSD requests, it's very straightforward.

For linger requests, reference the oldest corresponding OSD request
still in flight and in addition to that surface the otherwise unused
lreq->watch_valid_thru timestamp.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/debugfs.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 83c270bce63c..b068e25f2acc 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -219,7 +219,8 @@ static void dump_request(struct seq_file *s, struct ceph_osd_request *req)
 	seq_printf(s, "%llu\t", req->r_tid);
 	dump_target(s, &req->r_t);
 
-	seq_printf(s, "\t%d", req->r_attempts);
+	seq_printf(s, "\t%d\t%u", req->r_attempts,
+		   jiffies_to_msecs(jiffies - req->r_start_stamp));
 
 	for (i = 0; i < req->r_num_ops; i++) {
 		struct ceph_osd_req_op *op = &req->r_ops[i];
@@ -255,10 +256,17 @@ static void dump_requests(struct seq_file *s, struct ceph_osd *osd)
 static void dump_linger_request(struct seq_file *s,
 				struct ceph_osd_linger_request *lreq)
 {
+	struct ceph_osd_request *req =
+	    list_first_entry_or_null(&lreq->osd_reqs, struct ceph_osd_request,
+				     r_private_item);
+
 	seq_printf(s, "%llu\t", lreq->linger_id);
 	dump_target(s, &lreq->t);
 
-	seq_printf(s, "\t%u\t%s%s/%d\n", lreq->register_gen,
+	seq_printf(s, "\t%u\t%u\t%u\t%s%s/%d\n", lreq->register_gen,
+		   req ? jiffies_to_msecs(jiffies - req->r_start_stamp) : 0,
+		   lreq->is_watch && lreq->committed && !lreq->last_error ?
+                        jiffies_to_msecs(jiffies - lreq->watch_valid_thru) : 0,
 		   lreq->is_watch ? "W" : "N", lreq->committed ? "C" : "",
 		   lreq->last_error);
 }
-- 
2.55.0

