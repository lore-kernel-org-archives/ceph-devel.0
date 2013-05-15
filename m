From: Gary Lowell <gary.lowell@inktank.com>
Subject: Re: 0.61 Cuttlefish / ceph-deploy missing in repos
Date: Wed, 15 May 2013 11:14:06 -0700
Message-ID: <C5E2743C-491F-4A79-82C6-0E8F352887C3@inktank.com>
References: <alpine.DEB.2.00.1305061744430.9909@cobra.newdream.net> <20130515110842.GA28468@oder.mch.fsc.net> <alpine.DEB.2.00.1305150846330.14301@cobra.newdream.net> <20130515173002.GB28468@oder.mch.fsc.net>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:46472 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932919Ab3EOSOW convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 May 2013 14:14:22 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so4241736iec.7
        for <ceph-devel@vger.kernel.org>; Wed, 15 May 2013 11:14:22 -0700 (PDT)
In-Reply-To: <20130515173002.GB28468@oder.mch.fsc.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kasper Dieter <dieter.kasper@ts.fujitsu.com>
Cc: Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Hi Kasper -

ceph-deploy has a couple open bugs on Fedora that we need to fix before it works.  Currently the only supported rpm platform is  Centos/RHEL 6.  Those packages can be found at http://ceph.com/rpm-cuttlefish/el6/noarch/ .    The modules install into the python 2.6.6 site library so they may not be useful for Fedora.

Fedora rpms will be available as soon as we sort out the open bugs.

Cheers,
Gary


On May 15, 2013, at 10:30 AM, Kasper Dieter wrote:

> On Wed, May 15, 2013 at 05:48:22PM +0200, Sage Weil wrote:
>> On Wed, 15 May 2013, Kasper Dieter wrote:
>>> Hi Sage,
>>> I'm a little bit confused about 'ceph-deploy' in 0.61:
>>> 
>>> . the 0.61 release note says: "ceph-deploy: our new deployment tool to replace 'mkcephfs'"
>>> . http://ceph.com/docs/master/rados/deployment/mkcephfs/
>>> 	says "To deploy a test or development cluster, you can use the mkcephfs tool. 
>>> 	We do not recommend using this tool for production environments."
>> 
>> Adjustd this in the docs, thanks!
>> 
>>> . http://ceph.com/docs/master/rados/deployment/
>>> 	says "MKCEPHFS (DEPRECATED)
>>> 	(...) As of Ceph v0.60, it is deprecated in favor of ceph-deploy."
>>> 
>>> But, /usr/sbin/mkcephfs is provided by the ceph*0.61.2*rpm(s)
>>> whereas ceph-deploy is missing.
>> 
>> ceph-deploy is packaged separately as it is designed to deploy any version 
>> of Ceph (>= bobtail).  The ceph-deploy package should be in the same repos 
>> as the ceph packages; if they are missing, let us know.  
> 
> yes, they are missing
> 
> e.g.
> http://ceph.com/rpm-cuttlefish/fc17/x86_64/
>      ceph-0.61.2-0.fc17.x86_64.rpm           13-May-2013 17:12  9.9M  
>      ceph-debuginfo-0.61.2-0.fc17.x86_64.rpm 13-May-2013 17:12  278M  
>      ceph-devel-0.61.2-0.fc17.x86_64.rpm     13-May-2013 17:12   36K  
>      ceph-fuse-0.61.2-0.fc17.x86_64.rpm      13-May-2013 17:12  1.0M  
>      ceph-radosgw-0.61.2-0.fc17.x86_64.rpm   13-May-2013 17:12  1.3M  
>      ceph-release-1-0.fc17.noarch.rpm        13-May-2013 17:15  3.5K  
>      ceph-test-0.61.2-0.fc17.x86_64.rpm      13-May-2013 17:12   10M  
>      cephfs-java-0.61.2-0.fc17.x86_64.rpm    13-May-2013 17:12   22K  
>      libcephfs1-0.61.2-0.fc17.x86_64.rpm     13-May-2013 17:12  1.3M  
>      libcephfs_jni1-0.61.2-0.fc17.x86_64.rpm 13-May-2013 17:12   33K  
>      librados2-0.61.2-0.fc17.x86_64.rpm      13-May-2013 17:12  1.1M  
>      librbd1-0.61.2-0.fc17.x86_64.rpm        13-May-2013 17:12  224K  
>      python-ceph-0.61.2-0.fc17.x86_64.rpm    13-May-2013 17:12   32K  
>      rbd-fuse-0.61.2-0.fc17.x86_64.rpm       13-May-2013 17:12   12K  
>      rest-bench-0.61.2-0.fc17.x86_64.rpm     13-May-2013 17:12  226K  
> 
> same in fc18, el6, sles11, ...
> 
> Best Regards,
> -Dieter
> 
> 
>> We are still 
>> streamlining the build process for that package so that updates and fixes 
>> (for the deployment tool) get published more quickly.
>> 
>>> The only way to get ceph-deploy seems to be using git:
>>> git clone https://github.com/ceph/ceph-deploy.git
>> 
>> This also works.
>> 
>> Thanks!
>> sage
>> 
>> 
>>> 
>>> 
>>> Is this the way it should be ?
>>> When will ceph-deploy be included in the Cuttlefish rpms ?
>>> 
>>> 
>>> Best Regards,
>>> -Dieter
>>> 
>>> 
>>> On Tue, May 07, 2013 at 04:51:25AM +0200, Sage Weil wrote:
>>>> Spring has arrived (at least for some of us), and a new stable release of 
>>>> Ceph is ready!  Thank you to everyone who has contributed to this release!
>>>> 
>>>> Bigger ticket items since v0.56.x "Bobtail":
>>>> 
>>>> * ceph-deploy: our new deployment tool to replace 'mkcephfs'
>>> (...)
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

