Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE5035295C
	for <ceph-devel@vger.kernel.org>; Sat,  5 Sep 2026 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620722; cv=none; b=gPVfwd0Bh5/0bbnmPNpwBpPyr/ynorlBU3IJZ+N5XhrCmXAtYjQJvZZt9ZPBpHCxG4kWhbvtMmh8WrZ/Tbb5VGsOEvN+RaaaSWRN8wHab5nIqxxs2QnvqerZlyENsEhRApQhvkWnwHG9VeBVBmlpKpA9o3HxjiAEiT58If4mgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620722; c=relaxed/simple;
	bh=zMGONik6vtJxiMuqeXBUMSsS91Q54mfzy4oFqafd1+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcSo941r+OKfG8lMFjf7gAijgCvtqfJJmM0fE0ACoyUqWRcdm3wObRrSRqZiYaeGanaGyu6lf0zY+6Haa/L2EiV4ulN45v/uOSn0TbfHCehAbr1mWO4YYgAF/rEsr6sgmrlLMrpDqfF5yzWOqfk0f4geoZXvF/oSiJxTZ/7O9dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C6438rvc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tife7G+s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C6438rvc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tife7G+s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788620719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRsdlaiL2JYwESMwJPo9WK/rTMylfFEh0dws5dSLdHs=;
	b=C6438rvcaNb7c7QyRRZdS3Znmw2y52WvsJNjpdezbvFXSKLuWhbizB7jrPKOG4Bxfz0rr6
	57atijfHZMC6S915jAYHyqsoOdEkwbqczuJpmZf4+a6uBthaBWGvgxQj7jGNVCJ76cc213
	2lBFANeq/ZH7dVGkYJmQOHXPM1TBxXU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-v5QEaR5-PzK7SKmDjPdJJQ-1; Sat, 05 Sep 2026 11:05:17 -0400
X-MC-Unique: v5QEaR5-PzK7SKmDjPdJJQ-1
X-Mimecast-MFC-AGG-ID: v5QEaR5-PzK7SKmDjPdJJQ_1788620717
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-910342dc2cfso23566276d6.2
        for <ceph-devel@vger.kernel.org>; Sat, 05 Sep 2026 08:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788620717; x=1789225517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GRsdlaiL2JYwESMwJPo9WK/rTMylfFEh0dws5dSLdHs=;
        b=Tife7G+sAPRUEmCrERC+jxrDweIAN6hcbGpTbkEdeP+X9WWHBp9tLjrlh7JVw4a5ps
         Jv2Num/stIv9G3vNEXSIPIck1qv8o3xXvnX4pplD5EC3fHcP0GCgSwS1GOBSA6KTLncy
         O6XDOcowpwMeF5jG5OLklLeFpg2KSM2jHy9zPjTA4LTDIUhmyFjzld8XR776pBGYU9XF
         u86QLe5xRqIgT1AORoQ1SGScA0pescww5adMSBWS7Hfud7u7bGfUu8PqcrZviI8EYuXm
         aWJqDjQlDcJX4G1L/Vr6WKr3nJDPi68Vrq2uqlcsllmo73/DGMPzjk3JEPRQVYi7ZRQS
         g6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788620717; x=1789225517;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GRsdlaiL2JYwESMwJPo9WK/rTMylfFEh0dws5dSLdHs=;
        b=fdYLEHSczzwwBWiInx7rNLjNa2aDSwBLB0Aqq9HYjzjwIJq3TskhXYEOG9A6/S7CUS
         rAAk0BXxKHp+CcAnzqhk8+ZLNcxnreHMc5apGYMb9PZVX6yiK/QBQstOGudO3r4VVnhH
         EWybpuAKAyuNcpvK0t1O+asx6BovxP8DBIB8d9HbdO6weBakvlx1MD2xPSnLXOMoILZH
         avuBfXH48O+wztKFqV9YFo6Mtyz2yvImujWrULkYHvO308d4+VFnJFHz0tG1FjIv0Rb/
         nHM0hjzOhtQ9MDjzzcFZfx8SfpgO4U8S0/xab1EI3JdnNXOvBj+V//67gS75ZWemzIZQ
         eE2g==
X-Gm-Message-State: AFuF++lt9u+3UxX18zCYKvUwEicmG59EX0a5ty66qQIMANKqfo/vCAVx
	1zx6zDzGzvHR9tTk27AoltN87mTX4rTa4z4I05HFJDLQneT4BGgZPg1nEF91vuFKsc4vUEPbv1u
	m3waHYSrn5j+nouZsRCMBvpowqQEsHnNliWbuC6nwLQu+TgckmhaRG0bSrJnUCYc=
X-Gm-Gg: AYBFou1G04+vz5gWP+ZJAzzsFjSNMCO4NunQXMTFIichCfMxBVTIeQ0ibJStallzEfQ
	7D1VNG5OhfA2uu40acphnJ6bvLztLQXaZFvPvPQWWle6AQUdc0Ifc19uBS3Q2MyVonjwfKsJsr/
	1DpUz7Ck7p/hMIl8KnNStQw4ym10Vml/Y9oHocnd1VcBmyT/sxlT/wOvk/G/GvEUFoQLeXLBGss
	ZIHe5oGGoq3UmKFrMk280RZxkmGE+iEinwNuui7FA6hKWtdLyWyyM11aQy2CLLNzlFlE59VZd39
	zuEKb1b25S6uJrwB/PziQAFOAfcw61K/kHL6Xz9dPGBzq1mGEX1GZthlwyXiEi4TKlSZKyIJxbh
	MNjAzDYSkGSf0myPmnkXYVf8DuDKEKWqpR4I5yF6mwi8Yuv4EMBw5GwMtOgwXXnlsv732OvE/GZ
	KMOSVU9CiJdqgfbQ==
X-Received: by 2002:a05:620a:3722:b0:939:3c0:7520 with SMTP id af79cd13be357-9398037b9a0mr1266547185a.18.1788620717277;
        Sat, 05 Sep 2026 08:05:17 -0700 (PDT)
X-Received: by 2002:a05:620a:3722:b0:939:3c0:7520 with SMTP id af79cd13be357-9398037b9a0mr1266540785a.18.1788620716709;
        Sat, 05 Sep 2026 08:05:16 -0700 (PDT)
Received: from cluster.. (4f.55.790d.ip4.static.sl-reverse.com. [13.121.85.79])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb566a8sm468675885a.25.2026.09.05.08.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 08:05:16 -0700 (PDT)
From: Alex Markuze <amarkuze@redhat.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: ceph-devel@vger.kernel.org
Subject: Re: [v4,3/3] ceph: don't unregister an MDS session before removing its caps
Date: Sat,  5 Sep 2026 15:05:14 +0000
Message-Id: <20260905150514.3442861-1-amarkuze@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260904150304.49104-4-max.kellermann@ionos.com>
References: <20260904150304.49104-1-max.kellermann@ionos.com> <20260904150304.49104-4-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Max,

NACK. Please respin.

  1. fs/ceph/mds_client.c: ceph_mdsc_close_sessions() still unregisters before remove_session_caps()
     Max, 1/3 and 2/3 look right, but the series is incomplete.
     The teardown loop in `ceph_mdsc_close_sessions()` still does
     `__unregister_session()` then `remove_session_caps()`.
     That path is also reached from corrupt snap-trace handling in
     `ceph_handle_caps()`, `ceph_handle_reply()`, and `handle_snap()`.
     There `mdsc->stopping` may be false and the mount need not be
     fenced, so `__do_request()` can register a new session for the
     rank in that window — the same race this series is meant to close.
     Use the same CLOSED → remove caps → verify/unregister ordering
     as `handle_session()`, and wake `mdsc->session_close_wq` after
     unregister so `wait_for_mds_rank_not_closing()` waiters can
     proceed.

-- 
Alex Markuze

