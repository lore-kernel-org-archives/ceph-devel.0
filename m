From: =?UTF-8?Q?Darius_Kasparavi=C4=8Dius?= <daznis-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph cluster stability
Date: Wed, 20 Feb 2019 17:47:08 +0200
Message-ID: <CANrNMwUVupc80VWW_OKbYnH1JzB9fKRJFB7q7wVgJH9MY8fB6w@mail.gmail.com>
References: <CANA9Uk5YZYbq5EN40PX5vo55wPzjYLU+Oy9m8Hm-DRG-f1zxFw@mail.gmail.com>
 <CAN-Gep+H2sbh+LL4Pzj9-XVyvCnP+2m++1yFgErBQaWNH3fv=A@mail.gmail.com>
 <CANA9Uk5_FfQqEbZ7O3xp4PPy=cSYUwSf-xWVM6+5WnQO6YkqmQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CANA9Uk5_FfQqEbZ7O3xp4PPy=cSYUwSf-xWVM6+5WnQO6YkqmQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello,


Check your CPU usage when you are doing those kind of operations. We
had a similar issue where our CPU monitoring was reporting fine < 40%
usage, but our load on the nodes was high mid 60-80. If it's possible
try disabling ht and see the actual cpu usage.
If you are hitting CPU limits you can try disabling crc on messages.
ms_nocrc
ms_crc_data
ms_crc_header

And setting all your debug messages to 0.
If you haven't done you can also lower your recovery settings a little.
osd recovery max active
osd max backfills

You can also lower your file store threads.
filestore op threads


If you can also switch to bluestore from filestore. This will also
lower your CPU usage. I'm not sure that this is bluestore that does
it, but I'm seeing lower cpu usage when moving to bluestore + rocksdb
compared to filestore + leveldb .


On Wed, Feb 20, 2019 at 4:27 PM M Ranga Swami Reddy
<swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>
> Thats expected from Ceph by design. But in our case, we are using all
> recommendation like rack failure domain, replication n/w,etc, still
> face client IO performance issues during one OSD down..
>
> On Tue, Feb 19, 2019 at 10:56 PM David Turner <drakonstein-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >
> > With a RACK failure domain, you should be able to have an entire rack powered down without noticing any major impact on the clients.  I regularly take down OSDs and nodes for maintenance and upgrades without seeing any problems with client IO.
> >
> > On Tue, Feb 12, 2019 at 5:01 AM M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> >>
> >> Hello - I have a couple of questions on ceph cluster stability, even
> >> we follow all recommendations as below:
> >> - Having separate replication n/w and data n/w
> >> - RACK is the failure domain
> >> - Using SSDs for journals (1:4ratio)
> >>
> >> Q1 - If one OSD down, cluster IO down drastically and customer Apps impacted.
> >> Q2 - what is stability ratio, like with above, is ceph cluster
> >> workable condition, if one osd down or one node down,etc.
> >>
> >> Thanks
> >> Swami
> >> _______________________________________________
> >> ceph-users mailing list
> >> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> >> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
