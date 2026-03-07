Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0642DA77F
	for <ceph-devel@vger.kernel.org>; Sat,  7 Mar 2026 14:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772892507; cv=none; b=TmeyE8Rtx0t55VwIQAL+TMl7OA8Q3g1Ln3C6rZ4OaSiw9tsScIZD1BokpsJ6EASbqTkIa9+p4s1dA5+59Vl0zTM1hOMgkVZKhZMF0ErKTmu+VU6Om51c5hoVZOO0/FDINGpWh193lHAnveazKyBl5JuiqbuVIppW2QQuUNldprs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772892507; c=relaxed/simple;
	bh=QvKBTacd5z2P43CbYauz1u/x08KHhA7f2Nkz0BaL8og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auNqHAs5jAq8E0Y4gCPGrVi2xW9IxUNn9AHUjeb/FMVzamErd0DomL9DJQr7GIgrYlaFdiF+6h9NaQhX3jr71Nvm97+lLkdjgN1q9ug+m8sMSaZ+oHGEKRAXP08cN10IDLtBJs7eappDXy3iI4TZ5Abd6J2eCSfqDwLTYUbpFHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j//Nqssx; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j//Nqssx"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-829865a8471so2913830b3a.3
        for <ceph-devel@vger.kernel.org>; Sat, 07 Mar 2026 06:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772892505; x=1773497305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=j//NqssxmhWBwW0YhQ6oRJKXQKgH7Mm5iRu1CkmB9uAJThjy7Ri+Hm5kgYVax8wgxU
         +UiSCPbRDYmh9msupkwRVd+MrCY3KmKJ878jDQZpUKiuXCsPJeRY7PuCigR1DNraTI5p
         z/WHvvdCakWKH7pHOzGnWAWuDlban3rOoSWXObOlZXonYOBQOka2Nh2H7H/LUaGJvDR0
         9Bnm9J9A8yJGqN5yUcPhNskNZFnMQCuDaYUoXhhovrbijKW/LfR0WS40gyVoFsFoZihQ
         68emMB2bbpGFUnPqT/U76/ZLZZdPJhB81OYDfiYC55dxiZ5FysUZjZVK7t2DEiQDjAsa
         4DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772892505; x=1773497305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Vj99fOR8e2nvanig9cWTi+niKOe1ygt4TyyqPTa8nU=;
        b=awS8Xn0D9P+lgbDLErzFyseFXvkZcGoeBnHPuE5MfHV/AQVosDxyEo4W+a4qgxsSHV
         91paqFv8PglZTZFRMJaa56wRoIgvLMAnNkiNcyRDpSPdLuGQlEJiB9vs3QX7/4aiu1ip
         FwReOn79MeUfyo4W3OgHnOimpfydKhSoAB+4NtzHDS84WuQnlhCzs6anNLoU0zOFWPg+
         PlZsi1jpG1QxA3zyidnu063mqd9NC73pO+LSW4h7Auf32yFrzFltuMSTWD977e71kWlY
         dDD8HWGGP0C6vTE6KkwDxiTGQTXmay6XRQ2CxoMIAbjn3bo7scYpohFAAEgriNPWHQ5q
         qmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbS+BwJlgOJBpbIAqdoUgjeEK4DzHC4WrXX+Ms1qVOZv14BXHWy/SHMztGj5baqxAmWZ2OFE1V6Lv/@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/29iEFuoGKxbSaDDbRtailTSnfo/vb+DftDYfqwKCGHWYN+9
	CJXefqVj9k7upzzEJRkWujOgmoYXlCI9wt6sDf3ovVfVbCyO0R67VHXC
X-Gm-Gg: ATEYQzzD+o+YpHyW1bBOpaSm2sQ5ITaijsKFEf5Pc7uL9K/VmCvB9lGXHGxRdbt3beD
	kx6hfkin91MtfnGWFoPJF7Q/QVYf9gKHHo9YhIlncW+Kv+QP4SXz/a8t3QW8Zd2DKhTrEio19CD
	qSdIKoXQh2vNeAtTnI0qOOJKGyVHwqTFknw9N2axNpAIafvTNDjTPm2hC86MpzGyiHiWL+8Kd9j
	FUYEIN9/8R95pgS9VbRqBADZPxlfBvH+eJR+g/lSVODFiP/QeJxfg8ykTuLlEGfWHsFaXAAQzlX
	0/5Ke7dwcUh19xBJ7iZk66nQaSp0Y0L2caVcXXE7Yr78ktSuWHnJxQijwNpdGksHKYTIV4BQVar
	UMlUFYLaSqvPI/NJY4ZSvLys1LPrQmuaFas8PY80lHFfbc3jMdT8LkFgVcEiQF9YoXzzio2ENoy
	I3i8vaBiwv3jTFRgYX6WxyTf1kfwY2bQU6qZzrPgdagfpeuBY0tTD2BtY=
X-Received: by 2002:a05:6a00:1c87:b0:81e:d7c3:2f3a with SMTP id d2e1a72fcca58-829a2f5a754mr4767475b3a.46.1772892505338;
        Sat, 07 Mar 2026 06:08:25 -0800 (PST)
Received: from toolbx ([103.103.35.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48ddd18sm4747313b3a.56.2026.03.07.06.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 06:08:25 -0800 (PST)
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	jlayton@kernel.org,
	chuck.lever@oracle.com,
	alex.aring@gmail.com,
	arnd@arndb.de,
	adilger@dilger.ca,
	mjguzik@gmail.com,
	smfrench@gmail.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	davem@davemloft.net,
	andreas@gaisler.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	agruenba@redhat.com,
	trondmy@kernel.org,
	anna@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	shuah@kernel.org,
	miklos@szeredi.hu,
	hansg@kernel.org
Subject: [PATCH v5 2/4] kselftest/openat2: test for OPENAT2_REGULAR flag
Date: Sat,  7 Mar 2026 20:06:44 +0600
Message-ID: <20260307140726.70219-3-dorjoychy111@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307140726.70219-1-dorjoychy111@gmail.com>
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just a happy path test.

Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
---
 .../testing/selftests/openat2/openat2_test.c  | 37 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 0e161ef9e9e4..e8847f7d416c 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -320,8 +320,42 @@ void test_openat2_flags(void)
 	}
 }
 
+#ifndef OPENAT2_REGULAR
+#define OPENAT2_REGULAR 040000000
+#endif
+
+#ifndef EFTYPE
+#define EFTYPE 134
+#endif
+
+void test_openat2_regular_flag(void)
+{
+	if (!openat2_supported) {
+		ksft_test_result_skip("Skipping %s as openat2 is not supported\n", __func__);
+		return;
+	}
+
+	struct open_how how = {
+		.flags = OPENAT2_REGULAR | O_RDONLY
+	};
+
+	int fd = sys_openat2(AT_FDCWD, "/dev/null", &how);
+
+	if (fd == -ENOENT) {
+		ksft_test_result_skip("Skipping %s as there is no /dev/null\n", __func__);
+		return;
+	}
+
+	if (fd != -EFTYPE) {
+		ksft_test_result_fail("openat2 should return EFTYPE\n");
+		return;
+	}
+
+	ksft_test_result_pass("%s succeeded\n", __func__);
+}
+
 #define NUM_TESTS (NUM_OPENAT2_STRUCT_VARIATIONS * NUM_OPENAT2_STRUCT_TESTS + \
-		   NUM_OPENAT2_FLAG_TESTS)
+		   NUM_OPENAT2_FLAG_TESTS + 1)
 
 int main(int argc, char **argv)
 {
@@ -330,6 +364,7 @@ int main(int argc, char **argv)
 
 	test_openat2_struct();
 	test_openat2_flags();
+	test_openat2_regular_flag();
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
 		ksft_exit_fail();
-- 
2.53.0

