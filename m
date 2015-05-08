From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 0/5] target/rbd: distributed lun reset support
Date: Fri, 08 May 2015 00:02:40 -0700
Message-ID: <1431068560.10406.147.camel@haakon3.risingtidesystems.com>
References: <1430819778-24483-1-git-send-email-mchristi@redhat.com>
	 <20150505174939.GA21297@infradead.org> <55499D46.9040008@redhat.com>
	 <20150506064812.GA5181@infradead.org> <554C51D5.30202@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <554C51D5.30202@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Hi Mike,

On Fri, 2015-05-08 at 01:04 -0500, Mike Christie wrote:
> On 05/06/2015 01:48 AM, Christoph Hellwig wrote:
> >>> As for the API:  I would much prefer to have things at the block layer
> >>> in some form than adding side band protocol for specific functionality.
> >>>
> >>
> >> Ok. For what you need for your NFS cluster work, will you have a
> >> request_queue or block_device or gendisk?
> > 
> > All of them.  It's just another consumer of the in-kernel block devices
> > interface.
> 
> Will users use lio with what you are working on?
> 
> I ask because I am thinking it might be better to implement my own
> se_subsystem_api and sbc_ops structs and in my backend just make libceph
> calls directly for callouts like sbc_ops->execute_rw. So I would not have
> a block_device or request_queue if I went that route.
> 
> If I do my own backend, for reset support (PR support will be similar
> with callouts added to the se_subsystem_api) I would just need the patch
> below.

<nod>

I think extending se_subsystem_api will be the preferred approach for
supporting backend active/active distributed LUN_RESET.

> 
> diff --git a/drivers/target/target_core_tmr.c b/drivers/target/target_core_tmr.c
> index 315ec34..b5a3b68 100644
> --- a/drivers/target/target_core_tmr.c
> +++ b/drivers/target/target_core_tmr.c
> @@ -323,7 +323,7 @@ static void core_tmr_drain_state_list(
>  	}
>  }
>  
> -int core_tmr_lun_reset(
> +int target_core_local_tmr_lun_reset(
>          struct se_device *dev,
>          struct se_tmr_req *tmr,
>          struct list_head *preempt_and_abort_list,
> @@ -386,4 +386,18 @@ int core_tmr_lun_reset(
>  			dev->transport->name);
>  	return 0;
>  }
> +EXPORT_SYMBOL(target_core_local_tmr_lun_reset);
>  
> +int core_tmr_lun_reset(
> +	struct se_device *dev,
> +	struct se_tmr_req *tmr,
> +	struct list_head *preempt_and_abort_list,
> +	struct se_cmd *prout_cmd)
> +{
> +	if (dev->transport->reset_device)
> +		return dev->transport->reset_device(dev);
> +	else
> +		return target_core_local_tmr_lun_reset(dev, tmr,
> +						       preempt_and_abort_list,
> +						       prout_cmd);
> +}
> diff --git a/include/target/target_core_backend.h b/include/target/target_core_backend.h
> index d61be72..faad6c4 100644
> --- a/include/target/target_core_backend.h
> +++ b/include/target/target_core_backend.h
> @@ -31,6 +31,7 @@ struct se_subsystem_api {
>  	struct se_device *(*alloc_device)(struct se_hba *, const char *);
>  	int (*configure_device)(struct se_device *);
>  	void (*free_device)(struct se_device *device);
> +	int (*reset_device)(struct se_device *);
>  
>  	ssize_t (*set_configfs_dev_params)(struct se_device *,
>  					   const char *, ssize_t);
> @@ -139,4 +139,7 @@ int	se_dev_set_max_sectors(struct se_device *, u32);
>  int	se_dev_set_optimal_sectors(struct se_device *, u32);
>  int	se_dev_set_block_size(struct se_device *, u32);
>  
> +int	target_core_local_tmr_lun_reset(struct se_device *, struct se_tmr_req *,
> +					struct list_head *, struct se_cmd *);
> +
>  #endif /* TARGET_CORE_BACKEND_H */
> 

The backend driver will also need to enforce it's own TAS setting when
providing a custom LUN_RESET callback in order to disable this logic
within target_core_mod.

For persistent reservations ops, se_subsystem_api will require a
PREEMPT_AND_ABORT specific callback too, yes..?

Do you see any additional SPC-3 PR specific required callbacks..?

--nab
