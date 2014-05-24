From: Ricardo Rocha <rocha.porto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: collectd / graphite / grafana .. calamari?
Date: Sat, 24 May 2014 15:46:04 +1200
Message-ID: <CA+xPSVDkyiwCk2yGt5yoEfQKDtr+vhiL8XakubwJgRwDnPG+yw@mail.gmail.com>
References: <CA+xPSVCDxfPNATq2_jZPACxPrp_fB=URRQC9AZRexe5UatA5=g@mail.gmail.com>
	<CAGd4Wr2zag-Hjjrx+ZpfdLWtt6aKOCYiy12BTSbPC3TXbQz1kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAGd4Wr2zag-Hjjrx+ZpfdLWtt6aKOCYiy12BTSbPC3TXbQz1kg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: John Spray <john.spray-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: "'ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org' (ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org)" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi John.

Thanks for the reply, sounds very good.

The extra visualizations from kibana (grafana only seems to pack a
small subset, but the codebase is basically the same) look cool, will
put some more in soon - seems like they can still be useful later.

Looking forward to some calamari.

Cheers,
  Ricardo

On Fri, May 23, 2014 at 10:42 PM, John Spray <john.spray-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi Ricardo,
>
> Let me share a few notes on metrics in calamari:
>  * We're bundling graphite, and using diamond to send home metrics.
> The diamond collector used in calamari has always been open source
> [1].
>  * The Calamari UI has its own graphs page that talks directly to the
> graphite API (the calamari REST API does not duplicate any of the
> graphing interface)
>  * We also bundle the default graphite dashboard, so that folks can go
> to /graphite/dashboard/ on the calamari server to plot anything custom
> they want to.
>
> It could be quite interesting hook in Grafana there in the same way
> that we currently hook in the default graphite dashboard, as it
> grafana definitely nicer and would give us a roadmap to influxdb (a
> project I am quite excited about).
>
> Cheers,
> John
>
> 1. https://github.com/ceph/Diamond/commits/calamari
>
> On Fri, May 23, 2014 at 1:58 AM, Ricardo Rocha <rocha.porto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi.
>>
>> I saw the thread a couple days ago on ceph-users regarding collectd...
>> and yes, i've been working on something similar for the last few days
>> :)
>>
>> https://github.com/rochaporto/collectd-ceph
>>
>> It has a set of collectd plugins pushing metrics which mostly map what
>> the ceph commands return. In the setup we have it pushes them to
>> graphite and the displays rely on grafana (check for a screenshot in
>> the link above).
>>
>> As it relies on common building blocks, it's easily extensible and
>> we'll come up with new dashboards soon - things like plotting osd data
>> against the metrics from the collectd disk plugin, which we also
>> deploy.
>>
>> This email is mostly to share the work, but also to check on Calamari?
>> I asked Patrick after the RedHat/Inktank news and have no idea what it
>> provides, but i'm sure it comes with lots of extra sauce - he
>> suggested to ask in the list.
>>
>> What's the timeline to have it open sourced? It would be great to have
>> a look at it, and as there's work from different people in this area
>> maybe start working together on some fancier monitoring tools.
>>
>> Regards,
>>   Ricardo
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
