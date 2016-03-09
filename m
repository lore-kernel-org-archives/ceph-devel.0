From: Matt Benjamin <mbenjamin@redhat.com>
Subject: Re: civetweb, sts work
Date: Wed, 9 Mar 2016 10:32:09 -0500 (EST)
Message-ID: <1570763779.63222893.1457537529135.JavaMail.zimbra@redhat.com>
References: <20160309083504.GA1862@degu.b.linuxbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:33986 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932847AbcCIPcK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Mar 2016 10:32:10 -0500
In-Reply-To: <20160309083504.GA1862@degu.b.linuxbox.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: ceph-devel@vger.kernel.org

Hi Marcus,

Can you pull up wip-rgw-sts-3 (it's last commit from upstream looks to be Feb. 26).

Thanks!

Matt

----- Original Message -----
> From: "Marcus Watts" <mwatts@redhat.com>
> To: ceph-devel@vger.kernel.org
> Sent: Wednesday, March 9, 2016 3:35:04 AM
> Subject: civetweb, sts work
> 
> I've just pushed out two new ceph branches, and I pushed out
> a revised copy of civetweb that these both use.
> 
> I've pushed my git branches to git@github.com:ceph/ceph.git
> They are:
> wip-openssl-2
> 	( based on recentish master. )
> 	ssl patches (should be the same as what's already in master)
> 	+ "build out of tree" am changes (as described previously)
> 	+ civetweb "ng" changes.
> 		I've managed to build this with both cmake and configure.
> 		I haven't had time to do any testing past that yet.
> 		It "should" all work of course...
> wip-rgw-sts-3
> 	everything that's in wip-openssl-2
> 	+ rgw-sts work.
> 	includes polymorphic rgw error object
> 	split out of some parts of rgw rest interface into objstore
> 		+ "generic" bits. (sts isn't an object store)
> 	basic sts encode/decode stuff.
> 		I've managed to build this with both cmake and configure.
> 		I haven't had time to do any testing past that yet.
> 		All the basic bits should work.
> 		The radosgw parts should work if I haven't broken them.
> 		The sts parts are still missing a lot of functionality.
> 

-- 
Matt Benjamin
Red Hat, Inc.
315 West Huron Street, Suite 140A
Ann Arbor, Michigan 48103

http://www.redhat.com/en/technologies/storage

tel.  734-707-0660
fax.  734-769-8938
cel.  734-216-5309
