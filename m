From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: RPM issues
Date: Fri, 18 Mar 2011 17:29:51 -0700
Message-ID: <AANLkTikBxKTBz8OM+gjO5Mx0JJ3TLSxXkLYf=uioBYC1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43239 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932112Ab1CSA3w (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 18 Mar 2011 20:29:52 -0400
Received: by fxm17 with SMTP id 17so4191286fxm.19
        for <ceph-devel@vger.kernel.org>; Fri, 18 Mar 2011 17:29:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Chrisman <brchrisman@gmail.com>, Terrance Hutchinson <terrance.hutchinson@gmail.com>, Jim Schutt <jaschut@sandia.gov>, ceph-devel@vger.kernel.org

Hi all,

 We have made some progress recently on getting a Ceph RPM that works
on CentOS 5.5 and other Red Hat-derived distros.

Now that our version number no longer includes a tilde, and the spec
file has been pruned a bit, I think we have a shot at building this
cleanly.

I just have a few questions that perhaps people more experienced with
RPM packaging can answer:

1. should we have a debug SPEC file and a regular SPEC file? I think
in the long term we want to have both a Ceph and a Ceph-devel RPM
built.

2. What is the best way to bundle the python bindings? Currently I am
getting this error when building the RPM:
> error: Installed (but unpackaged) file(s) found:
> /usr/lib/python2.4/site-packages/rados.py
> /usr/lib/python2.4/site-packages/rados.pyc
> /usr/lib/python2.4/site-packages/rados.pyo
However, I need to find an RPM variable that has a path to the python
site-packages directory. automake knows this, but so far I haven't
figured out where this information lives in RPM.

This guy suggests a workaround:
http://www.linux-archive.org/centos/171366-python-sybase-centos-5-x86_64-a.html
But his workaround seems kind of clumsy, and in fact doesn't work for
me on CentOS 5.5. Surely there is a standard way to refer to the
sit-packages directory in RPM without hacks?

3. How should we handle tcmalloc, if at all? Google-perftools is not
bundled for 64 bit on CentOS. (It seems like this decision was made
because some of the stuff in this package is buggy on 64 bit x86.
However, tcmalloc itself is not buggy on 64 bit.). And in general, how
do we handle things that are "good to have" but which shouldn't be
dependencies?

cheers,
Colin
