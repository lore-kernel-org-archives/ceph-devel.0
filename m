From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: clock skew on Jenkins builders causing Shaman builds to fail
Date: Thu, 22 Jun 2017 09:20:12 +0200
Message-ID: <1c385dcf-0aa5-5c90-3365-5ea1a7b7209f@suse.cz>
References: <68d4c9c4-a9c0-b6a2-c948-0e31ff07b006@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52771 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751124AbdFVHUP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Jun 2017 03:20:15 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F197AB1E
        for <ceph-devel@vger.kernel.org>; Thu, 22 Jun 2017 07:20:13 +0000 (UTC)
In-Reply-To: <68d4c9c4-a9c0-b6a2-c948-0e31ff07b006@suse.cz>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This shows the failure nicely: https://shaman.ceph.com/builds/ceph/jewel/

On 06/22/2017 08:56 AM, Nathan Cutler wrote:
> Today I noticed that "jewel" failed to build for CentOS with the 
> following error:
> 
> configure: error: newly created file is older than distributed files! 
> Check your system clock
> 
> Here is the URL: 
> https://jenkins.ceph.com/job/ceph-dev-build/ARCH=x86_64,AVAILABLE_ARCH=x86_64,AVAILABLE_DIST=centos7,DIST=centos7,MACHINE_SIZE=huge/8518//consoleFull 
> 
> 
> Others on IRC mentioned that this is a known problem from at least 
> yesterday. Could somebody please take care of it. It is blocking jewel 
> integration testing.
> 
> Thanks!
> 
> Nathan
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
