From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Regarding cache tier understanding
Date: Thu, 7 Aug 2014 07:12:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408070706200.18917@cobra.newdream.net>
References: <755F6B91B3BE364F9BCA11EA3F9E0C6F264570F2@SACMBXIP02.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-339714553-1407420720=:18917"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <755F6B91B3BE364F9BCA11EA3F9E0C6F264570F2-cXZ6iGhjG0i+xgsn/SD5JjJ2aSJ780jGSxCzGc5ayCJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Somnath Roy <Somnath.Roy-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anirban Ray <Anirban.Ray-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Allen Samuels <Allen.Samuels-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-339714553-1407420720=:18917
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Thu, 7 Aug 2014, Somnath Roy wrote:
> Hi Sage,
>=20
> I went through the tiering agent code base and here is my understanding=
 on
> the agent behavior. Please let me know if that is correct.
>=20
> =A0
>=20
> 1.=A0=A0=A0=A0=A0=A0 Agent will be always in idle state if target_max_b=
ytes or
> target_max_objects not set on the pool irrespective of other tiering pa=
rams
> set in the pool. dirty_micro and full_micro will not be calculated if t=
hose
> two params are zero which is by default I guess.

Yeah

> 2.=A0=A0=A0=A0=A0=A0 Now, flush will be activated if dirty_micro is > f=
lush_target. My
> understanding is, once it is activated it will iterate through all the =
dirty
> objects and flush all the dirty objects which is > cache_min_flush_age.=
 Am I
> right ?

Yeah

> 3.=A0=A0=A0=A0=A0=A0 For the eviction, if full_micro > 1000000 , the mo=
de set as
> TierAgentState::EVICT_MODE_FULL and all the clean objects are flushed.

Yeah

> 4.=A0=A0=A0=A0=A0=A0 if (full_micro > evict_target), the mode is set as
> TierAgentState::EVICT_MODE_SOME. In this scenario evict_effort is calcu=
lated
> and based on hit_set and temp calculation some clean objects are evicte=
d. My
> question is , can we quantify this value ? For ex, if the target_full_r=
atio
> =3D 50%, once the eviction is triggered, what %objects will be evicted =
?

The effort is calculated based on how far between target_full and 100% we=
=20
are.  This is mapped onto the estimation of atime.  We generate a=20
histogram of age for the objects we have examined, so after the agent has=
=20
run a bit we'll have a reasonable idea how the current object's age=20
compares to others and can decide whether this is older or newer than the=
=20
others; based on that we decide what to do.

> 5.=A0=A0=A0=A0=A0=A0 Also, why we are multiplying with 1000000 always ?=
 Is it because in
> the histogram it is positioned as 0..1000000 ?

Yeah, and we use "micro" units throughout to avoid doing any floating=20
point.

> 6.=A0=A0=A0=A0=A0=A0 I saw the cache_min_evict_age is not been used any=
where, am I
> missing anything ?

It's possible.  The _min_ params are a bit dangerous because they can=20
potentially confuse the cache agent (e.g., what if *all* objects are unde=
r=20
the min?  How/when do we decide to ignore the min, or, how/when do we=20
give up trying to find an older object?).

> 7.=A0=A0=A0=A0=A0=A0 The cache_min_flush_age will only be applicable if=
 the flush is
> triggered after crossing the dirty_threshold, right ? If dirty_threshol=
d is
> not breached, the flush age param is never checked.

Right.

> I need to understand the behavior so that we can test the Cache tiering
> properly.
>=20
> Is there any behavior I am missing here which you want us to test out ?

There is a new behavior just merged into master that controls our decisio=
n=20
to promote data into the cache on read; see maybe_handle_cache().  That's=
=20
not strictly agent behavior per se.  Also, there is now a readforward mod=
e=20
that doesn't promote on read ever, based on our discussion about the=20
performance of flash on read.

Hope this helps!
sage
--557981400-339714553-1407420720=:18917
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--557981400-339714553-1407420720=:18917--
