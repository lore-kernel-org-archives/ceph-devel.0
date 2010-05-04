From: Christian Brunner <chb@muc.de>
Subject: qemu-kvm/rbd: aio patch in git
Date: Wed, 5 May 2010 00:33:15 +0200
Message-ID: <20100504223315.GA42090@ncolin.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ncolin.muc.de ([193.149.48.11]:55511 "EHLO ncolin.muc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932784Ab0EDWdR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 May 2010 18:33:17 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi Yehuda,

I've seen that my initial aio implementation is now in the git repository.
This patch isn't working very well. Could you revert it, please?

I'm still having problems with aio handling, but I'll try to send an 
updated patch by the weekend.

Christian
