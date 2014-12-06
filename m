From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: normalizing radosgw
Date: Sat, 6 Dec 2014 10:39:53 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412061025330.18213@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Several things are different/annoying with radosgw than with other Ceph 
daemons:

- binary/package are named 'radosgw' instead of 'ceph-rgw'.

This is cosmetic, but it also makes it fit less well into the 
new /var/lib/ceph/* view of things.

- default log location is /var/log/radosgw/$cluster-$name.log instead of 
/var/lib/ceph/$cluster-$rgw.$name.log (or similar).

- rgw_data default is /var/lib/ceph/radosgw instead of /var/lib/ceph/rgw

(not sure if 3 letters for consistency is better?)

- rgw usually authenticates as a client.something user, which means if you 
do use more standard rgw log names, then you get 
/var/log/ceph/client.something.$pid.$uniqueid.log.  There is a loose 
convention that 'something' is 'rgw.hostname' (i.e., client.rgw.hostname).

- radosgw has it's own separate sysvinit script that enumerates daemons 
from /etc/ceph/ceph.conf sections that start with client.radosgw.*

- radosgw upstart script is called radosgw (not ceph-rgw) and enumerates 
daemons from /var/lib/ceph/radosgw/*

(totally different than sysvinit!)

- radosgw instances usually need some stuff in ceph.conf to make them 
behave properly, which means they need a section in the shared 
/etc/ceph/ceph.conf.  more work for admins or config management systems.

- on rpm-based systems we have a separate sysvinit script that is 
slightly different (mostly because the username is different, apache 
instead of www-data).

---

There is enough wrong here and little enough convention that my 
proposal is to essentially start fresh:

- rename package ceph-rgw.  obsoletes/replaces radosgw.  

- merge rgw start/stop into standard sysvinit script (just another 
daemon type?).

- normalize upstart start/stop (just rename radosgw-* to ceph-rgw-*, 
basically).

- make upstart use /var/lib/ceph/rgw instead of /var/lib/ceph/radosgw (do 
this automagically on upgrade?  that will at least avoid the upgrade pain 
for ubuntu users)

- create new systemd start/stop that are correct the first time 
around.

- move log file to /var/log/ceph


The part I'm not sure about is how to handle config.  I would really like 
the ability to put per-daemon config stuff in /var/lib/ceph/rgw/foo/conf 
or config, but there is no 'include file' function in our ini-file parser 
(or in other typical ini-file implementations that i can find) and I don't 
like the idea the per-daemon config would completely supplant the 
/etc/ceph/ one.

Basically, I'd like to get to a point where we can programatically deploy 
an rgw without any wonky code that edits the ceph.conf.  Perhaps the way 
to accomplish this is to have the admin create a generic client.rgw user 
and generic [client.rgw] section in the global ceph.conf?

If there were an include file function, we could make the per-daemon 
config file something like

 include /etc/ceph/$cluster.conf
 [client.rgw.hostname]
 rgw foo = bar
 rgw baz = blip

or whatever.

Thoughts?  Suggestions?

sage
