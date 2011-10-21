From: Josh Durgin <josh.durgin@dreamhost.com>
Subject: Re: rbd snap rm error
Date: Fri, 21 Oct 2011 08:45:28 -0700
Message-ID: <3c016dac6373e7287ac2b068d9dbbf34@hq.newdream.net>
References: <CAO47_-9S_72Q3=EZmh9qLgGj_Rt7DkP0VM4onkyrtiMA4zxHxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:57011 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847Ab1JUPqR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Oct 2011 11:46:17 -0400
Received: from pochacco.sd.dreamhost.com (pochacco.sd.dreamhost.com [66.33.195.34])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 636D41F576A
	for <ceph-devel@vger.kernel.org>; Fri, 21 Oct 2011 08:46:16 -0700 (PDT)
In-Reply-To: <CAO47_-9S_72Q3=EZmh9qLgGj_Rt7DkP0VM4onkyrtiMA4zxHxQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: ceph-devel@vger.kernel.org

On Fri, 21 Oct 2011 11:41:55 +0200, Christian Brunner <chb@muc.de>
wrote:
> When I want to delete a snapshot, everything is working, but there is
> a strange error message:
> 
> # rbd create --size=100 image
> # rbd snap create --snap=image-snap1 image
> # rbd snap ls image
> 8       image-snap1     104857600
> # rbd snap rm --snap=image-snap1 image
> 2011-10-21 11:35:58.506393 7f4975f66720 librbd: could not set snap to
> : error 2: No such file or directory
> 2011-10-21 11:35:58.506554 7f4975f66720 librbd: Error re-reading rbd
> header: error 2: No such file or directory
> # rbd snap ls image
> #
> 
> The snapshot hat been removed anyway. So this is not a real problem,
> it's just irritating.

This is more fallout from some argument parsing changes (like #1628).
I'll be fixing this today.
