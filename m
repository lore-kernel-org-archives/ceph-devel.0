From: JJ <jjones@cirrhus9.com>
Subject: Installing_on_RedHat_or_CentOS
Date: Mon, 30 Jan 2012 10:46:34 -0500
Message-ID: <4F26BB5A.5060103@cirrhus9.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.cirrhus9.com ([75.101.139.254]:43898 "EHLO
	cirrhus9b.cirrhus9.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753374Ab2A3P53 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jan 2012 10:57:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by cirrhus9b.cirrhus9.com (Postfix) with ESMTP id 213A110D70DA
	for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2012 07:49:24 -0800 (PST)
Received: from cirrhus9b.cirrhus9.com ([127.0.0.1])
	by localhost (cirrhus9b.cirrhus9.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D9jfcleaaLeM for <ceph-devel@vger.kernel.org>;
	Mon, 30 Jan 2012 07:49:23 -0800 (PST)
Received: from [192.168.1.4] (dynamic-acs-24-101-150-38.zoominternet.net [24.101.150.38])
	by cirrhus9b.cirrhus9.com (Postfix) with ESMTP id 9353210C6205
	for <ceph-devel@vger.kernel.org>; Mon, 30 Jan 2012 07:49:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I am trying to follow the direction at
http://ceph.newdream.net/wiki/Installing_on_RedHat_or_CentOS

This is my 3rd or 4th attempt trying to install ceph on 2 different OSs, 
(CentOS 5.[57] and Ubuntu 11.10

Lately, on CentOS 5.5, the boost-devel 1.33.1 comes installed.
I found a repo that has boost-devel* 1.39 and upgraded my system to that 
release.

the part that fails at 
http://ceph.newdream.net/wiki/Installing_on_RedHat_or_CentOS is the 
instruction titled ""Building ceph itself" / "git checkout -b rc 
origin/rc" complains with
"fatal: git checkout: updating paths is incompatible with switching 
branches.
"Did you intend to checkout 'origin/rc' which can not be resolved as 
commit?"

I don't know git or it's particulars.

Is 64bit architecture a requirement?
Is fuse* a requirement? (modprobe fuse doesn't issue any warnings)
Where can I find a more detailed list of requirements?

http://ceph.newdream.net/wiki/Backend_filesystem_requirements doesn't 
tell me much, sorry.

Thank you for your time,

-- 

JJ
Support Engineer
Cirrhus9.com
