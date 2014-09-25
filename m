From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: v0.67.11 dumpling released
Date: Thu, 25 Sep 2014 08:53:52 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409250852020.16795@cobra.newdream.net>
References: <alpine.DEB.2.00.1409250808190.15854@cobra.newdream.net>
	<5424390D.6010203@cloudapt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <5424390D.6010203-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mike Dawson <mike.dawson-ffsCFlcjuZBWk0Htik3J/w@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, 25 Sep 2014, Mike Dawson wrote:
> On 9/25/2014 11:09 AM, Sage Weil wrote:
> > v0.67.11 "Dumpling"
> > ===================
> > 
> > This stable update for Dumpling fixes several important bugs that affect a
> > small set of users.
> > 
> > We recommend that all Dumpling users upgrade at their convenience.  If
> > none of these issues are affecting your deployment there is no urgency.
> > 
> > 
> > Notable Changes
> > ---------------
> > 
> > * common: fix sending dup cluster log items (#9080 Sage Weil)
> > * doc: several doc updates (Alfredo Deza)
> > * libcephfs-java: fix build against older JNI headesr (Greg Farnum)
> > * librados: fix crash in op timeout path (#9362 Matthias Kiefer, Sage Weil)
> > * librbd: fix crash using clone of flattened image (#8845 Josh Durgin)
> > * librbd: fix error path cleanup when failing to open image (#8912 Josh
> > Durgin)
> > * mon: fix crash when adjusting pg_num before any OSDs are added (#9052
> >    Sage Weil)
> > * mon: reduce log noise from paxos (Aanchal Agrawal, Sage Weil)
> > * osd: allow scrub and snap trim thread pool IO priority to be adjusted
> >    (Sage Weil)
> 
> Sage,
> 
> Thanks for the great work! Could you provide any links describing how to tune
> the scrub and snap trim thread pool IO priority? I couldn't find these
> settings in the docs.

It's 

 osd disk thread ioprio class = idle
 osd disk thread ioprio priority = 0

Note that this is a short-term solution; we eventaully want to send all IO 
through the same queue so that we can prioritize things more carefully.  
This setting will most likely go away in the future.

> IIUC, 0.67.11 does not include the proposed changes to address #9487 or 
> #9503, right?

Correct.  That will come later once it's gone through more testing.

Thanks!
sage
