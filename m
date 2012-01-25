From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: rbd snap ls does not list more than 200 snapshots
Date: Tue, 24 Jan 2012 17:48:26 -0800
Message-ID: <4F1F5F6A.1050802@dreamhost.com>
References: <4F1F309C.9060507@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35287 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754694Ab2AYBs0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 24 Jan 2012 20:48:26 -0500
In-Reply-To: <4F1F309C.9060507@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: martin@tuxadero.com
Cc: ceph-devel@vger.kernel.org

On 01/24/2012 02:28 PM, Martin Mailand wrote:
> Hi,
> I created quite a few snapshots of a rbd image. After around 200
> snapshots the command rbd snap ls vm10 does not return, instead it uses
> all of the memory of a 32G machine an then the oom killer gets kicked in.
> Are 200 snapshots a known limit?
>
> How to reproduce:
>
> for i in $(seq 500); do rbd snap create --snap=a$i vm10; echo $i ; done
>
> rbd snap ls vm10
> doesn't return

Thanks for the info - this is fixed by
2c2cc1596cd63b6368d13a2665c6c85d3d8ed532.

> top:
> 25381 root 20 0 5425m 5.2g 5436 S 29 16.4 1:10.21 rbd
>
> rbd -v
> ceph version 0.40-206-g6c275c8
> (commit:6c275c8195a8ae04e8a492d043fa6dfd60cecd82)
>
>
> -martin
