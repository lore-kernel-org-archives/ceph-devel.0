From: Eric Eastman <eric0e-YDxpq3io04c@public.gmane.org>
Subject: Re: ceph-deploy mon create / gatherkeys problems
Date: Sun, 18 Aug 2013 16:28:39 -0400 (EDT)
Message-ID: <8D06A68A827BE16-FF0-46E32@webmail-d235.sysops.aol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

It may be overkill, but my notes on starting over with loading ceph on
my test clusters is:

From ceph00  (my admin node)
  ceph-deploy -v purge ceph00 ceph01 ceph02 ceph03 ceph04 ...

Then on each system
   rm -rf /var/lib/ceph /etc/ceph

Then reinstall the ceph software and configure it with ceph-deploy.

With ceph-deploy version 1.0-1 this solved problems with re-installing
ceph with ceph-deploy, as these directories were not fully cleaned
with the purge option.  Maybe we need a "distclean" option.

I am installing my first cluster built with ceph-deploy version 1.2.1
and I really like debug being the default, so I can see what
its doing. I will report if I find any issues with it.

* If you previously had a problem here and then realized you
were doing something not quite right and got it working, please
reply and share  what it was so we can make sure others avoid the 
problem!
