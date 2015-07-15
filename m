From: David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH 0/2] target/iscsi: clustered SendTargets handling
Date: Wed, 15 Jul 2015 13:00:17 +0200
Message-ID: <1436958019-16937-1-git-send-email-ddiss@suse.de>
Return-path: <target-devel-owner@vger.kernel.org>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: target-devel@vger.kernel.org, mchristi@redhat.com
List-Id: ceph-devel.vger.kernel.org

For active/active clustered iSCSI targets (e.g. LIO + Ceph RBD),
SendTargets responses from any single node should include portal details
for remote cluster nodes.

This patch-set adds a TPG discoverable_while_disabled attribute, which
when set sees LIO include details for a disabled TPG in SendTargets
responses.

This allows for the use of a common configuration for cluster nodes,
with TPGT/enable set on a node specific basis.

A patch-set to ensure that LIO doesn't listen/accept connections via
disabled TPGs will follow once I've finished cleaning it up.

Feedback appreciated.

Cheers, David
