From: mchristi@redhat.com
Subject: [PATCH 0/2] osd support for scsi commands
Date: Wed, 29 Jul 2015 04:25:44 -0500
Message-ID: <1438161946-28473-1-git-send-email-mchristi@redhat.com>
Return-path: <target-devel-owner@vger.kernel.org>
Sender: target-devel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The following patches implememt what is needed for rbd to be able
to implment SCSI WRITE_SAME and COMPARE_AND_WRITE support. This is
needed when we export rbd devices to ESXi using iSCSI or FC or whatever
your favorite SCSI transport is. Basically, ESXi uses these commands to
do things like thin provisioning and locking.

Detailed info can be found here
http://linux-iscsi.org/wiki/VStorage_APIs_for_Array_Integration

The patches were made over the ceph tree pulled today.
