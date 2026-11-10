Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341466;
	b=kyXldQZa6+Zc91ecT5xQH0y7Ujaxu9DtcmqNL5xbbHrm9aWDTz3pgUmyWk1eIsoJIKJt
	 sbb2XiGW6BFBbThNt13lSdoAfC5y3oH9asHumseOwtrpiFZVmAs5FJO6wNsI3O+SZPzxq
	 UDx4GoVoPeehW7OWlSv0wwjtrFZnEqaByC6tyhI3laIaxEcuQhkMWkQJlZo5lr/nL38+n
	 4lmqK2Nd61Ser9SVrfIF5/z4rhMOuOADsmQM0DXPsuyrV6LZmWlePa5pByJJVcfS3XV5L
	 Siip15l3q2uFmPWM7kGJbLrasy1nLWUkiK9p+9/YN+36+vrPdIIdiQFd6rXfE8AAdPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oD7V5JnOTBsRPWmIXzAKOsRS//p2Ym79gsdNorj5/Ow=;
	b=avzuIjwf14fVkuKIT1L94jbQgsHMHnIvmELewz01FrylFZOZ5DxBBUyEvOURKCYT1O2f
	 iXmeNM8b+4MPzvw4kBMw7EQbp2XA8kAc7vf6QK60RovEILGHXnPO+x8URAfkvSjuuATkz
	 sUKwq/G56TnkTMUKpoQ57/O+6QdQj3/DxV/TV3ydqXQykblqbvL1+8AjzpK/zckw+hgpx
	 Br0uD7e9+JUNwOlofRnG0A3806HK/0m782rxh1nJsfQVWOCfTSaIyojXMiXxPsVgQo1dc
	 LDpDfR6Q1iU1L+6XGmVdTqMWmO9SCe2HzeAA95GqyHVhuFfRNUVtO9CdTEJkE2BoSPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hk5l7OjI;
	arc=none smtp.remote-ip=209.85.222.180
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05E5606A321
	for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 20:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D05E5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Hk5l7OjI
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f1e5d7450so238530085a.2
        for <ceph-devel@vger.kernel.org>; Tue, 10 Nov 2026 12:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794341465; x=1794946265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oD7V5JnOTBsRPWmIXzAKOsRS//p2Ym79gsdNorj5/Ow=;
        b=Hk5l7OjIvcHezNMlIIc023p3FSXgw+1evRUTnVlwDSeHXedeQkVxZL0RyVeYAGfNqr
         TTJ+JJh6y1m4r2O1cTVqEBEiAtFQW8668xM1rm/+bG1OVTXnCUpQUZIjSHJZeGiVmgwl
         lh6WbtSwF0/rKJfW3IBJop3E3ZJSJzYctJPM0hjAdsRPMebqSZXDtOE45gi8KYpy8tFu
         gWUxu04SGk8cix4l085bwi+zwldNewM+fOEuTsEcpkfuRJZNiS8uUafyIQt7/amDGVNh
         rHZDceTSTjV2/vObt9uHPlfehN9aHdOR7N4GKEJLZYIQhhGe8+FD2BeX64yMIl4fhKso
         cSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794341465; x=1794946265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oD7V5JnOTBsRPWmIXzAKOsRS//p2Ym79gsdNorj5/Ow=;
        b=tiCnIyzRfGxr6n5bGk76iz7uT1kJ46fcYJDqB4QxNhCf+HFUdFRa2QvSuH34RZP0f9
         KqobPwIP9dp0Q2KyhxZfX/s6w25xQ2Ppt2zi6EnTZJ4Rgdbyot7N56101Hz25+rPW6h2
         EtwOnpzcS3tFIoOaZPSa1D+7PQcUA9N3AmWjSPIep6MaRh3kqFC6l6vQVcIJ88htK5fo
         cRVg/IkOeeOFDdqvdxN+k3MBF1OkQZrWaZu+7XpZqP9BnlaLYqYWfrgAY4P/7I7DTTx1
         lDc4hszXXxFcXhDkqDiUK9eqOkSWnou9i7Zn31eX40ZlgpOSFC9j6BEONU/rUspc8USX
         u7zA==
X-Gm-Message-State: APuU4Z9zDBDuP0TJgrM2fWMG5diR3Lns/FLED89UH5AR72NAOeGZNbEx
	aXwDwliUCJV++c4QL74Xwtbw2qaU/wQEA8c4ITEf74KuzP9kbLS6oxCZf+5rU9sK
X-Gm-Gg: AYBFou3dwsC8yQbbQAo6v6XOp4Vlvdx9Ovu7PV99PN4WeGdF1eFaq2FXpBUEmFgM4qC
	KThkztkHmjzhvtlpqeziksuMwngb/YkRBkM1DsQDbEO1Wze4ZJfdU1coPgAQxKMavScPbB+2IDf
	5v2ji8Xz6o4pPPuwcLqXzsRbVPKet3jfLyGHw3WJvxYO5RPozfIJighZiZnKLVQ6MX6HkzgoVFM
	hq+SyRnEe92RQBvEs811IqNPy34z9uC4vdqkKsIo5XhGdTaJjwHtzZKYwR4vvJD1A483zzz6z+Q
	FnZLLNrhOFGgGPX07jJ82lujvfOKcWpH1tSDUN4rdnjvDwiqL0Y1mn8I7MeUR2//dI7NB57LTOZ
	T149Ah/BtEu3i+LwXjz3QF2uNUE7ZDTkcpRbHzuADwadeCQ3XdN9HSL2wMNQKoRLH3sraaLZm1f
	HwXy/aewQ6cb9eMYjumpU966/n71ybtlEEAinu9Vn+0Pwi4LZfvgLx9Anmi3FHz78gIUi0djA83
	M+wxEiPSBGxjZhADfJtj+HhfqiJtp3WSPNBvrSIgeeyZVSb2WaQXckf1WZSxSnBLawTkzNSrjuW
	645Q28vrDg9DlL6tNHmOvspuOglMme3b2tw5xm006V1mz6Rmx2J32/yuWWJc+LonRkWJp3Ow4Q=
	=
X-Received: by 2002:a05:620a:1713:b0:93a:14c:32ad with SMTP id af79cd13be357-947afa562b3mr23310485a.0.1794341464854;
        Tue, 10 Nov 2026 12:11:04 -0800 (PST)
Received: from zambezi.front.sepia.ceph.com ([2a02:8308:b10e:9400:faf:460b:2f23:8f6f])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73c84bsm301815085a.9.2026.11.10.12.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 12:11:04 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH 1/3] libceph: replace lreq->ping_sent with req->r_start_stamp
Date: Tue, 10 Nov 2026 21:10:14 +0100
Message-ID: <20261110201025.255594-2-idryomov@gmail.com>
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

Eliminate lreq->ping_sent by making more use of req->r_start_stamp.
This requires setting req->r_start_stamp outside of account_request()
but it only has one other caller apart from send_linger_ping().

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/osd_client.h |  1 -
 net/ceph/osd_client.c           | 14 ++++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index 50b14a5661c7..0847c522f897 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -316,7 +316,6 @@ struct ceph_osd_linger_request {
 	struct ceph_osd *osd;
 	struct ceph_osd_request *reg_req;
 	struct ceph_osd_request *ping_req;
-	unsigned long ping_sent;
 	unsigned long watch_valid_thru;
 	struct list_head pending_lworks;
 
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b8e4740d07fe..5053363134ee 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2482,12 +2482,13 @@ static void account_request(struct ceph_osd_request *req)
 	req->r_flags |= CEPH_OSD_FLAG_ONDISK;
 	atomic_inc(&req->r_osdc->num_requests);
 
-	req->r_start_stamp = jiffies;
 	req->r_start_latency = ktime_get();
 }
 
 static void submit_request(struct ceph_osd_request *req, bool wrlocked)
 {
+	req->r_start_stamp = jiffies;
+
 	ceph_osdc_get_request(req);
 	account_request(req);
 	__submit_request(req, wrlocked);
@@ -3195,11 +3196,11 @@ static void linger_ping_cb(struct ceph_osd_request *req)
 	}
 
 	dout("%s lreq %p linger_id %llu result %d ping_sent %lu last_error %d\n",
-	     __func__, lreq, lreq->linger_id, req->r_result, lreq->ping_sent,
+	     __func__, lreq, lreq->linger_id, req->r_result, req->r_start_stamp,
 	     lreq->last_error);
 	if (lreq->register_gen == req->r_ops[0].watch.gen) {
 		if (!req->r_result) {
-			lreq->watch_valid_thru = lreq->ping_sent;
+			lreq->watch_valid_thru = req->r_start_stamp;
 		} else if (!lreq->last_error) {
 			lreq->last_error = normalize_watch_error(req->r_result);
 			queue_watch_error(lreq);
@@ -3218,6 +3219,7 @@ static void send_linger_ping(struct ceph_osd_linger_request *lreq)
 {
 	struct ceph_osd_client *osdc = lreq->osdc;
 	struct ceph_osd_request *req;
+	unsigned long now = jiffies;
 	int ret;
 
 	if (ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD)) {
@@ -3225,10 +3227,8 @@ static void send_linger_ping(struct ceph_osd_linger_request *lreq)
 		return;
 	}
 
-	lreq->ping_sent = jiffies;
 	dout("%s lreq %p linger_id %llu ping_sent %lu register_gen %u\n",
-	     __func__, lreq, lreq->linger_id, lreq->ping_sent,
-	     lreq->register_gen);
+	     __func__, lreq, lreq->linger_id, now, lreq->register_gen);
 
 	if (lreq->ping_req) {
 		if (lreq->ping_req->r_osd)
@@ -3251,6 +3251,8 @@ static void send_linger_ping(struct ceph_osd_linger_request *lreq)
 	req->r_linger = true;
 	lreq->ping_req = req;
 
+	req->r_start_stamp = now;
+
 	ceph_osdc_get_request(req);
 	account_request(req);
 	req->r_tid = atomic64_inc_return(&osdc->last_tid);
-- 
2.55.0

