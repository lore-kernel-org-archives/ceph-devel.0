From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] rbd: always set out parameter in qemu_rbd_snap_list
Date: Wed, 07 Dec 2011 11:27:48 +0100
Message-ID: <4EDF3FA4.7060601@redhat.com>
References: <1323219910-17021-1-git-send-email-josh.durgin@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27174 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753825Ab1LGKYl (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 7 Dec 2011 05:24:41 -0500
In-Reply-To: <1323219910-17021-1-git-send-email-josh.durgin@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@dreamhost.com>
Cc: qemu-devel@nongnu.org, ceph-devel@vger.kernel.org, chb@muc.de

Am 07.12.2011 02:05, schrieb Josh Durgin:
> The caller expects psn_tab to be NULL when there are no snapshots or
> an error occurs. This results in calling g_free on an invalid address.
> 
> Reported-by: Oliver Francke <Oliver@filoo.de>
> Signed-off-by: Josh Durgin <josh.durgin@dreamhost.com>

Thanks, applied to the block branch.

Kevin
