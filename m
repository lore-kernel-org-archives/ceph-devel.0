From: David Zafman <david.zafman@inktank.com>
Subject: Some gitbuilders not working
Date: Thu, 08 Jan 2015 22:55:08 -0800
Message-ID: <54AF7B4C.6010305@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58246 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753296AbbAIGzM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 9 Jan 2015 01:55:12 -0500
Received: by mail-pa0-f52.google.com with SMTP id eu11so16671815pac.11
        for <ceph-devel@vger.kernel.org>; Thu, 08 Jan 2015 22:55:12 -0800 (PST)
Received: from David-Zs-MacBook-Pro.local ([2605:e000:1313:8003:a00d:a585:f370:4092])
        by mx.google.com with ESMTPSA id gi6sm6040166pbd.93.2015.01.08.22.55.10
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2015 22:55:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


We are seeing gitbuilder failures.  This is what I saw on one.

error: Failed build dependencies:
xmlstarlet is needed by ceph-1:0.90-821.g680fe3c.el7.x86_64
