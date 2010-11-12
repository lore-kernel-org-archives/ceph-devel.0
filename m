From: Sage Weil <sage@newdream.net>
Subject: Re: Java binding for RADOS API
Date: Fri, 12 Nov 2010 10:04:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1011121002150.13140@cobra.newdream.net>
References: <AANLkTinCd2NJAo7WFY0EcOirWBbu_SfM7M0GcDGbxYHx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44332 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756063Ab0KLSA6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Nov 2010 13:00:58 -0500
In-Reply-To: <AANLkTinCd2NJAo7WFY0EcOirWBbu_SfM7M0GcDGbxYHx@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

Hi Takuya,

This looks great!  (At least to my largely Java-averse eyes :).  I'm happy 
to put a git tree clone up, although I don't have a way to allow outside 
access so any pushes would have to then go through me.  We can also link 
it up in the wiki and elsewhere.

sage


On Fri, 12 Nov 2010, Takuya ASADA wrote:

> Hi,
> 
> I had implemented Java binding for RADOS API to integrate RADOS for
> Eucalyptus, the opensource IaaS platform.
> 
> The API is based on librados with small changes:
> class Rados is container of librados::Rados, it does only create_pool,
> list_pools, lookup_pool, open_pool.
> To access objects, it uses class Pool, which is container of
> librados::pool_t, can received from Rados.openPool().
> This has read, write, remove, stat and list_objects_open.
> 
> Sample code:
> https://github.com/syuu1228/rados4j/blob/master/test/Test.java
> 
> Whole code can fetch from:
> https://github.com/syuu1228/rados4j
> 
> Javadoc is available on following URL(API list only, not documented yet):
> http://rados4j.dokukino.com/doc/
> 
> Here's build sequence:
> $ ant             # this will save librados4j.so and rados4j.jar into target/
> $ ant javadoc # if an API document needed
> 
> I want to contribute it like phprados.
> Comments?
> 
> syuu
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
