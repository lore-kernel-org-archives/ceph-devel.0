From: Marek Dohojda <mdohojda-opdyKS0+pbOZkjO+N0TKoEEOCMrvLtNR@public.gmane.org>
Subject: Re: Is it safe to increase pg number in a production
	environment
Date: Wed, 5 Aug 2015 10:04:00 -0600
Message-ID: <A8204035-AFFC-4CB6-BA9A-339E0B3826C7@altitudedigital.com>
References: <CALAOqpNhquUYW5YqNDZQh4K927Xumw8GcPPoYRsmyEhSHBY-Xw@mail.gmail.com>
	<CAN=+7FVjixrHHUZ01-5HaLd19SbjLkhqpKdKN1jDqPCk1UoR0A@mail.gmail.com>
	<B655F3AF-5BCE-4285-BD86-79E4DC666261@altitudedigital.com>
	<55C16A52.4040403@unitedstack.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Content-Type: multipart/mixed; boundary="===============1813052533=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <55C16A52.4040403-OsJI6HhKm/eMe3Hu20U6GA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jevon Qiao <qiaojianfeng-OsJI6HhKm/eMe3Hu20U6GA@public.gmane.org>
Cc: =?utf-8?B?5LmU5bu65bOw?= <scaleqiao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>, cbt-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============1813052533==
Content-Type: multipart/alternative; boundary="Apple-Mail=_B5C80659-46FE-4E75-8FCE-BA69C4DB1020"


--Apple-Mail=_B5C80659-46FE-4E75-8FCE-BA69C4DB1020
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I started with 7 and expended it to 14 with starting PG of 512 to 4096, =
as recommended.=20

Unfortunately I can=E2=80=99t tell you the exact IO impact as I=E2=80=99ve=
 done my changes in the off hours where the impact wasn=E2=80=99t =
important, I could see reduction in performance but since it had no =
impact on me I didn=E2=80=99t messure it exactly.

Since I had the luxury of leaving it going overnight I didn=E2=80=99t =
step the PG.  I would, however, highly recommend in normal circumstances =
to do this in stages to reduce the impact you will see. =20

You can see very significant IO load, and CPU time during the operation. =
 The realoctation in my case took over an hour to accomplish.


> On Aug 4, 2015, at 7:43 PM, Jevon Qiao <qiaojianfeng-OsJI6HhKm/eMe3Hu20U6GA@public.gmane.org> =
wrote:
>=20
> Thank you and Samuel for the prompt response.
> On 5/8/15 00:52, Marek Dohojda wrote:
>> I have done this not that long ago.  My original PG estimates were =
wrong and I had to increase them.
>>=20
>> After increasing the PG numbers the Ceph rebalanced, and that took a =
while.  To be honest in my case the slowdown wasn=E2=80=99t really =
visible, but it took a while.
> How many OSDs do you have in your cluster? How much did you adjust the =
PG numbers?
>> My strong suggestion to you would be to do it in a long IO time, and =
be prepared that this willl take quite a long time to accomplish.  Do it =
slowly  and do not increase multiple pools at once.
> Both you and Samuel said to do it slowly, do you mean to adjust the pg =
numbers step by step rather than doing it in one step? Also, would you =
please explain 'a long IO time' in details.
>=20
> Thanks,
> Jevon
>> It isn=E2=80=99t recommended practice but doable.
>>=20
>>=20
>>> On Aug 4, 2015, at 10:46 AM, Samuel Just <sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>=20
>>> It will cause a large amount of data movement.  Each new pg after =
the
>>> split will relocate.  It might be ok if you do it slowly.  =
Experiment
>>> on a test cluster.
>>> -Sam
>>>=20
>>> On Mon, Aug 3, 2015 at 12:57 AM, =E4=B9=94=E5=BB=BA=E5=B3=B0 =
<scaleqiao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>> Hi Cephers,
>>>>=20
>>>> This is a greeting from Jevon. Currently, I'm experiencing an issue =
which
>>>> suffers me a lot, so I'm writing to ask for your =
comments/help/suggestions.
>>>> More details are provided bellow.
>>>>=20
>>>> Issue:
>>>> I set up a cluster having 24 OSDs and created one pool with 1024 =
placement
>>>> groups on it for a small startup company. The number 1024 was =
calculated per
>>>> the equation 'OSDs * 100'/pool size. The cluster have been running =
quite
>>>> well for a long time. But recently, our monitoring system always =
complains
>>>> that some disks' usage exceed 85%. I log into the system and find =
out that
>>>> some disks' usage are really very high, but some are not(less than =
60%).
>>>> Each time when the issue happens, I have to manually re-balance the
>>>> distribution. This is a short-term solution, I'm not willing to do =
it all
>>>> the time.
>>>>=20
>>>> Two long-term solutions come in my mind,
>>>> 1) Ask the customers to expand their clusters by adding more OSDs. =
But I
>>>> think they will ask me to explain the reason of the imbalance data
>>>> distribution. We've already done some analysis on the environment, =
we
>>>> learned that the most imbalance part in the CRUSH is the mapping =
between
>>>> object and pg. The biggest pg has 613 objects, while the smallest =
pg only
>>>> has 226 objects.
>>>>=20
>>>> 2) Increase the number of placement groups. It can be of great help =
for
>>>> statistically uniform data distribution, but it can also incur =
significant
>>>> data movement as PGs are effective being split. I just cannot do it =
in our
>>>> customers' environment before we 100% understand the consequence. =
So anyone
>>>> did this under a production environment? How much does this =
operation affect
>>>> the performance of Clients?
>>>>=20
>>>> Any comments/help/suggestions will be highly appreciated.
>>>>=20
>>>> --
>>>> Best Regards
>>>> Jevon
>>>>=20
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>=20
>>> _______________________________________________
>>> ceph-users mailing list
>>> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org =
<mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
>> More majordomo info at  http://vger.kernel.org/majordomo-info.htmlml =
<http://vger.kernel.org/majordomo-info.htmlml>

--Apple-Mail=_B5C80659-46FE-4E75-8FCE-BA69C4DB1020
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dutf-8"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D""><div class=3D"">I started with 7 and expended it to 14 with =
starting PG of 512 to 4096, as recommended.&nbsp;</div><div class=3D""><br=
 class=3D""></div><div class=3D"">Unfortunately I can=E2=80=99t tell you =
the exact IO impact as I=E2=80=99ve done my changes in the off hours =
where the impact wasn=E2=80=99t important, I could see reduction in =
performance but since it had no impact on me I didn=E2=80=99t messure it =
exactly.</div><div class=3D""><br class=3D""></div><div class=3D"">Since =
I had the luxury of leaving it going overnight I didn=E2=80=99t step the =
PG. &nbsp;I would, however, highly recommend in normal circumstances to =
do this in stages to reduce the impact you will see. &nbsp;</div><div =
class=3D""><br class=3D""></div><div class=3D"">You can see very =
significant IO load, and CPU time during the operation. &nbsp;The =
realoctation in my case took over an hour to accomplish.</div><div =
class=3D""><br class=3D""></div><br class=3D""><div><blockquote =
type=3D"cite" class=3D""><div class=3D"">On Aug 4, 2015, at 7:43 PM, =
Jevon Qiao &lt;<a href=3D"mailto:qiaojianfeng-OsJI6HhKm/eMe3Hu20U6GA@public.gmane.org" =
class=3D"">qiaojianfeng-OsJI6HhKm/eMe3Hu20U6GA@public.gmane.org</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Thank you and Samuel for the prompt =
response.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">On 5/8/15 00:52, Marek =
Dohojda wrote:</span><br style=3D"font-family: Helvetica; font-size: =
12px; font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><blockquote type=3D"cite" style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D"">I have done this not that long ago. &nbsp;My original =
PG estimates were wrong and I had to increase them.<br class=3D""><br =
class=3D"">After increasing the PG numbers the Ceph rebalanced, and that =
took a while. &nbsp;To be honest in my case the slowdown wasn=E2=80=99t =
really visible, but it took a while.<br class=3D""></blockquote><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">How many OSDs do you have in your cluster? How =
much did you adjust the PG numbers?</span><br style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D""><blockquote type=3D"cite" =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D"">My strong suggestion to =
you would be to do it in a long IO time, and be prepared that this willl =
take quite a long time to accomplish. &nbsp;Do it slowly &nbsp;and do =
not increase multiple pools at once.<br class=3D""></blockquote><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Both you and Samuel said to do it slowly, do you =
mean to adjust the pg numbers step by step rather than doing it in one =
step? Also, would you please explain 'a long IO time' in =
details.</span><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; =
font-style: normal; font-variant: normal; font-weight: normal; =
letter-spacing: normal; line-height: normal; orphans: auto; text-align: =
start; text-indent: 0px; text-transform: none; white-space: normal; =
widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; float: =
none; display: inline !important;" class=3D"">Thanks,</span><br =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px;" class=3D""><span =
style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; =
font-variant: normal; font-weight: normal; letter-spacing: normal; =
line-height: normal; orphans: auto; text-align: start; text-indent: 0px; =
text-transform: none; white-space: normal; widows: auto; word-spacing: =
0px; -webkit-text-stroke-width: 0px; float: none; display: inline =
!important;" class=3D"">Jevon</span><br style=3D"font-family: Helvetica; =
font-size: 12px; font-style: normal; font-variant: normal; font-weight: =
normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: =
normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: =
0px;" class=3D""><blockquote type=3D"cite" style=3D"font-family: =
Helvetica; font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;" class=3D"">It isn=E2=80=99t recommended =
practice but doable.<br class=3D""><br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">On Aug 4, 2015, at 10:46 =
AM, Samuel Just &lt;<a href=3D"mailto:sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" =
class=3D"">sjust-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; wrote:<br class=3D""><br class=3D"">It=
 will cause a large amount of data movement. &nbsp;Each new pg after =
the<br class=3D"">split will relocate. &nbsp;It might be ok if you do it =
slowly. &nbsp;Experiment<br class=3D"">on a test cluster.<br =
class=3D"">-Sam<br class=3D""><br class=3D"">On Mon, Aug 3, 2015 at =
12:57 AM, =E4=B9=94=E5=BB=BA=E5=B3=B0 &lt;<a =
href=3D"mailto:scaleqiao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" class=3D"">scaleqiao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org</a>&gt;=
 wrote:<br class=3D""><blockquote type=3D"cite" class=3D"">Hi =
Cephers,<br class=3D""><br class=3D"">This is a greeting from Jevon. =
Currently, I'm experiencing an issue which<br class=3D"">suffers me a =
lot, so I'm writing to ask for your comments/help/suggestions.<br =
class=3D"">More details are provided bellow.<br class=3D""><br =
class=3D"">Issue:<br class=3D"">I set up a cluster having 24 OSDs and =
created one pool with 1024 placement<br class=3D"">groups on it for a =
small startup company. The number 1024 was calculated per<br =
class=3D"">the equation 'OSDs * 100'/pool size. The cluster have been =
running quite<br class=3D"">well for a long time. But recently, our =
monitoring system always complains<br class=3D"">that some disks' usage =
exceed 85%. I log into the system and find out that<br class=3D"">some =
disks' usage are really very high, but some are not(less than 60%).<br =
class=3D"">Each time when the issue happens, I have to manually =
re-balance the<br class=3D"">distribution. This is a short-term =
solution, I'm not willing to do it all<br class=3D"">the time.<br =
class=3D""><br class=3D"">Two long-term solutions come in my mind,<br =
class=3D"">1) Ask the customers to expand their clusters by adding more =
OSDs. But I<br class=3D"">think they will ask me to explain the reason =
of the imbalance data<br class=3D"">distribution. We've already done =
some analysis on the environment, we<br class=3D"">learned that the most =
imbalance part in the CRUSH is the mapping between<br class=3D"">object =
and pg. The biggest pg has 613 objects, while the smallest pg only<br =
class=3D"">has 226 objects.<br class=3D""><br class=3D"">2) Increase the =
number of placement groups. It can be of great help for<br =
class=3D"">statistically uniform data distribution, but it can also =
incur significant<br class=3D"">data movement as PGs are effective being =
split. I just cannot do it in our<br class=3D"">customers' environment =
before we 100% understand the consequence. So anyone<br class=3D"">did =
this under a production environment? How much does this operation =
affect<br class=3D"">the performance of Clients?<br class=3D""><br =
class=3D"">Any comments/help/suggestions will be highly appreciated.<br =
class=3D""><br class=3D"">--<br class=3D"">Best Regards<br =
class=3D"">Jevon<br class=3D""><br =
class=3D"">_______________________________________________<br =
class=3D"">ceph-users mailing list<br class=3D""><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br =
class=3D""><br =
class=3D""></blockquote>_______________________________________________<br=
 class=3D"">ceph-users mailing list<br class=3D""><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br =
class=3D""></blockquote>--<br class=3D"">To unsubscribe from this list: =
send the line "unsubscribe ceph-devel" in<br class=3D"">the body of a =
message to<span class=3D"Apple-converted-space">&nbsp;</span><a =
href=3D"mailto:majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" =
class=3D"">majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org</a><br class=3D"">More majordomo =
info at &nbsp;<a href=3D"http://vger.kernel.org/majordomo-info.htmlml" =
class=3D"">http://vger.kernel.org/majordomo-info.htmlml</a></blockquote></=
div></blockquote></div><br class=3D""></body></html>=

--Apple-Mail=_B5C80659-46FE-4E75-8FCE-BA69C4DB1020--

--===============1813052533==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1813052533==--
