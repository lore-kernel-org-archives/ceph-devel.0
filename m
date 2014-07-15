From: =?ISO-8859-1?Q?Luis_Pab=F3n?= <lpabon@redhat.com>
Subject: Re: rpm dependencies
Date: Tue, 15 Jul 2014 15:02:30 -0400
Message-ID: <53C57AC6.2030303@redhat.com>
References: <alpine.DEB.2.00.1407142132260.21295@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55977 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932924AbaGOTCd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 15 Jul 2014 15:02:33 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6FJ2VWG004002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <ceph-devel@vger.kernel.org>; Tue, 15 Jul 2014 15:02:32 -0400
In-Reply-To: <alpine.DEB.2.00.1407142132260.21295@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

Hi Sage,
     Looks like it is configuration issue in configure.ac.  I'm fixing 
the issue now and will be sending a patch soon.

- Luis


On 07/15/2014 12:39 AM, Sage Weil wrote:
> Hey Luis,
>
> I pushed wip-dencoder, which moves ceph-dencoder to ceph from ceph-common.
> This avoids the dependency for ceph-common.
>
> For the librados2 package, though, there is still a leveldb dependency
> that makes no sense.  See the packages at
>
>   http://gitbuilder.ceph.com/ceph-rpm-rhel6_5-x86_64-basic/ref/wip-dencoder/x86_64/
>
>   $ wget http://gitbuilder.ceph.com/ceph-rpm-rhel6_5-x86_64-basic/ref/wip-dencoder/x86_64/librados2-0.82-595.g95f5a44.el6.x86_64.rpm
>   $ rpm -qpR librados2-0.82-595.g95f5a44.el6.x86_64.rpm | grep level
>   warning: librados2-0.82-595.g95f5a44.el6.x86_64.rpm: Header V4 DSA/SHA1 Signature, key ID 03c3951a: NOKEY
>   libleveldb.so.1()(64bit)
>   $ rpm2cpio librados2-0.82-595.g95f5a44.el6.x86_64.rpm | cpio -i --make-directories
>   ...
>   $ ldd usr/lib/librados2.so.2 | grep -c leveldb
>   1
>
> Our Makefile.am doesn't specify that we link against leveldb for librados,
> although strangely it is listed in the librados.la file anyway (along with
> every other lib anything links against).  Despite this, ldd
> .libs/librados.so on my (debian) box doesn't list it when building
> locally.
>
> The Makefile-env.am has --as-needed, which is supposed to make us only use
> dependencies we actually use.
>
> Not sure what is going on with the RPM build that is putting this
> dependency in place...
>
> Any idea what is going on?  :/
>
> sage

