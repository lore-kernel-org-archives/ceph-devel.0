From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Why is librbd1 / librados2 from Firefly 20% slower
 than the one from dumpling?
Date: Wed, 25 Jun 2014 17:17:02 -0700
Message-ID: <CAPYLRzjL1JrgsThUejDHQsG3qcK1ZTXgcO2mHEuoHN-FbwVwsQ@mail.gmail.com>
References: <539B11C4.1010400@profihost.ag>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <539B11C4.1010400-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Sorry we let this drop; we've all been busy traveling and things.

There have been a lot of changes to librados between Dumpling and
Firefly, but we have no idea what would have made it slower. Can you
provide more details about how you were running these tests?
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com


On Fri, Jun 13, 2014 at 7:59 AM, Stefan Priebe <s.priebe-2Lf/h1ldwEHR5kwTpVNS9A@public.gmane.org> wrote:
> Hi,
>
> while testint firefly i cam into the sitation where i had a client where the
> latest dumpling packages where installed (0.67.9).
>
> As my pool has hashppool false and the tunables are set to default it can
> talk to my firefly ceph sotrage.
>
> For random 4k writes using fio with librbd and 32 jobs and an iodepth of 32.
>
> I get these results:
>
> librbd / librados2 from dumpling:
>   write: io=3020.9MB, bw=103083KB/s, iops=25770, runt= 30008msec
>   WRITE: io=3020.9MB, aggrb=103082KB/s, minb=103082KB/s, maxb=103082KB/s,
> mint=30008msec, maxt=30008msec
>
> librbd / librados2 from firefly:
>   write: io=7344.3MB, bw=83537KB/s, iops=20884, runt= 90026msec
>   WRITE: io=7344.3MB, aggrb=83537KB/s, minb=83537KB/s, maxb=83537KB/s,
> mint=90026msec, maxt=90026msec
>
> Stefan
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
