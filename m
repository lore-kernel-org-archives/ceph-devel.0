Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500774;
	b=lwMUEOItslzo0sTzvZ3pGBaKQSZ4eeTwRcolceSnVTcRjgDCHk1Vm+s72QVtTZ8A6Oxz
	 mEXgm92OyEHfmn49ClRXwBQFZHxOBnCKhT1pcjEX7uDn4quUc+7zYlvBCdAwKtqgmxCuA
	 wIc/YCnixAg4o0PiLUodalW8K4PAzey4e0lpzhAZaJuoMemL5MjavjkEvO362lRpopgbX
	 5rgmKp5JGreyKyK3WvfLIvTGxH4pySu4cKjNutlbw7laPLUHNISANgBMBrmKC0oF45Tsn
	 bPBpSUQLU6g5M9F3DtL7KX1SPu+ATbg5yhsCWsXUUs+/1y13tbMxD8aPs+H32Fu4GFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500774;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
	b=fVws60aEN/mz7e2Wstz8Jf0syMUp1IrY6urvUzvp56DXjI6OHnS5H0wKX/hEZY67cSVj
	 z4TFFiSLlqeby6GtrC/DiZ+x5KWH0/Nd5JxttDi4KagM87pqUHeCaTPhBZCLb3VRB4jl5
	 Asw2zoveDe2J9/Cry+BSE/SxE2JS0/6IBMwbKty+lKIhHRUqxeRV4qjRH1tCxOvkBMY/s
	 88MTfkJQt9SJdQkT4/O7OpDVV0jjyxKzuP4CUNDLdI+P+QyaYjC6jSzsVBSZkHOR8rjl2
	 fCoeu7SP1ELO8xbHJcHDKjcTBf7V6iS14pAGE2DIkitjqpgOW64Hpja2pgiccwSz9Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ghSX0mrp;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sJcYLhdB;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC11606A32A
	for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 12:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9BC11606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ghSX0mrp;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=sJcYLhdB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792500772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
	b=ghSX0mrpMwbLCIP4GqRTHDNhkQqDM0peYXfo9FQPD485NE9nng4vozE6DV5PUD0oqgwaxw
	/STySalzdl9cWMF5LYZByfFbgLcbokqQQXiTSy2m0KILlXW+CFygXSX8+uWzGJE2E3dkC/
	/3LAtgOjlLUheGrC05IhwaNYh6unt80=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-zKHNanQ_PB-iACNOB3rCRA-1; Tue, 20 Oct 2026 12:52:43 +0000
X-MC-Unique: zKHNanQ_PB-iACNOB3rCRA-1
X-Mimecast-MFC-AGG-ID: zKHNanQ_PB-iACNOB3rCRA_1792500762
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b1d43907c2so3612899a12.0
        for <ceph-devel@vger.kernel.org>; Tue, 20 Oct 2026 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792500762; x=1793105562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
        b=sJcYLhdBPlyCvITcjoMJCirtD3PPzZMPnNFxOe87vaVuhpHrIXWHIkuOu2iY/atHLh
         1JF7UuAGdokQTF27QVDwaogPAJj2p+i45CjQ82k92qVljM2CEAu4L1dtWpdcRnWg/nkw
         g5Fkgi0hcuM9hVOl68ideiHl0TGGwq+HjvnkrUPd9xztWqSqPwpQnDjxVrygB6s94SWm
         H6chIRaxCIEQ+keh44j1oAS7Bfjb2Ij3zS3txZkWltNNArc547Dqio+kmRJV/l6P3csv
         dbQjXRPRSp8Sp5p7+PkBB2gvF1Gn7wdPhCy0WReEFI3bOtSYOC3s6w5dvuTQJOBVNQgw
         JCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500762; x=1793105562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RRNHwuzxK2uMbz7SC9yJ7WKgsG9c53Ltjg56svJJIY8=;
        b=oXBrUJK9np/fAU3GSxHHh7HKVojZE8F/C6cNze3hc+GIScr4y+p+f6G41D4x+6Q4Qz
         4BL1fP7qcARU3IimFaZXnFPEdVmcILq/YvwUOu4fjE3e+dG2vIrD1gL7KLASbJWUMujR
         hlW61QWVy1Bf7TWZyiTFigbQ020XSvHuuH2hO8iukIo+SxnMU3dHwHbO5Fg07RRjbZA+
         6KvmbCJ+oEYz/zJwSEJSQl8ZLyTO27RppLyIEkdi3O8bwbbjNZfMaaUqkoz7QdMclsS0
         EGoxO+5at7Jp8zFCguCNrroQGMvDcgqbA00EbtAHYGvG23Oc6IXiDaB7wYg/q2wvzbsh
         TXXg==
X-Gm-Message-State: AFq9FYIaEzBMyPyTFPlsD1yiUlQkBrlkOPTWj4RGybQucJBOYxLI0DAz
	uB548mQ6l05Q8lJPLM6A/6DWeVWqvt3VTi8rFhRule2nzD7XWzizQSJriRJEJ3Zp/F5SKVjSIZV
	C4CfID1HlO/JfO1RLttAVBvWAPE3QLyHmQSuQmX0UfNziWZ0BquEeaWqH4DUNXcx76Mb3TuTast
	l6QnR7h1ieYqat5p5W6ie4DaLwwEi+NLrv0VJgvd4GcY8r405ftQ==
X-Gm-Gg: AYBFou1KcRapEON5XN8/g5YpykAlACD9/CNeZiMjcR0fX7u/gqLih91B7GrLzBotUpj
	QdKyWZtEYhkAC8+AqIqtliv2yiTQYNEHkHU9qg2q/z8CXyvJsTiaSdF23kEhYdAfNET2OvtVH6R
	4YL1pQnQG5ldC3Mu48wYNC+8PQYjoY6XJ3WofYIAp16V8KhE+F4AwPdA2OPGlffwvnwLxUCxXd2
	Q7uaXfCBWSqYJY0KqgtjWNiWQ7RqD9ZPgCooJW3IwE1w44c0nPY0DkfedKc7TpnMYDWHi6VW3XB
	zoA9SNHv6y/dwNhKZHmIDpg6pbudumRSk99QqQwGyheQgAzvUPHvC53FvqVjJuymTIAcaHd/S3F
	TdWrs2+A6/dXp9iHdtZc0YP5Bna3CfkH4DVCkIH9BlAfUe0WCn1oh2eD8KvN3K7jN1eUU1zssDi
	rIJwxh7UFGAhvpzdL/BluyLssha3GvjNWUc8G1FnFf8KS/ZA9BjVz68UXLYTGkR/MZgQxjwo4rO
	T0=
X-Received: by 2002:a05:6402:3206:b0:6b3:b648:3170 with SMTP id 4fb4d7f45d1cf-6b3b6483f02mr6091849a12.4.1792500762177;
        Tue, 20 Oct 2026 05:52:42 -0700 (PDT)
X-Received: by 2002:a05:6402:3206:b0:6b3:b648:3170 with SMTP id 4fb4d7f45d1cf-6b3b6483f02mr6091819a12.4.1792500761744;
        Tue, 20 Oct 2026 05:52:41 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b3c74eb8a7sm2982781a12.2.2026.10.20.05.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:52:41 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: ceph-devel@vger.kernel.org
Cc: Alex Markuze <amarkuze@redhat.com>,
	idryomov@gmail.com,
	xiubo.li@clyso.com,
	slava@dubeyko.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v4 1/5] dcache: export d_find_alias_rcu() for modular filesystems
Date: Tue, 20 Oct 2026 12:52:33 +0000
Message-Id: <ad1e9d2c5ba4803f1c7dafc6687638b0489a7265.1792498351.git.amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1792498351.git.amarkuze@redhat.com>
References: <cover.1792498351.git.amarkuze@redhat.com>
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

The Ceph subvolume quarantine ancestry walk needs to find a dentry
alias under RCU without taking a reference. d_find_alias_rcu() provides
these semantics, but it is not exported, so a modular Ceph client fails
at modpost with an undefined reference to the helper.

Export d_find_alias_rcu() to GPL modules so filesystem modules can use
the existing RCU lookup without changing its lifetime rules.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610171220.i77KPiw5-lkp@intel.com/
Signed-off-by: Alex Markuze <amarkuze@redhat.com>
---
 fs/dcache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1b1a81f10da6..13ba553081b3 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1248,6 +1248,7 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 	return de;
 }
+EXPORT_SYMBOL_GPL(d_find_alias_rcu);
 
 /*
  *	Try to kill dentries associated with this inode.

