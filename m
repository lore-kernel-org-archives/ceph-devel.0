From: Mike Dawson <mike.dawson-9dgm/EUDD3RBYT3KYJiKsA@public.gmane.org>
Subject: Urgent Notice to Users on 0.61.1
Date: Fri, 10 May 2013 23:27:19 -0400
Message-ID: <518DBA97.7030506@scholarstack.com>
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
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Anyone running 0.61.1,

Watch out for high disk usage due to a file likely located at 
/var/log/ceph/ceph-mon.<mon-name>.tdump. This file contains debugging 
for monitor transactions. This debugging was added in the past week or 
so to track down another anomaly. It is not necessary (or useful unless 
you are debugging monitor transactions).

Depending on the load of your cluster, the tdump file may become large 
quickly. I've seen it grow over 50GB/day.

IMHO, the default setting should be "false", but it was merged in prior 
to 0.61.1 with a default of "true". If you are on 0.61.1, you can 
confirm the settings with:

ceph --admin-daemon /var/run/ceph/ceph-mon.<mon-name>.asok config show | 
grep mon_debug_dump

To disable it, add "mon debug dump transactions = false" to ceph.conf, 
and restart your monitors. Alternatively, you can inject the argument or 
add the cmdline flag.

dmick has an issue started at:
http://tracker.ceph.com/issues/5024

Thanks,
Mike
