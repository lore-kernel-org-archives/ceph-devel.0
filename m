From: Sage Weil <sage@newdream.net>
Subject: Re: ceph fs
Date: Fri, 13 May 2011 08:53:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105130851401.12286@cobra.newdream.net>
References: <201105122129.20828.ufm@ufm.su>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53941 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758703Ab1EMPxE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2011 11:53:04 -0400
In-Reply-To: <201105122129.20828.ufm@ufm.su>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fyodor Ustinov <ufm@ufm.su>
Cc: ceph-devel@vger.kernel.org

On Thu, 12 May 2011, Fyodor Ustinov wrote:
> Hi!
> 
> Like previous, but ceph fs instead of rbd.
> (i.e. iozone with 4G file).
> 
> [  783.295035] ceph: loaded (mds proto 32)
> [  783.300122] libceph: client4125 fsid ff352dfd-078c-e65f-a769-d25abb384d92
> [  783.300642] libceph: mon0 77.120.112.193:6789 session established
> [  941.278185] libceph: msg_new can't create type 0 front 4096
> [  941.278456] libceph: msgpool osd_op alloc failed
> [  941.278539] libceph: msg_new can't create type 0 front 512
> [  941.278606] libceph: msgpool osd_op_reply alloc failed
> [  941.278670] libceph: msg_new can't create type 0 front 4096
> [  941.278737] libceph: msgpool osd_op alloc failed
> [  941.278808] libceph: msg_new can't create type 0 front 512
> [  941.278875] libceph: msgpool osd_op_reply alloc failed
> [  941.279011] libceph: msg_new can't create type 0 front 4096
> [  941.279079] libceph: msgpool osd_op alloc failed
> [  941.279153] libceph: msg_new can't create type 0 front 512
> [  941.279220] libceph: msgpool osd_op_reply alloc failed
> [  941.279286] libceph: msg_new can't create type 0 front 4096
> [  941.279352] libceph: msgpool osd_op alloc failed
> [  941.279422] libceph: msg_new can't create type 0 front 512
> [  941.279623] libceph: msgpool osd_op_reply alloc failed
> [  941.279692] libceph: msg_new can't create type 0 front 4096
> [  941.279897] libceph: msgpool osd_op alloc failed
> [  941.280042] libceph: msg_new can't create type 0 front 512
> [  941.280300] libceph: msgpool osd_op_reply alloc failed
> [  941.280418] libceph: msg_new can't create type 0 front 4096
> [  941.280534] libceph: msgpool osd_op alloc failed
> [  941.280793] libceph: msg_new can't create type 0 front 512
> [  941.280958] libceph: msgpool osd_op_reply alloc failed
> [  941.281074] libceph: msg_new can't create type 0 front 4096
> [  941.281236] libceph: msgpool osd_op alloc failed

The ceph memory allocations are definitely not bulletproof and low memory 
situations can still cause problems.  I'm not sure that that is what is 
going on here, but you might try adjusting vm.min_free_kbytes and see if 
that has an effect.  e.g.,

	sysctl -w vm.min_free_kbytes=262144

(although I'd check the current value first to make sure you're adjusting 
it up).

sage
