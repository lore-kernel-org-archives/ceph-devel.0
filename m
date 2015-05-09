From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/5] target/rbd: distributed lun reset support
Date: Sat, 9 May 2015 07:29:35 -0700
Message-ID: <20150509142935.GA31964@infradead.org>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
 <20150505174939.GA21297@infradead.org>
 <55499D46.9040008@redhat.com>
 <20150506064812.GA5181@infradead.org>
 <554C51D5.30202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <target-devel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <554C51D5.30202@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On Fri, May 08, 2015 at 01:04:05AM -0500, Mike Christie wrote:
> > All of them.  It's just another consumer of the in-kernel block devices
> > interface.
> 
> Will users use lio with what you are working on?

It's the other way around.  The pNFS block device uses a block device
it wants to use persistent reservations on.  If we do have a proper
in-kernel API for that it could also work on say RBD and NVMe as long as
they provide a mapping for SCSI3 PRs.  For NVMe that exists as a spec,
and for RBD it seems like you're about to deliver one.

> I ask because I am thinking it might be better to implement my own
> se_subsystem_api and sbc_ops structs and in my backend just make libceph
> calls directly for callouts like sbc_ops->execute_rw. So I would not have
> a block_device or request_queue if I went that route.
> 
> If I do my own backend, for reset support (PR support will be similar
> with callouts added to the se_subsystem_api) I would just need the patch
> below.

It's defintively simpler, so for prototyping it might be the way to go.
I think in the long run going for a general block device API will be
more useful for everyone involved.
