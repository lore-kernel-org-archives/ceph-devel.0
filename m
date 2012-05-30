From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: building test cluster : missing /etc/ceph/client.admin.keyring,
 need help
Date: Wed, 30 May 2012 09:25:56 +0200
Message-ID: <4FC5CB84.2010700@profihost.ag>
References: <bd085420-d72b-48db-9544-47458d83d173@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.profihost.ag ([85.158.179.208]:46317 "EHLO
	mail.profihost.ag" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754174Ab2E3HZw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 May 2012 03:25:52 -0400
In-Reply-To: <bd085420-d72b-48db-9544-47458d83d173@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: ceph-devel@vger.kernel.org

Am 30.05.2012 09:20, schrieb Alexandre DERUMIER:
> 
> Hi, 
> I'm building my rados test cluster, 
> 
> 
> 3 servers,with on each server : 1 mon - 5 osd
> 
> mon daemon and osd are started, but when i use ceph command, it's missing client.admin.keyring
> 
> root@cephtest1:/etc/ceph# ceph -w
> 2012-05-30 09:05:35.255619 7fd1e9cfa760 -1 auth: failed to open keyring from /etc/ceph/client.admin.keyring
> 2012-05-30 09:05:35.255631 7fd1e9cfa760 -1 monclient(hunting): failed to open keyring: (2) No such file or directory
> 2012-05-30 09:05:35.255693 7fd1e9cfa760 -1 ceph_tool_common_init failed.
Just run:
mkcephfs -a -c /etc/ceph/ceph.conf -k /etc/ceph/client.admin.keyring

and it will create the admin key for you.

Stefan
