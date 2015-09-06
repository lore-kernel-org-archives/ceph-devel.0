From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 12/18] target: compare and write backend driver sense
 handling
Date: Sun, 6 Sep 2015 00:12:06 -0700
Message-ID: <20150906071206.GA21970@infradead.org>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
 <1438161835-27960-12-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43348 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbbIFHMG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 6 Sep 2015 03:12:06 -0400
Content-Disposition: inline
In-Reply-To: <1438161835-27960-12-git-send-email-mchristi@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: mchristi@redhat.com
Cc: ceph-devel@vger.kernel.org, target-devel@vger.kernel.org

On Wed, Jul 29, 2015 at 04:23:49AM -0500, mchristi@redhat.com wrote:
> From: Mike Christie <michaelc@cs.wisc.edu>
> 
> Currently, backend drivers seem to only fail IO with
> SAM_STAT_CHECK_CONDITION which gets us
> TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE.
> For compare and write support we will want to be able to fail with
> TCM_MISCOMPARE_VERIFY. This patch adds a new helper that allows backend
> drivers to fail with specific sense codes.
> 
> It also allows the backend driver to set the miscompare offset.

I agree that we should allwo for better passing of sense data, but I
also think we need to redo the sense handling instead of adding more
warts.

One premise is that with various updates to the standards it will become
more common to generate sense data even if we did not fail the whole
command, so this might be a good opportunity to preparate for that.

> diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
> index ce8574b..f9b0527 100644
> --- a/drivers/target/target_core_transport.c
> +++ b/drivers/target/target_core_transport.c
> @@ -639,8 +639,7 @@ static void target_complete_failure_work(struct work_struct *work)
>  {
>  	struct se_cmd *cmd = container_of(work, struct se_cmd, work);
>  
> -	transport_generic_request_failure(cmd,
> -			TCM_LOGICAL_UNIT_COMMUNICATION_FAILURE);
> +	transport_generic_request_failure(cmd, cmd->sense_reason);
>  }

So I think we should merge target_complete_failure_work and
target_complete_ok_work as a first step.

Then as a second do away with transport_generic_request_failure and just
have single target_complete_cmd that will return success or error based
on the scsi_status field an generate sense if cmd->sense_reason is set.

Third we should replace SCF_TRANSPORT_TASK_SENSE and
SCF_EMULATED_TASK_SENSE with a single driver visible flag and instead
have a new TCM_PASSTHROUGH_SENSE sense code to not generate new sense
data if pscsi passed on sense data.

>  struct se_cmd {
> +	sense_reason_t		sense_reason;

At this point you should probably also remove the sense_reason from the
iscsi_cmd now that it's in the generic CMD.
