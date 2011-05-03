From: Tommi Virtanen <tommi.virtanen@dreamhost.com>
Subject: Re: [PATCH] libceph: fix ceph_msg_new error path
Date: Tue, 3 May 2011 09:14:31 -0700
Message-ID: <20110503161431.GA20739@dreamer>
References: <1304389796-11363-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:49968 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab1ECQOb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 May 2011 12:14:31 -0400
Content-Disposition: inline
In-Reply-To: <1304389796-11363-1-git-send-email-henry_c_chang@tcloudcomputing.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org, Henry C Chang <henry_c_chang@tcloudcomputing.com>

On Tue, May 03, 2011 at 02:29:56AM +0000, Henry C Chang wrote:
> If memory allocation failed, calling ceph_msg_put() will cause GPF
> since some of ceph_msg variables are not initialized first.
> 
> Fix Bug #970.

Looks good and explains the symptoms perfectly. Committed to
ceph-client.git as 56f63aeb6360fb3ba9584bd5b094d55283a9e332.
Thanks!

-- 
:(){ :|:&};:
