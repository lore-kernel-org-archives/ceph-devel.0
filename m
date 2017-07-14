From: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Subject: upgrade procedure to Luminous
Date: Fri, 14 Jul 2017 15:01:25 +0100
Message-ID: <fc6ff947-e806-84c8-4eae-099a465482c6@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Dear all,


The current upgrade procedure to jewel, as stated by the RC's release 
notes, can be boiled down to

- upgrade all monitors first
- upgrade osds only after we have a **full** quorum, comprised of all 
the monitors in the monmap, of luminous monitors (i.e., once we have the 
'luminous' feature enabled in the monmap).

While this is a reasonable idea in principle, reducing a lot of the 
possible upgrade testing combinations, and a simple enough procedure 
from Ceph's point-of-view, it seems it's not a widespread upgrade procedure.

As far as I can tell, it's not uncommon for users to take this 
maintenance window to perform system-wide upgrades, including kernel and 
glibc for instance, and finishing the upgrade with a reboot.

The problem with our current upgrade procedure is that once the first 
server reboots, the osds in that server will be unable to boot, as the 
monitor quorum is not yet 'luminous'.

The only way to minimize potential downtime is to upgrade and restart 
all the nodes at the same time, which can be daunting and it basically 
defeats the purpose of a rolling upgrade. And in this scenario, there is 
an expectation of downtime, something Ceph is built to prevent.

Additionally, requiring the `luminous` feature to be enabled in the 
quorum becomes even less realistic in the face of possible failures. God 
forbid that in the middle of upgrading, the last remaining monitor 
server dies a horrible death - e.g., power, network. We'll be left with 
still a 'not-luminous' quorum, and a bunch of OSDs waiting for this flag 
to be flipped. And not it's a race to either get that monitor up, or 
remove it from the monmap.

Even if one were to make the decision of only upgrading system packages, 
reboot, and then upgrade Ceph packages, there is the unfortunate 
possibility that library interdependencies would require Ceph's binaries 
to be updated, so this may be a show-stopper as well.

Alternatively, if one is to simply upgrade the system and not reboot, 
and then proceed to perform the upgrade procedure, one would still be in 
a fragile position: if, for some reason, one of the nodes reboots, we're 
in the same precarious situation as before.

Personally, I can see two ways out of this, at different positions in 
the reasonability spectrum:

1. add temporary monitor nodes to the cluster, may they be on VMs or 
bare hardware, already running Luminous, and then remove the same amount 
of monitors from the cluster. This leaves us to upgrade a single monitor 
node. This has the drawback of folks not having spare nodes to run the 
monitors on, or running monitors on VMs -- which may affect their 
performance during the upgrade window, and increase complexity in terms 
of firewall and routing rules.

2. migrate/upgrade all nodes on which Monitors are located first, then 
only restart them after we've gotten all nodes upgraded. If anything 
goes wrong, one can hurry through this step or fall-back to 3.

3. Reducing the monitor quorum to 1. This pains me to even think about, 
and it bothers me to bits that I'm finding myself even considering this 
as a reasonable possibility. It shouldn't, because it isn't. But it's a 
lot more realistic than expecting OSD downtime during an upgrade procedure.

On top of this all, I found during my tests that any OSD, running 
luminous prior to the luminous quorum, will need to be restarted before 
it can properly boot into the cluster. I'm guessing this is a bug rather 
than a feature though.

Any thoughts on how to mitigate this, or on whether I got this all wrong 
and am missing a crucial detail that blows this wall of text away, 
please let me know.


   -Joao
