From: John Spray <jspray@redhat.com>
Subject: Update on ceph-mgr
Date: Wed, 18 May 2016 12:02:34 +0100
Message-ID: <CALe9h7fCyrZGPqcymcsRiHwVMaTUP26c8xmQO6QAy6XkfVO27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:33289 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbcERLCz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2016 07:02:55 -0400
Received: by mail-oi0-f44.google.com with SMTP id v145so70270329oie.0
        for <ceph-devel@vger.kernel.org>; Wed, 18 May 2016 04:02:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi all,

For those who are interested, I wanted to give a quick update on the
recently-started ceph-mgr work.  This is all still very changeable,
but now that some code exists I'm putting it out there.

Firstly, here it is: https://github.com/jcsp/ceph/tree/wip-ceph-mgr

The place I'm starting is with the python embedding.  Currently it's
running the REST API code that previously lived in Calamari, which you
can now see in src/pybind/mgr/ (entry point is rest.py).  As
previously discussed, the Python interface is pretty minimal:
 * Python modules expose a serve() method and a notify() method (see rest.py)
 * Python modules consume methods "get" (for cluster objects like
maps), get_server (for the list of servers+services) and send_command
(for sending rados commands)

The rest.py module is serving the webapp using cherrypy -- this is a
handy choice because it just uses plain python threads, which are
fairly easy to deal with from the C++ side (gevent has a whole
different model that C-land sometimes needs to be aware of, gunicorn
uses multiprocessing).

I had to update some of the rest api code to work with the latest
version of django-rest-framework because Calamari was using an older
one.  My code is working with the versions of python dependencies that
are present in Fedora 22.

To play with this:
 1. Build your tree with cmake
 2. make ceph-mgr
 3. CALAMARI_CONFIG=<whereever>/ceph/src/pybind/mgr/calamari.conf
PYTHONPATH=env/lib/python2.7/site-packages bin/ceph-mgr -f
 4. Point your browser at e.g.
http://localhost:8002/api/v2/cluster/osd and witness that you get
calamari-like API output

Next part is the integration with the mon so that we can run ceph-mgr
as an active/standby HA service, and let it store its configuration
inside the mon.  Once we have that, combined with the embedded python
parts, this will turn into a nicely cleaned up pull request for the
main ceph tree.

Cheers,
John
