Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE4725B0B7
	for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2026 03:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784519364; cv=none; b=qwbM5wlZGrdTqQWmXwE2ofc97dTL34K/ys55xjnQVG8jKrWczHHZxox5XmlU1gd5QUVBjKGibwL1WSZO1+yCJJPm5CwzsF42CUMs1VrwKh+haXoPBIOG90bPRg9nJY6YhEO+Dm1LiRUxnSFcOUcY9cqqGqn5Fsb+Wsx8x4ZQJ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784519364; c=relaxed/simple;
	bh=kvkSz4uXvZ+sqVMV8M/fAlkJbBDw+zoR+E9q3t3zyIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zr+7LPTOO5AOyRhtu4ZgekU4zedybn2GkuXRo5BVe1xQZD3LMgJLTHO0FL/2bdIBN8X3F0fLka1RNtQED3pyJiImWs4mC1USkebA+FoQgPYbDPewLQxv20VLqEVUSsAjU+7pudD9buWkos7Q1TE6n+io5SjgRWO+5v9B3NWAXhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwOFjl0V; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwOFjl0V"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8487b7b4066so9789398b3a.1
        for <ceph-devel@vger.kernel.org>; Sun, 19 Jul 2026 20:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784519362; x=1785124162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UvRyWFovuSrNKXFRnuXS1i5HHV/NGt8oDmqO5kWAO2I=;
        b=JwOFjl0VypVgkb5sklFxjsGusLHpzR5U6BKd5jhh4TxhFj9XhVbGY5ZhQ0EXHXDRsf
         wnS8ClgG05jL1AvfMdArsvzdDNcYHQ5ti7LRtoepr+IOg11WHqeFxNWbZ0FNj3kPgztP
         PW+q9ZPZORPdGGKlNWQCrBw6Zx6xGtCVODUbuXw5bvh+NAVqVt/fiPcIuEsOPOsH/v/A
         mz3WT/Ieh3nRDzHhREwi6VvWIR1Isq0DxpjGl58/qSdHG4T66ZHEij70qHcWj5dJ2Xux
         hy6A8gX9HZbCLg7yTGxqyRzPT89zjHAsFeiuQiKVRmUSKm+hCOJeeTMKPiCv/p9tfwaA
         +F2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784519362; x=1785124162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UvRyWFovuSrNKXFRnuXS1i5HHV/NGt8oDmqO5kWAO2I=;
        b=nmLdI8INXuecDfLPm0C5yYunuA/LUUqqRsFvNL8UmBLGiTUKy0q4WQUTQ8dQruUXcM
         Ibr07CHVLgCttfEr49OGCsIm7qs6rGNTawzIXxkK50zfGZe4D2R7YJAt9P7tT5Rra1XU
         K3+IBFqJF122CvV5fN2voyHaHElM9nNBLBvLQ5IUkX/M54BsnEV2L1+6BwSmFBrECCVD
         y17ExlxXUdyVDhgwGWZTQHUxn0XXwK8ZRDLJt4sMXd/HzPSB/4umlPwzp+MJIut9/TvK
         14sgGJCNOLmHUGiKTghAKDc0giO18Bz5QzyAjYDZmIn+fDETAJTdeTWHtw7GivsWdmiU
         deKA==
X-Gm-Message-State: AOJu0YzgBVpsPVp/+xqqK4U8K8z76TBc3pvtNrN0tPByUO5HS+tAg6mY
	l44SqcblOD5tIxaPyu+1Wb1g+ouIAiX3YOO1O7hDbgQwlZYuGaVne4ctarGoXNYnee0=
X-Gm-Gg: AfdE7cmQNUkJflRF6kOizMDWhIkBYIpxRug3zT2HDGmzxkMadkn1aYUApIibYuQt5hR
	cgpe4kE6hY9hioMKTL1evuGeswwcHNp/NiqUIYhawC8c/BU8beuCWgQ7nxRgT09DXwHQvSBPhIZ
	9e3gvqFIX83C84wAiN5KEaaewfK8RTVnwLRB1eRraOVX6iY1mKdaWcAXHPa6VzMFHUrlm5y5FPD
	bKF19LRGWMtI5tuXM74z+5NNdhBHY5Ge9VMej5dW7HWRB817rCubRgbgz608Zt+eL9BQVY5WZ/E
	BXZ7tlRVfQx2stc7iwyOl+GAFy9h6uJ3kJzQ+SJW0Q6K067hesroX4n+HaY5qGX5Amvhp7rmh/x
	3vgzZpXJAX/Zk+2v68w0DLHc5iZHh8bQn3JyX579x3aeYdo4DVUZmYqspDhwl/ivcWXWiwpI0TY
	5IWPFpLQMLc91qQTvPvA==
X-Received: by 2002:a05:6a00:21d2:b0:84a:29a7:f650 with SMTP id d2e1a72fcca58-84c29093c61mr11676721b3a.0.1784519362169;
        Sun, 19 Jul 2026 20:49:22 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([144.48.80.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e3f6sm4813498b3a.44.2026.07.19.20.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 20:49:21 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com,
	amarkuze@redhat.com,
	slava@dubeyko.com,
	sage@newdream.net,
	vega@nebusec.ai,
	xizh2024@lzu.edu.cn,
	enjou1224z@gmail.com
Subject: [PATCH 0/1] libceph: fix debugfs osdmap UAF during stop
Date: Mon, 20 Jul 2026 11:49:05 +0800
Message-ID: <cover.1784371310.git.xizh2024@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zihan Xi <xizh2024@lzu.edu.cn>

Hi Linux kernel maintainers,

We found and validated a bug in net/ceph/osd_client.c. The bug is
reachable by a root user during CephFS mount teardown via the debugfs
osdmap file. We tested the reproducer on an unfixed kernel and observed
the teardown-time crash. The fix only changes osdmap publication during
client stop and should not affect normal osdmap updates.

This series contains one patch:

  1/1 libceph: unpublish osdmap before destroying it on stop

We provide bug details, reproducer steps, and a crash log below.

---- details below ----

Bug details:

osdmap_show() takes osdc->lock for reading, snapshots osdc->osdmap, and
then walks the map while formatting /sys/kernel/debug/ceph/*/osdmap.
ceph_osdc_stop() closes OSD state under the write side of the same lock,
but then drops the lock before destroying osdc->osdmap and leaves the
pointer published until the destroy completes.

A concurrent debugfs reader can therefore acquire osdc->lock after the
stop path drops it and traverse an osdmap that is being freed or has
already been freed. The patch removes the osdmap pointer from osdc under
the write lock, so the writer waits for current debugfs readers and later
readers see a NULL osdmap. Queued OSD map messages also check for the
unpublished osdmap after taking the lock and return during teardown.

Reproducer:

Guest:

    bash /root/poc.sh

Host:

    bash ~/.agents/skills/qemu-start-linux-kernel/scripts/qemu-start-kernel.sh \
        /home/tanyuan-cve/data/repos/linux-repos/linux-v7.0
    scp -i /home/tanyuan-cve/data/rootfs-trixie/image.id_rsa \
        -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
        -P <PORT> poc.sh root@localhost:/root/
    ssh -i /home/tanyuan-cve/data/rootfs-trixie/image.id_rsa \
        -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null \
        -p <PORT> root@localhost 'bash /root/poc.sh'

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.sh------

#!/bin/bash
set -euo pipefail

MON_IP=127.0.0.1
MON_PORT=6789
MON_ID=a
MON_DIR=/var/lib/ceph/mon/ceph-${MON_ID}
MNT=/mnt/cephtest
MAX_OSD=100000
ROUNDS=20
READERS=48

install_deps() {
    export DEBIAN_FRONTEND=noninteractive
    apt-get update
    apt-get install -y --no-install-recommends ceph-mon ceph-base
}

setup_monitor() {
    local fsid

    pkill -x ceph-mon || true
    rm -rf /etc/ceph "${MON_DIR}" /tmp/monmap /tmp/mon.keyring /tmp/ceph-mon.out
    mkdir -p /etc/ceph "${MON_DIR}"

    fsid="$(uuidgen)"
    cat >/etc/ceph/ceph.conf <<EOF
[global]
fsid = ${fsid}
mon_host = ${MON_IP}:${MON_PORT}
mon_initial_members = ${MON_ID}
auth_cluster_required = none
auth_service_required = none
auth_client_required = none
public_network = 127.0.0.0/8
osd_pool_default_size = 1
osd_pool_default_min_size = 1
mon_allow_pool_delete = true

[mon.${MON_ID}]
mon addr = ${MON_IP}:${MON_PORT}
EOF

    monmaptool --create --add "${MON_ID}" "${MON_IP}:${MON_PORT}" --fsid "${fsid}" /tmp/monmap
    ceph-authtool /tmp/mon.keyring --create-keyring --gen-key -n mon. --cap mon 'allow *'
    ceph-mon --mkfs -i "${MON_ID}" --monmap /tmp/monmap --keyring /tmp/mon.keyring
    nohup ceph-mon -i "${MON_ID}" -c /etc/ceph/ceph.conf -d >/tmp/ceph-mon.out 2>&1 &

    for _ in $(seq 1 50); do
        if ceph -s -m "${MON_IP}:${MON_PORT}" --connect-timeout 2 >/dev/null 2>&1; then
            break
        fi
        sleep 0.2
    done

    ceph config set mon mon_max_osd 200000 -m "${MON_IP}:${MON_PORT}"
    ceph osd setmaxosd "${MAX_OSD}" -m "${MON_IP}:${MON_PORT}"
}

trigger_once() {
    local round found f mp

    mkdir -p "${MNT}"
    dmesg -c >/dev/null || true

    for round in $(seq 1 "${ROUNDS}"); do
        rm -f /tmp/osdmap.pids
        timeout 12 mount -t ceph "${MON_IP}:${MON_PORT}":/ "${MNT}" -o mount_timeout=3,_netdev \
            >/tmp/mount."${round}".out 2>&1 &
        mp=$!
        found=""

        for _ in $(seq 1 300); do
            for f in /sys/kernel/debug/ceph/*/osdmap; do
                [ -f "${f}" ] || continue
                found="${f}"
                break 2
            done
            sleep 0.02
        done

        if [ -n "${found}" ]; then
            for _ in $(seq 1 "${READERS}"); do
                cat "${found}" >/dev/null 2>/dev/null &
                echo $! >>/tmp/osdmap.pids
            done
        fi

        wait "${mp}" || true
        if [ -f /tmp/osdmap.pids ]; then
            xargs -r kill </tmp/osdmap.pids || true
        fi
        mountpoint -q "${MNT}" && umount "${MNT}" || true
        sleep 0.05
    done
}

main() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "run as root" >&2
        exit 1
    fi

    install_deps
    setup_monitor
    trigger_once
}

main "$@"

------END poc.sh--------

----BEGIN crash log----

page_owner tracks the page as allocated

[  555.707188][T11090] page last allocated via order 0, migratetype Unmovable, gfp_mask 0x52800(GFP_NOWAIT|__GFP_NORETRY|__GFP_COMP), pid 11060, tgid 11060 (sleep), ts 548768365989, free_ts 548710187389

[  555.708433][T11090] page last free pid 0 tgid 0 stack trace:

[  555.755710][T11096] BUG: unable to handle page fault for address: ffa00000150431b0

[  555.756282][T11096] #PF: supervisor read access in kernel mode

[  555.756768][T11096] #PF: error_code(0x0000) - not-present page

[  555.757239][T11096] PGD 100000067 P4D 101ea8067 PUD 101ead067 PMD 0 

[  555.757778][T11096] Oops: Oops: 0000 [#1] SMP KASAN NOPTI

[  555.758217][T11096] CPU: 2 UID: 0 PID: 11096 Comm: cat Not tainted 7.0.0-08308-g9e1e9d660255 #1 PREEMPT(full) 

[  555.759008][T11096] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014

[  555.759862][T11096] RIP: 0010:ceph_pr_addr+0xb9/0x350

[  555.760277][T11096] Code: 40 38 f1 40 0f 9e c6 84 c9 0f 95 c1 40 84 ce 0f 85 55 02 00 00 83 e0 07 38 c2 0f 9e c1 84 d2 0f 95 c0 84 c1 0f 85 40 02 00 00 <48> 8b 43 08 be 04 00 00 00 48 c7 c7 00 f4 74 9a 48 89 44 24 28 48

[  555.761817][T11096] RSP: 0018:ffa0000001abf898 EFLAGS: 00010286

[  555.762296][T11096] RAX: 0000000000000000 RBX: ffa00000150431a8 RCX: 0000000000000000

[  555.762915][T11096] RDX: 0000000000000000 RSI: 0000000000000080 RDI: ffa0000001abf860

[  555.763535][T11096] RBP: 00000000aaaaaa68 R08: 0000000000000080 R09: ffa0000001abfa38

[  555.764165][T11096] R10: 0000000000000000 R11: ffa0000001abfa38 R12: 1ff4000000357f14

[  555.764795][T11096] R13: ff11000021d64400 R14: 00000000000007e5 R15: 00000000ffffffff

[  555.765422][T11096] FS:  00007f46869b0780(0000) GS:ff11000184b68000(0000) knlGS:0000000000000000

[  555.766128][T11096] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[  555.766649][T11096] CR2: ffa00000150431b0 CR3: 000000002286f000 CR4: 0000000000751ef0

[  555.767275][T11096] PKRU: 55555554

[  555.767552][T11096] Call Trace:

[  555.767822][T11096]  <TASK>

[  555.768059][T11096]  ? __pfx_ceph_pr_addr+0x10/0x10

[  555.768459][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.768912][T11096]  ? snprintf+0xaa/0xe0

[  555.769250][T11096]  ? __pfx_snprintf+0x10/0x10

[  555.769638][T11096]  osdmap_show+0x553/0xff0

[  555.770005][T11096]  ? __pfx_osdmap_show+0x10/0x10

[  555.770397][T11096]  ? rcu_is_watching+0x12/0xc0

[  555.770779][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.771211][T11096]  ? __kvmalloc_node_noprof+0x668/0x9a0

[  555.771640][T11096]  ? seq_read_iter+0x371/0x11f0

[  555.772015][T11096]  seq_read_iter+0x40f/0x11f0

[  555.772377][T11096]  ? folio_add_new_anon_rmap+0x2b1/0x1110

[  555.772793][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.773238][T11096]  seq_read+0x2b0/0x450

[  555.773569][T11096]  ? __pfx_seq_read+0x10/0x10

[  555.773951][T11096]  ? __pfx___might_resched+0x10/0x10

[  555.774374][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.774825][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.775315][T11096]  full_proxy_read+0x10c/0x170

[  555.775702][T11096]  vfs_read+0x173/0xb70

[  555.776036][T11096]  ? __pfx_css_rstat_updated+0x10/0x10

[  555.776468][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.776921][T11096]  ? lock_vma_under_rcu+0x12b/0x3f0

[  555.777326][T11096]  ? __pfx_vfs_read+0x10/0x10

[  555.777698][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.778144][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.778592][T11096]  ? find_held_lock+0x2b/0x80

[  555.778964][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.779411][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.779861][T11096]  ? find_held_lock+0x2b/0x80

[  555.780241][T11096]  ksys_read+0xf9/0x1d0

[  555.780571][T11096]  ? __pfx_ksys_read+0x10/0x10

[  555.780954][T11096]  ? srso_alias_return_thunk+0x5/0xfbef5

[  555.781399][T11096]  ? rcu_is_watching+0x12/0xc0

[  555.781787][T11096]  do_syscall_64+0x116/0xf80

[  555.782154][T11096]  ? irqentry_exit+0x117/0x830

[  555.782531][T11096]  entry_SYSCALL_64_after_hwframe+0x77/0x7f

[  555.783011][T11096] RIP: 0033:0x7f4686a42687

[  555.783376][T11096] Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff

[  555.784926][T11096] RSP: 002b:00007ffc5b028a30 EFLAGS: 00000202 ORIG_RAX: 0000000000000000

[  555.785582][T11096] RAX: ffffffffffffffda RBX: 00007f46869b0780 RCX: 00007f4686a42687

[  555.786212][T11096] RDX: 0000000000040000 RSI: 00007f4686915000 RDI: 0000000000000003

[  555.786834][T11096] RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000000

[  555.787456][T11096] R10: 0000000000000000 R11: 0000000000000202 R12: 00007f4686915000

[  555.788084][T11096] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000040000

[  555.788723][T11096]  </TASK>

[  555.788957][T11096] Modules linked in:

[  555.789246][T11096] CR2: ffa00000150431b0

[  555.789529][T11096] ---[ end trace 0000000000000000 ]---

[  555.789529][T11099] BUG: unable to handle page fault for address: ffa000001503e000

[  555.789895][T11096] RIP: 0010:ceph_pr_addr+0xb9/0x350

[  555.790462][T11099] #PF: supervisor read access in kernel mode

[  555.790880][T11096] Code: 40 38 f1 40 0f 9e c6 84 c9 0f 95 c1 40 84 ce 0f 85 55 02 00 00 83 e0 07 38 c2 0f 9e c1 84 d2 0f 95 c0 84 c1 0f 85 40 02 00 00 <48> 8b 43 08 be 04 00 00 00 48 c7 c7 00 f4 74 9a 48 89 44 24 28 48

[  555.791269][T11099] #PF: error_code(0x0000) - not-present page

[  555.792787][T11096] RSP: 0018:ffa0000001abf898 EFLAGS: 00010286

[  555.793175][T11099] PGD 100000067 

[  555.793176][T11096] 

[  555.793180][T11099] P4D 101ea8067 

[  555.793664][T11096] RAX: 0000000000000000 RBX: ffa00000150431a8 RCX: 0000000000000000

[  555.793900][T11099] PUD 101ead067 

[  555.794088][T11096] RDX: 0000000000000000 RSI: 0000000000000080 RDI: ffa0000001abf860

[  555.794319][T11099] PMD 0 

[  555.794939][T11096] RBP: 00000000aaaaaa68 R08: 0000000000000080 R09: ffa0000001abfa38

[  555.795176][T11099] 

[  555.795808][T11096] R10: 0000000000000000 R11: ffa0000001abfa38 R12: 1ff4000000357f14

[  555.796000][T11099] Oops: Oops: 0000 [#2] SMP KASAN NOPTI

[  555.796625][T11096] R13: ff11000021d64400 R14: 00000000000007e5 R15: 00000000ffffffff

[  555.796806][T11099] CPU: 3 UID: 0 PID: 11099 Comm: cat Tainted: G      D             7.0.0-08308-g9e1e9d660255 #1 PREEMPT(full) 

[  555.797421][T11096] FS:  00007f46869b0780(0000) GS:ff11000184b68000(0000) knlGS:0000000000000000

[  555.797779][T11099] Tainted: [D]=DIE

[  555.798398][T11096] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

[  555.799202][T11099] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014

[  555.799788][T11096] CR2: ffa00000150431b0 CR3: 000000002286f000 CR4: 0000000000751ef0

[  555.800028][T11099] RIP: 0010:ceph_pr_addr+0xe9/0x350

[  555.800544][T11096] PKRU: 55555554

[  555.801232][T11099] Code: 00 00 00 48 c7 c7 00 f4 74 9a 48 89 44 24 28 48 8b 43 10 48 89 44 24 30 48 8b 43 18 48 89 44 24 38 48 8b 43 20 48 89 44 24 40 <48> 8b 43 28 48 89 44 24 48 48 8b 43 30 48 89 44 24 50 48 8b 43 38

[  555.801864][T11096] Kernel panic - not syncing: Fatal exception

[  556.869115][T11096] Shutting down cpus with NMI

[  556.872070][T11096] Kernel Offset: disabled

[  556.872417][T11096] Rebooting in 86400 seconds..


-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  libceph: unpublish osdmap before destroying it on stop

 net/ceph/osd_client.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

-- 
2.43.0

