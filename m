From: Javen Wu <javen.wu@xtaotech.com>
Subject: Re: librados option 'conf' and 'cluster'.
Date: Wed, 20 Jan 2016 22:26:34 +0800
Message-ID: <569F991A.8030407@xtaotech.com>
References: <569CB969.8080601@xtaotech.com>
 <alpine.DEB.2.11.1601191007570.28274@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr213139.mail.yeah.net ([223.252.213.139]:48317 "EHLO
	mr213139.mail.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbcATO0r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Jan 2016 09:26:47 -0500
In-Reply-To: <alpine.DEB.2.11.1601191007570.28274@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, jdurgin@redhat.com

Hi Sage,

I have a quick fixing and will run more testing before post code review.
The change would be restricted to the config parsing.

With the fixing (hacking) ;)
1. When only configuration file is given, cluster name would be the 
prefix of
the basename of conf file.
2. When both configuration file and cluster name are given, both 
arguments are
respected.
3. When only cluster name is given, configuration file would be
/etc/ceph/$cluster.conf.

With the change,
1. openstack cinder-volume rbd driver
2. qemu rbd driver
3. all consumers of rados_create()
would be able to support the CEPH clusters not being named 'ceph'
without change.

Thanks
Javen
Sage Weil wrote:
> On Mon, 18 Jan 2016, Javen Wu wrote:
>> Hi buddies,
>>
>> Recently, I met a problem about librados option 'conf' and 'cluster'.
>> I created a CEPH cluster but not name it 'ceph', it triggers a lot of problems
>> on my openstack environment.
>> I found there are consumers of librados or librados python binding only
>> respect
>>   'conf' option. However, the option 'cluster' is ignored usually.
>>
>> So far, I suffered the problem in:
>> 1. librados python binding
>> 2. qemu rbd driver
>> 3. cinder volume rbd driver
>>
>> I saw there is rados_create2() API in librados besides rados_create(), but
>> it seems the API is not widedly used by consumers yet.
>>
>> I am thinking whether we can do a compromise in librados. If consumers of
>> librados does not give an arguments for 'cluster'(cluster name) explicitly,
>> Can we use (basename(conffile).split('.conf')[0]) as cluster name by
>> default in librados?
>>
>> So that all consumers of the librados can tolerate the non-'ceph' cluster name
>> without any change.
>>
>> How do you guys think? If you agree to the change, I can do the quick fixing.
> This would be a bit of a hack, but it seems reasonable enough to me--I
> can't think of anything that would break as a result.
>
> Josh, what do you think?  The logic it could even be restricted to the
> client side only...
>
> sage
>

