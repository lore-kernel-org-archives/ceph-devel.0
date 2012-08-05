From: Matthew Roy <imjustmatthew@gmail.com>
Subject: "no key for auth" when running "auth export mon. -o /tmp/monkey"?
Date: Sun, 5 Aug 2012 02:13:59 -0400
Message-ID: <CADXA5U0m-PXRnZJhN83+HQ6uZXiM76A+ZD=q2JdrUD_8-q0Gmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:64105 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab2HEGN7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 5 Aug 2012 02:13:59 -0400
Received: by pbbrr13 with SMTP id rr13so736063pbb.19
        for <ceph-devel@vger.kernel.org>; Sat, 04 Aug 2012 23:13:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

When following http://ceph.com/docs/master/ops/manage/grow/mon/#adding-a-monitor
running the command:

ceph auth export mon. -o /tmp/monkey

on a working cluster gives the result:

no key for auth(auid = <20 digits> key=AAAAAAAAAAAAAAAA with 0 caps)

The key "mon." is in the monitors' keyrings, but not in the list of
keys returned by "ceph auth list". Is this an indication of a problem
with the cluster or a bug in the documentation?

Thanks for your help,
Matthew
