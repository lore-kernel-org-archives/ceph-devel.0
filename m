From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: [ceph-users] v0.93 Hammer release candidate
	released
Date: Mon, 2 Mar 2015 21:18:24 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1503022117430.25972@cobra.newdream.net>
References: <alpine.DEB.2.00.1502271408230.1577@cobra.newdream.net>
	<alpine.DEB.2.00.1503022114370.25972@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1503022114370.25972-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-announce-ceph.com>,
	<mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-announce-ceph.com/>
List-Post: <mailto:ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com>,
	<mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "Ceph-announce" <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Mon, 2 Mar 2015, Sage Weil wrote:
> I forgot to mention a very important note for those running the v0.92 
> development release and upgrading:
> 
> On Fri, 27 Feb 2015, Sage Weil wrote:
> > Upgrading
> > ---------
> 
> * If you are upgrading from v0.92, you must stop all OSD daemons and flush their
>   journals (``ceph-osd -i NNN --flush-journal'') before upgrading.  There was
>   a transaction encoding bug in v0.92 that broke compatibility.  Upgrading from
>   v0.91 or anything earlier is safe.
> 
> > * No special restrictions when upgrading from firefly or giant
> 
> I know this has bitten a few of you already; I'm very sorry!  Following 
> the procedure now should resolve it.

Sorry, to be more clear: reinstalling v0.92, flushing journals, upgrading 
to v0.93, and then starting the OSDs should resolve it.

sage
