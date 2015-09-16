From: Sage Weil <sweil@redhat.com>
Subject: Re: osds full, delete stuck.
Date: Tue, 15 Sep 2015 18:42:55 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1509151841420.23022@cobra.newdream.net>
References: <5F4E7462F2F4A14E974FBE17B8EB37210DC05AEF@H3CMLB13-EX.srv.huawei-3com.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-482899330-1442367777=:23022"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34966 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbbIPBm6 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Sep 2015 21:42:58 -0400
In-Reply-To: <5F4E7462F2F4A14E974FBE17B8EB37210DC05AEF@H3CMLB13-EX.srv.huawei-3com.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chenxiaowei <chen.xiaowei@h3c.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-482899330-1442367777=:23022
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 16 Sep 2015, Chenxiaowei wrote:
> 
> Hi, Sage:
> 
>          Lately my team run into a problem: when osds full, the delete/write
> request stuck.
> 
> But we all agree that the cluster should not stuck when sending delete
> request, cause after that maybe the osds can
> 
> write again. So what?s your advice? Wish your reply, thanks.

The workaround is to temporarily raise the full threshold so you can 
do some deletes.  But you're right that a rados delete operation 
should be accepted in this state.  I've opened

	http://tracker.ceph.com/issues/13110

sage
--557981400-482899330-1442367777=:23022--
