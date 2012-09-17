From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: RBD image max simultaneous mounts
Date: Sun, 16 Sep 2012 23:55:04 -0700
Message-ID: <a492ca49d3642786d9786179203d293c@hq.newdream.net>
References: <50568E3B.3060403@bashkirtsev.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:47865 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab2IQGwK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Sep 2012 02:52:10 -0400
Received: from pochacco.sd.dreamhost.com (pochacco.sd.dreamhost.com [66.33.195.34])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 7B3A1DD90C
	for <ceph-devel@vger.kernel.org>; Sun, 16 Sep 2012 23:52:10 -0700 (PDT)
In-Reply-To: <50568E3B.3060403@bashkirtsev.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Vladimir Bashkirtsev <vladimir@bashkirtsev.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 17 Sep 2012 12:13:07 +0930, Vladimir Bashkirtsev
<vladimir@bashkirtsev.com> wrote:
> Dear devs,
> 
> We just had an incident where two instances of the same VM started up
> on different hosts and mounted the same RBD image. Image had ext4
> partition and it became corrupted quickly. Therefore it would be good
> to have some setting in RBD info like max_simultaneous_mounts which
> will dictate how many simultaneous mounts of the same RBD image may be
> in existence. Obviously such glusterfs would not have such issue in
> RBD image but old trusty extfs fails miserably. It may be hard to
> implement in ceph due to distributed nature. Then basic check in
> QEMU-RBD driver would be good as well.
> 
> Regards,
> Vladimir

This is what locking and fencing of rbd images is intended to address.

The original discussion:
http://comments.gmane.org/gmane.comp.file-systems.ceph.devel/7094

The current status:
http://permalink.gmane.org/gmane.comp.file-systems.ceph.devel/9210

Josh
