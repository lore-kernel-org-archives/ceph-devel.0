From: Takuya ASADA <syuu@dokukino.com>
Subject: Java binding for RADOS API
Date: Fri, 12 Nov 2010 12:37:13 +0000
Message-ID: <AANLkTinCd2NJAo7WFY0EcOirWBbu_SfM7M0GcDGbxYHx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57936 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756625Ab0KLMhg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 12 Nov 2010 07:37:36 -0500
Received: by wyb28 with SMTP id 28so1861631wyb.19
        for <ceph-devel@vger.kernel.org>; Fri, 12 Nov 2010 04:37:35 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I had implemented Java binding for RADOS API to integrate RADOS for
Eucalyptus, the opensource IaaS platform.

The API is based on librados with small changes:
class Rados is container of librados::Rados, it does only create_pool,
list_pools, lookup_pool, open_pool.
To access objects, it uses class Pool, which is container of
librados::pool_t, can received from Rados.openPool().
This has read, write, remove, stat and list_objects_open.

Sample code:
https://github.com/syuu1228/rados4j/blob/master/test/Test.java

Whole code can fetch from:
https://github.com/syuu1228/rados4j

Javadoc is available on following URL(API list only, not documented yet):
http://rados4j.dokukino.com/doc/

Here's build sequence:
$ ant             # this will save librados4j.so and rados4j.jar into target/
$ ant javadoc # if an API document needed

I want to contribute it like phprados.
Comments?

syuu
