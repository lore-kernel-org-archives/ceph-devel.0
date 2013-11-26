From: Yehuda Sadeh <yehuda-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [radosgw] increase avg get time after sharding
Date: Tue, 26 Nov 2013 13:50:35 -0800
Message-ID: <CABBk=J-XB_QG2v5974bUABjyow26HKjj0JpfFe91ivv+cUt70A@mail.gmail.com>
References: <CAMNMNTz8g3huG53E8pEzB5oEDqMFmRkypegZmjJ4jCzUH=5E6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAMNMNTz8g3huG53E8pEzB5oEDqMFmRkypegZmjJ4jCzUH=5E6A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Nov 26, 2013 at 1:27 PM, Dominik Mostowiec
<dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
> We have 2 clusters with copy of objects.
> On one of them we splited all large buckets (largest 17mln objects) to
> 256 buckets each (shards) and we have added 3 extra servers (6->9).
> Old bucket was created in ceph argonaut.
> Now we have dumpling.
> After this operation get avg time increased almost twice:
> https://www.dropbox.com/s/lbrpk6ias6r4459/avg_get_time.PNG
> I found that also increased 'get_initial_lat'
> Sum of this parametr on all servers in cluster:
> https://www.dropbox.com/s/l90a43vf9ivw639/get_initial_lat_sum.png
>
> Do you have an idea what is the reason?
> Where can I start to search?
>

Are you running latest dumpling? There was some performance related
issue that was fixed fairly recently.
I'd start with trying to identify whether the issue is in the osd or
in the gateway itself. Try turning on some logging (e.g., debug ms =
1, debug rgw = 20), and try to see where most of the request
processing time is spent (within the gateway, or is it just waiting
for the osd?).

Yehuda
