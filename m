From: Mark Kirkwood <mark.kirkwood-6STWZtX7tXAqAMOr+u8IRA@public.gmane.org>
Subject: Re: ceph-deploy progress and CDS session
Date: Wed, 07 Aug 2013 13:34:22 +1200
Message-ID: <5201A41E.3000601@catalyst.net.nz>
References: <alpine.DEB.2.00.1308021100150.22864@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1308021100150.22864-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

One thing that comes to mind is the ability to create (or activate) 
osd's with a custom crush specification from (say) a supplied file.

Regards

Mark

On 03/08/13 06:02, Sage Weil wrote:
> There is a session at CDS scheduled to discuss ceph-deploy (4:40pm PDT on
> Monday).  We'll be going over what we currently have in backlog for
> improvements, but if you have any opinions about what else ceph-deploy
> should or should not do or areas where it is problematic, please reply to
> this thread to let us know what you think, and/or join the CDS discussion
> hangout.
>
> For those who haven't noticed, we now have a full-time devoloper,
> Alfredo Deza, who is working on ceph-deploy.  He's been making huge
> progress over the last couple of weeks improving error reporting,
> visibility into what ceph-deploy is doing, and fixing various bugs.  We
> have a long list of things we want to do with the tool, but any feedback
> from users is helpful to make sure we're working on the right things
> first!
>
