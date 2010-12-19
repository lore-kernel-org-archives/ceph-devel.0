From: Tatsuya Kawano <tatsuya6502@gmail.com>
Subject: Controlling placement groups via RADOS
Date: Sun, 19 Dec 2010 20:05:09 +0900
Message-ID: <7D359599-D49F-4F0E-B422-7CC745F12166@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:44207 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753030Ab0LSLFO convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 19 Dec 2010 06:05:14 -0500
Received: by pxi20 with SMTP id 20so566164pxi.10
        for <ceph-devel@vger.kernel.org>; Sun, 19 Dec 2010 03:05:13 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi, 

When I use RADOS, is there any way to store a group of objects into the same placement group? What are the relationships between pool, object and placement group?

I'm a contributor of Apache HBase. HBase is a distributed, highly scalable database built on top of Hadoop Distributed File System (HDFS). I'd like to develop an adapter to store HBase's journals and data files onto RADOS instead of HDFS. Since HBase worker nodes (called Region Server) are collocated on the servers who are running OSDs, I'd like to take advantage of data locality. A Region Server writes journals and periodically flushes data files, and I want to store the primary copy of all these objects to the local OSD, so that the Region Server can read them from the OSD without wasting network bandwidth. 

Thanks, 
Tatsuya 


--
Tatsuya Kawano (Mr.)
Tokyo, Japan

http://twitter.com/#!/tatsuya6502


