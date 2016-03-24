From: Victor Denisov <vdenisov@mirantis.com>
Subject: blueprint: consistency groups
Date: Thu, 24 Mar 2016 08:50:04 -0700
Message-ID: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:33885 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbcCXPuG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 11:50:06 -0400
Received: by mail-yw0-f172.google.com with SMTP id h129so64719328ywb.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 08:50:05 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jdurgin@redhat.com, dillaman@redhat.com, Mykola Golub <mgolub@mirantis.com>

Hi Ceph developers,

With this email I would like to start a discussion about the design of
the consistency groups feature.

I created a wiki page for this blueprint:
http://tracker.ceph.com/projects/ceph/wiki/consistency_groups

So far it's only filled with what I know for sure about the
consistency groups feature.

First of all this feature is going to require a new entity in rbd -
consistency group.

This entity will be represented in the object storage in the way
similar to how it's done for images.

cg_id.<group name> object has the id of the consistency group.

cg_header.<group id> object has the list of all images in the
consistency group.

Snapshot information will be stored in the omap attributes of
cg_header.

Every description of a snapshot will contain the list of snapshot ids
of the images that comprise the cg's snapshot.

Potentially, I assume, we want to allow images to be members of
several consistency groups. However it can add complexity to the
implementation, see the explanation down the text.

The operations that we should be able to perform on consistency groups are:

   * Create a consistency group

   * Show a consistency group

   * List all available consistency groups

   * Add an image to a consistency group

   * Create a snapshot of all the members of a consistency group
     - Created snapshot of a consistency group only has references to
       snapshots that appear under the corresponding images

   * List all snapshots of a consistency group

   * Delete consistency group's snapshot

   * Modify consistency group (delete, add images to the consistency group)

   * Enable journaling feature for the whole consistency group.

Enabling journaling feature for the whole consistency group will
create one journal for all images in the group. All io operations to
the images in the group will go to this journal. Every operation will
have a tag identifying what image this operation is for. This feature
is required for rbd mirroring.

In order to make it compatible with cinder consistency groups feature
the functionality should cover Cinder Driver API:

def create_consistencygroup(self, context, consistencygroup, volumes)
def delete_consistencygroup(self, context, consistencygroup)
def create_cgsnapshot(self, context, cgsnapshot)
def delete_cgsnapshot(self, context, cgsnapshot)

https://github.com/openstack/cinder-specs/blob/master/specs/juno/consistency-groups.rst

The biggest question regarding the implementation comes from the live
snapshot feature. We believe constistent snapshot is not possible
without cooperation with rbd client (VM, application), because only
application knows if it is in constistent state for snapshotting.  In
the first iteration we would like to make it simple, so CG snapshot
operation just creates snapshots for all images and stores the
snapshot list in its metadata. The consistensy should be provided by
the user, who should ensure that application is in consistent point
(completed all transactions, stopped writting and flushed) during
snapshotting.
