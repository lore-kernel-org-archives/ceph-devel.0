From: Guang <guangyy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RADOS + deep scrubbing performance issues in
	production environment
Date: Mon, 3 Feb 2014 21:40:07 +0800
Message-ID: <ECAD21C4-A342-48ED-BE40-9562B8CCDA08@yahoo.com>
References: <20140127151321.GD26390@philipgian-mac>
	<CAFMfnwp4u-O8m3gZko35y5t3r05kAgt9zUWOew_pmHSJjmLPmA@mail.gmail.com>
	<alpine.DEB.2.00.1401271045160.2149@cobra.newdream.net>
	<20140128181306.GC11532@philipgian-mac>
	<066498EC-D137-472A-85DB-93751E85C753@yahoo.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/mixed; boundary="===============0303378362=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <066498EC-D137-472A-85DB-93751E85C753-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Filippos Giannakos <philipgian-Sqt7GMbKoOQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Development" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Cc: synnefo-devel-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============0303378362==
Content-Type: multipart/alternative; boundary="Apple-Mail=_B23FDCA9-018B-412A-A12B-63E9E9FBCDF8"


--Apple-Mail=_B23FDCA9-018B-412A-A12B-63E9E9FBCDF8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

+ceph-users.

Does anybody have the similar experience of scrubbing / deep-scrubbing?

Thanks,
Guang

On Jan 29, 2014, at 10:35 AM, Guang <yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org> wrote:

> Glad to see there are some discussion around scrubbing / =
deep-scrubbing.
>=20
> We are experiencing the same that scrubbing could affect latency quite =
a bit and so far I found two slow patterns (dump_historic_ops): 1) =
waiting from being dispatched 2) waiting in the op working queue to be =
fetched by an available op thread. For the first slow pattern, it looks =
like there is lock (as dispatcher stop working for 2 seconds and then =
resume, same for scrubber thread), that needs further investigation. For =
the second slow pattern, as scrubbing brings more ops (for scrubbing =
check), that make the op thread's work load increase (client op has a =
lower priority), I think that could be improved by increasing the op =
thread number, I will confirm this analysis by adding more op threads =
and turn on scrubbing on OSD basis.
>=20
> Does the above observation and analysis make sense?
>=20
> Thanks,
> Guang
>=20
> On Jan 29, 2014, at 2:13 AM, Filippos Giannakos <philipgian-Sqt7GMbKoOQ@public.gmane.org> =
wrote:
>=20
>> On Mon, Jan 27, 2014 at 10:45:48AM -0800, Sage Weil wrote:
>>> There is also=20
>>>=20
>>> ceph osd set noscrub
>>>=20
>>> and then later
>>>=20
>>> ceph osd unset noscrub
>>>=20
>>> I forget whether this pauses an in-progress PG scrub or just makes =
it stop=20
>>> when it gets to the next PG boundary.
>>>=20
>>> sage
>>=20
>> I bumped into those settings but I couldn't find any documentation =
about them.
>> When I first tried them, they didn't do anything immediately, so I =
thought they
>> weren't the answer. After your mention, I tried them again, and after =
a while
>> the deep-scrubbing stopped. So I'm guessing they stop scrubbing on =
the next PG
>> boundary.
>>=20
>> I see from this thread and others before, that some people think it =
is a spindle
>> issue. I'm not sure that it is just that. Replicating it to an idle =
cluster that
>> can do more than 250MiB/seconds and pausing for 4-5 seconds on a =
single request,
>> sounds like an issue by itself. Maybe there is too much locking or =
not enough
>> priority to the actual I/O ? Plus, that idea of throttling deep =
scrubbing based
>> on the iops sounds appealing.
>>=20
>> Kind Regards,
>> --=20
>> Filippos
>> <philipgian-Sqt7GMbKoOQ@public.gmane.org>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--Apple-Mail=_B23FDCA9-018B-412A-A12B-63E9E9FBCDF8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div>+ceph-users.</div><div><br></div><div>Does anybody have the =
similar experience of scrubbing / =
deep-scrubbing?</div><div><br></div><div>Thanks,</div><div>Guang</div><br>=
<div><div>On Jan 29, 2014, at 10:35 AM, Guang &lt;<a =
href=3D"mailto:yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org">yguang11-/E1597aS9LQAvxtiuMwx3w@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dus-ascii"><div style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div><span style=3D"font-size: 16px;">Glad to see there are some =
discussion around scrubbing / deep-scrubbing.</span></div><div><span =
style=3D"font-size: 16px;"><br></span></div><div><span style=3D"font-size:=
 16px;">We are experiencing the same that scrubbing could affect latency =
quite a bit and so far I found two slow patterns =
(dump_historic_ops)</span><span style=3D"font-size: 16px; =
">:&nbsp;</span><span style=3D"font-size: 16px;">1) waiting from being =
dispatched 2) waiting in the op working queue to be fetched by an =
available op thread. For the first slow pattern, it looks like there is =
lock (as dispatcher stop working for 2 seconds and then resume, same for =
scrubber thread), that needs further investigation. For the second slow =
pattern, as scrubbing brings more ops (for scrubbing check), that make =
the op thread's work load increase (client op has a lower priority), I =
think that&nbsp;could&nbsp;be improved by increasing the op thread =
number, I will confirm this analysis by adding more op threads and turn =
on scrubbing on OSD basis.</span></div><div><span style=3D"font-size: =
16px;"><br></span></div><div><span style=3D"font-size: 16px;">Does the =
above observation and analysis make =
sense?</span></div><div><br></div><div><span style=3D"font-size: =
16px;">Thanks,</span></div><div><span style=3D"font-size: =
16px;">Guang</span></div><br><div><div>On Jan 29, 2014, at 2:13 AM, =
Filippos Giannakos &lt;<a =
href=3D"mailto:philipgian-Sqt7GMbKoOQ@public.gmane.org">philipgian-Sqt7GMbKoOQ@public.gmane.org</a>&gt; =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite">On Mon, Jan 27, 2014 at 10:45:48AM -0800, Sage Weil =
wrote:<br><blockquote type=3D"cite">There is also <br><br> ceph osd set =
noscrub<br><br>and then later<br><br> ceph osd unset noscrub<br><br>I =
forget whether this pauses an in-progress PG scrub or just makes it stop =
<br>when it gets to the next PG =
boundary.<br><br>sage<br></blockquote><br>I bumped into those settings =
but I couldn't find any documentation about them.<br>When I first tried =
them, they didn't do anything immediately, so I thought they<br>weren't =
the answer. After your mention, I tried them again, and after a =
while<br>the deep-scrubbing stopped. So I'm guessing they stop scrubbing =
on the next PG<br>boundary.<br><br>I see from this thread and others =
before, that some people think it is a spindle<br>issue. I'm not sure =
that it is just that. Replicating it to an idle cluster that<br>can do =
more than 250MiB/seconds and pausing for 4-5 seconds on a single =
request,<br>sounds like an issue by itself. Maybe there is too much =
locking or not enough<br>priority to the actual I/O ? Plus, that idea of =
throttling deep scrubbing based<br>on the iops sounds =
appealing.<br><br>Kind Regards,<br>-- <br>Filippos<br>&lt;<a =
href=3D"mailto:philipgian-Sqt7GMbKoOQ@public.gmane.org">philipgian-Sqt7GMbKoOQ@public.gmane.org</a>&gt;<br>--<br>T=
o unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in<br>the body of a message to <a =
href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br=
>More majordomo info at &nbsp;<a =
href=3D"http://vger.kernel.org/majordomo-info.html">http://vger.kernel.org=
/majordomo-info.html</a><br></blockquote></div><br></div></blockquote></di=
v><br></body></html>=

--Apple-Mail=_B23FDCA9-018B-412A-A12B-63E9E9FBCDF8--

--===============0303378362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0303378362==--
