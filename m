From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: sizeof (struct tYpO *) : it is just a typo or rather a bug ?
Date: Thu, 24 Jul 2014 20:20:16 +0200
Message-ID: <53D14E60.1010105@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ia64@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

Inspired by this "typo" fix 
http://article.gmane.org/gmane.linux.kernel/1754640
I grep'ed the current git tree of linus for similar issues.

For these 4 places I'm wondering where the appropriate struct definition is located :

arch/ia64/sn/kernel/io_acpi_init.c:         sizeof(struct pci_devdev_info *)) {
tools/perf/builtin-sched.c:     sched->tasks = realloc(sched->tasks, sched->nr_tasks * sizeof(struct task_task *));
fs/ceph/xattr.c:                xattrs = kcalloc(numattr, sizeof(struct ceph_xattr *),
fs/ceph/xattr.c:                memset(xattrs, 0, numattr*sizeof(struct ceph_xattr *));

Nevertheless I was told, that gcc doesn't complain about such things due to eventually evaluating it to "sizeof(null)". I'm however curious if at least a warning should be emitted in such a case, or?

-- 
Toralf
