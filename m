From: Shinobu Kinjo <skinjo@redhat.com>
Subject: [ceph-users] Ceph.conf
Date: Thu, 10 Sep 2015 04:44:07 -0400 (EDT)
Message-ID: <945773049.14811634.1441874647066.JavaMail.zimbra@redhat.com>
References: <719445511.14807548.1441873777873.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:45007 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932101AbbIJIoH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Sep 2015 04:44:07 -0400
In-Reply-To: <719445511.14807548.1441873777873.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@lists.ceph.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hello,

I'm seeing 859 parameters in the output of:

    $ ./ceph --show-config | wc -l
    *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
    859

In:

    $ ./ceph --version
    *** DEVELOPER MODE: setting PATH, PYTHONPATH and LD_LIBRARY_PATH ***
    ceph version 9.0.2-1454-g050e1c5 (050e1c5c7471f8f237d9fa119af98c1efa9a8479)

Since I'm quite new to Ceph, so my question is:

    Where can I know what each parameter exactly mean?

I am probably right. Some parameters are just for tes-
ting purpose.

Thank you for your help in advance.

Shinobu
