From: Dyweni - Ceph-Devel <YS3fpFE2ykfB@dyweni.com>
Subject: Config File Problem for new =?UTF-8?Q?clusters=3F?=
Date: Thu, 26 May 2011 21:37:24 -0500
Message-ID: <ba77d656c1e15f1dc3190cfee883de01@pl1.haspere.com>
Reply-To: <YS3fpFE2ykfB@dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from pl1.haspere.com ([208.111.35.220]:39883 "EHLO pl1.haspere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753145Ab1E0ChZ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 May 2011 22:37:25 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

 Hi,

 For testing purposes, I tried to specify the default pg_size which will 
 be used to create the default pg_pools (data, metadata, rbd).

 By default, the pg_size is 2.  However, regardless of where I add 'osd 
 pool default size' to the ceph.conf file (I've tried the [mon] and [osd] 
 sections), the pg_size is always 2.

 How does one define what the pg_size will be before calling 
 '/usr/bin/mkcephfs -c /etc/ceph/ceph.conf -a --mkbtrfs'?

 Thanks,
 Dyweni

