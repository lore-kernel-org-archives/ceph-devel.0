From: Wido den Hollander <wido@42on.com>
Subject: Re: Update on ceph-mgr
Date: Wed, 18 May 2016 13:10:58 +0200 (CEST)
Message-ID: <295874104.352.1463569858689@ox.pcextreme.nl>
References: <CALe9h7fCyrZGPqcymcsRiHwVMaTUP26c8xmQO6QAy6XkfVO27w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:38806 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751891AbcERLLF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 18 May 2016 07:11:05 -0400
In-Reply-To: <CALe9h7fCyrZGPqcymcsRiHwVMaTUP26c8xmQO6QAy6XkfVO27w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>


> Op 18 mei 2016 om 13:02 schreef John Spray <jspray@redhat.com>:
> 
> 
> Hi all,
> 
> For those who are interested, I wanted to give a quick update on the
> recently-started ceph-mgr work.  This is all still very changeable,
> but now that some code exists I'm putting it out there.
> 
> Firstly, here it is: https://github.com/jcsp/ceph/tree/wip-ceph-mgr
> 
> The place I'm starting is with the python embedding.  Currently it's
> running the REST API code that previously lived in Calamari, which you
> can now see in src/pybind/mgr/ (entry point is rest.py).  As
> previously discussed, the Python interface is pretty minimal:
>  * Python modules expose a serve() method and a notify() method (see rest.py)
>  * Python modules consume methods "get" (for cluster objects like
> maps), get_server (for the list of servers+services) and send_command
> (for sending rados commands)
> 
> The rest.py module is serving the webapp using cherrypy -- this is a
> handy choice because it just uses plain python threads, which are
> fairly easy to deal with from the C++ side (gevent has a whole
> different model that C-land sometimes needs to be aware of, gunicorn
> uses multiprocessing).
> 
> I had to update some of the rest api code to work with the latest
> version of django-rest-framework because Calamari was using an older
> one.  My code is working with the versions of python dependencies that
> are present in Fedora 22.
> 
> To play with this:
>  1. Build your tree with cmake
>  2. make ceph-mgr
>  3. CALAMARI_CONFIG=<whereever>/ceph/src/pybind/mgr/calamari.conf
> PYTHONPATH=env/lib/python2.7/site-packages bin/ceph-mgr -f
>  4. Point your browser at e.g.
> http://localhost:8002/api/v2/cluster/osd and witness that you get
> calamari-like API output
> 
> Next part is the integration with the mon so that we can run ceph-mgr
> as an active/standby HA service, and let it store its configuration
> inside the mon.  Once we have that, combined with the embedded python
> parts, this will turn into a nicely cleaned up pull request for the
> main ceph tree.
> 

So is the idea that when you install 'ceph-mon' you get the API by default?

Having a REST API for Ceph enabled at all times or with a simple click would be great for integrations with for example Salt.

And why do you need HA at all, the API mainly talks to the mon, right?

Wido

> Cheers,
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
