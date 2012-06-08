From: Matt Weil <mweil@genome.wustl.edu>
Subject: CentOS 6.2 build error
Date: Fri, 08 Jun 2012 11:33:36 -0500
Message-ID: <4FD22960.2040006@genome.wustl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from gscsmtp.wustl.edu ([128.252.233.26]:49995 "HELO
	gscsmtp.wustl.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751931Ab2FHQdg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Jun 2012 12:33:36 -0400
Received: from dhcp-10-0-7-38.gsc.wustl.edu (dhcp-10-0-7-38.gsc.wustl.edu [10.0.7.38])
	by gscsmtp.wustl.edu (Postfix) with ESMTPSA id 1930E40074
	for <ceph-devel@vger.kernel.org>; Fri,  8 Jun 2012 11:33:36 -0500 (CDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

>   CXX    libosdc_la-Objecter.lo
>   CXX    libosdc_la-ObjectCacher.lo
>   CXX    libosdc_la-Filer.lo
> osdc/ObjectCacher.cc: In member function 'int ObjectCacher::_readx(ObjectCacher::OSDRead*, ObjectCacher::ObjectSet*, Context*, bool)':
> osdc/ObjectCacher.cc:1043: error: 'INT_MAX' was not declared in this scope
> make[3]: *** [libosdc_la-ObjectCacher.lo] Error 1
> make[3]: *** Waiting for unfinished jobs....
> make[3]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47.2/src'
> make[2]: *** [all-recursive] Error 1
> make[2]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47.2/src'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/rpmbuild/BUILD/ceph-0.47.2/src'
> make: *** [all-recursive] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.ey4eKa (%build)
>
>
> RPM build errors:
>     Bad exit status from /var/tmp/rpm-tmp.ey4eKa (%build)
