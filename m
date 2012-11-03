From: Sage Weil <sage@inktank.com>
Subject: Re: python-ceph
Date: Sat, 3 Nov 2012 11:59:09 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1211031158120.25450@cobra.newdream.net>
References: <CACkq2momtqxBZ+XCz_j_kiJsbn_8epU=vovn8-RfAob-d5d-wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35537 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753724Ab2KCS7K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Nov 2012 14:59:10 -0400
In-Reply-To: <CACkq2momtqxBZ+XCz_j_kiJsbn_8epU=vovn8-RfAob-d5d-wA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Travis Rhoden <trhoden@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Fri, 2 Nov 2012, Travis Rhoden wrote:
> Hi folks,
> 
> Are there any plans to release python-ceph to pypi?  It would be nice
> to see it packaged up in distutils/egg format and added to pypi, that
> way other python packages can list it as a dependency.

This is definitely something we want to work.

> I know there is currently a python-ceph package in Debian, but that
> doesn't allow me to list it as a dependency in a setup.py file and
> have it installed in a virtualenv, for example.  Right now I have to
> copy rbd.py into my virtualenv.
> 
> Curious to know if this is something you would consider.  Perhaps it
> is something I could help with.

That would be great!

sage
