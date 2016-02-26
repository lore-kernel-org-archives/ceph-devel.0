From: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: vstart and Python bindings
Date: Thu, 25 Feb 2016 17:27:04 -0700
Message-ID: <20160225172704.134e9480@lembas.zaitcev.lan>
References: <20160224233718.6a8c7569@lembas.zaitcev.lan>
	<56CEA76D.9040200@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53459 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752728AbcBZA1F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 25 Feb 2016 19:27:05 -0500
In-Reply-To: <56CEA76D.9040200@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

Dear Loic:

The PR 7792 is not the problem. The issue appears to be that cythonization
is not performed (anymore). There's a coupld of Makefile.am files in
src/pybind, but no relevant Makefile files are generated. I tried to make
it more explicit with this:

./configure --with-rados --with-cython --with-radosgw

Still no effect.

Greetings,
-- Pete

On Thu, 25 Feb 2016 14:04:13 +0700
Loic Dachary <loic@dachary.org> wrote:

> Hi Pete,
> 
> You need https://github.com/ceph/ceph/pull/7792 which is going to be merged real soon now ;-)
> 
> Cheers
> 
> On 25/02/2016 13:37, Pete Zaitcev wrote:
> > I did a git pull today and rebuilt. Ran vstart, and it produced a
> > Python traceback, ending with:
> > 
> > ImportError: No module named rados
> > 
> > Oooookay... This box never had Python bindings installed, but okay,
> > someone innovated something. Fine, I thought. Installed python-rados,
> > and ./ceph -w tracebacks:
> > 
> > Traceback (most recent call last):
> >   File "./ceph", line 953, in <module>
> >     retval = main()
> >   File "./ceph", line 778, in main
> >     run_in_thread(cluster_handle.monitor_log, level, watch_cb, 0)
> > AttributeError: 'Rados' object has no attribute 'monitor_log'
> > 
> > Of course. The system version of pybind is obsolete, but ./ceph gets
> > wrong one. Actually, it's not even getting built from .pyx anymore.
> > 
> > Could whoever did all this please undo?
> > 
> > -- Pete

