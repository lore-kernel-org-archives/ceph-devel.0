From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: removing auids and auid-based cephx capabilities
Date: Wed, 8 Aug 2018 20:33:43 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1808082028510.22275@piezo.novalocal>
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

There is an undocumented part of the cephx authentication framework called 
the 'auid' (auth uid) that assigns an integer identifier to cephx users 
and to rados pools and allows you to craft cephx capabilities that apply 
to those pools.  This is leftover infrastructure from an ancient time in 
which RGW buckets mapped 1:1 to rados pools (pre-argonaut!) and it was 
expected the cephx capabilities would line up with that.

Although in theory parts of the auid infrastructure might work and be in 
use, it is undocumented, untested, and a messy artifact in the code.  I'd 
like to remove it.

***

  If you are using auid-based cephx capabilities, now is the time to tell 
  us!  Or, if you know of any reason we should keep it around, now is 
  the time to speak up.

  Otherwise we will remove it!

***

Thanks!
sage
