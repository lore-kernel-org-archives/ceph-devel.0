Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795399964;
	b=WvLfiLCjzVdMyPCzaEtvMH5sFlxjnJuzPSxz9fliHa4ruKcRx4S0iU/mKiv7h+3G2AC3
	 abR3V2G8z7Vw3KbEQd/6N6m8lQLmGJkYKTy0cEakrMQm3nNzMRcp86N2TohMhXLXReLCj
	 hFxG11QTXFHerPlKlZJjdvN4UdMu8Yy/raPhwAaMFn2L8uZCTFrHCOncGG1ge7xeX+11C
	 yei+v1hyLOPuC9yRkZaW+sQ3vwmDWSaqU8AkJsh0HV8HPoPJPqFA52bQ/ssJ3LHcuM5cT
	 Ti+5mMr0egsb2zy9Gf+TqJj2l7t3mDIF1cSCPWFkKR3kh0A3T794HUZGmoA8XyrzCqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795399964;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-FangMail-Miltered:X-FangMail-Envelope:
	 X-FangMail-Bounce-Flag:X-FangMail-Outinfo:X-CLEAN:Message-Id:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=7snh2fjiFQLdPh6oxCsIhUHa07aswWP9dgfjblyJRbc=;
	b=Z1S9GrVEnoqAi/jd58YbG7kaH9eRo//tJIWiyJ4YVeYy8xz78MpEEiZf71HkrPJ3X6Qj
	 Afus61KAuGesy13ZwnqvQIvnfseba8ntKWbtr2XtyFiasw7n8DSblD72/mUZ4PQ0c0m7Z
	 O8cjJ2105r6vsb2El+S4tdfcdWxvS2BnuK42lhSS3B+c5cz7S+NcVpp8qDcBizJzPY3ka
	 gMRulTrbY8Mp2vOciqs47nLVW5kQzvJrTN6ZIj/LxkAXcYoaDoBBJwr8kGy61bSiC5DR3
	 Nv4Zt1OEJLhGJByP9QFcFTFuVmPB0TTFFzFxhGLUxq7S/IOb5j4W0NvbCC22m1KPcoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BC8606A320;
	Mon, 23 Nov 2026 02:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17BC8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jXqGJ2LHfz22gV;
	Mon, 23 Nov 2026 10:12:40 +0800 (CST)
From: Daolong Zhang <dlzhangak@isoftstone.com>
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daolong Zhang <dlzhangak@isoftstone.com>
Subject: Re: [PATCH] ceph: add compression_hint mount option
Date: Mon, 23 Nov 2026 10:12:39 +0800
X-Mailer: git-send-email 2.48.1
In-Reply-To: <1795369032.6B032847.000.4jXbqX65jvzcYb@fangwg01>
References: <1795169573.6B001D21.006.4jWB3k0l79z3mds@fangwg01> <1795369032.6B032847.000.4jXbqX65jvzcYb@fangwg01>
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
X-SOURCE-IP: 221.226.109.28 unknown Mon, 23 Nov 2026 10:12:40 +0800
X-FangMail-Miltered: at fangwg01 with ID 6B03A118.000 by FangMail milter!
X-FangMail-Envelope: 1795399960/4jXqGJ2LHfz22gV/6B03A118.000/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1795399960.6B03A118.000
X-FangMail-Outinfo: 1795399960/6B03A118.000/4jXqGJ2LHfz22gV/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1795399960.6B03A118.000.4jXqGJ2LHfz22gV@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6B03A118.000/4jXqGJ2LHfz22gV

Hi Alex,

Thanks for the review!

Good catch on ceph_reconfigure_fc(). I will track whether
compression_hint was explicitly passed in struct ceph_parse_opts_ctx so
the existing hint is preserved when omitted while compression_hint=none
still clears it, and rebase the patch onto the latest ceph-client
testing branch for v2.

Thanks,
Daolong
