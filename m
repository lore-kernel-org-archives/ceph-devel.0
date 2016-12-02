From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: stalls caused by scrub on jewel
Date: Fri, 2 Dec 2016 16:48:44 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612021643080.22800@piezo.novalocal>
References: <alpine.DEB.2.11.1611152232260.2650@piezo.us.to>
	<67e859f3-1aa6-e4b5-06b5-664583f668f1@univ-lorraine.fr>
	<0309fdb3-1924-dec4-9658-b8f3055b3518@epfl.ch>
	<9F915199-F93D-4F5E-82F8-ACA428ADFA30@univ-lorraine.fr>
	<7770A453-1C79-4B89-A402-481D6463AA87@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1309775336-1480697326=:22800"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <7770A453-1C79-4B89-A402-481D6463AA87-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Dan Jakubiec <dan.jakubiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1309775336-1480697326=:22800
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 2 Dec 2016, Dan Jakubiec wrote:
> For what it's worth... this sounds like the condition we hit we 
> re-enabled scrub on our 16 OSDs (after 6 to 8 weeks of noscrub).  They 
> flapped for about 30 minutes as most of the OSDs randomly hit suicide 
> timeouts here and there.
> 
> This settled down after about an hour and the OSDs stopped dying.  We 
> have since left scrub enabled for about 4 days and have only seen three 
> small spurts of OSD flapping since then (which quickly resolved 
> themselves).

Yeah.  I think what's happening is that with a cold cache it is slow 
enough to suicide, but with a warm cache it manages to complete (although 
I bet it's still stalling other client IO for perhaps multiple seconds).  
I would leave noscrub set for now.

sage




> 
> -- Dan
> 
> > On Dec 1, 2016, at 14:38, Frédéric Nass <frederic.nass-mHc8WM8rKNgDTEWcYJR2Ng@public.gmane.org> wrote:
> > 
> > Hi Yoann,
> > 
> > Thank you for your input. I was just told by RH support that it’s gonna make it to RHCS 2.0 (10.2.3). Thank you guys for the fix !
> > 
> > We thought about increasing the number of PGs just after changing the merge/split threshold values but this would have led to a _lot_ of data movements (1.2 billion of XFS files) over weeks, without any possibility to scrub / deep-scrub to ensure data consistency. Still as soon as we get the fix, we will increase the number of PGs.
> > 
> > Regards,
> > 
> > Frederic.
> > 
> > 
> > 
> >> Le 1 déc. 2016 à 16:47, Yoann Moulin <yoann.moulin-p8DiymsW2f8@public.gmane.org> a écrit :
> >> 
> >> Hello,
> >> 
> >>> We're impacted by this bug (case 01725311). Our cluster is running RHCS 2.0 and is no more capable to scrub neither deep-scrub.
> >>> 
> >>> [1] http://tracker.ceph.com/issues/17859
> >>> [2] https://bugzilla.redhat.com/show_bug.cgi?id=1394007
> >>> [3] https://github.com/ceph/ceph/pull/11898
> >>> 
> >>> I'm worried we'll have to live with a cluster that can't scrub/deep-scrub until March 2017 (ETA for RHCS 2.2 running Jewel 10.2.4).
> >>> 
> >>> Can we have this fix any sooner ?
> >> 
> >> As far as I know about that bug, it appears if you have big PGs, a workaround could be increasing the pg_num of the pool that has the biggest PGs.
> >> 
> >> -- 
> >> Yoann Moulin
> >> EPFL IC-IT
> > 
> > _______________________________________________
> > ceph-users mailing list
> > ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> 
> 
--8323329-1309775336-1480697326=:22800
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-1309775336-1480697326=:22800--
