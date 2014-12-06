From: Steven C Timm <timm-13hema8v3vg@public.gmane.org>
Subject: Re: running as non-root
Date: Sat, 6 Dec 2014 19:54:50 +0000
Message-ID: <06DD77485437AF46B35123BD0106CC8803B04901@MAIL02.fnal.gov>
References: <alpine.DEB.2.00.1412061039550.18213@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1412061039550.18213-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Sage, at least in the Redhat world there are ways to get a pre-assigned uid/gid for a service that is 
part of a system service.  There's a registered list of services that get fixed uid/gid, you can google for it.
Any service can add an adduser command with a fixed uid/gid but best to cooperate with the various distros.
Sometimes sysadmins will want to use a configuration management package such as puppet to 
create the users, that is another way to do it, because then the init scripts can detect the ceph user
is already there.

Steve Timm

________________________________________
From: ceph-users [ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] on behalf of Sage Weil [sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
Sent: Saturday, December 06, 2014 12:43 PM
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org
Subject: [ceph-users] running as non-root

While we are on the subject of init systems and packaging, I would *love*
to fix things up for hammer to

 - create a ceph user and group
 - add various users to ceph group (like qemu or kvm user and
apache/www-data?)
 - fix permissions on /var/log/ceph and /var/run/ceph (770?) so that qemu
and rgw can write logs and asok files there
 - make daemons run as ceph user instead of root

The main hangup is with that last one.  As I understand it, when packages
create users, they get a semi-random UID assigned.  That means that all
the data on a ceph-osd disk would have a semi-random UID.  If it were
hot-swapped into another host, the uid would be wrong.  Is there a way
use a fixed uid?

Also on the roadmap is defining proper selinux policies so that these
dameons are confined into the appropriate directories etc., but I imagine
running as non-root is a big help (or even prerequisite?) to making that
happen?

Suggestions or comments?  Or volunteers?  We haven't had time to look at
this yet but I think it's important!

sage

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
