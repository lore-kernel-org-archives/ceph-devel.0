From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: Make libcephfs return error when unmounted?
Date: Wed, 11 Apr 2012 14:59:45 -0700
Message-ID: <20E3E083-D1C5-4D86-9709-95515538C1BA@cs.ucsc.edu>
References: <71CC6D8F-361D-4C00-AED1-C0C928CDAB9F@cs.ucsc.edu> <CAC-hyiGhR-ayeffsT6ZTAS4aozr_Ub_YJQN8L5Hs9zM3zWBS5g@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:34115 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933301Ab2DKV7q convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Apr 2012 17:59:46 -0400
In-Reply-To: <CAC-hyiGhR-ayeffsT6ZTAS4aozr_Ub_YJQN8L5Hs9zM3zWBS5g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Cc: ceph-devel@vger.kernel.org, Greg Farnum <gregory.farnum@dreamhost.com>, Sage Weil <sage@newdream.net>


On Apr 11, 2012, at 11:22 AM, Yehuda Sadeh Weinraub wrote:

> Also need to check that cmount is initialized.  I'd add a helper:
> 
> Client *ceph_get_client(struct ceph_mount_info *cmont)
> {
>  if (cmount && cmount->is_mounted())
>    return cmount->get_client();
> 
>  return NULL;
> }

How useful is checking cmount != NULL here? This defensive check depends on users initializing their cmount pointers to NULL, but the API doesn't do anything to require this initialization assumption.

- Noah