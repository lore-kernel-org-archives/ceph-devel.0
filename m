From: Alex Elder <elder@inktank.com>
Subject: Re: [PATCH 0/5] rbd: avoid snapshot update race
Date: Sat, 27 Apr 2013 14:42:06 -0500
Message-ID: <517C2A0E.40309@inktank.com>
References: <517C2914.8030400@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:53853 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab3D0TmI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 27 Apr 2013 15:42:08 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so5890257iec.8
        for <ceph-devel@vger.kernel.org>; Sat, 27 Apr 2013 12:42:08 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id xc3sm9219406igb.10.2013.04.27.12.42.06
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 27 Apr 2013 12:42:07 -0700 (PDT)
In-Reply-To: <517C2914.8030400@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On 04/27/2013 02:37 PM, Alex Elder wrote:
> This series ends with a patch that avoids a race involving the
> initial read of an rbd image header and a change to the snapshot
> context.  The problem occurs because the rbd client sets up its
> watch request on the header object *after* the initial header
> read, and if the snapshot context changes between them the
> kernel client snapshot context will not be up-to-date.

This series is available in the "review/wip-rbd-cleanup-4"
in the ceph-client git repository, which is based on branch
"review/wip-rbd-cleanup-3".

					-Alex

> The fix is to set up the watch before doing the initial
> header read.  The recent patches, along with the patches
> in this series, make doing things in this order possible.
> 
> 					-Alex
> 
> [PATCH 1/5] rbd: move more initialization into rbd_dev_probe_image()
> [PATCH 2/5] rbd: define rbd_header_name()
> [PATCH 3/5] rbd: don't clean up watch in device release function
> [PATCH 4/5] rbd: don't bother checking whether order changes
> [PATCH 5/5] rbd: set up watch in rbd_dev_probe_image()
> 

