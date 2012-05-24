From: Greg Farnum <greg@inktank.com>
Subject: Re: Problems while doing rpmbuild on CENTOS
Date: Thu, 24 May 2012 11:10:14 -0700
Message-ID: <9B1CD036B0BB44718194AB21F6649F25@inktank.com>
References: <1337848646.30818.48.camel@indica.cc.iitb.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:59623 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933458Ab2EXSKS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 14:10:18 -0400
Received: by dady13 with SMTP id y13so82590dad.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 11:10:18 -0700 (PDT)
In-Reply-To: <1337848646.30818.48.camel@indica.cc.iitb.ac.in>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ajit@iitb.ac.in
Cc: ceph-devel@vger.kernel.org

On Thursday, May 24, 2012 at 1:37 AM, Ajit K Jena wrote:
> Hi All,
> 
> I am trying to build the CEPH stuff from bzip source archive by
> using the command below:
> 
> rpmbuild -tb /home/src/ceph.related/ceph-0.47.2.tar.bz2
> 
> I get the following error:
> 
> error: File /home/src/ceph.related/libs3-trunk.tar.gz: No such
> file or directory
> 
> What is this and where do I get this file from ? Can anyone pl give
> me some pointers on this ?
> 
> Regards.
> 
> --ajit

Are you building --with-radosgw? Did you successfully build 0.47 or 0.47.1?
(This isn't an error we're familiar with and the bundled libs3 is new in 0.47 so we're running into a number of problems with its build, especially on RPM platforms.)
-Greg


