From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 0/2] ceph: support cross-quota-tree renames
Date: Mon,  6 Apr 2020 16:11:59 +0100
Message-ID: <20200406151201.32432-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, Gregory Farnum <gfarnum@redhat.com>, Zheng Yan <zyan@redhat.com>
Cc: Frank Schilder <frans@dtu.dk>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Hi!

The following patches will make the cephfs kernel client behave the same
way as the fuse client when doing renames across different quota realms.

Luis Henriques (2):
  ceph: normalize 'delta' parameter usage in check_quota_exceeded
  ceph: allow rename operation under different quota realms

 fs/ceph/dir.c   |  9 +++----
 fs/ceph/quota.c | 62 +++++++++++++++++++++++++++++++++++++++++++++----
 fs/ceph/super.h |  3 ++-
 3 files changed, 65 insertions(+), 9 deletions(-)
