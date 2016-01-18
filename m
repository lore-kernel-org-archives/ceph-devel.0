From: Javen Wu <javen.wu@xtaotech.com>
Subject: librados option 'conf' and 'cluster'.
Date: Mon, 18 Jan 2016 18:07:37 +0800
Message-ID: <569CB969.8080601@xtaotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m109-177.yeah.net ([123.58.177.109]:53310 "EHLO
	m109-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049AbcARKHy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jan 2016 05:07:54 -0500
Received: from [192.168.10.243] (unknown [119.57.173.137])
	by m199-177.yeah.net (HMail) with ESMTPSA id 1281D11052B8
	for <ceph-devel@vger.kernel.org>; Mon, 18 Jan 2016 18:07:47 +0800 (CST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi buddies,

Recently, I met a problem about librados option 'conf' and 'cluster'.
I created a CEPH cluster but not name it 'ceph', it triggers a lot of 
problems
on my openstack environment.
I found there are consumers of librados or librados python binding only 
respect
  'conf' option. However, the option 'cluster' is ignored usually.

So far, I suffered the problem in:
1. librados python binding
2. qemu rbd driver
3. cinder volume rbd driver

I saw there is rados_create2() API in librados besides rados_create(), but
it seems the API is not widedly used by consumers yet.

I am thinking whether we can do a compromise in librados. If consumers of
librados does not give an arguments for 'cluster'(cluster name) explicitly,
Can we use (basename(conffile).split('.conf')[0]) as cluster name by
default in librados?

So that all consumers of the librados can tolerate the non-'ceph' 
cluster name
without any change.

How do you guys think? If you agree to the change, I can do the quick 
fixing.

Thanks
Javen
