Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843B844BC87
	for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782749495; cv=none; b=fJSRXkqeSEyB8yo4oKETsRLO9ocbIaGhlKEPW8aTT2MYpMwTSdTmgs2t+/IR6fsoVIn1lCfGpvEzoP4bl9R3ZX7295IvmgygHZLN/GePYv/yIYA5CN9TpC1U8u/MDAuS3NCVSnJaq8aadXQydOfpyQV3liquLkTumK93cmecmOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782749495; c=relaxed/simple;
	bh=sDyMJKvvgmJsz66TIMr/XuyeuU7pG2HENOCF4Qyv+3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QO0B4cu6Rn5MbDavCIqgTnPUUi8NJmdeAaP+uGc+TRrQVThOR0ZhaGpqvv+Sgw3uSXfTcL67ILcmyFFR0QtHLsn7a66b90g3FQSjBM1uwQqZi9M+JD3G2pFvLkpRmi9apr1XxAgE2kNjAj7oGg7D9gIARb5fbGIyoNJyncFgX6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=WNvAxh8T; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="WNvAxh8T"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-664f0a76a74so679411d50.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2026 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782749490; x=1783354290; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mJlpjxDzG642BvS2mG2M+ZjhrmA/hrXpqiOambpcf9I=;
        b=WNvAxh8TiZ3SPsg9VQf2FmMgLoHODbPa3KoNhtwO8wQJp9Hc/t5YDJRLng1s3XBc/L
         6tAdOb+WKza9NLG3qzaDccEK7cwzfKxl7jhWTcIy/uR6TTJMHHkktjIikcAVHUBEPH9u
         6xUBGrYudouHjqBXMDtaAD2RwPzwJL0WzyOrRt/hb2P1+mJgM18MG2TKhIDllb4PeU+q
         UrS55mWcRq7KlrC9Aj/WZhZG8w3C3r0tyYVfeYkZNekgoWEoBzzzCQH3iCuFrcRx4lJX
         oz3ZPNrU/MWLjq4qIcJpGqZBuAmGFPIYtgHQdOfPmp3Xoxo/u/fsCFl+gxTLTSRswRYe
         FAMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782749490; x=1783354290;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mJlpjxDzG642BvS2mG2M+ZjhrmA/hrXpqiOambpcf9I=;
        b=PwjSORNdFZkrYCZNuLTiKM8Pi9n0wwjAqiJDe5KTcMgVxIx6dUEQdIOydRTVnoTNOA
         OH0iNpqCaa9jw7TtZ+0VkAh4ny/z10nl55pQ0X1w9SclNwTFbFZXyZo8H2IWCKTBjxZf
         EfO8Nfu9/AiPpz215XODJqfJ9kjlMt/toj6ixchpziBrA8fVlvqxmd4X6f45ZwxhNntR
         37AACjKPV+kDbmuloQePIcv3+SYulDJvLe8ynLtvom4+OwisUaSTnJs72TbKsjEB0xiw
         wag4LUZkqFSWLzETmQvD0zT2yVMgBrIA1QQOgO0WDAxU5SwRszi2mBFhdX5Pudezg8WI
         maiQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqz98jUKav1Px5wN8tzeh5BIlPAkVKuKRjy7eueyxOVrfUZmXkMXMkb/MHyx5DgGQ2yYotYj+s6gOsv@vger.kernel.org
X-Gm-Message-State: AOJu0YzzA3PVEc9Z2Yzp1+wIb5qv1suLJXLx+anBeR1shFRwdQ8ijd5T
	n+KEy5SZQO4uUcFcbxJGoZqgmBeTywu66JnLIO9fRa6iX3HpgTsChc0p6bdgmUqDNSg=
X-Gm-Gg: AfdE7cl95c305VqmfM2njDZW1+3TsWVhY7BXNhBDAl2vzU2awHWV7yPqLoUlz8Dereh
	EhxYPrkacQabUlq/bPge26FxfEE9dfDTjBEUxAYx3CnQR/pi1f3xOSBtorC7Tj8VNTpV6XLMfWA
	+RAJ6J+OIedjJaR4DS+dI4OWzVPP2oDFfpHG6kij+1mWn1Wh9t5fq8d1eLfxbdmnOEcMY8/EAOh
	SFsMUgLkZVwHglTfTjv2Q8wiaCXBE7cZZSv8/a5hNMttrFZeEDHiXYtNSmktUkcWdB6tjRH7yu1
	kS+x8n9mS0RiSUKeKX+w9xiRD6L3GxC951W2rUSzWYAhpt8oH93S9CFBME5SkB7VzILIYrp8xop
	1DInESIbm2YOsBlzNFZK0RG6Q8MIc8dfIVl+LESOxp6PGrHY6vNszCyTc910Z2fUps0riV5JHO4
	SnPKQUxijiCb9bTgPXGVWsBp/ZN2ifJt8fYzRcIc1u9kNiGQ4lu779bJz3iTJGj8MYd7LVrXkB1
	iEB48tga/9tkiA9DYL1cZ6rR0oG9CvxxRk+9GryGnKk6c9izxMP4y4qSCRVZwppbIAm/dWtCbFa
	uKvCm3w=
X-Received: by 2002:a05:690c:7304:b0:80c:85e5:8755 with SMTP id 00721157ae682-810da30b2d7mr1606277b3.62.1782749489957;
        Mon, 29 Jun 2026 09:11:29 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8025c877360sm118501057b3.5.2026.06.29.09.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:11:29 -0700 (PDT)
Message-ID: <26523ef6d4fcd4c81e0b80212d8bcc155464130d.camel@dubeyko.com>
Subject: Re: [PATCH 0/1] libceph: debugfs: monmap_show use-after-free during
 client teardown
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Ren Wei <n05ec@lzu.edu.cn>, idryomov@gmail.com, amarkuze@redhat.com, 
	sage@newdream.net
Cc: yuantan098@gmail.com, zcliangcn@gmail.com, bird@lzu.edu.cn, 
	ldy3087146292@gmail.com, ceph-devel@vger.kernel.org
Date: Mon, 29 Jun 2026 09:11:27 -0700
In-Reply-To: <cover.1781280238.git.ldy3087146292@gmail.com>
References: <cover.1781280238.git.ldy3087146292@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

CC: ceph-devel@vger.kernel.org

On Mon, 2026-06-15 at 14:31 +0800, Ren Wei wrote:
> From: Douya Le <ldy3087146292@gmail.com>
>=20
> Hi Linux kernel maintainers,
>=20
> We found and validated an issue in net/ceph/debugfs.c.
> The bug is reachable by root on a local system.
> The relevant details are provided below.
>=20
> ---- details below ----
>=20
> Bug details:
>=20
> The bug is in the interaction between `monmap_show()` in
> `net/ceph/debugfs.c` and client teardown in `ceph_destroy_client()` /
> `ceph_monc_stop()`.
>=20
> `monmap_show()` reads `client->monc.monmap` under `monc->mutex` for
> the
> `/sys/kernel/debug/ceph/.../monmap` debugfs file and assumes that
> this
> makes the pointer stable while it prints the monitor map.
>=20
> During teardown, `ceph_destroy_client()` used to call
> `ceph_monc_stop()` before removing the per-client debugfs files.
> `ceph_monc_stop()` drops `monc->mutex` early and later frees
> `monc->monmap`. This leaves a window where the `monmap` debugfs file
> is
> still reachable, but the backing `monmap` object has already been
> freed.
> A concurrent debugfs read can then enter `monmap_show()`, observe a
> stale non-NULL `monc->monmap` pointer, and dereference freed memory.
>=20
> With KASAN enabled, this reproduces as a slab use-after-free read in
> `monmap_show()`.
>=20
> Reproducer:
>=20
> gcc -O2 -pthread -o mini_poc mini_poc.c
> PANIC_ON_WARN=3D0 ./mini_poc
>=20
>=20
> We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.
>=20
> ------BEGIN mini_poc.c------
>=20
> #define _GNU_SOURCE
>=20
> #include <dirent.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <pthread.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/stat.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
>=20
> #define CEPH_DEBUGFS "/sys/kernel/debug/ceph"
> #define MAX_DAEMONS 8
> #define MAX_CMD 4096
> #define MAX_PATH 512
> #define READ_BUF 4096
>=20
> static volatile sig_atomic_t stop_flag;
> static int readers =3D 64;
> static int workers =3D 8;
> static int mon_port =3D 6789;
> static int panic_on_warn;
> static unsigned int mount_hold_us =3D 50000;
> static char fsid[64];
> static char workdir[MAX_PATH] =3D "/root/ceph-lab-mini";
> static char base_mnt[MAX_PATH] =3D "/mnt/ceph-mini";
> static pid_t daemons[MAX_DAEMONS];
> static size_t daemon_count;
> static pthread_t *reader_tids;
> static pthread_t *worker_tids;
>=20
> static void trim_newline(char *s)
> {
> 	size_t len;
>=20
> 	if (!s)
> 		return;
>=20
> 	len =3D strlen(s);
> 	while (len > 0 && (s[len - 1] =3D=3D '\n' || s[len - 1] =3D=3D '\r'
> ||
> 			=C2=A0=C2=A0 s[len - 1] =3D=3D ' ' || s[len - 1] =3D=3D '\t'))
> {
> 		s[--len] =3D '\0';
> 	}
> }
>=20
> static void fail(const char *fmt, ...)
> {
> 	va_list ap;
>=20
> 	va_start(ap, fmt);
> 	vfprintf(stderr, fmt, ap);
> 	va_end(ap);
> 	fputc('\n', stderr);
> 	exit(1);
> }
>=20
> static void log_msg(const char *fmt, ...)
> {
> 	va_list ap;
>=20
> 	va_start(ap, fmt);
> 	fprintf(stderr, "[mini] ");
> 	vfprintf(stderr, fmt, ap);
> 	fprintf(stderr, "\n");
> 	va_end(ap);
> }
>=20
> static int run_cmd(const char *fmt, ...)
> {
> 	va_list ap;
> 	char cmd[MAX_CMD];
> 	int rc;
>=20
> 	va_start(ap, fmt);
> 	vsnprintf(cmd, sizeof(cmd), fmt, ap);
> 	va_end(ap);
>=20
> 	rc =3D system(cmd);
> 	if (rc =3D=3D -1)
> 		return -1;
> 	if (WIFEXITED(rc))
> 		return WEXITSTATUS(rc);
> 	return 255;
> }
>=20
> static void must_succeed(const char *fmt, ...)
> {
> 	va_list ap;
> 	char cmd[MAX_CMD];
> 	int rc;
>=20
> 	va_start(ap, fmt);
> 	vsnprintf(cmd, sizeof(cmd), fmt, ap);
> 	va_end(ap);
>=20
> 	rc =3D system(cmd);
> 	if (rc =3D=3D -1)
> 		fail("system failed: %s", cmd);
> 	if (!WIFEXITED(rc) || WEXITSTATUS(rc) !=3D 0)
> 		fail("command failed (%d): %s", rc, cmd);
> }
>=20
> static void read_cmd_output(char *buf, size_t buflen, const char
> *fmt, ...)
> {
> 	va_list ap;
> 	char cmd[MAX_CMD];
> 	FILE *fp;
>=20
> 	va_start(ap, fmt);
> 	vsnprintf(cmd, sizeof(cmd), fmt, ap);
> 	va_end(ap);
>=20
> 	fp =3D popen(cmd, "r");
> 	if (!fp)
> 		fail("popen failed: %s", cmd);
>=20
> 	if (!fgets(buf, (int)buflen, fp)) {
> 		pclose(fp);
> 		fail("no output from command: %s", cmd);
> 	}
>=20
> 	if (pclose(fp) =3D=3D -1)
> 		fail("pclose failed: %s", cmd);
>=20
> 	trim_newline(buf);
> }
>=20
> static void require_bin(const char *bin)
> {
> 	if (run_cmd("command -v %s >/dev/null 2>&1", bin) !=3D 0)
> 		fail("missing required binary: %s", bin);
> }
>=20
> static void kill_daemons(void)
> {
> 	size_t i;
>=20
> 	for (i =3D 0; i < daemon_count; i++) {
> 		if (daemons[i] > 0)
> 			kill(daemons[i], SIGTERM);
> 	}
>=20
> 	for (i =3D 0; i < daemon_count; i++) {
> 		if (daemons[i] > 0)
> 			waitpid(daemons[i], NULL, 0);
> 	}
>=20
> 	daemon_count =3D 0;
> }
>=20
> static void cleanup(void)
> {
> 	int i;
>=20
> 	stop_flag =3D 1;
> 	kill_daemons();
>=20
> 	for (i =3D 1; i <=3D workers; i++) {
> 		run_cmd("timeout 5 umount %s.%d >/dev/null 2>&1",
> base_mnt, i);
> 	}
>=20
> 	run_cmd("pkill -f '^ceph-mon -i a ' >/dev/null 2>&1");
> 	run_cmd("pkill -f '^ceph-mgr -i x ' >/dev/null 2>&1");
> 	run_cmd("pkill -f '^ceph-mds -i a ' >/dev/null 2>&1");
> 	run_cmd("pkill -f '^ceph-osd -i 0 ' >/dev/null 2>&1");
> 	run_cmd("rm -rf %s", workdir);
> }
>=20
> static void handle_signal(int signo)
> {
> 	(void)signo;
> 	stop_flag =3D 1;
> }
>=20
> static void install_handlers(void)
> {
> 	struct sigaction sa;
>=20
> 	memset(&sa, 0, sizeof(sa));
> 	sa.sa_handler =3D handle_signal;
> 	sigemptyset(&sa.sa_mask);
> 	sigaction(SIGINT, &sa, NULL);
> 	sigaction(SIGTERM, &sa, NULL);
> }
>=20
> static pid_t start_daemon(const char *log_path, const char *fmt, ...)
> {
> 	va_list ap;
> 	char cmd[MAX_CMD];
> 	pid_t pid;
>=20
> 	if (daemon_count >=3D MAX_DAEMONS)
> 		fail("too many daemons");
>=20
> 	va_start(ap, fmt);
> 	vsnprintf(cmd, sizeof(cmd), fmt, ap);
> 	va_end(ap);
>=20
> 	pid =3D fork();
> 	if (pid < 0)
> 		fail("fork failed");
> 	if (pid =3D=3D 0) {
> 		int fd =3D open(log_path, O_CREAT | O_WRONLY |
> O_TRUNC, 0644);
> 		if (fd < 0)
> 			_exit(127);
> 		dup2(fd, STDOUT_FILENO);
> 		dup2(fd, STDERR_FILENO);
> 		close(fd);
> 		execl("/bin/sh", "sh", "-c", cmd, (char *)NULL);
> 		_exit(127);
> 	}
>=20
> 	daemons[daemon_count++] =3D pid;
> 	return pid;
> }
>=20
> static void wait_for(const char *desc, const char *cmd, int seconds)
> {
> 	int i;
>=20
> 	for (i =3D 0; i < seconds; i++) {
> 		if (stop_flag)
> 			fail("stopped while waiting for %s", desc);
> 		if (run_cmd("%s", cmd) =3D=3D 0)
> 			return;
> 		sleep(1);
> 	}
>=20
> 	fail("timed out waiting for %s", desc);
> }
>=20
> static void write_ceph_conf(void)
> {
> 	FILE *fp =3D fopen("/etc/ceph/ceph.conf", "w");
>=20
> 	if (!fp)
> 		fail("failed to open /etc/ceph/ceph.conf");
>=20
> 	fprintf(fp,
> 		"[global]\n"
> 		"fsid =3D %s\n"
> 		"mon host =3D 127.0.0.1\n"
> 		"public network =3D 127.0.0.0/8\n"
> 		"auth cluster required =3D none\n"
> 		"auth service required =3D none\n"
> 		"auth client required =3D none\n"
> 		"osd pool default size =3D 1\n"
> 		"osd pool default min size =3D 1\n"
> 		"osd crush chooseleaf type =3D 0\n"
> 		"osd objectstore =3D memstore\n"
> 		"memstore device bytes =3D 536870912\n"
> 		"mon_allow_pool_delete =3D true\n"
> 		"ms_bind_ipv4 =3D true\n"
> 		"ms_bind_ipv6 =3D false\n"
> 		"[mon.a]\n"
> 		"mon addr =3D 127.0.0.1:%d\n"
> 		"mon data =3D %s/mon.a\n"
> 		"host =3D syzkaller\n"
> 		"[osd.0]\n"
> 		"host =3D syzkaller\n"
> 		"osd data =3D %s/osd0\n"
> 		"[mds.a]\n"
> 		"host =3D syzkaller\n"
> 		"mds data =3D %s/mds.a\n"
> 		"[mgr.x]\n"
> 		"host =3D syzkaller\n"
> 		"mgr data =3D %s/mgr.x\n",
> 		fsid, mon_port, workdir, workdir, workdir, workdir);
>=20
> 	if (fclose(fp) !=3D 0)
> 		fail("failed to write ceph.conf");
> }
>=20
> static void setup_cluster(void)
> {
> 	char osd_uuid[64];
> 	char osd_id[32];
>=20
> 	log_msg("preparing local CephFS cluster");
>=20
> 	must_succeed("rm -rf %s", workdir);
> 	must_succeed("mkdir -p %s/mon.a %s/osd0 %s/mgr.x %s/mds.a",
> 		=C2=A0=C2=A0=C2=A0=C2=A0 workdir, workdir, workdir, workdir);
> 	must_succeed("mkdir -p /etc/ceph /var/log/ceph
> /var/run/ceph");
> 	write_ceph_conf();
>=20
> 	must_succeed("monmaptool --create --add a 127.0.0.1:%d --
> fsid %s %s/monmap",
> 		=C2=A0=C2=A0=C2=A0=C2=A0 mon_port, fsid, workdir);
> 	must_succeed("ceph-mon --mkfs -i a --monmap %s/monmap --mon-
> data %s/mon.a --setuser root --setgroup root",
> 		=C2=A0=C2=A0=C2=A0=C2=A0 workdir, workdir);
> 	start_daemon("/var/log/ceph/mon.a.log",
> 		=C2=A0=C2=A0=C2=A0=C2=A0 "exec ceph-mon -i a --mon-data %s/mon.a -f",
> 		=C2=A0=C2=A0=C2=A0=C2=A0 workdir);
> 	wait_for("monitor", "ceph -s >/dev/null 2>&1", 60);
>=20
> 	read_cmd_output(osd_uuid, sizeof(osd_uuid), "uuidgen");
> 	must_succeed("sh -c 'ceph osd create %s > /tmp/ceph-osd-
> id.mini'", osd_uuid);
> 	read_cmd_output(osd_id, sizeof(osd_id), "cat /tmp/ceph-osd-
> id.mini");
> 	if (strcmp(osd_id, "0") !=3D 0)
> 		fail("unexpected osd id: %s", osd_id);
>=20
> 	must_succeed("ceph-osd -i 0 --mkfs --mkkey --monmap
> %s/monmap --osd-uuid %s --osd-data %s/osd0",
> 		=C2=A0=C2=A0=C2=A0=C2=A0 workdir, osd_uuid, workdir);
> 	start_daemon("/var/log/ceph/osd.0.log",
> 		=C2=A0=C2=A0=C2=A0=C2=A0 "exec ceph-osd -i 0 -f");
> 	wait_for("osd", "sh -c \"ceph osd stat 2>/dev/null | grep -q
> '1 up'\"", 60);
>=20
> 	must_succeed("ceph osd crush add osd.0 1 host=3Dsyzkaller
> root=3Ddefault >/dev/null");
> 	start_daemon("/var/log/ceph/mgr.x.log",
> 		=C2=A0=C2=A0=C2=A0=C2=A0 "exec ceph-mgr -i x -f");
> 	must_succeed("ceph osd pool create cephfs_metadata 8
> >/dev/null");
> 	must_succeed("ceph osd pool create cephfs_data 8
> >/dev/null");
> 	must_succeed("ceph fs new cephfs cephfs_metadata cephfs_data
> >/dev/null");
> 	start_daemon("/var/log/ceph/mds.a.log",
> 		=C2=A0=C2=A0=C2=A0=C2=A0 "exec ceph-mds -i a -f");
> 	wait_for("mds", "sh -c \"ceph mds stat 2>/dev/null | grep -q
> 'up:'\"", 60);
> }
>=20
> static void *reader_thread(void *arg)
> {
> 	char buf[READ_BUF];
> 	(void)arg;
>=20
> 	while (!stop_flag) {
> 		DIR *dir =3D opendir(CEPH_DEBUGFS);
> 		struct dirent *de;
>=20
> 		if (!dir) {
> 			usleep(10000);
> 			continue;
> 		}
>=20
> 		while (!stop_flag && (de =3D readdir(dir)) !=3D NULL) {
> 			char path[MAX_PATH];
> 			ssize_t n;
> 			int fd;
>=20
> 			if (de->d_name[0] =3D=3D '.')
> 				continue;
>=20
> 			snprintf(path, sizeof(path), "%s/%s/monmap",
> 				 CEPH_DEBUGFS, de->d_name);
> 			fd =3D open(path, O_RDONLY | O_CLOEXEC);
> 			if (fd < 0)
> 				continue;
>=20
> 			do {
> 				n =3D read(fd, buf, sizeof(buf));
> 			} while (n > 0 || (n < 0 && errno =3D=3D
> EINTR));
>=20
> 			close(fd);
> 		}
>=20
> 		closedir(dir);
> 	}
>=20
> 	return NULL;
> }
>=20
> static void *worker_thread(void *arg)
> {
> 	int idx =3D (int)(long)arg;
> 	char mnt[MAX_PATH];
> 	char cmd[MAX_CMD];
> 	int n;
>=20
> 	n =3D snprintf(mnt, sizeof(mnt), "%s.%d", base_mnt, idx);
> 	if (n < 0 || n >=3D (int)sizeof(mnt))
> 		fail("mount path too long");
> 	mkdir(mnt, 0755);
>=20
> 	while (!stop_flag) {
> 		snprintf(cmd, sizeof(cmd),
> 			 "timeout 20 mount -i -t ceph
> 'guest@%s.cephfs=3D/' %s "
> 			 "-o
> 'mon_addr=3D127.0.0.1:%d,ms_mode=3Dlegacy,noshare,mount_timeout=3D20'
> >/dev/null 2>&1",
> 			 fsid, mnt, mon_port);
> 		if (run_cmd("%s", cmd) =3D=3D 0) {
> 			usleep(mount_hold_us);
> 			run_cmd("timeout 20 umount %s >/dev/null
> 2>&1", mnt);
> 		}
> 	}
>=20
> 	return NULL;
> }
>=20
> static void parse_env_int(const char *name, int *value, int min, int
> max)
> {
> 	const char *s =3D getenv(name);
> 	char *end =3D NULL;
> 	long v;
>=20
> 	if (!s || !*s)
> 		return;
>=20
> 	v =3D strtol(s, &end, 0);
> 	if (!end || *end !=3D '\0' || v < min || v > max)
> 		fail("invalid %s: %s", name, s);
> 	*value =3D (int)v;
> }
>=20
> static void prepare_runtime(void)
> {
> 	if (geteuid() !=3D 0)
> 		fail("run as root");
>=20
> 	require_bin("ceph");
> 	require_bin("ceph-mon");
> 	require_bin("ceph-mgr");
> 	require_bin("ceph-mds");
> 	require_bin("ceph-osd");
> 	require_bin("monmaptool");
> 	require_bin("mount");
> 	require_bin("umount");
> 	require_bin("mountpoint");
> 	require_bin("uuidgen");
> 	require_bin("timeout");
>=20
> 	parse_env_int("READERS", &readers, 1, 4096);
> 	parse_env_int("WORKERS", &workers, 1, 256);
> 	parse_env_int("MON_PORT", &mon_port, 1, 65535);
> 	parse_env_int("PANIC_ON_WARN", &panic_on_warn, 0, 1);
>=20
> 	if (getenv("WORKDIR"))
> 		snprintf(workdir, sizeof(workdir), "%s",
> getenv("WORKDIR"));
> 	if (getenv("BASE_MNT"))
> 		snprintf(base_mnt, sizeof(base_mnt), "%s",
> getenv("BASE_MNT"));
>=20
> 	read_cmd_output(fsid, sizeof(fsid), "uuidgen");
>=20
> 	must_succeed("mountpoint -q /sys/kernel/debug || mount -t
> debugfs none /sys/kernel/debug");
> 	must_succeed("sysctl -w kernel.panic_on_warn=3D%d >/dev/null",
> panic_on_warn);
> 	must_succeed("sh -c 'echo 8 >/proc/sys/kernel/printk'");
> }
>=20
> int main(void)
> {
> 	long i;
>=20
> 	install_handlers();
> 	atexit(cleanup);
> 	prepare_runtime();
> 	setup_cluster();
>=20
> 	log_msg("cluster is ready; starting %d readers and %d
> workers", readers, workers);
>=20
> 	reader_tids =3D calloc((size_t)readers, sizeof(*reader_tids));
> 	worker_tids =3D calloc((size_t)workers, sizeof(*worker_tids));
> 	if (!reader_tids || !worker_tids)
> 		fail("calloc failed");
>=20
> 	for (i =3D 0; i < readers; i++) {
> 		if (pthread_create(&reader_tids[i], NULL,
> reader_thread, NULL) !=3D 0)
> 			fail("pthread_create reader failed");
> 	}
>=20
> 	for (i =3D 0; i < workers; i++) {
> 		if (pthread_create(&worker_tids[i], NULL,
> worker_thread, (void *)(i + 1)) !=3D 0)
> 			fail("pthread_create worker failed");
> 	}
>=20
> 	for (;;) {
> 		if (stop_flag)
> 			break;
> 		pause();
> 	}
>=20
> 	return 0;
> }
>=20
> ------END mini_poc.c--------
>=20
> ----BEGIN crash log----
>=20
> [=C2=A0 613.239991][T14677]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [=C2=A0 613.241882][T14677] BUG: KASAN: slab-use-after-free in
> monmap_show+0x2b9/0x320
> [=C2=A0 613.244065][T14677] Read of size 4 at addr ffff8880588441d0 by
> task mini_poc/14677
> [=C2=A0 613.245758][T14677] CPU: 0 UID: 0 PID: 14677 Comm: mini_poc Not
> tainted 7.1.0-rc6-00222-g512db8267b73 #5 PREEMPT(full)
> [=C2=A0 613.245908][T14677] monmap_show+0x2b9/0x320
> [=C2=A0 613.246010][T14677] full_proxy_read+0x135/0x1a0
> [=C2=A0 613.246058][T14677] ksys_read+0x12a/0x250
> [=C2=A0 613.289570][T14677] Allocated by task 55:
> [=C2=A0 613.294344][T14677]=C2=A0 mon_dispatch+0x18dc/0x2710
> [=C2=A0 613.303567][T14677] Freed by task 14812:
> [=C2=A0 613.309266][T14677]=C2=A0 ceph_destroy_client+0x78/0x160
> [=C2=A0 613.310209][T14677]=C2=A0 destroy_fs_client+0x1e4/0x3b0
> [=C2=A0 613.319394][T14677] The buggy address belongs to the object at
> ffff8880588441c0
> [=C2=A0 613.321942][T14677] The buggy address is located 16 bytes inside
> of
> [=C2=A0 613.321942][T14677]=C2=A0 freed 192-byte region [ffff8880588441c0=
,
> ffff888058844280)
> [=C2=A0 613.376017][T14677] Memory state around the buggy address:
> [=C2=A0 613.380180][T14677] >ffff888058844180: fc fc fc fc fc fc fc fc fa
> fb fb fb fb fb fb fb
> [=C2=A0 613.386573][T14677]
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
>=20
> -----END crash log-----
>=20
> Best regards,
> Douya Le
