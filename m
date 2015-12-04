From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: cmake
Date: Thu, 3 Dec 2015 17:03:47 -0700
Message-ID: <20151203170347.33867061@lembas.zaitcev.lan>
References: <20151203152436.73e15e38@lembas.zaitcev.lan>
	<20151203223020.GB17144@ultraspiritum.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34208 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751983AbbLDADs (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 19:03:48 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 647E483F6A
	for <ceph-devel@vger.kernel.org>; Fri,  4 Dec 2015 00:03:48 +0000 (UTC)
In-Reply-To: <20151203223020.GB17144@ultraspiritum.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Adam C. Emerson" <aemerson@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 3 Dec 2015 17:30:21 -0500
"Adam C. Emerson" <aemerson@redhat.com> wrote:

> On 03/12/2015, Pete Zaitcev wrote:

> > I'm trying to run cmake, in order to make sure my patches do not break it
> > (in particular WIP 5073 added source files). Result looks like this:
> > 
> > [zaitcev@lembas ceph-tip]$ cmake src
> 
> I believe the problem is 'cmake src'

Thanks for the tip about the separate build directory and the top-level
CMakeLists.txt. However, it still fails like this:

[zaitcev@lembas build]$ cmake ..
CMake Error at CMakeLists.txt:1 (include):
  include could not find load file:

    GetGitRevisionDescription
...................

Do you know by any chance where it gets that include? Also, what's
your cmake --version?

Greetings,
-- Pete
