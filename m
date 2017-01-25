From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 0/2] iov_iter: allow iov_iter_get_pages_alloc to allocate more pages per call
Date: Wed, 25 Jan 2017 08:32:03 -0500
Message-ID: <20170125133205.21704-1-jlayton@redhat.com>
References: <20170124212327.14517-1-jlayton@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170124212327.14517-1-jlayton@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, lustre-devel@lists.lustre.org, v9fs-developer@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

Small respin of the patch that I sent yesterday for the same thing.

This moves the maxsize handling into iov_iter_pvec_size, so that we don't
end up iterating past the max size we'll use anyway when trying to
determine the pagevec length.

Also, a respun patch to make ceph use iov_iter_get_pages_alloc instead of
trying to do it via its own routine.

Al, if these look ok, do you want to pick these up or shall I ask
Ilya to merge them via the ceph tree?

Jeff Layton (2):
  iov_iter: allow iov_iter_get_pages_alloc to allocate more pages per
    call
  ceph: switch DIO code to use iov_iter_get_pages_alloc

 fs/ceph/file.c |  75 ++----------------------------
 lib/iov_iter.c | 142 +++++++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 116 insertions(+), 101 deletions(-)

-- 
2.9.3
