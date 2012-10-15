From: Tommi Virtanen <tv@inktank.com>
Subject: New branch: Python packaging integrated into automake
Date: Mon, 15 Oct 2012 11:11:54 -0700
Message-ID: <CADvuQRE=Qz2fiHsFrj4++L0zKQQAqGztnhOmYytVeVuHO63TOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:44655 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab2JOSMP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Oct 2012 14:12:15 -0400
Received: by mail-qa0-f46.google.com with SMTP id c26so1567867qad.19
        for <ceph-devel@vger.kernel.org>; Mon, 15 Oct 2012 11:12:14 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi. While working on the external journal stuff, for a while I thought
I needed more python code than I ended up needing. To support that
code, I put in the skeleton of "import ceph.foo" support. While I
ultimately didn't need it, I didn't want to throw away the results. If
you later need to have more python stuff in core ceph, use this branch
as the base.

It's intentionally separate from the python-ceph Debian package; that
one is about providing python programmers APIs to use RADOS, RBD etc
(compare to librados-dev etc); this is about Python code used by core
Ceph itself.

https://github.com/ceph/ceph/tree/automake-python
