From: "Matt W. Benjamin" <matt@linuxbox.com>
Subject: xio-rados-firefly branch update
Date: Tue, 22 Apr 2014 15:44:37 -0400 (EDT)
Message-ID: <182441649.114.1398195877116.JavaMail.root@thunderbeast.private.linuxbox.com>
References: <586483842.112.1398195579489.JavaMail.root@thunderbeast.private.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from aa.linuxbox.com ([69.128.83.226]:4949 "EHLO aa.linuxbox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbaDVTou (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 22 Apr 2014 15:44:50 -0400
In-Reply-To: <586483842.112.1398195579489.JavaMail.root@thunderbeast.private.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Gregory Farnum <greg@inktank.com>, Yaron Haviv <yaronh@mellanox.com>, Eyal Salomon <esalomon@mellanox.com>

Hi,

We've completed a trial merge of our current XioMessenger branches to Ceph
upstream master.  The resulting branch is on our public Ceph development
repo, on banch xio-rados-firefly:

https://github.com/linuxbox2/linuxbox-ceph/commits/xio-rados-firefly

This branch isn't fully vetted.  We haven't re-run librados tests on it, and
there may be issues.  In addition, the core XioMessenger code on this branch
has at least one open bug (a race condition) that appeared after we switched
to Accelio one-way messages (which streamline the workflow, and are faster than
the original request-response code).  We'll send an update on this to the
list as soon as we can (later this week).

There is also ongoing merge work (making XioMessenger work with the rest of
Ceph), and open items (e.g., XioMessenger doesn't implement CephX).

What I think is good about this branch is it has all the commits broken out,
starting with general changes to the Messenger class family, for review.

Thanks and regards,

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
