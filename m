From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: un-even data filled on OSDs
Date: Tue, 7 Jun 2016 09:07:04 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1606070905590.6221@cpach.fuggernut.com>
References: <CANA9Uk4NH7H4kQjEzeNp26bvar5DRWvnNdPff-wCJDRfb1be_A@mail.gmail.com>
	<alpine.DEB.2.11.1606070830160.6221@cpach.fuggernut.com>
	<CANA9Uk6YXFpAyp+jUgq7Cc9nRwR4Ha=UO-0nPrEAxy8A_GxGNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk6YXFpAyp+jUgq7Cc9nRwR4Ha=UO-0nPrEAxy8A_GxGNA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
> Hi Sage,
> >Jewel and the latest hammer point release have an improved
> >reweight-by-utilization (ceph osd test-reweight-by-utilization ... to dry
> > run) to correct this.
> 
> Thank you....But not planning to upgrade the cluster soon.
> So, in this case - are there any tunable options will help? like
> "crush tunable optimal" or so?
> OR any other configuration options change will help?

Firefly also has reweight-by-utilization... it's just a bit less friendly 
than the newer versions.  CRUSH tunables don't generally help here unless 
you have lots of OSDs that are down+out.

Note that firefly is no longer supported.

sage


> 
> 
> Thanks
> Swami
> 
> 
> On Tue, Jun 7, 2016 at 6:00 PM, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org> wrote:
> > On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
> >> Hello,
> >> I have aorund 100 OSDs in my ceph cluster. In this a few OSDs filled
> >> with >85% of data and few OSDs filled with ~60%-70% of data.
> >>
> >> Any reason why the unevenly OSDs filling happned? do I need to any
> >> tweaks on configuration to fix the above? Please advise.
> >>
> >> PS: Ceph version is - 0.80.7
> >
> > Jewel and the latest hammer point release have an improved
> > reweight-by-utilization (ceph osd test-reweight-by-utilization ... to dry
> > run) to correct this.
> >
> > sage
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
