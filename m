From: =?UTF-8?Q?Bart=C5=82omiej_=C5=9Awi=C4=99cki?=
	<bartlomiej.swiecki@corp.ovh.com>
Subject: quick way to rebuild deb packages
Date: Tue, 21 Jul 2015 18:15:07 +0200
Message-ID: <20150721181507.138bc9380985439e49ac05ab@corp.ovh.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 2.mo1.mail-out.ovh.net ([178.32.119.250]:46581 "EHLO
	2.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933095AbbGUWMF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Jul 2015 18:12:05 -0400
Received: from mail612.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo1.mail-out.ovh.net (Postfix) with SMTP id 27FE310700B9
	for <ceph-devel@vger.kernel.org>; Tue, 21 Jul 2015 18:15:14 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

I'm currently working on a test environment for ceph where we're using deb files to deploy new version on test cluster.
To make this work efficiently I'd have to quckly build deb packages.

I tried dpkg-buildpackages -nc which should keep the results of previous build but it ends up in a linking error:

> ...
>   CXXLD    ceph_rgw_jsonparser
> ./.libs/libglobal.a(json_spirit_reader.o): In function `~thread_specific_ptr':
> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boost::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cleanup_function>, void*, bool)'
> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boost::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cleanup_function>, void*, bool)'
> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boost::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cleanup_function>, void*, bool)'
> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boost::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cleanup_function>, void*, bool)'
> /usr/include/boost/thread/tss.hpp:79: undefined reference to `boost::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cleanup_function>, void*, bool)'
> ./.libs/libglobal.a(json_spirit_reader.o):/usr/include/boost/thread/tss.hpp:79: more undefined references to `boost::detail::set_tss_data(void const*, boost::shared_ptr<boost::detail::tss_cleanup_function>, void*, bool)' follow
> ./.libs/libglobal.a(json_spirit_reader.o): In function `call_once<void (*)()>':
> ...

Any ideas on what could go wrong here ?

Version I'm compiling is v0.94.1 but I've observed same results with 9.0.1.

-- 
Bartlomiej Swiecki <bartlomiej.swiecki@corp.ovh.com>
