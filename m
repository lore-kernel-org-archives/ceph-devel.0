From: Tatsuya Kawano <tatsuya6502@gmail.com>
Subject: Auto-striping feature
Date: Tue, 25 Jan 2011 20:53:06 +0900
Message-ID: <1408EC05-75B0-4DD8-B6D6-7F5D10AAC096@gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43401 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab1AYLxt convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Jan 2011 06:53:49 -0500
Received: by pva4 with SMTP id 4so846996pva.19
        for <ceph-devel@vger.kernel.org>; Tue, 25 Jan 2011 03:53:49 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi, 

I have some questions about auto-striping feature in Ceph. 

- What is the default striping size?
- How can I specify the striping size for a specific file (via libceph and kernel driver)? 
- How many PGs will be involved on striping one file. 


I'm writing several files to Ceph and the size of each file will be about 64MB. There will be 10 to 20 OSDs in the cluster. I wonder how each file will be divided into objects and how these objects will be distributed in the cluster.

Thanks, 

--
Tatsuya Kawano (Mr.)
Tokyo, Japan

