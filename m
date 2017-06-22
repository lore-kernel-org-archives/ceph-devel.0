From: Nathan Cutler <ncutler@suse.cz>
Subject: clock skew on Jenkins builders causing Shaman builds to fail
Date: Thu, 22 Jun 2017 08:56:40 +0200
Message-ID: <68d4c9c4-a9c0-b6a2-c948-0e31ff07b006@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51706 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751124AbdFVG4m (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Jun 2017 02:56:42 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A4A3AB1E
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jun 2017 06:56:41 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Today I noticed that "jewel" failed to build for CentOS with the 
following error:

configure: error: newly created file is older than distributed files! 
Check your system clock

Here is the URL: 
https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=centos7,DIST=centos7,MACHINE_SIZE=huge/8518//consoleFull

Others on IRC mentioned that this is a known problem from at least 
yesterday. Could somebody please take care of it. It is blocking jewel 
integration testing.

Thanks!

Nathan
