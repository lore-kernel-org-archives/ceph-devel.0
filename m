From: George Mihaiescu <lmihaiescu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: would people mind a slow osd restart during
	luminous upgrade?
Date: Thu, 9 Feb 2017 08:30:12 -0500
Message-ID: <C490FBFB-7A7E-49FE-8283-A59C1205557F@gmail.com>
References: <alpine.DEB.2.11.1702090302470.7782@piezo.novalocal>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1702090302470.7782-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi Sage,

Is the update running in parallel for all OSDs being restarted? 

Because 5 min per server is different than 150 min when there are 30 OSDs there..

Thank you,
George 

> On Feb 8, 2017, at 22:09, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
> Hello, ceph operators...
> 
> Several times in the past we've had to do some ondisk format conversion 
> during upgrade which mean that the first time the ceph-osd daemon started 
> after upgrade it had to spend a few minutes fixing up it's ondisk files.  
> We haven't had to recently, though, and generally try to avoid such 
> things.
> 
> However, there's a change we'd like to make in FileStore for luminous (*) 
> and it would save us a lot of time and complexity if it was a one-shot 
> update during the upgrade.  I would probably take in the neighborhood of 
> 1-5 minutes for a 4-6TB HDD.  That means that when restarting the daemon 
> during the upgrade the OSD would stay down for that period (vs the usual 
> <1 restart time).
> 
> Does this concern anyone?  It probably means the upgrades will take longer 
> if you're going host by host since the time per host will go up.
> 
> sage
> 
> 
> * eliminate 'snapdir' objects, replacing them with a head object + 
> whiteout.
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
