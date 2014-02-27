From: Zhongliang Zhao <zhaozhongliang@gmail.com>
Subject: location-aware file placement in Ceph
Date: Thu, 27 Feb 2014 14:25:00 +0100
Message-ID: <530F3CAC.2040504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:33242 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbaB0NZA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Feb 2014 08:25:00 -0500
Received: by mail-ee0-f49.google.com with SMTP id b57so1385348eek.36
        for <ceph-devel@vger.kernel.org>; Thu, 27 Feb 2014 05:24:59 -0800 (PST)
Received: from ?IPv6:2001:620:400:64:56e6:fcff:fe80:6e5c? ([2001:620:400:64:56e6:fcff:fe80:6e5c])
        by mx.google.com with ESMTPSA id x2sm16832837eeo.8.2014.02.27.05.24.57
        for <ceph-devel@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 27 Feb 2014 05:24:58 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dear all,

As new to ceph, may I ask in the crush algorithm, is there a way to 
configure where the file to be stored, not randomly.
My requirement is to place the files that within the same 
location(within a geographic area), into the same OSD, instead of 
randomly placing them seperately.

I guess crush may support this. But to do this, I just have to configure 
some parameters in some ceph commands? or I have to modify the ceph 
crush algorithm and re-compile ceph?

Many thanks for any helpful pointers.

Cheers, Giovanni
