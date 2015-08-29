From: GuangYang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: Opensource plugin for pulling out cluster recovery
 and client IO metric
Date: Sat, 29 Aug 2015 00:20:07 -0700
Message-ID: <BLU175-W431B0044739E336DB96623DF6D0@phx.gbl>
References: <CALL4jwPkeHemknEWypgTzAE7kSa9F+pyZZQUWJwYFY6OQWTFbQ@mail.gmail.com>,
	<CAJ4mKGbOm8DMyPCzi_NFKVYBrnSW4UvGWuWB_EBp69Oc4tdSaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAJ4mKGbOm8DMyPCzi_NFKVYBrnSW4UvGWuWB_EBp69Oc4tdSaQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Gregory Farnum <gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Vickey Singh <vickey.singh22693-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

----------------------------------------
> Date: Fri, 28 Aug 2015 12:07:39 +0100
> From: gfarnum-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
> To: vickey.singh22693-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
> CC: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TZNg+MwTxZMZA@public.gmane.org=
l.org
> Subject: Re: [ceph-users] Opensource plugin for pulling out cluster recov=
ery and client IO metric
>
> On Mon, Aug 24, 2015 at 4:03 PM, Vickey Singh
> <vickey.singh22693-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hello Ceph Geeks
>>
>> I am planning to develop a python plugin that pulls out cluster recovery=
 IO
>> and client IO operation metrics , that can be further used with collectd.
>>
>> For example , i need to take out these values
>>
>> recovery io 814 MB/s, 101 objects/s
>> client io 85475 kB/s rd, 1430 kB/s wr, 32 op/s
The calculation *window* for those stats are very small, IIRC, they are two=
 PG version which most likely map to two seconds (average of the last two s=
econds), you may increase=A0mon_stat_smooth_intervals to enlarge the window=
, but I didn't try it myself.

I found the 'ceph status -f json' has better formatted output and more info=
rmation.
>>
>>
>> Could you please help me in understanding how ceph -s and ceph -w outputs
>> prints cluster recovery IO and client IO information.
>> Where this information is coming from. Is it coming from perf dump ? If =
yes
>> then which section of perf dump output is should focus on. If not then h=
ow
>> can i get this values.
>>
>> I tried ceph --admin-daemon /var/run/ceph/ceph-osd.48.asok perf dump , b=
ut
>> it generates hell lot of information and i am confused which section of
>> output should i use.
perf counters have a tone of information which needs time to understand the=
 details, but if the purpose is just to dump as what they are and do better=
 aggregation/reporting, you can check 'perf schema' first to get the type o=
f the field, can cross check the perf_counter's definition for each type, t=
o determine how you collection/aggregate those data.
>
> This information is generated only on the monitors based on pg stats
> from the OSDs, is slightly laggy, and can be most easily accessed by
> calling "ceph -s" on a regular basis. You can get it with json output
> that is easier to parse, and you can optionally set up an API server
> for more programmatic access. I'm not sure on the details of doing
> that last, though.
> -Greg
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
 		 	   		  =
