From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: Re: libs3 build errors
Date: Fri, 11 May 2012 16:59:16 -0700
Message-ID: <32072637-AF2C-48ED-9D35-1D8C20A28C4C@cs.ucsc.edu>
References: <32649264-9077-48F0-AF8B-B59EACDBD6B1@cs.ucsc.edu> <Pine.LNX.4.64.1205111652280.17928@cobra.newdream.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-01.cse.ucsc.edu ([128.114.48.32]:49437 "EHLO
	mail-01.cse.ucsc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761323Ab2EKX7R convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 May 2012 19:59:17 -0400
In-Reply-To: <Pine.LNX.4.64.1205111652280.17928@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org


On May 11, 2012, at 4:52 PM, Sage Weil wrote:

> On Fri, 11 May 2012, Noah Watkins wrote:
>> The latest master branch passes ./configure and dpkg-checkbuilddeps tests, but the the build fails:
>> 
>> Any work around? I'm on Ubuntu 11.04.. the only thing I see in the repositories is a libxml2-dev, but includes <libxml2/parser.h>.
> 
> Did you 'git submodule update --init'?

Yup. All update-to-date:

nwatkins@kyoto:~/projects/ceph/ceph$ git submodule status
 cddd50247fe2d578c1bd25d011594888865f70da ceph-object-corpus (heads/master)
 eee22bb3eca01404983f38109232034a3fcff474 src/leveldb (heads/master)
 f049cb9840b38e96cb76f78242f067c154d1c666 src/libs3 (heads/master)

libxml2-config --cflags is returning the correct paths, but this isn't being reflected in libs3 for some reason.

- Noah