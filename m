From: Bart Van Assche <bart.vanassche@sandisk.com>
Subject: Re: [PATCH 17/18] target: add rbd backend
Date: Wed, 29 Jul 2015 07:27:35 -0700
Message-ID: <55B8E2D7.2040605@sandisk.com>
References: <1438161835-27960-1-git-send-email-mchristi@redhat.com>
 <1438161835-27960-17-git-send-email-mchristi@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <target-devel-owner@vger.kernel.org>
In-Reply-To: <1438161835-27960-17-git-send-email-mchristi@redhat.com>
Sender: target-devel-owner@vger.kernel.org
To: mchristi@redhat.com, ceph-devel@vger.kernel.org, target-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

On 07/29/15 02:23, mchristi@redhat.com wrote:
> +static sector_t tcm_rbd_get_blocks(struct se_device *dev)
> +{
> +	struct tcm_rbd_dev *tcm_rbd_dev = TCM_RBD_DEV(dev);
> +	sector_t blocks_long = tcm_rbd_dev->rbd_dev->mapping.size >>
> +								SECTOR_SHIFT;
> +
> +	if (SECTOR_SIZE == dev->dev_attrib.block_size)
> +		return blocks_long;
> +
> +	switch (SECTOR_SIZE) {
> +	case 4096:
> +		switch (dev->dev_attrib.block_size) {
> +		case 2048:
> +			blocks_long <<= 1;
> +			break;
> +		case 1024:
> +			blocks_long <<= 2;
> +			break;
> +		case 512:
> +			blocks_long <<= 3;
> +		default:
> +			break;
> +		}
> +		break;
> +	case 2048:
> +		switch (dev->dev_attrib.block_size) {
> +		case 4096:
> +			blocks_long >>= 1;
> +			break;
> +		case 1024:
> +			blocks_long <<= 1;
> +			break;
> +		case 512:
> +			blocks_long <<= 2;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case 1024:
> +		switch (dev->dev_attrib.block_size) {
> +		case 4096:
> +			blocks_long >>= 2;
> +			break;
> +		case 2048:
> +			blocks_long >>= 1;
> +			break;
> +		case 512:
> +			blocks_long <<= 1;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	case 512:
> +		switch (dev->dev_attrib.block_size) {
> +		case 4096:
> +			blocks_long >>= 3;
> +			break;
> +		case 2048:
> +			blocks_long >>= 2;
> +			break;
> +		case 1024:
> +			blocks_long >>= 1;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return blocks_long;
> +}

Hello Mike,

Had you already considered to replace the above switch / case statement 
by something like the following ?

static sector_t tcm_rbd_get_blocks(struct se_device *dev)
{
	return TCM_RBD_DEV(dev)->rbd_dev->mapping.size >>
				ilog2(dev->dev_attrib.block_size);
}

Thanks,

Bart.
