From: Gregory Farnum <greg-3KCAGdo1P2hBDgjK7y7TUQ@public.gmane.org>
Subject: Re: How to unset lfor setting (from cache pool)
Date: Mon, 6 Apr 2015 10:54:36 -0700
Message-ID: <CAC6JEv86h8Fp-rogMyFO1AKMqpsCPzohXfEF0HwgfJtrWONHgg@mail.gmail.com>
References: <55225007.7040404@vccloud.vn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <55225007.7040404-QlevPasa8l681eZEIcUDRw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Mon, Apr 6, 2015 at 2:21 AM, Ta Ba Tuan <tuantb-QlevPasa8l681eZEIcUDRw@public.gmane.org> wrote:
> Hi all,
>
> I have ever to setup the cache-pool for my pool.
> But had some proplems about cache-pool running, so I removed the cache pool
> from My CEPH Cluster.
>
> The DATA pool currently don't use cache pool, but "lfor" setting still be
> appeared.
> lfor seems is a setting, not flag.
>
> pool 3 'data_pool' replicated size 3 min_size 1 crush_ruleset 4 object_hash
> rjenkins pg_num 4098 pgp_num 4098 last_change 145235 lfor 75731 flags
> hashpspool stripe_width 0
>
> How to unset lfor?,  and  After unsetting lofr, My pool activities OK?

"lfor" is not a config option; it's "last force op resend" and the
value is an OSDMap epoch. You can see some details about exactly what
it means in the v0.80.2 changelog.
-Greg

>
> Thanks!
> --
> Tuantaba
> Ha Noi-VietNam.
>
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
