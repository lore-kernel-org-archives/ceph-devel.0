From: Wido den Hollander <wido@widodh.nl>
Subject: Re: Java binding for RADOS API
Date: Fri, 12 Nov 2010 14:35:44 +0100
Message-ID: <1289568944.4894.16.camel@wido-desktop>
References: <AANLkTinCd2NJAo7WFY0EcOirWBbu_SfM7M0GcDGbxYHx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp02.mail.pcextreme.nl ([109.72.87.138]:58161 "EHLO
	smtp02.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab0KLNfr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Nov 2010 08:35:47 -0500
In-Reply-To: <AANLkTinCd2NJAo7WFY0EcOirWBbu_SfM7M0GcDGbxYHx@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Takuya ASADA <syuu@dokukino.com>
Cc: ceph-devel@vger.kernel.org

Hi Takuya,

Great work! I've been following rados4j for a while now (Found you on
Github), like the approach!

Eucalyptus works with Qemu took right, wouldn't Qemu-RBD be a better
solution? Or what are your plans with RADOS for Eucalyptus?

But great work! I think a lot of people don't see the full potential of
RADOS, hope your bindings and phprados will make more people use RADOS.

If you ask Sage, he might want to setup a new GIT repo for you and a
project in the tracker, so we can keep track of bugs and features.

Thanks,

Wido

On Fri, 2010-11-12 at 12:37 +0000, Takuya ASADA wrote:
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

