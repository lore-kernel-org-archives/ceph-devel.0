From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: would people mind a slow osd restart during luminous
	upgrade?
Date: Thu, 9 Feb 2017 03:09:14 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702090302470.7782@piezo.novalocal>
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
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hello, ceph operators...

Several times in the past we've had to do some ondisk format conversion 
during upgrade which mean that the first time the ceph-osd daemon started 
after upgrade it had to spend a few minutes fixing up it's ondisk files.  
We haven't had to recently, though, and generally try to avoid such 
things.

However, there's a change we'd like to make in FileStore for luminous (*) 
and it would save us a lot of time and complexity if it was a one-shot 
update during the upgrade.  I would probably take in the neighborhood of 
1-5 minutes for a 4-6TB HDD.  That means that when restarting the daemon 
during the upgrade the OSD would stay down for that period (vs the usual 
<1 restart time).

Does this concern anyone?  It probably means the upgrades will take longer 
if you're going host by host since the time per host will go up.

sage


* eliminate 'snapdir' objects, replacing them with a head object + 
whiteout.
