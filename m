From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: Snap trim queue length issues
Date: Fri, 15 Dec 2017 14:58:04 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712151454030.2838@piezo.novalocal>
References: <82009aab-6b20-ef21-9bbd-76fddf84e0a3@corp.ovh.com>
 <CAN-Gep+JEdr1V8B42YTy0rZzFM8B0TwHRqTs8WjrjcQm8tFgHA@mail.gmail.com>
 <81eabcfe-59b1-70c9-4f4f-2abbc86b9456@corp.ovh.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-2094118088-1513349886=:2838"
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <81eabcfe-59b1-70c9-4f4f-2abbc86b9456-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: =?ISO-8859-2?Q?Piotr_Da=B3ek?= <piotr.dalek-Rm6v+N6rxxBWk0Htik3J/w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-2094118088-1513349886=:2838
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 15 Dec 2017, Piotr Dałek wrote:
> On 17-12-14 05:31 PM, David Turner wrote:
> > I've tracked this in a much more manual way.  I would grab a random subset
> > [..]
> > 
> > This was all on a Hammer cluster.  The changes to the snap trimming queues
> > going into the main osd thread made it so that our use case was not viable
> > on Jewel until changes to Jewel that happened after I left.  It's exciting
> > that this will actually be a reportable value from the cluster.
> > 
> > Sorry that this story doesn't really answer your question, except to say
> > that people aware of this problem likely have a work around for it.  However
> > I'm certain that a lot more clusters are impacted by this than are aware of
> > it and being able to quickly see that would be beneficial to troubleshooting
> > problems.  Backporting would be nice.  I run a few Jewel clusters that have
> > some VM's and it would be nice to see how well the cluster handle snap
> > trimming.  But they are much less critical on how much snapshots they do.
> 
> Thanks for your response, it pretty much confirms what I though:
> - users aware of issue have their own hacks that don't need to be efficient or
> convenient.
> - users unaware of issue are, well, unaware and at risk of serious service
> disruption once disk space is all used up.
> 
> Hopefully it'll be convincing enough for devs. ;)

Your PR looks great!  I commented with a nit on the format of the warning 
itself.

I expect this is trivial to backport to luminous; it will need to be 
partially reimplemented for jewel (with some care around the pg_stat_t and 
a different check for the jewel-style health checks).

sage
--8323329-2094118088-1513349886=:2838
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--8323329-2094118088-1513349886=:2838--
