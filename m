From: JJ <jjones@cirrhus9.com>
Subject: autogen.sh error
Date: Tue, 31 Jan 2012 17:13:59 -0500
Message-ID: <4F2867A7.4040005@cirrhus9.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.cirrhus9.com ([75.101.139.254]:33472 "EHLO
	cirrhus9b.cirrhus9.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753040Ab2AaWQx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Jan 2012 17:16:53 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by cirrhus9b.cirrhus9.com (Postfix) with ESMTP id C8CF510D70DA
	for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 14:16:52 -0800 (PST)
Received: from cirrhus9b.cirrhus9.com ([127.0.0.1])
	by localhost (cirrhus9b.cirrhus9.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GFNfnk683Y+v for <ceph-devel@vger.kernel.org>;
	Tue, 31 Jan 2012 14:16:52 -0800 (PST)
Received: from [192.168.1.4] (dynamic-acs-24-101-150-38.zoominternet.net [24.101.150.38])
	by cirrhus9b.cirrhus9.com (Postfix) with ESMTP id 0CBDE10C6205
	for <ceph-devel@vger.kernel.org>; Tue, 31 Jan 2012 14:16:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

ceph-devs:

I keep getting errors and I am not sure how I can satisfy this?
CentOS 5.5 x86_64 / 2.6.18-194.32.1.el5xen

Makefile.am:182: `lib/libgtest.a' is not a standard libtool library name
Makefile.am:182: did you mean `lib/libgtest.la'?
Makefile.am:182: `lib/libgtest_main.a' is not a standard libtool library 
name
Makefile.am:182: did you mean `lib/libgtest_main.la'?

It looks like the test for
BuildRequires: google-perftools-devel%{?_isa} fails here?

What the heck is ?_isa ?
I don't see any such designation at
https://code.google.com/p/gperftools/downloads/list

google-perftools-devel-1.7-2.el5 / google-perftools-1.7-2.el5 are installed.

Thanks!

-- 

JJ / Habitual
Support Engineer
Cirrhus9.com

