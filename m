From: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Subject: Re: The first infernalis dev release will be v9.0.0
Date: Tue, 05 May 2015 15:20:48 +0100
Message-ID: <5548D1C0.30204@suse.de>
References: <alpine.DEB.2.00.1504301528410.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1504301528410.5458-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On 05/04/2015 05:09 PM, Sage Weil wrote:
> The first Ceph release back in Jan of 2008 was 0.1.  That made sense at 
> the time.  We haven't revised the versioning scheme since then, however, 
> and are now at 0.94.1 (first Hammer point release).  To avoid reaching 
> 0.99 (and 0.100 or 1.00?) we have a new strategy.  This was discussed a 
> bit on ceph-devel and in #ceph-devel and there doesn't appear to be any 
> scheme that everyone likes.
> 
> So, we're going to go with something that only a few people dislike:
> 
>  x.0.z - development releases (for early testers and the brave at heart)
>  x.1.z - release candidates (for test clusters, brave users)
>  x.2.z - stable/bugfix releases (for users)
> 
> x will start at 9 for Infernalis ("I" is the 9th letter), making our first 
> development release of the 9th release cycle 9.0.0.  Subsequent 
> development releases will be 9.0.1, 9.0.2, etc.
> 
> In a couple months we'll have a 9.1.0 (and maybe 9.1.1) release candidate.
> 
> A few weeks after that we'll have the Infernalis release 9.2.0, followed 
> by stable bug fix updates 9.2.1, 9.2.2, etc., and then begin work on the 
> Jewel (10.y.z) release.
> 
> We'll see how this works out.  We can adjust this in the future to any 
> other 9.y.z scheme (e.g., 9.1, 9.2 etc dev releases and 9.8.z stable 
> releases); the main commitment here is to the 9 part, indicating 
> Infernalis is the 9th major release cycle.

Looks sane!

I'm guessing once 9.1.0 is frozen the dev cycles will move on to 10.0.1?

  -Joao
