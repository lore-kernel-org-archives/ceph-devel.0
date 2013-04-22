From: Wido den Hollander <wido@42on.com>
Subject: Re: Authentication question with RBD+STGT
Date: Mon, 22 Apr 2013 21:02:53 +0200
Message-ID: <5175895D.6060505@42on.com>
References: <51757CD2.2070404@liquidweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from websrv.42on.com ([31.25.102.167]:57886 "EHLO websrv.42on.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754706Ab3DVTDA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 22 Apr 2013 15:03:00 -0400
In-Reply-To: <51757CD2.2070404@liquidweb.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Scott Sullivan <ssullivan@liquidweb.com>
Cc: ceph-devel@vger.kernel.org

Hi,

On 04/22/2013 08:09 PM, Scott Sullivan wrote:
> Referring to this:
> http://ceph.com/dev-notes/adding-support-for-rbd-to-stgt/
>
> I compiled the latest tgt with RBD support. My question is when using
> this method to access RBD volumes, where do you tell it what user to
> authenticate to the cluster with? I do see the above linked page
> mentions it will read a local ceph.conf.

It seems like you can't. A quick peek at the source code of mainline tgt:

bs_rbd.c

static tgtadm_err bs_rbd_init(struct scsi_lu *lu)
{
..
..
         rados_ret = rados_create(&cluster, NULL);
         if (rados_ret < 0) {
                 eprintf("bs_rbd_init: rados_create: %d\n", rados_ret);
                 return ret;
         }
..
..
}

Looking at librados.h:

  * @param id the user to connect as (i.e. admin, not client.admin)
  * @returns 0 on success, negative error code on failure
  */
int rados_create(rados_t *cluster, const char * const id);

So it seems like tgt doesn't support Cephx at all? Or is the 
documentation for librados wrong that it will use "admin" as id when 
NULL is given and cephx is enabled?

I'm not sure if you can pass the id in CEPH_ARGS, but you can give it a try:

export CEPH_ARGS="--id myuser"
tgtadm .......

Wido

>
> Say I want to use cephx for authentication; how do I tell this:
>
> tgtadm --lld iscsi --mode logicalunit --op new --tid 1 --lun 1
> --backing-store pool0/test-image --bstype rbd
>
> to authenticate to pool0/test-image as user testuser? My local ceph.conf
> (that I run the tgtadm command on) contains:
>
> [global]
>          log_max_recent = 500
>
> [mon.a]
>          host = c01-m01
>          mon addr = XX.XX.XX.XX:6789
>
> [mon.b]
>          host = c01-m02
>          mon addr = XX.XX.XX.XX:6789
>
> [mon.c]
>          host = c01-m03
>          mon addr = XX.XX.XX.XX:6789
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Wido den Hollander
42on B.V.

Phone: +31 (0)20 700 9902
Skype: contact42on
