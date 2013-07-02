From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: wip-libcephfs rebased and pulled up to v.65
Date: Tue, 2 Jul 2013 17:37:46 -0400 (EDT)
Message-ID: <515941372.160.1372801066160.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <460228344.155.1372800973209.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:3931 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467Ab3GBVhu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Jul 2013 17:37:50 -0400
In-Reply-To: <460228344.155.1372800973209.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sage Weil <sage@inktank.com>, aemerson <aemerson@linuxbox.com>, David Zafman <david.zafman@inktank.com>

Hi Sage (et al),

We have rebased the former wip-libcephfs branch, on the model of the
rebased example branch, as planned, and also pulled it up to Ceph's
v65 tag/master, also as planned.

In addition to cross checking this, Adam has updated our Ganesha client
driver to use the ll v2 API, and this checks out.

We've pushed wip-libcephfs-rebased-v65 to our public git repository,
https://github.com/linuxbox2/linuxbox-ceph, for review.

Thanks,

Matt

-- 
Matt Benjamin
The Linux Box
206 South Fifth Ave. Suite 150
Ann Arbor, MI  48104

http://linuxbox.com

tel.  734-761-4689 
fax.  734-769-8938 
cel.  734-216-5309 
