From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] use int64_t for return values from rbd
 instead of int
Date: Tue, 20 Nov 2012 17:29:22 +0100
Message-ID: <20121120162922.GA8665@stefanha-thinkpad.redhat.com>
References: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45226 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997Ab2KTQ30 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Nov 2012 11:29:26 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2523164bkw.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Nov 2012 08:29:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1353415495-30561-1-git-send-email-s.priebe@profihost.ag>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Priebe <s.priebe@profihost.ag>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, ceph-devel@vger.kernel.org, pve-devel@pve.proxmox.com, josh.durgin@inktank.com

On Tue, Nov 20, 2012 at 01:44:55PM +0100, Stefan Priebe wrote:
> rbd / rados tends to return pretty often length of writes
> or discarded blocks. These values might be bigger than int.
> 
> Signed-off-by: Stefan Priebe <s.priebe@profihost.ag>
> ---
>  block/rbd.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Looks good but I want to check whether this fixes an bug you've hit?
Please indicate details of the bug and how to reproduce it in the commit
message.

Stefan
