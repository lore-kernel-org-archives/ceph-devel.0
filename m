From: <Eric_YH_Chen@wiwynn.com>
Subject: Snapshot/Clone in RBD
Date: Tue, 22 May 2012 18:39:06 +0800
Message-ID: <8512670932FB654F81AF0FEF1BE6D49D016566CC@WHQBEMAIL1.whq.wistron>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from twnhumsw3.wistron.com ([220.128.89.23]:57978 "EHLO
	TWNHUMSW3.wistron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757916Ab2EVKtJ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 May 2012 06:49:09 -0400
Received: from TWNHUFE4.whq.wistron (unverified [10.37.31.104]) by TWNHUMSW3.wistron.com
 (Clearswift SMTPRS 5.4.0) with ESMTP id <Ta48243797bc0a816711b14@TWNHUMSW3.wistron.com> for <ceph-devel@vger.kernel.org>;
 Tue, 22 May 2012 18:41:36 +0800
Content-class: urn:content-classes:message
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all:

    According to the document, snapshot in RBD is "Read-only".  

    That is to say, if I want to clone the image, I should use
"rbd_copy". Right?

    I am curious about if this function is optimized, ex: copy-on-write,
to speed up the performance.
    
    What I want to do is to integrate rbd with kvm. I hope that I can
clone the image as soon as possible to speed up the vm creation.

    (One base image, and create other vm from this.)
  
    Do you have any suggestion about this point? Thanks a lot! 
