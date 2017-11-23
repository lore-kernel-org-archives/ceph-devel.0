From: Nathan Cutler <ncutler@suse.cz>
Subject: boost: to download, or not to download?
Date: Fri, 24 Nov 2017 00:35:27 +0100
Message-ID: <385d1ed2-23f4-b1d8-4761-f1d1c7642a8b@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39536 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752615AbdKWXf3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 23 Nov 2017 18:35:29 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91CA5AAF1
        for <ceph-devel@vger.kernel.org>; Thu, 23 Nov 2017 23:35:28 +0000 (UTC)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Background: I'm trying to build Ceph in OBS from the tarball generated 
by make-dist.

I noticed that Shaman builds download Boost from the Internet - this is 
not an option in OBS because the build workers there do not have 
external network connectivity.

Examining make-dist, it seems very much to be downloading Boost and 
including it in the tarball, but not in a way that convinces Ceph to not 
download it again during the actual build.

There are two problems that I can see:

First, make-dist makes its final tarball by merging three tarballs into 
one, and in the process ends up putting the boost code out-of-tree. This 
is trivial to fix.

Second, even when I fix that, BuildBoost.cmake ignores it because of 
this line:

if(EXISTS 
"${PROJECT_SOURCE_DIR}/src/boost/libs/config/include/boost/config.hpp")

There simply is no such subdirectory "include" under 
src/boost/libs/config so the EXISTS conditional always evaluates to 
"false" and hence Boost always gets downloaded from the Internet: 
https://github.com/ceph/ceph/blob/master/cmake/modules/BuildBoost.cmake#L78-L85

Any hints will be greatly appreciated! It doesn't seem right that 
make-dist goes to the trouble of downloading Boost and including it in 
the tarball, only to have to re-download it at build time.

Nathan
