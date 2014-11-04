From: Cheng Wei-Chung <freeze.vicente.cheng@gmail.com>
Subject: Conflict with libgoogle-perftools4 in ubuntu12.04(precise)
Date: Tue, 4 Nov 2014 11:45:11 +0800
Message-ID: <CABF_e-Fv1V8ACFFOYuiKWe8gy133P-eJuY0u8t4Nf3V_AWODrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33825 "EHLO
	mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbaKDDpM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Nov 2014 22:45:12 -0500
Received: by mail-oi0-f49.google.com with SMTP id u20so9559479oif.8
        for <ceph-devel@vger.kernel.org>; Mon, 03 Nov 2014 19:45:11 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Dear all:

I know that the default precise repo did not have libgoogle-perftools4.
It should only have libgoogle-perftools0.
In the situation that we add the Ubuntu Cloud Archive will bring
libgoogle-perftools4 with havana icehouse, juno and later version.
It will make conflict with ceph if we have other softwares like
mongodb that depends on libgoogle-perftools4.

I found the following feature:
http://tracker.ceph.com/issues/8039
Is this feature still haven't done, right?

I try to build the ceph version 0.87 with libgoogle-perftools4 and
upgrade from firefly in my test environment.

It looks work normally. I think ceph can work on
libgoogle-perftools0/libgoogle-perftools4.

Is there the plan for fix this conflict for the people using the
ubuntu cloud archive in precise?
Or we need to build a specific version with libgoogle-perftools4 if we
have any reasons to use libgoogle-perftools4.

very thanks!!!
