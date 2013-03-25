From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: v0.56.4 released
Date: Mon, 25 Mar 2013 16:28:53 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303251627430.12444@cobra.newdream.net>
References: <alpine.DEB.2.00.1303251616110.12444@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1303251616110.12444-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Mon, 25 Mar 2013, Sage Weil wrote:
> There is one minor change (fix) in the output to the 'ceph osd tree 
> --format=json' command. Please see the full release notes.

Greg just reminded me about one additional note about upgrades (that 
should hopefully affect noone):

* The MDS disk format has changed from prior releases *and* from v0.57. In 
  particular, upgrades to v0.56.4 are safe, but you cannot move from 
  v0.56.4 to v0.57 if you are using the MDS for CephFS; you must upgrade
  directly to v0.58 (or later) instead.

sage
