From: Jeff Layton <jlayton@samba.org>
Subject: Re: [PATCH v2] Samba RADOS service registration
Date: Thu, 15 Feb 2018 13:09:45 -0500
Message-ID: <1518718185.4086.45.camel@samba.org>
References: <20180213022540.5f9686b7@suse.de>
         <20180213202727.77175e21@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hr2.samba.org ([144.76.82.148]:63708 "EHLO hr2.samba.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163370AbeBOSJt (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:09:49 -0500
In-Reply-To: <20180213202727.77175e21@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Disseldorp <ddiss@suse.de>, Samba Technical <samba-technical@lists.samba.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, 2018-02-13 at 20:27 +0100, David Disseldorp wrote:
>
> +	instance_guid = rados_get_instance_id(state->cluster);
> +
> +	ret = ceph_service_instance_gen(instance_buf, sizeof(instance_buf),
> +					daemon, instance_guid);
> +	if (ret < 0) {
> +		goto out_mem_free;
> +	}
> +
> +	DBG_DEBUG("registering as %s with %s Ceph cluster\n", instance_buf,
> +		  (cluster_name != NULL ? cluster_name : "default"));
> +
> +	ret = rados_service_register(state->cluster, "samba", instance_buf, "");

IIUC, if the program (samba in this case) dies, and then is restarted
(maybe host reboots?), it'll get a new instance_guid, right? Or am I
misunderstanding what rados_get_instance_id will return here?
-- 
Jeff Layton <jlayton@samba.org>
