From: Markus Blank-Burian <burian-iYtK5bfT9M8b1SvskN2V4Q@public.gmane.org>
Subject: Re: un-even data filled on OSDs
Date: Tue, 7 Jun 2016 17:11:17 +0200
Message-ID: <DUB403-EAS83F104088C40DDED40FB02D55D0@phx.gbl>
References: <CANA9Uk4NH7H4kQjEzeNp26bvar5DRWvnNdPff-wCJDRfb1be_A@mail.gmail.com>	<alpine.DEB.2.11.1606070830160.6221@cpach.fuggernut.com>	<CANA9Uk6YXFpAyp+jUgq7Cc9nRwR4Ha=UO-0nPrEAxy8A_GxGNA@mail.gmail.com>	<alpine.DEB.2.11.1606070905590.6221@cpach.fuggernut.com>	<CANA9Uk7aQrom4HEWJHSUjJeY7ywK8KZ0pmdsoY6dwHf4HhPBWg@mail.gmail.com>
	<alpine.DEB.2.11.1606070921430.6221@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1606070921430.6221-Wo5lQnKln9t9PHm/lf2LFUEOCMrvLtNR@public.gmane.org>
Content-Language: de
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: 'Sage Weil' <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, 'M Ranga Swami Reddy' <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'ceph-devel' <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 'ceph-users' <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello Sage,

are there any development plans to improve PG distribution to OSDs? 

We use CephFS on Infernalis and objects are distributed very well across the
PGs. But the automatic PG distribution creates large fluctuations, even in the
simplest case for same-sized OSDs and a flat hierarchy using 3x replication.
Testing with crushtool, we would need an unreasonable high number of PG/OSD to
have a nearly-flat distribution.
Reweighting the PGs with "ceph osd reweight" helped for our cache-pool since it
has a flat hierarchy (one OSD/host). The EC pool on the other hand has a
hierarchy with around 2-4 OSDs (1-4TB / OSD) per host and redundancy is
distributed across hosts (6-8TB / host). I assume, there would be no way around
tuning the host weights in the crush map in this case?

Markus

-----Original Message-----
From: ceph-users [mailto:ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org] On Behalf Of Sage
Weil
Sent: Dienstag, 7. Juni 2016 15:22
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>; ceph-users
<ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Subject: Re: [ceph-users] un-even data filled on OSDs

On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
> OK, understood...
> To fix the nearfull warn, I am reducing the weight of a specific OSD, 
> which filled >85%..
> Is this work-around advisable?

Sure.  This is what reweight-by-utilization does for you, but automatically.

sage

> 
> Thanks
> Swami
> 
> On Tue, Jun 7, 2016 at 6:37 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
> >> Hi Sage,
> >> >Jewel and the latest hammer point release have an improved 
> >> >reweight-by-utilization (ceph osd test-reweight-by-utilization ... 
> >> >to dry
> >> > run) to correct this.
> >>
> >> Thank you....But not planning to upgrade the cluster soon.
> >> So, in this case - are there any tunable options will help? like 
> >> "crush tunable optimal" or so?
> >> OR any other configuration options change will help?
> >
> > Firefly also has reweight-by-utilization... it's just a bit less 
> > friendly than the newer versions.  CRUSH tunables don't generally 
> > help here unless you have lots of OSDs that are down+out.
> >
> > Note that firefly is no longer supported.
> >
> > sage
> >
> >
> >>
> >>
> >> Thanks
> >> Swami
> >>
> >>
> >> On Tue, Jun 7, 2016 at 6:00 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> >> > On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
> >> >> Hello,
> >> >> I have aorund 100 OSDs in my ceph cluster. In this a few OSDs 
> >> >> filled with >85% of data and few OSDs filled with ~60%-70% of data.
> >> >>
> >> >> Any reason why the unevenly OSDs filling happned? do I need to 
> >> >> any tweaks on configuration to fix the above? Please advise.
> >> >>
> >> >> PS: Ceph version is - 0.80.7
> >> >
> >> > Jewel and the latest hammer point release have an improved 
> >> > reweight-by-utilization (ceph osd test-reweight-by-utilization 
> >> > ... to dry
> >> > run) to correct this.
> >> >
> >> > sage
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe 
> >> ceph-devel" in the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> >>
> 
> 
_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
