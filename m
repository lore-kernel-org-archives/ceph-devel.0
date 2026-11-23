Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795396941;
	b=2nu17LCqoRs8VcN8GVW8FMjQROoVm/XzQ6SvwPRgQ6yXHuyHgBfDw4jCvLeEGOivFlsI
	 DxN5m92OGUUFJX3+f3ogJBbUDzheE7Ud38XA9S2jnd2xi32WREKEW0FNTN7/aYzHdQqo5
	 hlhZE3dmCn2QwyerXnuQt1zdjXWYHnPHoduxsVHQ7A78BtCXIz6t+pvfzGksXHsqDjjBA
	 unXYvoKsXZ/uURj14HVRR+M/55VL68h3GLIZ3jjkrEKOPU/5/aK1GKxJJxRiWu2smBLGo
	 AJyf6c5vdFIM53reIA/GhnFyBKSKt1JTPCq3kVxZPCtMhUJQvZ+e8FmLyjFkhgtl3yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795396941;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-FangMail-Miltered:X-FangMail-Envelope:
	 X-FangMail-Bounce-Flag:X-FangMail-Outinfo:X-CLEAN:Message-Id:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=sozx49Xtni80QJxBhW4H+JcO6t7+xpCi7n4VKz86+/I=;
	b=IIcaJTcW1JY/ZGOfSp2jsaAOn5HGYX6mkOjw10MatiOx3jCieZl7XXV2mbOIs3Wkoto+
	 g9D1X8R1xknYnVUKrN1eBvajys5N6xNmv/9uImpiWMRUQTqTYKKgcjDt9KGCBFz31I4UT
	 y3dVAbRcJ/T5G1Gz7xmTmfEZPIDqydC3svlLWLJqrx9zG0o5u+dCNlioDxDLkl3bW9JlX
	 /giGP+cWXbH71HYxh5JUyZUpsEa9nl3uEl5fhlhhx7quOmD0Bee5pLwqBwExsBy+cX4t7
	 Pf5qcCU6FThEpe6kfPtMSyEaJFc3Io9NIZvSOAPiIhawkFX8t4GEATQKRDWleCmYTzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23466606A31A;
	Mon, 23 Nov 2026 01:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23466606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jXp830N86z3cLX;
	Mon, 23 Nov 2026 09:22:11 +0800 (CST)
From: Daolong Zhang <dlzhangak@isoftstone.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daolong Zhang <dlzhangak@isoftstone.com>
Subject: Re: [PATCH] ceph: fix inode and i_filelock_ref leak on file lock rollback
Date: Mon, 23 Nov 2026 09:22:10 +0800
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261122193828.1324376-1-amarkuze@redhat.com>
References: <1793858040.6AEC19F5.003.4jKs1y00vLz3CgW@fangwg01> <20261122193828.1324376-1-amarkuze@redhat.com>
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
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Mon, 23 Nov 2026 09:22:11 +0800
X-FangMail-Miltered: at fangwg01 with ID 6B039542.003 by FangMail milter!
X-FangMail-Envelope: 1795396931/4jXp830N86z3cLX/6B039542.003/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1795396931.6B039542.003
X-FangMail-Outinfo: 1795396931/6B039542.003/4jXp830N86z3cLX/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1795396931.6B039542.003.4jXp830N86z3cLX@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B039542.003/4jXp830N86z3cLX

Hi Alex,

Thanks for the detailed explanation regarding the race with auth cap
trimming during an in-flight unlock after try_unlock_file().

I will drop the CEPH_LOCK_UNLOCK check in ceph_lock_message() and keep
only the dst->fl_u.ceph.inode guard in ceph_fl_copy_lock() in v2.

Best regards,
Daolong
