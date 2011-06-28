From: Wido den Hollander <wido@widodh.nl>
Subject: [PATCH 1/3] bash_completion: Add bash completion for ceph, rados, radosgw_admin and rbd
Date: Tue, 28 Jun 2011 20:28:12 +0200
Message-ID: <1309285694-12399-2-git-send-email-wido@widodh.nl>
References: <1309285694-12399-1-git-send-email-wido@widodh.nl>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([109.72.90.196]:37352 "EHLO
	logger.ceph.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1755714Ab1F1SiY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jun 2011 14:38:24 -0400
In-Reply-To: <1309285694-12399-1-git-send-email-wido@widodh.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>


Signed-off-by: Wido den Hollander <wido@widodh.nl>
---
 src/bash_completion/ceph          |   60 +++++++++++++++++++++++++++++++++++++
 src/bash_completion/rados         |   40 ++++++++++++++++++++++++
 src/bash_completion/radosgw_admin |   57 +++++++++++++++++++++++++++++++++++
 src/bash_completion/rbd           |   44 +++++++++++++++++++++++++++
 4 files changed, 201 insertions(+), 0 deletions(-)
 create mode 100644 src/bash_completion/ceph
 create mode 100644 src/bash_completion/rados
 create mode 100644 src/bash_completion/radosgw_admin
 create mode 100644 src/bash_completion/rbd

diff --git a/src/bash_completion/ceph b/src/bash_completion/ceph
new file mode 100644
index 0000000..f7ec55b
--- /dev/null
+++ b/src/bash_completion/ceph
@@ -0,0 +1,60 @@
+#
+# Ceph - scalable distributed file system
+#
+# Copyright (C) 2011 Wido den Hollander <wido@widodh.nl>
+#
+# This is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License version 2.1, as published by the Free Software
+# Foundation.  See file COPYING.
+#
+
+_ceph()
+{
+        local cur prev
+
+        COMPREPLY=()
+        cur="${COMP_WORDS[COMP_CWORD]}"
+        prev="${COMP_WORDS[COMP_CWORD-1]}"
+
+        if [[ ${cur} == -* ]] ; then
+            COMPREPLY=( $(compgen -W "--conf -c --name --id -m --version -s --status -w --watch -o --out-file -i --in-file" -- ${cur}) )
+            return 0
+        fi
+
+        case "${prev}" in
+            -o | --out-file | -i | --in-file | --conf | -c)
+                COMPREPLY=( $(compgen -f ${cur}) )
+                return 0
+                ;;
+            -m)
+                COMPREPLY=( $(compgen -A hostname ${cur}) )
+                return 0
+                ;;
+            auth)
+                COMPREPLY=( $(compgen -W "list add del" -- ${cur}) )
+                return 0
+                ;;
+            pg)
+                COMPREPLY=( $(compgen -W "stat dump getmap map send_pg_creates scrub repair" -- ${cur}) )
+                return 0
+                ;;
+            osd)
+                COMPREPLY=( $(compgen -W "tell stat injectargs pool dump getmaxosd tree getmap getcrushmap lspools" -- ${cur}) )
+                return 0
+                ;;
+            mon)
+                COMPREPLY=( $(compgen -W "tell stat injectargs getmap" -- ${cur}) )
+                return 0
+                ;;
+            mds)
+                COMPREPLY=( $(compgen -W "tell stat injectargs stat getmap dump compat" -- ${cur}) )
+                return 0
+                ;;
+            *)
+                COMPREPLY=( $(compgen -W "osd mon mds pg auth" -- ${cur}) )
+                return 0
+            ;;
+        esac
+}
+complete -F _ceph ceph
diff --git a/src/bash_completion/rados b/src/bash_completion/rados
new file mode 100644
index 0000000..aa277c3
--- /dev/null
+++ b/src/bash_completion/rados
@@ -0,0 +1,40 @@
+#
+# Ceph - scalable distributed file system
+#
+# Copyright (C) 2011 Wido den Hollander <wido@widodh.nl>
+#
+# This is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License version 2.1, as published by the Free Software
+# Foundation.  See file COPYING.
+#
+
+_rados()
+{
+        local cur prev
+
+        COMPREPLY=()
+        cur="${COMP_WORDS[COMP_CWORD]}"
+        prev="${COMP_WORDS[COMP_CWORD-1]}"
+
+        if [[ ${cur} == -* ]] ; then
+            COMPREPLY=( $(compgen -W "-c --conf -m -d -f -p --pool -b --snap -i -o --create" -- ${cur}) )
+            return 0
+        fi
+
+        case "${prev}" in
+            --conf | -c | -o | -i)
+                COMPREPLY=( $(compgen -f ${cur}) )
+                return 0
+                ;;
+            -m)
+                COMPREPLY=( $(compgen -A hostname ${cur}) )
+                return 0
+                ;;
+            *)
+                COMPREPLY=( $(compgen -W "lspools mkpool rmpool df ls chown get put create rm listxattr getxattr setxattr rmxattr stat mapext lssnap mksnap rmsnap rollback bench" -- ${cur}) )
+                return 0
+            ;;
+        esac
+}
+complete -F _rados rados
diff --git a/src/bash_completion/radosgw_admin b/src/bash_completion/radosgw_admin
new file mode 100644
index 0000000..1583e91
--- /dev/null
+++ b/src/bash_completion/radosgw_admin
@@ -0,0 +1,57 @@
+#
+# Ceph - scalable distributed file system
+#
+# Copyright (C) 2011 Wido den Hollander <wido@widodh.nl>
+#
+# This is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License version 2.1, as published by the Free Software
+# Foundation.  See file COPYING.
+#
+
+_radosgw_admin()
+{
+        local cur prev
+
+        COMPREPLY=()
+        cur="${COMP_WORDS[COMP_CWORD]}"
+        prev="${COMP_WORDS[COMP_CWORD-1]}"
+
+        if [[ ${cur} == -* ]] ; then
+            COMPREPLY=( $(compgen -W "--uid --subuser --access-key --os-user --email --auth_uid --secret --os-secret --gen-access-key --gen-secret \
+                                      --access --display-name --bucket --object --date --conf --name --id --version -s -w" -- ${cur}) )
+            return 0
+        fi
+
+        case "${prev}" in
+            --conf | -c)
+                COMPREPLY=( $(compgen -f ${cur}) )
+                return 0
+                ;;
+            -m)
+                COMPREPLY=( $(compgen -A hostname ${cur}) )
+                return 0
+                ;;
+            user)
+                COMPREPLY=( $(compgen -W "create modify info rm" -- ${cur}) )
+                return 0
+                ;;
+            subuser)
+                COMPREPLY=( $(compgen -W "create modify rm" -- ${cur}) )
+                return 0
+                ;;
+            key)
+                COMPREPLY=( $(compgen -W "create rm" -- ${cur}) )
+                return 0
+                ;;
+            buckets)
+                COMPREPLY=( $(compgen -W "list unlink" -- ${cur}) )
+                return 0
+                ;;
+            *)
+                COMPREPLY=( $(compgen -W "user subuser key buckets policy log" -- ${cur}) )
+                return 0
+            ;;
+        esac
+}
+complete -F _radosgw_admin radosgw_admin
diff --git a/src/bash_completion/rbd b/src/bash_completion/rbd
new file mode 100644
index 0000000..5b6ec0e
--- /dev/null
+++ b/src/bash_completion/rbd
@@ -0,0 +1,44 @@
+#
+# Ceph - scalable distributed file system
+#
+# Copyright (C) 2011 Wido den Hollander <wido@widodh.nl>
+#
+# This is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License version 2.1, as published by the Free Software
+# Foundation.  See file COPYING.
+#
+
+_rbd()
+{
+        local cur prev
+
+        COMPREPLY=()
+        cur="${COMP_WORDS[COMP_CWORD]}"
+        prev="${COMP_WORDS[COMP_CWORD-1]}"
+
+        if [[ ${cur} == -* ]] ; then
+            COMPREPLY=( $(compgen -W "-c --conf -m -d -f -p --pool --snap -i -o --image --dest --dest-pool --path --size --user --secret" -- ${cur}) )
+            return 0
+        fi
+
+        case "${prev}" in
+            --conf | -c | --path | --secret)
+                COMPREPLY=( $(compgen -f ${cur}) )
+                return 0
+                ;;
+            -m)
+                COMPREPLY=( $(compgen -A hostname ${cur}) )
+                return 0
+                ;;
+            snap)
+                COMPREPLY=( $(compgen -W "ls create rollback rm" -- ${cur}) )
+                return 0
+                ;;
+            *)
+                COMPREPLY=( $(compgen -W "ls list info create resize rm export import cp copy mv rename snap watch map unmap" -- ${cur}) )
+                return 0
+            ;;
+        esac
+}
+complete -F _rbd rbd
-- 
1.7.0.4

